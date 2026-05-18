import 'package:astro_brahmand/controller/razorpay_controller.dart';
import 'package:astro_brahmand/model/razorpay_model.dart';
import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/utill/shared_preference.dart';
import 'package:astro_brahmand/view/screen/wallet/controller/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RazorpayPaymentOptionsSheet extends StatelessWidget {
  final PaymentGateway paymentGateway;
  final String description;
  final String? userUniId;
  final String type;
  final String walletId;

  const RazorpayPaymentOptionsSheet({
    super.key,
    required this.paymentGateway,
    required this.description,
    required this.userUniId,
    required this.type,
    required this.walletId,
  });

  @override
  Widget build(BuildContext context) {
    final RazorpayController controller = Get.find<RazorpayController>();
    final WalletController walletController = Get.find<WalletController>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Choose payment method",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorResources.colorPrimary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () async {
                Get.back();
                await SharedPreferencesHelper.saveData(
                  AppConstants.paymentGateway,
                  AppConstants.payRazorpay,
                );
                controller.openCheckout(paymentGateway, description, userUniId, type);
              },
              child: const Text("Razorpay Checkout"),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(color: ColorResources.colorPrimary),
                foregroundColor: ColorResources.colorPrimary,
              ),
              onPressed: () {
                Get.back();
                // QR is created inside proceedPaymentRequest with payment_method = razorpay_qr
                walletController.proceedPaymentRequest(
                  walletId,
                  AppConstants.payRazorpayQr,
                );
              },
              child: const Text("Scan QR & Pay"),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
