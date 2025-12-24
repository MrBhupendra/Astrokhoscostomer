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
  const PaymentWebViewScreen(this.title, this.url, this.type, this.description, {super.key});

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;
  bool paymentSuccess = false;

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
      ..setUserAgent('Mozilla/5.0 (Linux; Android 10; SM-G973F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.93 Mobile Safari/537.36')
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''Page resource error:code: ${error.errorCode} description: ${error.description} errorType: ${error.errorType} isForMainFrame: ${error.isForMainFrame}''');
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint("Navigating to ${request.url}");

            if(request.url.contains('Success') && request.url.startsWith(AppConstants.baseUrl)){
              paymentSuccess = true;
              Get.back();
              AppDialog().showPaymentSuccessDialog(widget.type);
            }
            else if(request.url.contains('Failure') && request.url.startsWith(AppConstants.baseUrl)){
              paymentSuccess = false;
              Get.back();
              AppDialog().showPaymentFailedDialog();
            }
            debugPrint('allowing navigation to ${request.url}');
            return handleUPIIntent(request.url);
           // return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
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

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  NavigationDecision handleUPIIntent(String url) {
    if (url.contains("phonepe://pay?") ||
        url.contains("tez://upi/pay?") ||
        url.contains("paytmmp://pay?") ||
        url.contains("bhim://pay?pa") ||
        url.contains("cred://pay?pa") ||
        url.contains("upi://pay?pa") ||
        url.contains("intent://pay?pa")) {
      _launchUPIIntent(url);
      return NavigationDecision.prevent;
    }
    return NavigationDecision.navigate;
  }

  void _launchUPIIntent(String strUrl) async {
    try {
      Uri url = Uri.parse(strUrl);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        CustomSnackBar.showBottom("UPI supported applications not found");
      }
    } catch (e) {
      CustomSnackBar.showBottom("Error launching UPI app");

    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool isPopGesture) async {
        if (!isPopGesture) {
          if (await _controller.canGoBack()) {
            await _controller.goBack();
          } else {
            if (context.mounted) {
              Get.back();
              if(paymentSuccess){
                AppDialog().showPaymentSuccessDialog(widget.type);
              }else{
                AppDialog().showPaymentFailedDialog();
              }

            }
          }
        }
      },
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: widget.title,onBackPressed: (){
            Get.back();
            if(paymentSuccess){
              AppDialog().showPaymentSuccessDialog(widget.type);
            }else{
              AppDialog().showPaymentFailedDialog();
            }
          },),
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
            // Explicitly cancel the request on iOS as the OS does not emit new
            // requests when a previous request is pending.
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
