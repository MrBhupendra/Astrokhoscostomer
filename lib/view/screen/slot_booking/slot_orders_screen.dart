import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:astro_brahmand/view/screen/slot_booking/controller/slot_order_controller.dart';
import 'package:astro_brahmand/view/screen/slot_booking/slot_chat/controller/slot_chat_intake_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/shared_preference.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_round_network_image.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import '../../widget/simmer_widget/simmer_list_view.dart';
import '../architect/architect_chat/controller/architect_chat_intake_form_controller.dart';
import '../chat/controller/chat_intake_form_controller.dart';

class SlotOrdersScreen extends StatelessWidget {
  final String type;

  SlotOrdersScreen(this.type, {super.key});

  final SlotOrderController controller = Get.put(SlotOrderController());

  @override
  Widget build(BuildContext context) {
   if (type == AppConstants.slotBooking) {
      controller.offsetCount = 0;
      controller.isOrderSuccess(false);
      controller.getSlotBookings(controller.offsetCount);

      controller.scrollController.addListener(() {
        if (controller.scrollController.position.pixels == controller.scrollController.position.maxScrollExtent) {
          if (controller.isOrderLoading.isFalse && !controller.isNoMoreData) {
            controller.getSlotBookings(controller.offsetCount);
          }
        }
      });
    }

    return Obx(() {
        if (type == AppConstants.slotBooking) {
          if(controller.isOrderSuccess.isTrue){
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeExtraSmall,
                        vertical: Dimensions.paddingSizeExtraSmall),
                    child: ListView.builder(
                      itemCount: controller.slotOrderData.length,
                      controller: controller.scrollController,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: Dimensions.paddingSizeExtraSmall),
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorResources.white,
                                borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                                border: Border.all(color: ColorResources.colorPrimaryLight, width: 1.5)),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingSizeMediumSmall,
                                    vertical: Dimensions.paddingSizeDefault),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomRoundNetworkImage(
                                        imageUrl: controller.slotOrderData[index].astrologerImg.toString(),
                                        height: 45,
                                        width: 45),
                                    const Gap(Dimensions.gapMedium),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          CustomTextMedium(
                                              controller.slotOrderData[index]
                                                  .astrologerDisplayName
                                                  .toString(),
                                              fontSize: Dimensions.fontSizeLarge),
                                          CustomTextRegular(
                                              controller.slotOrderData[index]
                                                  .slotDate
                                                  .toString(),
                                              color: ColorResources.black1,
                                              fontSize: Dimensions.fontSizeSmall),
                                          CustomTextRegular(
                                              "Session will expire at: ${controller.slotOrderData[index]
                                                  .slotEnd
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
                                                controller.slotOrderData[index]
                                                    .status
                                                    .toString(),
                                                fontSize: Dimensions.fontSizeSmall,
                                                color: ColorResources.colorPrimaryDark,
                                              ),
                                            ),
                                          ),
                                          const Gap(6),
                                          if(controller.slotOrderData[index].status.toString() == "in-progress")
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      ChatIntakeFormController chatIntakeFormController = Get.put(ChatIntakeFormController());
                                                      chatIntakeFormController.setAstrologerData(
                                                          controller.slotOrderData[index].astrologerDisplayName.toString(),
                                                          controller.slotOrderData[index].astrologerImg.toString(),
                                                          controller.slotOrderData[index].astrologerUniId.toString(),
                                                          AppConstants.video,
                                                      0);
                                                      controller.startSlotVideoCall(controller.slotOrderData[index].orderId.toString(),controller.slotOrderData[index].astrologerUniId.toString());
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
                                                    onPressed: () {
                                                      ChatIntakeFormController chatIntakeFormController = Get.put(ChatIntakeFormController());
                                                      chatIntakeFormController.setAstrologerData(
                                                          controller.slotOrderData[index].astrologerDisplayName.toString(),
                                                          controller.slotOrderData[index].astrologerImg.toString(),
                                                          controller.slotOrderData[index].astrologerUniId.toString(),
                                                          AppConstants.video,
                                                      0);
                                                      controller.startSlotVideoCall(controller.slotOrderData[index].orderId.toString(),controller.slotOrderData[index].astrologerUniId.toString());
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
                                                        "Call")),
                                              ),
                                              const Gap(5),
                                              Expanded(
                                                child: ElevatedButton(
                                                    onPressed: () async {
                                                      String? customerUniUd = await SharedPreferencesHelper.getData(AppConstants.userUniId);
                                                      String astrologerUniId = controller.slotOrderData[index].astrologerUniId.toString();
                                                      String uniqueId = controller.slotOrderData[index].orderId.toString();
                                                      String channelName = '$customerUniUd-$astrologerUniId-$uniqueId';
                                                      String endTime = controller.slotOrderData[index].slotEnd.toString();

                                                      SlotChatIntakeFormController chatIntakeFormController = Get.put(SlotChatIntakeFormController());
                                                      chatIntakeFormController.setAstrologerData(controller.slotOrderData[index].astrologerDisplayName.toString(), controller.slotOrderData[index].astrologerImg.toString(), controller.slotOrderData[index].astrologerUniId.toString(),AppConstants.chat,endTime);
                                                      Get.toNamed('/slot_chat_screen', arguments: {
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
                        );
                      },
                    ),
                  ),
                ),
                Obx(() => Visibility(
                    visible: controller.isOrderLoading.isTrue,
                    child: CustomTextRegular('Loading...'),
                  ),
                )
              ],
            );
          }
          else if (controller.isOrderLoading.isTrue) {
            return ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return const SimmerListView();
              },
            );
          }
          else {
            return const EmptyScreen();
          }
        }

        else {
          return Center(
            child: CustomTextRegular(
              AppStrings.somethingWentWrong.tr,
              fontSize: Dimensions.fontSizeLarge,
            ),
          );
        }
      },
    );
  }
}
