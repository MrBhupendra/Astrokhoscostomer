import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../utill/app_constants.dart';
import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';
import '../../utill/images.dart';
import '../screen/astrologer_detail/controller/astrologer_profile_controller.dart';
import '../screen/splash/controller/config_controller.dart';
import 'custom_round_network_image.dart';
import 'custom_snack_bar.dart';
import 'custom_text_medium.dart';
import 'custom_text_regular.dart';

class CustomAstrologerEmergencyWidget extends StatelessWidget {
  AstrologerProfileController controller;
  String emergencyCallRate;
  String emergencyChatRate;
  String emergencyVideoRate;
  CustomAstrologerEmergencyWidget(this.controller,this.emergencyCallRate,this.emergencyChatRate,this.emergencyVideoRate, {super.key});
  final ConfigController configController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10,top: 20,bottom: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CustomRoundNetworkImage(
                          imageUrl: controller.astrologerData.value.astroImg.toString(),
                          height: Dimensions.profileImageHeight,
                          width: Dimensions.profileImageHeight),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                            padding: const EdgeInsets.all(4),
                            child: Image.asset(Images.emergencyAlert,height: 18,width: 18,)
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(15),
              CustomTextMedium(
                controller.astrologerData.value.displayName.toString(),
                fontSize: Dimensions.fontSizeOverLarge,
                textAlign: TextAlign.center,
              ),
              const Gap(8),
              CustomTextRegular(
                "Try Emergency Session @ ${configController.currencySymbol} $emergencyCallRate",
                textAlign: TextAlign.center,
                color: ColorResources.black4,
              ),
              const Gap(10),
              CustomTextMedium(
                "${AppConstants.appName} will try calling ${controller.astrologerData.value.displayName}, if there is anything urgent. We cant promise if they would be able to take the call",
                textAlign: TextAlign.center,
                color: ColorResources.black4,
              ),
              const Gap(8),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          if(controller.astrologerData.value.emergencyChatStatus == 1){
                            controller.checkCallDetail(
                                AppConstants.emergencyChat,
                                controller.astrologerData.value.astrologerUniId.toString(),
                                controller.astrologerData.value
                            );
                          }else{
                            CustomSnackBar.showBottom("Astrologer currently unavailable for emergency chat");
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall,
                              vertical: Dimensions.paddingSizeExtraSmall
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                              color: controller.astrologerData.value.emergencyChatStatus == 1 ? ColorResources.orange : ColorResources.black7
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(Images.navChat, color: controller.astrologerData.value.emergencyChatStatus == 1 ? ColorResources.white : ColorResources.colorText,height: 20,width: 20,),
                              const Gap(10),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomTextRegular(
                                    "Chat Now",
                                    textAlign: TextAlign.center,
                                    color: controller.astrologerData.value.emergencyChatStatus == 1 ? ColorResources.white : ColorResources.colorText,
                                    fontSize: Dimensions.fontSizeSmall,
                                  ),
                                  CustomTextRegular(
                                    "${configController.currencySymbol} $emergencyChatRate/min",
                                    textAlign: TextAlign.center,
                                    color: controller.astrologerData.value.emergencyChatStatus == 1 ? ColorResources.white : ColorResources.colorText,
                                    fontSize: 11,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(10),
                      GestureDetector(
                        onTap: (){
                          if(controller.astrologerData.value.emergencyCallStatus == 1){
                            controller.checkCallDetail(
                                AppConstants.emergencyCall,
                                controller.astrologerData.value.astrologerUniId.toString(),
                                controller.astrologerData.value
                            );
                          }else{
                            CustomSnackBar.showBottom("Astrologer currently unavailable for emergency call");
                          }

                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall,
                              vertical: Dimensions.paddingSizeExtraSmall
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                              color: controller.astrologerData.value.emergencyCallStatus == 1 ? ColorResources.orange : ColorResources.black7
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(Images.navCall, color:controller.astrologerData.value.emergencyCallStatus == 1 ? ColorResources.white : ColorResources.colorText,height: 20,width: 20,),
                              const Gap(10),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomTextRegular(
                                    "Call Now",
                                    textAlign: TextAlign.center,
                                    color: controller.astrologerData.value.emergencyCallStatus == 1 ? ColorResources.white : ColorResources.colorText,
                                    fontSize: Dimensions.fontSizeSmall,
                                  ),
                                  CustomTextRegular(
                                    "${configController.currencySymbol} $emergencyCallRate/min",
                                    textAlign: TextAlign.center,
                                    color: controller.astrologerData.value.emergencyCallStatus == 1 ? ColorResources.white : ColorResources.colorText,
                                    fontSize: 11,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(10),
                      GestureDetector(
                        onTap: (){
                          if(controller.astrologerData.value.emergencyVideoStatus == 1){
                            controller.checkCallDetail(
                                AppConstants.emergencyVideoCall,
                                controller.astrologerData.value.astrologerUniId.toString(),
                                controller.astrologerData.value
                            );
                          }else{
                            CustomSnackBar.showBottom("Astrologer currently unavailable for emergency video call");
                          }

                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall,
                              vertical: Dimensions.paddingSizeExtraSmall
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                              color: controller.astrologerData.value.emergencyVideoStatus == 1 ? ColorResources.orange : ColorResources.black7
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(Images.astroVideoCall, color:controller.astrologerData.value.emergencyVideoStatus == 1 ? ColorResources.white : ColorResources.colorText,height: 20,width: 20,),
                              const Gap(10),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomTextRegular(
                                    "Video Call",
                                    textAlign: TextAlign.center,
                                    color: controller.astrologerData.value.emergencyVideoStatus == 1 ? ColorResources.white : ColorResources.colorText,
                                    fontSize: Dimensions.fontSizeSmall,
                                  ),
                                  CustomTextRegular(
                                    "${configController.currencySymbol} $emergencyVideoRate/min",
                                    textAlign: TextAlign.center,
                                    color: controller.astrologerData.value.emergencyVideoStatus == 1 ? ColorResources.white : ColorResources.colorText,
                                    fontSize: 11,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
