import 'package:astro_brahmand/controller/razorpay_controller.dart';
import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/utill/dimensions.dart';
import 'package:astro_brahmand/view/widget/custom_elevated_button.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../utill/images.dart';

enum _SuccessPhase { updatingWallet, ready, failed }

/// Payment already verified on previous screen — wallet update runs in background.
class RazorpayQrPaymentSuccessScreen extends StatefulWidget {
  final String orderId;
  final String paymentId;
  final String type;
  final num? amount;

  const RazorpayQrPaymentSuccessScreen({
    super.key,
    required this.orderId,
    required this.paymentId,
    required this.type,
    this.amount,
  });

  @override
  State<RazorpayQrPaymentSuccessScreen> createState() =>
      _RazorpayQrPaymentSuccessScreenState();
}

class _RazorpayQrPaymentSuccessScreenState
    extends State<RazorpayQrPaymentSuccessScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _scaleAnim;
  late final DateTime _paidAt;
  Timer? _redirectTimer;

  _SuccessPhase _phase = _SuccessPhase.updatingWallet;
  bool _hasRedirected = false;
  bool _navigateAfterWalletUpdate = false;
  int _remainingSeconds = 5;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.elasticOut,
    );
    _animController.forward();
    _paidAt = DateTime.now();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _completePayment();
    });
  }

  Future<void> _completePayment() async {
    final RazorpayController controller = Get.find<RazorpayController>();
    final bool success = await controller.updateOnlinePayment(
      widget.orderId,
      widget.paymentId,
      showSuccessDialog: false,
      showProgressDialog: false,
    );

    if (!mounted) return;

    if (!success) {
      setState(() => _phase = _SuccessPhase.failed);
      CustomSnackBar.showBottom(
        'Unable to update wallet. Please contact support.',
      );
      return;
    }

    setState(() => _phase = _SuccessPhase.ready);
    _startRedirectCountdown();

    if (_navigateAfterWalletUpdate) {
      _navigateHome();
    }
  }

  void _startRedirectCountdown() {
    _redirectTimer?.cancel();
    _redirectTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _phase != _SuccessPhase.ready) return;
      if (_remainingSeconds <= 1) {
        timer.cancel();
        _navigateHome();
        return;
      }
      setState(() => _remainingSeconds--);
    });
  }

  void _navigateHome() {
    if (_hasRedirected) return;

    if (_phase == _SuccessPhase.updatingWallet) {
      _navigateAfterWalletUpdate = true;
      CustomSnackBar.showBottom('Updating wallet balance. Redirecting shortly...');
      return;
    }

    if (_phase == _SuccessPhase.failed) {
      Get.back();
      return;
    }

    _hasRedirected = true;
    _redirectTimer?.cancel();
    Get.offAllNamed('/dashboard');
  }

  String _amountText() {
    final amount = widget.amount ?? 0;
    final hasDecimal = amount.truncateToDouble() != amount;
    return '${AppConstants.defaultCurrencySymbol}${amount.toStringAsFixed(hasDecimal ? 2 : 0)}';
  }

  String _formatDateTime(DateTime dateTime) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final hour = dateTime.hour == 0
        ? 12
        : dateTime.hour > 12
            ? dateTime.hour - 12
            : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year} • $hour:$minute $period';
  }

  String get _statusBadge {
    switch (_phase) {
      case _SuccessPhase.updatingWallet:
        return 'UPDATING WALLET';
      case _SuccessPhase.ready:
        return '• COMPLETED';
      case _SuccessPhase.failed:
        return 'FAILED';
    }
  }

  Color get _statusColor {
    switch (_phase) {
      case _SuccessPhase.updatingWallet:
        return ColorResources.orange;
      case _SuccessPhase.ready:
        return const Color(0xFF1F9C55);
      case _SuccessPhase.failed:
        return ColorResources.red;
    }
  }

  @override
  void dispose() {
    _redirectTimer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isReady = _phase == _SuccessPhase.ready;
    final bool isUpdating = _phase == _SuccessPhase.updatingWallet;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F5FF),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(18, 28, 18, 18),
            child: Column(
              children: [
                ScaleTransition(
                  scale: _scaleAnim,
                  child: Image.asset(
                    Images.paymentSuccess,
                    height: 80,
                    width: 80,
                  ),
                ),
                const Gap(28),
                CustomTextMedium(
                  'Payment Successful!',
                  fontSize: 26,
                  color: ColorResources.black1,
                  textAlign: TextAlign.center,
                ),
                const Gap(10),
                CustomTextRegular(
                  isUpdating
                      ? 'Payment received. Updating your wallet balance...'
                      : isReady
                          ? 'Your wallet has been updated successfully.'
                          : 'Wallet update failed. Please try again or contact support.',
                  fontSize: Dimensions.fontSizeDefault,
                  color: ColorResources.black4,
                  textAlign: TextAlign.center,
                ),
                const Gap(34),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: ColorResources.colorPrimary.withOpacity(0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 15),
                        child: Row(
                          children: [
                            Container(
                              height: 34,
                              width: 34,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ColorResources.colorPrimary
                                      .withOpacity(0.35),
                                ),
                              ),
                              child: const Icon(
                                Icons.account_balance_wallet_sharp,
                                color: ColorResources.colorPrimary,
                                size: 18,
                              ),
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CustomTextMedium(
                                  'AMOUNT PAID',
                                  fontSize: Dimensions.fontSizeExtraSmall,
                                  color: ColorResources.black3,
                                ),
                                const Gap(2),
                                CustomTextMedium(
                                  _amountText(),
                                  fontSize: 26,
                                  color: ColorResources.colorPrimary,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1, color: ColorResources.black7),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 15),
                        child: Column(
                          children: [
                            _ReceiptRow(
                              label: 'Transaction ID',
                              value: widget.paymentId,
                            ),
                            const Gap(20),
                            const _ReceiptRow(
                              label: 'Payment Method',
                              value: 'UPI QR Payment',
                              leadingIcon: Icons.qr_code_2,
                            ),
                            const Gap(20),
                            _ReceiptRow(
                              label: 'Date & Time',
                              value: _formatDateTime(_paidAt),
                            ),
                            const Gap(20),
                            Row(
                              children: [
                                CustomTextRegular(
                                  'Status',
                                  color: ColorResources.black5,
                                  fontSize: Dimensions.fontSizeDefault,
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _statusColor.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: CustomTextMedium(
                                    _statusBadge,
                                    color: _statusColor,
                                    fontSize: Dimensions.fontSizeSmall,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(28),
                if (isUpdating)
                  const SizedBox(
                    height: 28,
                    width: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: ColorResources.colorPrimary,
                    ),
                  )
                else if (isReady) ...[
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 54,
                        width: 54,
                        child: CircularProgressIndicator(
                          value: _remainingSeconds / 5,
                          strokeWidth: 4,
                          backgroundColor: const Color(0xFFE8DDF7),
                          color: ColorResources.colorPrimary,
                        ),
                      ),
                      CustomTextMedium(
                        '${_remainingSeconds}s',
                        color: ColorResources.colorPrimary,
                        fontSize: Dimensions.fontSizeSmall,
                      ),
                    ],
                  ),
                  const Gap(18),
                  CustomTextRegular(
                    'Redirecting automatically in ${_remainingSeconds}s...',
                    fontSize: Dimensions.fontSizeDefault,
                    color: ColorResources.black3,
                    textAlign: TextAlign.center,
                  ),
                ],
                const Gap(28),
                CustomElevatedButton(
                  text: 'Back to Home',
                  onPressed: _navigateHome,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ReceiptRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData? leadingIcon;

  const _ReceiptRow({
    required this.label,
    required this.value,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomTextRegular(
          label,
          color: ColorResources.black5,
          fontSize: Dimensions.fontSizeDefault,
        ),
        const Gap(12),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (leadingIcon != null) ...[
                Icon(leadingIcon, color: const Color(0xFF9A7A28), size: 16),
                const Gap(4),
              ],
              Flexible(
                child: CustomTextMedium(
                  value,
                  color: ColorResources.black2,
                  fontSize: Dimensions.fontSizeDefault,
                  textAlign: TextAlign.right,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
