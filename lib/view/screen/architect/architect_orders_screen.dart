import 'package:astro_brahmand/view/screen/architect/architect_chat/controller/architect_chat_intake_form_controller.dart';
import 'package:astro_brahmand/view/screen/architect/controller/architect_orders_controller.dart';
import 'package:astro_brahmand/view/widget/custom_box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../utill/app_constants.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/shared_preference.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_round_network_image.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import '../../widget/simmer_widget/simmer_list_view.dart';
import '../chat/controller/chat_intake_form_controller.dart';
import '../splash/controller/config_controller.dart';

import 'package:astro_brahmand/utill/common_methods.dart';
class ArchitectOrdersScreen extends GetView<ArchitectOrdersController> {
  final String type;

  ArchitectOrdersScreen(this.type, {super.key});
  final ConfigController configController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (type == "InProgress") {
      controller.getInProgressOrders();
    } else if (type == "Completed") {
      controller.getCompletedOrders();
    }

    return Obx(
      () {
        if (type == "InProgress") {
          if (controller.isInProgressSuccess.isTrue) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraSmall,
                  vertical: Dimensions.paddingSizeExtraSmall),
              child: ListView.builder(
                itemCount: controller.inProgressOrderData.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // controller.astrologerName = controller
                      //     .chatChannelListModel
                      //     .data![index]
                      //     .displayName
                      //     .toString();
                      //
                      // controller.astrologerImage = controller
                      //     .chatChannelListModel
                      //     .data![index]
                      //     .astroImg
                      //     .toString();
                      //
                      // controller.channelName = controller
                      //     .chatChannelListModel
                      //     .data![index]
                      //     .channelName
                      //     .toString();
                      //
                      // Get.toNamed('/chatHistory');
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: Dimensions.paddingSizeExtraSmall),
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorResources.white,
                            borderRadius: BorderRadius.circular(
                                Dimensions.borderRadiusDefault),
                            border: Border.all(
                                color: ColorResources.colorPrimaryLight,
                                width: 1.5)),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeMediumSmall,
                                vertical: Dimensions.paddingSizeDefault),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomRoundNetworkImage(
                                    imageUrl: controller
                                        .inProgressOrderData[index].astroImg
                                        .toString(),
                                    height: 45,
                                    width: 45),
                                const Gap(Dimensions.gapMedium),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomTextMedium(
                                          controller.inProgressOrderData[index]
                                              .displayName
                                              .toString(),
                                          fontSize: Dimensions.fontSizeLarge),
                                      CustomTextRegular(
                                          controller.inProgressOrderData[index]
                                              .orderDate
                                              .toString(),
                                          color: ColorResources.black1,
                                          fontSize: Dimensions.fontSizeSmall),
                                      CustomTextRegular(
                                        "Session will expire at: ${controller.inProgressOrderData[index]
                                            .orderEnd
                                            .toString()}",
                                          color: ColorResources.colorSecondary,
                                          fontSize: Dimensions.fontSizeSmall),
                                      const Gap(5),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: ColorResources.colorPrimaryLight,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions
                                                  .borderRadiusExtraSmall),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              Dimensions
                                                  .paddingSizeExtraOverSmall),
                                          child: CustomTextRegular(
                                            "In-Progress",
                                            fontSize: Dimensions.fontSizeSmall,
                                            color: ColorResources.colorPrimaryDark,
                                          ),
                                        ),
                                      ),
                                      const Gap(6),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  ChatIntakeFormController chatIntakeFormController = Get.put(ChatIntakeFormController());
                                                  chatIntakeFormController.setAstrologerData(
                                                      controller.inProgressOrderData[index].displayName.toString(),
                                                      controller.inProgressOrderData[index].astroImg.toString(),
                                                      controller.inProgressOrderData[index].astrologerUniId.toString(),
                                                      AppConstants.video,
                                                  0);
                                                  controller.startServiceVideoCall(controller.inProgressOrderData[index].uniqeid.toString(),controller.inProgressOrderData[index].astrologerUniId.toString());
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                  ColorResources.colorPrimaryLight,
                                                  padding:
                                                  const EdgeInsets.only(
                                                      top: 0, bottom: 0),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8),
                                                  ),
                                                ),
                                                child: CustomTextRegular(
                                                    "Video")),
                                          ),
                                          const Gap(5),
                                          Expanded(
                                            child: ElevatedButton(
                                                onPressed: () async {
                                                  String? customerUniUd =
                                                      await SharedPreferencesHelper.getData(AppConstants.userUniId);
                                                  String astrologerUniId = controller.inProgressOrderData[index].astrologerUniId.toString();
                                                  String uniqueId = controller.inProgressOrderData[index].uniqeid.toString();
                                                  String channelName = '$customerUniUd-$astrologerUniId-$uniqueId';
                                                  String endTime = controller.inProgressOrderData[index].orderEnd.toString();

                                                  ArchitectChatIntakeFormController chatIntakeFormController = Get.put(ArchitectChatIntakeFormController());
                                                  chatIntakeFormController.setAstrologerData(controller.inProgressOrderData[index].displayName.toString(), controller.inProgressOrderData[index].astroImg.toString(), controller.inProgressOrderData[index].astrologerUniId.toString(),AppConstants.chat,endTime);
                                                  Get.toNamed('/architect_chat_screen', arguments: {
                                                    'channelName': channelName,
                                                    'uniqueId': uniqueId
                                                  });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                  ColorResources
                                                      .colorPrimary,
                                                  padding:
                                                  const EdgeInsets.only(
                                                      top: 8, bottom: 8),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(8),
                                                  ),
                                                ),
                                                child: CustomTextRegular(
                                                  "CHAT",
                                                  color: ColorResources.white,
                                                )),
                                          ),
                                        ],
                                      )
                                   
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (controller.isInProgressLoading.isTrue) {
            return ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return const SimmerListView();
              },
            );
          } else {
            return const EmptyScreen();
          }
        }

        if (type == "Completed") {
          if (controller.isCompletedSuccess.isTrue) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraSmall,
                  vertical: Dimensions.paddingSizeExtraSmall),
              child: ListView.builder(
                itemCount: controller.completedOrderData.length,
                itemBuilder: (context, index) {
                  String? orderType = controller.completedOrderData[index].orderType;

                  String? displayText = CommonMethods().architectOrderTypeLabel(orderType);
                  return GestureDetector(
                    onTap: (){
                      // controller.astrologerName = controller.completedOrderData[index]
                      //     .displayName
                      //     .toString();
                      //
                      // controller.astrologerImage = controller.completedOrderData[index]
                      //     .astroImg
                      //     .toString();
                      //
                      // controller.channelName = controller.completedOrderData[index]
                      //     .channelName
                      //     .toString();

                      Get.toNamed('/chatHistory');
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: Dimensions.paddingSizeExtraSmall),
                      child: Container(
                        decoration: CustomBoxDecoration.getBorderDecoration(),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeMediumSmall,
                                vertical: Dimensions.paddingSizeDefault),
                            child: Row(
                              children: [
                                CustomRoundNetworkImage(
                                    imageUrl: controller.completedOrderData[index]
                                        .astroImg
                                        .toString(),
                                    height: 55,
                                    width: 55),
                                const Gap(Dimensions.gapMedium),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      CustomTextMedium(
                                          controller.completedOrderData[index].displayName
                                              .toString(),
                                          fontSize:
                                          Dimensions.fontSizeLarge),
                                      CustomTextRegular(
                                          "($displayText)",
                                          color: ColorResources.black1,
                                          fontSize:
                                          Dimensions.fontSizeSmall),
                                      CustomTextRegular(
                                          "Amount: ${configController.currencySymbol}${controller.completedOrderData[index].charge.toString()}",
                                          color: ColorResources.colorPrimary,
                                      ),
                                      CustomTextRegular(
                                          controller.completedOrderData[index].updatedAt
                                              .toString(),
                                          color: ColorResources.black1,
                                          fontSize:
                                          Dimensions.fontSizeSmall),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios_rounded,
                                    size: 18,
                                    color: ColorResources.colorPrimary)
                              ],
                            )),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (controller.isCompletedLoading.isTrue) {
            return ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return const SimmerListView();
              },
            );
          } else {
            return const EmptyScreen();
          }
        }

        else {
          return const EmptyScreen();
        }
      },
    );
  }
}
