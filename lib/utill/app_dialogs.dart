import 'package:get/get.dart';

import '../view/widget/custom_call_connect_widget.dart';
import '../view/widget/custom_okdialog_widget.dart';
import '../view/widget/custom_payment_status_dialog.dart';
import 'app_constants.dart';
import 'app_strings.dart';
import 'color_resources.dart';
import 'images.dart';

class AppDialog {
  void showPaymentFailedDialog() {
    Get.dialog(
        CustomPaymentDialogWidget(
          imagePath: Images.paymentFailed,
          onPressed: () {
            Get.back(); //CLose Dialog
          },
          title: AppStrings.paymentFailed,
          description: AppStrings.paymentFailedDesc,
          btnText: AppStrings.tryAgain,
          borderColor: ColorResources.lightRed,
          textColor: ColorResources.lightRed,
        ),
        barrierDismissible: false);
  }

  void showPaymentSuccessDialog(String type) {
    Get.dialog(
        CustomPaymentDialogWidget(
            imagePath: Images.paymentSuccess,
            onPressed: () {
              Get.back(); //Close Dialog
              if (type.isNotEmpty) {
                if (type == AppConstants.subscriptionOrder) {
                  //REPORT
                  Get.offAllNamed('/subscription_purchase_list');
                } else if (type == AppConstants.report) {
                  //REPORT
                  Get.offAllNamed('/report_order_list_vedic');
                } else if (type == AppConstants.jeevini) {
                  //JEEVINI
                  Get.offAllNamed('/paid_orders_tab_screen',
                      arguments: {'index': 0});
                } else if (type == AppConstants.divineCode) {
                  //DIVINE
                  Get.offAllNamed('/paid_orders_tab_screen',
                      arguments: {'index': 1});
                } else if (type == AppConstants.pdfBook) {
                  //BOOKS
                  Get.offAllNamed('/paid_orders_tab_screen',
                      arguments: {'index': 2});
                } else if (type == AppConstants.report) {
                  //REPORT
                  Get.offAllNamed('/paid_orders_tab_screen',
                      arguments: {'index': 3});
                } else if (type == AppConstants.shop) {
                  //SHOP
                  Get.offAllNamed('/orders_tab_screen',
                      arguments: {'index': 1});
                } else if (type == AppConstants.serviceOrder) {
                  //Service
                  Get.offAllNamed('/orders_tab_screen',
                      arguments: {'index': 2});
                } else if (type == AppConstants.groupPoojaOrder) {
                  //GroupPooja
                  Get.offAllNamed('/orders_tab_screen',
                      arguments: {'index': 3});
                } else if (type == AppConstants.architect) {
                  //Architect
                  Get.offAllNamed('/architect_orders_tab_screen');
                } else if (type == AppConstants.slotBooking) {
                  //SlotBooking
                  Get.offAllNamed('/orders_tab_screen',
                      arguments: {'index': 4});
                } else if (type == AppConstants.askQuestion) {
                  //askQuestion
                  Get.offNamed('/ask_question_order_screen');
                }
                else if (type == AppConstants.orderMandirDarshan) {
                  //GroupPooja
                  Get.offAllNamed('/orders_tab_screen',
                      arguments: {'index': 6});
                } else {
                  Get.offAllNamed('/dashboard');
                }
              } else {
                Get.offAllNamed('/dashboard');
              }
            },
            title: AppStrings.paymentSuccess.tr,
            description: AppStrings.paymentSuccessDesc.tr,
            btnText: AppStrings.continueBtn),
        barrierDismissible: false);
  }

  void showCallSuccessDialog(String message, String type) {
    Get.dialog(
        CustomOkdialogWidget(
          imagePath: Images.successCheck,
          title: AppStrings.success.tr,
          onPressed: () async {
            if (type == "Queue") {
              Get.back();
              Get.toNamed("/queue_list");
            } else {
              Get.back();
            }
          },
          description: message,
        ),
        barrierDismissible: false
    );
  }

  void showCallDialog(String message, String type, String callType, String cusImage, String cusName, String astroImage, String astroName) {
    Get.dialog(
        CustomCallConnectDialog(
          cusImage: cusImage,
          astroImage: astroImage,
          cusName: cusName,
          astroName: astroName,
          title: "Waitlist Joined!",
          onOkPressed: () {
            if (type == "Queue") {
              Get.back();
              Get.toNamed("/queue_list");
            } else {
              Get.back();
            }
          },
          description: message,
          iconImage: callType == AppConstants.chat
              ? Images.icChatDialog
              : callType == AppConstants.call
                  ? Images.icCallDialog
                  : callType == AppConstants.video
                      ? Images.icVideoDialog
                      : Images.icConnectDialog,
        ),
        barrierDismissible: false
    );
  }
}
