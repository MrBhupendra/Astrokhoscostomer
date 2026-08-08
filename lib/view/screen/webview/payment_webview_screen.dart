import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:astro_brahmand/utill/app_dialogs.dart';
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../utill/app_constants.dart';
import '../../widget/custom_snack_bar.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String title;
  final String url;
  final String type;
  final String description;

  const PaymentWebViewScreen(
      this.title,
      this.url,
      this.type,
      this.description, {
        super.key,
      });

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;
  bool paymentSuccess = false;
  bool _hasCompleted = false;

  /// Last outcome parsed from PayU pages before server callback.
  bool? _payuOutcome;

  /// Last outcome parsed from PayPal pages before server callback.
  bool? _paypalOutcome;

  /// True after user reaches PayU response (usually means payment was attempted).
  bool _sawPayuResponsePage = false;

  static const String _successPath = '/customerwalletapp/Success';
  static const String _failurePath = '/customerwalletapp/Failure';
  static const String _payuAppCallbackPath = '/api/paymentresponsepayuapp';
  static const String _paypalAppCallbackPath = '/api/paymentresponsepaypalapp';

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setUserAgent(
        'Mozilla/5.0 (Linux; Android 10; SM-G973F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.93 Mobile Safari/537.36',
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
          },
          onPageStarted: (String url) {
            if (_isPayuResponseUrl(url)) {
              _sawPayuResponsePage = true;
              _schedulePayuOutcomeCapture();
            }
            _handlePaymentUrl(url);
          },
          onPageFinished: (String url) async {
            await _capturePayuOutcomeFromPage(url);
            _handlePaymentUrl(url);
          },
          onWebResourceError: (WebResourceError error) {
            if (_hasCompleted || !(error.isForMainFrame ?? false)) return;
            final failingUrl = error.url ?? '';
            if (_isPayuAppCallback(failingUrl)) {
              _completeAfterPayuCallback();
            } else if (_isPaypalAppCallback(failingUrl)) {
              _completeAfterPaypalCallback();
            }
          },
          onNavigationRequest: (NavigationRequest request) {

            if (_handlePaymentUrl(request.url)) {
              return NavigationDecision.prevent;
            }

            return handleUPIIntent(request.url);
          },
          onUrlChange: (UrlChange change) {
            final url = change.url;
            if (url != null) {
              _handlePaymentUrl(url);
            }
          },
          onHttpAuthRequest: (HttpAuthRequest request) {
            openDialog(request);
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.url));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }

  /// Returns true if navigation should be prevented.
  bool _handlePaymentUrl(String url) {
    if (_hasCompleted) return true;

    if (_isSuccessUrl(url)) {
      _finishPayment(true);
      return true;
    }
    if (_isFailureUrl(url)) {
      _finishPayment(false);
      return true;
    }

    final uri = Uri.tryParse(url);
    if (uri != null) {
      final fromQuery = _outcomeFromUri(uri);
      if (fromQuery != null) {
        _payuOutcome = fromQuery;
      }
    }

    if (_isPayuAppCallback(url)) {
      // Server callback is not a user-facing page; close WebView instead of 404.
      _completeAfterPayuCallback();
      return true;
    }

    if (_isPaypalAppCallback(url)) {
      _capturePaypalOutcomeFromUrl(url);
      // Server callback is not a user-facing page; close WebView instead of 404.
      _completeAfterPaypalCallback();
      return true;
    }

    return false;
  }

  Future<void> _capturePayuOutcomeFromPage(String url) async {
    if (_hasCompleted) return;

    final uri = Uri.tryParse(url);
    if (uri == null) return;

    final fromQuery = _outcomeFromUri(uri);
    if (fromQuery != null) {
      _payuOutcome = fromQuery;
      paymentSuccess = fromQuery;
      return;
    }

    final host = uri.host.toLowerCase();
    final isPayuHost = host.contains('payu.in') || host.contains('payu.com');
    if (!isPayuHost) return;

    try {
      final raw = await _controller.runJavaScriptReturningResult(
        'document.body ? (document.body.innerText || document.body.textContent || "") : ""',
      );
      final pageText = raw.toString().toLowerCase();
      final fromText = _outcomeFromText(pageText);
      if (fromText != null) {
        _payuOutcome = fromText;
        paymentSuccess = fromText;
      }
    } catch (_) {
      // Ignore PayU page parse failures.
    }
  }

  bool? _outcomeFromUri(Uri uri) {
    final params = uri.queryParameters;
    for (final key in ['status', 'unmappedstatus', 'payment_status', 'result']) {
      final value = params[key]?.toLowerCase();
      final outcome = _outcomeFromText(value ?? '');
      if (outcome != null) return outcome;
    }
    return null;
  }

  bool? _outcomeFromText(String text) {
    final t = text.toLowerCase();
    if (t.contains('success') ||
        t.contains('successful') ||
        t.contains('captured') ||
        t == 'success') {
      return true;
    }
    if (t.contains('failure') ||
        t.contains('failed') ||
        t.contains('cancelled') ||
        t.contains('canceled') ||
        t.contains('abort') ||
        t == 'failure') {
      return false;
    }
    return null;
  }

  bool _isSuccessUrl(String url) {
    if (!url.startsWith(AppConstants.baseUrl)) return false;
    final uri = Uri.tryParse(url);
    return uri != null &&
        (uri.path == _successPath || url.contains('customerwalletapp/Success'));
  }

  bool _isFailureUrl(String url) {
    if (!url.startsWith(AppConstants.baseUrl)) return false;
    final uri = Uri.tryParse(url);
    return uri != null &&
        (uri.path == _failurePath || url.contains('customerwalletapp/Failure'));
  }

  bool _isPayuAppCallback(String url) {
    final uri = Uri.tryParse(url);
    return uri != null && uri.path == _payuAppCallbackPath;
  }

  bool _isPaypalAppCallback(String url) {
    final uri = Uri.tryParse(url);
    return uri != null && uri.path == _paypalAppCallbackPath;
  }

  void _capturePaypalOutcomeFromUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return;

    final payerId = uri.queryParameters['PayerID'] ??
        uri.queryParameters['payer_id'] ??
        uri.queryParameters['payerId'];
    if (payerId != null && payerId.isNotEmpty) {
      _paypalOutcome = true;
      paymentSuccess = true;
      return;
    }

    for (final key in ['cancel', 'cancelled', 'canceled']) {
      final value = uri.queryParameters[key]?.toLowerCase();
      if (value == 'true' || value == '1') {
        _paypalOutcome = false;
        paymentSuccess = false;
        return;
      }
    }

    final fromQuery = _outcomeFromUri(uri);
    if (fromQuery != null) {
      _paypalOutcome = fromQuery;
      paymentSuccess = fromQuery;
      return;
    }

    // PayPal cancel returns callback with token only (no PayerID).
    if (_isPaypalAppCallback(url)) {
      _paypalOutcome = false;
      paymentSuccess = false;
    }
  }

  bool _isPayuResponseUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;
    return uri.host == 'secure.payu.in' && uri.path == '/response';
  }

  void _schedulePayuOutcomeCapture() {
    Future<void>.delayed(const Duration(milliseconds: 400), () async {
      if (_hasCompleted || _payuOutcome != null) return;
      await _capturePayuOutcomeFromPage(
        (await _controller.currentUrl()) ?? '',
      );
    });
  }

  bool _resolvedOutcome() {
    if (_payuOutcome != null) return _payuOutcome!;
    if (paymentSuccess) return true;
    // PayU reached response page then server callback — treat as success.
    if (_sawPayuResponsePage) return true;
    return false;
  }

  Future<void> _completeAfterPayuCallback() async {
    if (_hasCompleted) return;
    if (_payuOutcome == null) {
      await _capturePayuOutcomeFromPage(
        (await _controller.currentUrl()) ?? '',
      );
      await Future<void>.delayed(const Duration(milliseconds: 250));
    }
    _finishPayment(_resolvedOutcome());
  }

  bool _resolvedPaypalOutcome() {
    if (_paypalOutcome != null) return _paypalOutcome!;
    return paymentSuccess;
  }

  Future<void> _completeAfterPaypalCallback() async {
    if (_hasCompleted) return;
    if (_paypalOutcome == null) {
      _capturePaypalOutcomeFromUrl((await _controller.currentUrl()) ?? '');
      await Future<void>.delayed(const Duration(milliseconds: 250));
    }
    _finishPayment(_resolvedPaypalOutcome());
  }

  void _finishPayment(bool success) {
    if (_hasCompleted) return;
    _hasCompleted = true;
    paymentSuccess = success;

    Get.back();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (success) {
        Future.delayed(const Duration(milliseconds: 500), () {
          AppDialog().showPaymentSuccessDialog(widget.type);
        });
      } else {
        Future.delayed(const Duration(milliseconds: 500), () {
          AppDialog().showPaymentFailedDialog();
        });
      }
    });
  }

  NavigationDecision handleUPIIntent(String url) {
    if (url.contains('phonepe://pay?') ||
        url.contains('tez://upi/pay?') ||
        url.contains('paytmmp://pay?') ||
        url.contains('bhim://pay?pa') ||
        url.contains('cred://pay?pa') ||
        url.contains('upi://pay?pa') ||
        url.contains('intent://pay?pa')) {
      _launchUPIIntent(url);
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }

  void _launchUPIIntent(String strUrl) async {
    try {
      String cleanedUrl = strUrl;
      String? packageName;

      if (cleanedUrl.startsWith('intent://')) {
        final intentPart = cleanedUrl.split('#Intent').last;
        final packageMatch =
        RegExp(r'package=([^;]+)').firstMatch(intentPart);
        if (packageMatch != null) {
          packageName = packageMatch.group(1);
        }
        cleanedUrl = cleanedUrl.replaceFirst('intent://pay', 'upi://pay');
        cleanedUrl = cleanedUrl.split('#Intent').first;
      }

      final uri = Uri.parse(cleanedUrl);

      if (Platform.isAndroid && packageName != null) {
        final intent = AndroidIntent(
          action: 'action_view',
          data: uri.toString(),
          package: packageName,
        );
        await intent.launch();
      } else {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      CustomSnackBar.showBottom(
        'No UPI application found or unable to open selected app.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop || _hasCompleted) return;
        if (await _controller.canGoBack()) {
          await _controller.goBack();
        } else if (context.mounted) {
          _finishPayment(paymentSuccess);
        }
      },
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            title: widget.title,
            onBackPressed: () {
              if (!_hasCompleted) {
                _finishPayment(paymentSuccess);
              }
            },
          ),
          body: WebViewWidget(controller: _controller),
        ),
      ),
    );
  }

  Future<void> openDialog(HttpAuthRequest httpRequest) async {
    final TextEditingController usernameTextController =
    TextEditingController();
    final TextEditingController passwordTextController =
    TextEditingController();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${httpRequest.host}: ${httpRequest.realm ?? '-'}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  autofocus: true,
                  controller: usernameTextController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  controller: passwordTextController,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                httpRequest.onCancel();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                httpRequest.onProceed(
                  WebViewCredential(
                    user: usernameTextController.text,
                    password: passwordTextController.text,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Authenticate'),
            ),
          ],
        );
      },
    );
  }
}

// class PaymentWebViewScreen extends StatefulWidget {
//   final String title;
//   final String url;
//   final String type;
//   final String description;
//   const PaymentWebViewScreen(this.title, this.url, this.type, this.description, {super.key});
//
//   @override
//   State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
// }
//
// class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
//   late final WebViewController _controller;
//   bool paymentSuccess = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     late final PlatformWebViewControllerCreationParams params;
//     if (WebViewPlatform.instance is WebKitWebViewPlatform) {
//       params = WebKitWebViewControllerCreationParams(
//         allowsInlineMediaPlayback: true,
//         mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
//       );
//     } else {
//       params = const PlatformWebViewControllerCreationParams();
//     }
//
//     final WebViewController controller =
//     WebViewController.fromPlatformCreationParams(params);
//
//     controller
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setUserAgent('Mozilla/5.0 (Linux; Android 10; SM-G973F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.93 Mobile Safari/537.36')
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             debugPrint('WebView is loading (progress : $progress%)');
//           },
//           onPageStarted: (String url) {
//             debugPrint('Page started loading: $url');
//           },
//           onPageFinished: (String url) {
//             debugPrint('Page finished loading: $url');
//           },
//           onWebResourceError: (WebResourceError error) {
//             debugPrint('''Page resource error:code: ${error.errorCode} description: ${error.description} errorType: ${error.errorType} isForMainFrame: ${error.isForMainFrame}''');
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             debugPrint("Navigating to ${request.url}");
//
//             if(request.url.contains('Success') && request.url.startsWith(AppConstants.baseUrl)){
//               paymentSuccess = true;
//               Get.back();
//               AppDialog().showPaymentSuccessDialog(widget.type);
//             }
//             else if(request.url.contains('Failure') && request.url.startsWith(AppConstants.baseUrl)){
//               paymentSuccess = false;
//               Get.back();
//               AppDialog().showPaymentFailedDialog();
//             }
//             debugPrint('allowing navigation to ${request.url}');
//             return handleUPIIntent(request.url);
//            // return NavigationDecision.navigate;
//           },
//           onUrlChange: (UrlChange change) {
//             debugPrint('url change to ${change.url}');
//           },
//           onHttpAuthRequest: (HttpAuthRequest request) {
//             openDialog(request);
//           },
//         ),
//       )
//       ..addJavaScriptChannel(
//         'Toaster',
//         onMessageReceived: (JavaScriptMessage message) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(message.message)),
//           );
//         },
//       )
//       ..loadRequest(Uri.parse(widget.url));
//
//     // #docregion platform_features
//     if (controller.platform is AndroidWebViewController) {
//       AndroidWebViewController.enableDebugging(true);
//       (controller.platform as AndroidWebViewController)
//           .setMediaPlaybackRequiresUserGesture(false);
//     }
//     // #enddocregion platform_features
//
//     _controller = controller;
//   }
//
//   NavigationDecision handleUPIIntent(String url) {
//     if (url.contains("phonepe://pay?") ||
//         url.contains("tez://upi/pay?") ||
//         url.contains("paytmmp://pay?") ||
//         url.contains("bhim://pay?pa") ||
//         url.contains("cred://pay?pa") ||
//         url.contains("upi://pay?pa") ||
//         url.contains("intent://pay?pa")) {
//       _launchUPIIntent(url);
//       return NavigationDecision.prevent;
//     }
//     return NavigationDecision.navigate;
//   }
//
//   void _launchUPIIntent(String strUrl) async {
//     try {
//       Uri url = Uri.parse(strUrl);
//       if (await canLaunchUrl(url)) {
//         await launchUrl(url);
//       } else {
//         CustomSnackBar.showBottom("UPI supported applications not found");
//       }
//     } catch (e) {
//       CustomSnackBar.showBottom("Error launching UPI app");
//
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       onPopInvoked: (bool isPopGesture) async {
//         if (!isPopGesture) {
//           if (await _controller.canGoBack()) {
//             await _controller.goBack();
//           } else {
//             if (context.mounted) {
//               Get.back();
//               if(paymentSuccess){
//                 AppDialog().showPaymentSuccessDialog(widget.type);
//               }else{
//                 AppDialog().showPaymentFailedDialog();
//               }
//
//             }
//           }
//         }
//       },
//       canPop: false,
//       child: SafeArea(
//         child: Scaffold(
//           appBar: CustomAppBar(title: widget.title,onBackPressed: (){
//             Get.back();
//             if(paymentSuccess){
//               AppDialog().showPaymentSuccessDialog(widget.type);
//             }else{
//               AppDialog().showPaymentFailedDialog();
//             }
//           },),
//           body: WebViewWidget(controller: _controller),
//         ),
//       ),
//     );
//   }
//
//   Future<void> openDialog(HttpAuthRequest httpRequest) async {
//     final TextEditingController usernameTextController =
//     TextEditingController();
//     final TextEditingController passwordTextController =
//     TextEditingController();
//
//     return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('${httpRequest.host}: ${httpRequest.realm ?? '-'}'),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 TextField(
//                   decoration: const InputDecoration(labelText: 'Username'),
//                   autofocus: true,
//                   controller: usernameTextController,
//                 ),
//                 TextField(
//                   decoration: const InputDecoration(labelText: 'Password'),
//                   controller: passwordTextController,
//                 ),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             // Explicitly cancel the request on iOS as the OS does not emit new
//             // requests when a previous request is pending.
//             TextButton(
//               onPressed: () {
//                 httpRequest.onCancel();
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 httpRequest.onProceed(
//                   WebViewCredential(
//                     user: usernameTextController.text,
//                     password: passwordTextController.text,
//                   ),
//                 );
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Authenticate'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
