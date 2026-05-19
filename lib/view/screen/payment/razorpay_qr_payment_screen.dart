import 'package:astro_brahmand/controller/razorpay_controller.dart';
import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:astro_brahmand/utill/app_dialogs.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/utill/dimensions.dart';
import 'package:astro_brahmand/view/widget/custom_elevated_button.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class RazorpayQrPaymentScreen extends StatelessWidget {
  const RazorpayQrPaymentScreen({super.key});

  void _cancelPaymentAndShowFailedDialog(RazorpayController controller) {
    controller.endQrFlow();
    Get.back();
    Future.delayed(const Duration(milliseconds: 300), () {
      AppDialog().showPaymentFailedDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    final RazorpayController controller = Get.find<RazorpayController>();

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) controller.endQrFlow();
      },
      child: Scaffold(
        appBar: AppBar(
          title: CustomTextRegular(
            'Scan QR & Pay',
            fontSize: 18,
            color: ColorResources.toolbarText,
          ),
          backgroundColor: ColorResources.colorPrimary,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _cancelPaymentAndShowFailedDialog(controller),
          ),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xFFF8F5FF),
        body: Obx(() {
          final imageUrl = controller.qrImageUrl.value;
          final error = controller.qrError.value;
          final statusText = controller.qrStatusText.value;
          final amount = controller.amountForQr;
          final isExpired = controller.isQrExpired.value;
          final isTimerStarted = controller.isQrTimerStarted.value;
          final canCheckPayment = controller.canCheckQrPayment;
          final remainingTime = controller.qrRemainingTimeText.value;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(10, 12, 10, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: ColorResources.colorPrimary.withOpacity(0.08),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        CustomTextMedium(
                          '${AppConstants.defaultCurrencySymbol}${amount.toStringAsFixed(amount.truncateToDouble() == amount ? 0 : 2)}',
                          fontSize: 30,
                          color: ColorResources.colorPrimary,
                        ),
                        const SizedBox(height: 5),
                        CustomTextRegular(
                          isExpired
                              ? 'This QR has expired'
                              : 'Scan & Pay using any UPI app',
                          fontSize: Dimensions.fontSizeDefault,
                          color: isExpired
                              ? ColorResources.red
                              : ColorResources.black4,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: ColorResources.black7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: imageUrl.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: ColorFiltered(
                                    colorFilter: isExpired
                                        ? const ColorFilter.matrix([
                                            0.2126, 0.7152, 0.0722, 0, 0,
                                            0.2126, 0.7152, 0.0722, 0, 0,
                                            0.2126, 0.7152, 0.0722, 0, 0,
                                            0, 0, 0, 0.45, 0,
                                          ])
                                        : const ColorFilter.matrix([
                                            1, 0, 0, 0, 0,
                                            0, 1, 0, 0, 0,
                                            0, 0, 1, 0, 0,
                                            0, 0, 0, 1, 0,
                                          ]),
                                    child: _QrNetworkImage(
                                      key: ValueKey(imageUrl),
                                      imageUrl: imageUrl,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: CustomTextRegular(
                                    error.isNotEmpty
                                        ? error
                                        : 'QR not available',
                                    textAlign: TextAlign.center,
                                    color: ColorResources.black4,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isExpired
                                  ? Icons.error_outline
                                  : Icons.timer_outlined,
                              size: 18,
                              color: ColorResources.red,
                            ),
                            const SizedBox(width: 6),
                            CustomTextMedium(
                              isExpired
                                  ? 'QR expired'
                                  : !isTimerStarted
                                      ? 'Loading QR...'
                                      : 'QR expires in $remainingTime',
                              fontSize: Dimensions.fontSizeDefault,
                              color: ColorResources.red,
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        const Divider(color: ColorResources.black7),
                        const SizedBox(height: 15),
                        if (!isExpired) ...[
                          const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.4,
                              color: ColorResources.colorPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                        CustomTextRegular(
                          statusText,
                          fontSize: Dimensions.fontSizeSmall,
                          color: ColorResources.black5,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (!isExpired)
                    CustomTextMedium(
                      'Use Google Pay, PhonePe, Paytm, BHIM or any other UPI app to complete payment',
                      fontSize: Dimensions.fontSizeSmall,
                      color: ColorResources.black4,
                      textAlign: TextAlign.center,
                    ),
                  if (!isExpired) ...[
                    const SizedBox(height: 18),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _PaymentHintIcon(
                            icon: Icons.account_balance_wallet_outlined),
                        SizedBox(width: 18),
                        _PaymentHintIcon(icon: Icons.account_balance_outlined),
                        SizedBox(width: 18),
                        _PaymentHintIcon(icon: Icons.payments_outlined),
                        SizedBox(width: 18),
                        _PaymentHintIcon(icon: Icons.credit_card_outlined),
                      ],
                    ),
                  ],
                  const SizedBox(height: 24),
                  if (isExpired) ...[
                    CustomElevatedButton(
                      text: 'Generate New QR',
                      onPressed: () => controller.regenerateQr(),
                    ),
                    const SizedBox(height: 8),
                  ] else ...[
                    CustomElevatedButton(
                      text: 'I Have Paid',
                      onPressed: canCheckPayment
                          ? () => controller.checkQrPaymentStatusOnce()
                          : null,
                    ),
                  ],
                  TextButton(
                    onPressed: () =>
                        _cancelPaymentAndShowFailedDialog(controller),
                    child: CustomTextMedium(
                      'Cancel Payment',
                      color: ColorResources.red,
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// Starts expiry timer only after QR image has finished loading.
class _QrNetworkImage extends StatefulWidget {
  final String imageUrl;

  const _QrNetworkImage({super.key, required this.imageUrl});

  @override
  State<_QrNetworkImage> createState() => _QrNetworkImageState();
}

class _QrNetworkImageState extends State<_QrNetworkImage> {
  bool _timerNotified = false;
  bool _imageLoaded = false;
  bool _hasError = false;

  void _onQrImageReady() {
    if (_timerNotified) return;
    _timerNotified = true;
    Get.find<RazorpayController>().startQrExpiryTimer();
  }

  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = Get.height * 0.7;
    final width = Get.width * 0.8;

    if (_hasError) {
      return SizedBox(
        height: height,
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: CustomTextRegular(
            'Unable to load QR image.\nPlease try again.',
            textAlign: TextAlign.center,
            color: ColorResources.black4,
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (!_imageLoaded) _buildShimmerPlaceholder(),
          Image.network(
            widget.imageUrl,
            fit: BoxFit.cover,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded || frame != null) {
                if (!_imageLoaded) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (!mounted) return;
                    setState(() => _imageLoaded = true);
                    _onQrImageReady();
                  });
                }
                return child;
              }
              return const SizedBox.shrink();
            },
            errorBuilder: (_, __, ___) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                setState(() {
                  _hasError = true;
                  _imageLoaded = true;
                });
              });
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class _PaymentHintIcon extends StatelessWidget {
  final IconData icon;

  const _PaymentHintIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: 38,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        icon,
        color: ColorResources.black6,
        size: 21,
      ),
    );
  }
}
