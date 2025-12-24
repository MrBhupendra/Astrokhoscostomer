import 'package:astro_brahmand/view/screen/queue_list/controller/queue_controller.dart';
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:astro_brahmand/view/widget/custom_empty_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../widget/custom_default_indicator.dart';
import '../../widget/custom_round_network_image.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import '../chat/controller/chat_intake_form_controller.dart';

class QueueListScreen extends GetView<QueueController> {
  const QueueListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getQueueList();
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: "My Queue List"),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.isQueueSuccess(false);
            controller.getQueueList();
          },
          child: Obx(
            () {
              if (controller.isQueueSuccess.isTrue) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeExtraSmall,
                    vertical: Dimensions.paddingSizeExtraSmall,
                  ),
                  child: ListView.builder(
                    itemCount: controller.queueListData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: Dimensions.paddingSizeExtraSmall,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorResources.white,
                            borderRadius: BorderRadius.circular(
                              Dimensions.borderRadiusDefault,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeMediumSmall,
                              vertical: Dimensions.paddingSizeDefault,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomTextRegular(
                                            "#REF ID: ${controller.queueListData[index].uniqeid}",
                                            color: ColorResources.black2,
                                            maxLines: 1,
                                          ),
                                          const Gap(3),
                                          CustomTextMedium(
                                              controller.queueListData[index].displayName
                                                  .toString(),
                                              maxLines: 2),
                                          const Gap(3),
                                          CustomTextRegular(
                                            controller.queueListData[index].orderDate
                                                .toString(),
                                            color: ColorResources.black2,
                                            maxLines: 1,
                                          ),
                                          const Gap(3),
                                          CustomTextRegular(
                                            "My Queue Count (${controller.queueListData[index].myQueueNumber})",
                                            color: ColorResources.black2,
                                            maxLines: 1,
                                          ),
                                          const Gap(3),
                                          CustomTextRegular(
                                            "Est Waiting Time ${getFormattedTime(int.parse(controller.queueListData[index].totalWaitingTime.toString()))}",
                                            color: ColorResources.black2,
                                            maxLines: 1,
                                          ),
                                          const Gap(3),
                                          // Image.asset(Images.info,height: 25,width: 25,)
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CustomRoundNetworkImage(
                                            imageUrl: controller.queueListData[index].astroImg
                                                .toString(),
                                            height: 50,
                                            width: 50),
                                        CustomTextRegular(
                                          controller.queueListData[index]
                                              .callType
                                              .toString()
                                              .toUpperCase(),
                                          fontSize: Dimensions.fontSizeDefault,
                                          color:
                                              ColorResources.colorPrimaryDark,
                                          maxLines: 2,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const Gap(5),
                                if (controller.queueListData[index].callType == "chat")
                                  Visibility(
                                    visible: controller.queueListData[index].callType ==
                                        "chat",
                                    child: Row(
                                      children: [
                                        Visibility(
                                          visible: controller.queueListData[index].status ==
                                                  "queue" ||
                                              controller.queueListData[index].status ==
                                                  "queue_request",
                                          child: Expanded(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  String uniqueId = controller.queueListData[index].uniqeid.toString();
                                                  int? id = controller.queueListData[index].id?.toInt();
                                                  controller.declineRequest(uniqueId,index, id!);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      ColorResources.black8,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 12, bottom: 12),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                child: CustomTextRegular(
                                                    "Cancel")),
                                          ),
                                        ),
                                        const Gap(5),
                                        Visibility(
                                          visible: controller.queueListData[index].status ==
                                              "queue_request",
                                          child: Expanded(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  int? id = controller.queueListData[index].id?.toInt() ?? 0;
                                                  AwesomeNotifications().cancel(id);
                                                  ChatIntakeFormController chatIntakeFormController = Get.put(ChatIntakeFormController());
                                                  chatIntakeFormController.setAstrologerData(controller.queueListData[index].displayName.toString(), controller.queueListData[index].astroImg.toString(), controller.queueListData[index].astrologerUniId.toString(),AppConstants.chat,controller.queueListData[index].isVirtualAstrologer ?? 0);
                                                  chatIntakeFormController.setIntakeData(
                                                      controller.queueListData[index].intake!.name.toString(),
                                                      controller.queueListData[index].intake!.gender.toString(),
                                                      controller.queueListData[index].intake!.dob.toString(),
                                                      controller.queueListData[index].intake!.tob.toString(),
                                                      controller.queueListData[index].intake!.birthPlace.toString(),
                                                      controller.queueListData[index].intake!.lat.toString(),
                                                      controller.queueListData[index].intake!.long.toString(),
                                                      controller.queueListData[index].intake!.maritalStatus.toString(),
                                                      controller.queueListData[index].intake!.occupation.toString(),
                                                      controller.queueListData[index].intake!.topic.toString(),
                                                      controller.queueListData[index].intake!.other.toString(),
                                                      partnerName_: controller.queueListData[index].intake!.partnerName ?? "",
                                                      partnerGender_: controller.queueListData[index].intake!.partnerGender ?? "",
                                                      partnerDob_: controller.queueListData[index].intake!.partnerDob ?? "",
                                                      partnerTob_: controller.queueListData[index].intake!.partnerTob ?? "",
                                                      partnerBirthPlace_: controller.queueListData[index].intake!.partnerBirthPlace ?? "",
                                                      partnerLatitude_: controller.queueListData[index].intake!.partnerLat ?? "",
                                                      partnerLongitude_: controller.queueListData[index].intake!.partnerLong ?? ""
                                                  );

                                                  String? astrologerUniId = chatIntakeFormController.astrologerUniId;
                                                  chatIntakeFormController.startChat(astrologerUniId);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      ColorResources
                                                          .colorPrimary,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 12, bottom: 12),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                child: CustomTextRegular(
                                                  "CHAT",
                                                  color: ColorResources.white,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (controller.queueListData[index].callType == "call")
                                  Visibility(
                                    visible: controller.queueListData[index].callType == "call",
                                    child: Row(
                                      children: [
                                        Visibility(
                                          visible: controller.queueListData[index].status == "queue",
                                          child: Expanded(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  String uniqueId = controller.queueListData[index].uniqeid.toString();
                                                  int? id = controller.queueListData[index].id?.toInt();
                                                    controller.declineRequest(uniqueId,index, id!);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      ColorResources.black8,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 12, bottom: 12),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                child: CustomTextRegular(
                                                    "Cancel")),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (controller.queueListData[index].callType == "video")
                                  Visibility(
                                    visible: controller.queueListData[index].callType ==
                                        "video",
                                    child: Row(
                                      children: [
                                        Visibility(
                                          visible: controller.queueListData[index].status ==
                                              "queue" ||
                                              controller.queueListData[index].status ==
                                                  "queue_request",
                                          child: Expanded(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  String uniqueId = controller.queueListData[index].uniqeid.toString();
                                                  int? id = controller.queueListData[index].id?.toInt();
                                                  controller.declineRequest(uniqueId,index, id!);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                  ColorResources.black8,
                                                  padding:
                                                  const EdgeInsets.only(
                                                      top: 12, bottom: 12),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8),
                                                  ),
                                                ),
                                                child: CustomTextRegular(
                                                    "Cancel")),
                                          ),
                                        ),
                                        const Gap(5),
                                        Visibility(
                                          visible: controller.queueListData[index].status == "queue_request",
                                          child: Expanded(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  int? id = controller.queueListData[index].id?.toInt() ?? 0;
                                                  AwesomeNotifications().cancel(id);
                                                  ChatIntakeFormController chatIntakeFormController = Get.put(ChatIntakeFormController());
                                                  chatIntakeFormController.setAstrologerData(controller.queueListData[index].displayName.toString(), controller.queueListData[index].astroImg.toString(), controller.queueListData[index].astrologerUniId.toString(),AppConstants.video,0);
                                                  chatIntakeFormController.setIntakeData(
                                                      controller.queueListData[index].intake!.name.toString(),
                                                      controller.queueListData[index].intake!.gender.toString(),
                                                      controller.queueListData[index].intake!.dob.toString(),
                                                      controller.queueListData[index].intake!.tob.toString(),
                                                      controller.queueListData[index].intake!.birthPlace.toString(),
                                                      controller.queueListData[index].intake!.lat.toString(),
                                                      controller.queueListData[index].intake!.long.toString(),
                                                      controller.queueListData[index].intake!.maritalStatus.toString(),
                                                      controller.queueListData[index].intake!.occupation.toString(),
                                                      controller.queueListData[index].intake!.topic.toString(),
                                                      controller.queueListData[index].intake!.other.toString(),
                                                      partnerName_: controller.queueListData[index].intake!.partnerName ?? "",
                                                      partnerGender_: controller.queueListData[index].intake!.partnerGender ?? "",
                                                      partnerDob_: controller.queueListData[index].intake!.partnerDob ?? "",
                                                      partnerTob_: controller.queueListData[index].intake!.partnerTob ?? "",
                                                      partnerBirthPlace_: controller.queueListData[index].intake!.partnerBirthPlace ?? "",
                                                      partnerLatitude_: controller.queueListData[index].intake!.partnerLat ?? "",
                                                      partnerLongitude_: controller.queueListData[index].intake!.partnerLong ?? ""
                                                  );

                                                  String? astrologerUniId = chatIntakeFormController.astrologerUniId;
                                                  chatIntakeFormController.startVideoCall(astrologerUniId);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                  ColorResources
                                                      .colorPrimary,
                                                  padding:
                                                  const EdgeInsets.only(
                                                      top: 12, bottom: 12),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8),
                                                  ),
                                                ),
                                                child: CustomTextRegular(
                                                  "Video Call",
                                                  color: ColorResources.white,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (controller.queueListData[index].callType == "call")
                                  Visibility(
                                    visible: controller.queueListData[index].callType ==
                                        "call",
                                    child: Row(
                                      children: [
                                        Visibility(
                                          visible: controller.queueListData[index].status ==
                                              "queue" ||
                                              controller.queueListData[index].status ==
                                                  "queue_request",
                                          child: Expanded(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  String uniqueId = controller.queueListData[index].uniqeid.toString();
                                                  int? id = controller.queueListData[index].id?.toInt();
                                                  controller.declineRequest(uniqueId,index,id!);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                  ColorResources.black8,
                                                  padding:
                                                  const EdgeInsets.only(
                                                      top: 12, bottom: 12),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8),
                                                  ),
                                                ),
                                                child: CustomTextRegular(
                                                    "Cancel")),
                                          ),
                                        ),
                                        const Gap(5),
                                        Visibility(
                                          visible: controller.queueListData[index].status ==
                                              "queue_request",
                                          child: Expanded(
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  int? id = controller.queueListData[index].id?.toInt() ?? 0;
                                                  AwesomeNotifications().cancel(id);
                                                  ChatIntakeFormController chatIntakeFormController = Get.put(ChatIntakeFormController());
                                                  chatIntakeFormController.setAstrologerData(controller.queueListData[index].displayName.toString(), controller.queueListData[index].astroImg.toString(), controller.queueListData[index].astrologerUniId.toString(),AppConstants.call,0);
                                                  chatIntakeFormController.setIntakeData(
                                                      controller.queueListData[index].intake!.name.toString(),
                                                      controller.queueListData[index].intake!.gender.toString(),
                                                      controller.queueListData[index].intake!.dob.toString(),
                                                      controller.queueListData[index].intake!.tob.toString(),
                                                      controller.queueListData[index].intake!.birthPlace.toString(),
                                                      controller.queueListData[index].intake!.lat.toString(),
                                                      controller.queueListData[index].intake!.long.toString(),
                                                      controller.queueListData[index].intake!.maritalStatus.toString(),
                                                      controller.queueListData[index].intake!.occupation.toString(),
                                                      controller.queueListData[index].intake!.topic.toString(),
                                                      controller.queueListData[index].intake!.other.toString(),
                                                      partnerName_: controller.queueListData[index].intake!.partnerName ?? "",
                                                      partnerGender_: controller.queueListData[index].intake!.partnerGender ?? "",
                                                      partnerDob_: controller.queueListData[index].intake!.partnerDob ?? "",
                                                      partnerTob_: controller.queueListData[index].intake!.partnerTob ?? "",
                                                      partnerBirthPlace_: controller.queueListData[index].intake!.partnerBirthPlace ?? "",
                                                      partnerLatitude_: controller.queueListData[index].intake!.partnerLat ?? "",
                                                      partnerLongitude_: controller.queueListData[index].intake!.partnerLong ?? ""
                                                  );

                                                  String? astrologerUniId = chatIntakeFormController.astrologerUniId;
                                                  chatIntakeFormController.startInAppVoiceCall(astrologerUniId);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                  ColorResources
                                                      .colorPrimary,
                                                  padding:
                                                  const EdgeInsets.only(
                                                      top: 12, bottom: 12),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8),
                                                  ),
                                                ),
                                                child: CustomTextRegular(
                                                  "Call",
                                                  color: ColorResources.white,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              else if (controller.isQueueLoading.isTrue) {
                return const CustomDefaultProgressIndicator();
              } else {
                return const EmptyScreen();
              }
            },
          ),
        ),
      ),
    );
  }

  String getFormattedTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds ~/ 60) % 60;
    num remainingSeconds = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
