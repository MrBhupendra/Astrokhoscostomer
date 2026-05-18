import 'package:get/get.dart';

import '../view/screen/chat/controller/chat_intake_form_controller.dart';
import '../view/screen/wallet/controller/wallet_controller.dart';
import '../view/widget/custom_call_connect_widget.dart';
import '../view/widget/custom_okdialog_widget.dart';
import '../view/widget/custom_payment_status_dialog.dart';
import 'app_constants.dart';
import 'app_strings.dart';
import 'color_resources.dart';
import 'images.dart';
import 'package:flutter/cupertino.dart';


class AppDialog {
  void showPaymentFailedDialog() {

    final walletController = Get.find<WalletController>();
    final uniqueId = walletController.getUniqueIdSafe();
    final channelName = walletController.getChannelNameSafe();
    final AgoraTokenSafe = walletController.getAgoraTokenSafe();
    final AgoraAppIdSafe = walletController.getAgoraAppIdSafe();
    final astroName = walletController.getAstroNameSafe();
    final astroImage = walletController.getAstroImageSafe();
    final astroUniId = walletController.getAstroUniIdSafe();
    final isVirtual = walletController.getIsVirtualSafe();
    print("callDuration===>5");
    print(uniqueId);
    print(channelName);
    print(AgoraTokenSafe);
    print(AgoraAppIdSafe);
    print(astroName);
    print(astroImage);
    print(astroUniId);
    print(isVirtual);
    Get.dialog(
        PopScope(
          canPop: false,
          child: CustomPaymentDialogWidget(
            imagePath: Images.paymentFailed,
            onPressed: () {
              if (uniqueId.isNotEmpty) {
                if (uniqueId.startsWith("CHAT")) {
                  final ChatIntakeFormController
                  chatIntakeFormController =
                  Get.put(ChatIntakeFormController());
                  chatIntakeFormController.setAstrologerData(
                      astroName
                          .toString(),
                      astroImage
                          .toString(),
                      astroUniId.toString(),
                      AppConstants.chat,
                      isVirtual);
                  Get.offAllNamed(
                    '/chat_screen',
                    arguments: {"channelName": channelName, "uniqueId": uniqueId},
                  );
                } else if (uniqueId.startsWith("CALL")) {
                  print("callDuration===>6");
                  print(uniqueId);
                  print(channelName);
                  print(AgoraTokenSafe);
                  print(AgoraAppIdSafe);
                  final ChatIntakeFormController
                  chatIntakeFormController =
                  Get.put(ChatIntakeFormController());
                  chatIntakeFormController.setAstrologerData(
                      astroName
                          .toString(),
                      astroImage
                          .toString(),
                      astroUniId.toString(),
                      AppConstants.call,
                      0);
                  Get.offAllNamed(
                    '/voiceCallScreen',
                    arguments: {"channelName": channelName, "uniqueId": uniqueId, "token": AgoraTokenSafe, "agoraAppId": AgoraAppIdSafe},
                  );
                } else if (uniqueId.startsWith("VIDEO")) {
                  final ChatIntakeFormController
                  chatIntakeFormController =
                  Get.put(ChatIntakeFormController());
                  chatIntakeFormController.setAstrologerData(
                      astroName
                          .toString(),
                      astroImage
                          .toString(),
                      astroUniId.toString(),
                      AppConstants.video,
                      0);
                  Get.offAllNamed(
                    '/videoCallScreen',
                    arguments: {"channelName": channelName, "uniqueId": uniqueId},
                  );
                } else {
                  // Fallback if uniqueId doesn’t match any known type
                  Get.back();
                }
                return;
              }
              Get.back(); // Close Dialog if uniqueId is empty
            },
            title: AppStrings.paymentFailed,
            description: AppStrings.paymentFailedDesc,
            btnText: AppStrings.tryAgain,
            borderColor: ColorResources.lightRed,
            textColor: ColorResources.lightRed,
          ),
        ),
        barrierDismissible: false);
  }

  void showPaymentSuccessDialog(String type) {
    Get.dialog(
        PopScope(
          canPop: false,
          child: CustomPaymentDialogWidget(
              imagePath: Images.paymentSuccess,
              onPressed: () {
                Get.back();
                continuePaymentSuccessNavigation(type);
              },
              title: AppStrings.paymentSuccess.tr,
              description: AppStrings.paymentSuccessDesc.tr,
              btnText: AppStrings.continueBtn),
        ),
        barrierDismissible: false);
  }

  /// QR / UPI style: show success dialog then auto-navigate after delay.
  void showPaymentSuccessDialogWithAutoContinue(String type,
      {Duration delay = const Duration(seconds: 2)}) {
    showPaymentSuccessDialog(type);
    Future.delayed(delay, () {
      if (Get.isDialogOpen == true) {
        Get.back();
        continuePaymentSuccessNavigation(type);
      }
    });
  }

  void continuePaymentSuccessNavigation(String type) {
    final walletController = Get.find<WalletController>();
    final uniqueId = walletController.getUniqueIdSafe();
    final channelName = walletController.getChannelNameSafe();
    final AgoraTokenSafe = walletController.getAgoraTokenSafe();
    final AgoraAppIdSafe = walletController.getAgoraAppIdSafe();
    final astroName = walletController.getAstroNameSafe();
    final astroImage = walletController.getAstroImageSafe();
    final astroUniId = walletController.getAstroUniIdSafe();
    final isVirtual = walletController.getIsVirtualSafe();

    if (uniqueId.isNotEmpty) {
      if (uniqueId.startsWith("CHAT")) {
        final ChatIntakeFormController chatIntakeFormController =
            Get.put(ChatIntakeFormController());
        chatIntakeFormController.setAstrologerData(
            astroName.toString(),
            astroImage.toString(),
            astroUniId.toString(),
            AppConstants.chat,
            isVirtual);
        Get.offAllNamed(
          '/chat_screen',
          arguments: {"channelName": channelName, "uniqueId": uniqueId},
        );
      } else if (uniqueId.startsWith("CALL")) {
        final ChatIntakeFormController chatIntakeFormController =
            Get.put(ChatIntakeFormController());
        chatIntakeFormController.setAstrologerData(
            astroName.toString(),
            astroImage.toString(),
            astroUniId.toString(),
            AppConstants.call,
            0);
        Get.offAllNamed(
          '/voiceCallScreen',
          arguments: {
            "channelName": channelName,
            "uniqueId": uniqueId,
            "token": AgoraTokenSafe,
            "agoraAppId": AgoraAppIdSafe
          },
        );
      } else if (uniqueId.startsWith("VIDEO")) {
        final ChatIntakeFormController chatIntakeFormController =
            Get.put(ChatIntakeFormController());
        chatIntakeFormController.setAstrologerData(
            astroName.toString(),
            astroImage.toString(),
            astroUniId.toString(),
            AppConstants.video,
            0);
        Get.offAllNamed(
          '/videoCallScreen',
          arguments: {"channelName": channelName, "uniqueId": uniqueId},
        );
      } else {
        Get.back();
      }
      return;
    }

    if (type.isNotEmpty) {
      if (type == AppConstants.subscriptionOrder) {
        Get.offAllNamed('/subscription_purchase_list');
      } else if (type == AppConstants.report) {
        Get.offAllNamed('/report_order_list_vedic');
      } else if (type == AppConstants.jeevini) {
        Get.offAllNamed('/paid_orders_tab_screen', arguments: {'index': 0});
      } else if (type == AppConstants.divineCode) {
        Get.offAllNamed('/paid_orders_tab_screen', arguments: {'index': 1});
      } else if (type == AppConstants.pdfBook) {
        Get.offAllNamed('/paid_orders_tab_screen', arguments: {'index': 2});
      } else if (type == AppConstants.shop) {
        Get.offAllNamed('/orders_tab_screen', arguments: {'index': 1});
      } else if (type == AppConstants.serviceOrder) {
        Get.offAllNamed('/orders_tab_screen', arguments: {'index': 2});
      } else if (type == AppConstants.groupPoojaOrder) {
        Get.offAllNamed('/orders_tab_screen', arguments: {'index': 3});
      } else if (type == AppConstants.architect) {
        Get.offAllNamed('/architect_orders_tab_screen');
      } else if (type == AppConstants.slotBooking) {
        Get.offAllNamed('/orders_tab_screen', arguments: {'index': 4});
      } else if (type == AppConstants.askQuestion) {
        Get.offNamed('/ask_question_order_screen');
      } else if (type == AppConstants.orderMandirDarshan) {
        Get.offAllNamed('/orders_tab_screen', arguments: {'index': 6});
      } else {
        Get.offAllNamed('/dashboard');
      }
    } else {
      Get.offAllNamed('/dashboard');
    }
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
