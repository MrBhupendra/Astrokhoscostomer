import 'package:astro_brahmand/utill/dimensions.dart';
import 'package:astro_brahmand/view/screen/chat/widget/chat_image_widget.dart';
import 'package:astro_brahmand/view/screen/chat/widget/chat_message_widget.dart';
import 'package:astro_brahmand/view/screen/slot_booking/slot_chat/controller/slot_chat_intake_form_controller.dart';
import 'package:astro_brahmand/view/screen/slot_booking/slot_chat/controller/slot_chat_screen_controller.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_bold.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../../utill/app_constants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/images.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_round_network_image.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../chat/controller/image_picker_controller.dart';
import '../../chat/model/chat_message_model.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class SlotChatScreen extends StatelessWidget {
  SlotChatScreen({super.key});

  final SlotChatScreenController controller = Get.put(SlotChatScreenController());
  final ImagePickerController imagePickerController = Get.put(ImagePickerController());
  final SlotChatIntakeFormController chatIntakeFormController = Get.find();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool isPopGesture) {
        if (!isPopGesture) {
          Get.back();
        }
      },
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorResources.colorPrimary,
            automaticallyImplyLeading: false,
            title: Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 22,
                        color: ColorResources.toolbarText,
                      ),
                      onPressed: () {
                        Get.back();
                      }),
                  const Gap(5),
                  CustomRoundNetworkImage(
                      imageUrl: chatIntakeFormController.astrologerImage.toString(),
                      height: 40,
                      width: 40),
                  const Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextMedium(
                            chatIntakeFormController.astrologerName.toString(),
                            fontSize: 16,
                            color: ColorResources.toolbarText),
                        Obx(() => controller.isArchitectOnline.isTrue
                            ? CustomTextRegular(
                                "Online",
                                color: ColorResources.white,
                                fontSize: Dimensions.fontSizeSmall,
                              )
                            : CustomTextRegular("Offline",
                                color: ColorResources.red,
                                fontSize: Dimensions.fontSizeSmall)),
                      ],
                    ),
                  )
                ]),
            titleSpacing: 0,
            actions: [
              GestureDetector(
                onTap: (){
                  String uniqueId = controller.uniqueId.toString();
                  //controller.startVoiceCall(uniqueId);
                },
                child: Container(
                  width: 32,
                  height: 32,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: ColorResources.colorPrimaryLight,
                      borderRadius: BorderRadius.circular(50)),
                  child: Image.asset(
                    Images.astroCall,
                    color: ColorResources.colorPrimaryDark,
                  ),
                ),
              ),
              const Gap(12),
              GestureDetector(
                onTap: (){
                  controller.dbReference.child(controller.isVideoCall).set(true);
                  controller.dbReference.child(controller.videoCallBy).set("Astrologer");
                },
                child: Container(
                  width: 32,
                  height: 32,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: ColorResources.colorPrimaryLight,
                      borderRadius: BorderRadius.circular(50)),
                  child: Image.asset(
                    Images.astroVideoCall,
                    // height: Dimensions.profileIconSize,
                    color: ColorResources.colorPrimaryDark,
                  ),
                ),
              ),
              const Gap(10),
            ],
          ),
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Images.chatBackground),
                    fit: BoxFit.fill)),
            child: Column(
              children: [
                //End time
                Container(
                  color: ColorResources.colorPrimaryLight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: CustomTextRegular(
                              "Session will expire at: ${chatIntakeFormController.endTime.toString()}",
                              fontSize: Dimensions.fontSizeDefault,
                              color: ColorResources.colorSecondary,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Obx(() => Visibility(
                    visible: controller.isChatHistoryLoading.isTrue,
                    child: const Text("Loading.."))),
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      itemCount: controller.chatHistoryList.length,
                      controller: controller.scrollController,
                      reverse: true,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        ChatMessageModel message =
                            controller.chatHistoryList[index];
                        if (message.messageType == AppConstants.text) {
                          return SwipeTo(
                            child: ChatMessageWidget(message, controller.uniId,isLastMessage: index == 0,),
                            onRightSwipe: (details) {
                              controller.selectedType.value = AppConstants.text;
                              controller.selectedText.value = controller
                                  .chatHistoryList[index].text
                                  .toString();
                              controller.selectedPersonName.value = (controller
                                          .chatHistoryList[index].senderUniId
                                          .toString() ==
                                      controller.uniId
                                  ? "You"
                                  : controller.chatHistoryList[index].name
                                      .toString());
                              controller.isMessageSelected(true);
                            },
                          );
                        } else if (message.messageType == AppConstants.image) {
                          return SwipeTo(
                            child: ChatImageWidget(message, controller.uniId),
                            onRightSwipe: (details) {
                              controller.selectedType.value =
                                  AppConstants.image;
                              controller.selectedText.value = controller
                                  .chatHistoryList[index].fileUrl
                                  .toString();
                              controller.selectedPersonName.value = (controller
                                          .chatHistoryList[index].senderUniId
                                          .toString() ==
                                      controller.uniId
                                  ? "You"
                                  : controller.chatHistoryList[index].name
                                      .toString());
                              controller.isMessageSelected(true);
                            },
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ),
                const Gap(5.0),
                Container(
                  decoration: const BoxDecoration(
                      color: ColorResources.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Voice note
                      Visibility(
                        visible: false,
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () =>
                                  controller.startRecording(),
                              child: const Text('Start Recording'),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => controller.stopRecording(),
                              child: const Text('Stop Recording'),
                            ),
                          ],
                        ),
                      ),
                      //Image Uploading
                      // For Capture Image
                      Obx(
                            () {
                          if (imagePickerController.isImagePicked.isTrue) {
                            // Send Image
                            AppLogger.d("isCaptureImage.isTrue ${imagePickerController.isImagePicked.isTrue}");
                            AppLogger.d("imageFile.value ${imagePickerController.imageFile.value}");
                            return Visibility(
                                visible: imagePickerController.isImagePicked.isTrue,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      // Display the captured image
                                      imagePickerController.imageFile.value != null
                                          ? Image.file(
                                        imagePickerController.imageFile.value!,
                                        width: 50,
                                        height: 50,
                                      )
                                          : Image.asset(
                                        Images.placeholder,
                                        width: 50,
                                        height: 50,
                                      ),
                                      const Gap(5),
                                      CustomTextRegular('Uploading image..')
                                    ],
                                  ),
                                )
                            );
                          } else {
                            return const Visibility(visible: false, child: Text(''));
                          }
                        },
                      ),
                      // For Image Picker
                      Obx(
                            () {
                          if (imagePickerController
                              .isImagePicked.isTrue) {
                            //SendImage
                            controller.sendImage(
                                imagePickerController.imageFile.value!,
                                imagePickerController.fileName
                                    .toString());

                            return Visibility(
                                visible: imagePickerController
                                    .isImagePicked.isTrue,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Image.file(
                                        imagePickerController
                                            .imageFile.value!,
                                        width: 50,
                                        height: 50,
                                      ),
                                      const Gap(5),
                                      CustomTextRegular(
                                          'Uploading image..')
                                    ],
                                  ),
                                ));
                          } else {
                            return const Visibility(
                                visible: false, child: Text(''));
                          }
                        },
                      ),

                      //Selected
                      Obx(
                            () {
                          if (controller.isMessageSelected.isTrue &&
                              controller.selectedType.value ==
                                  AppConstants.text) {
                            return Visibility(
                                visible:
                                controller.isMessageSelected.isTrue &&
                                    controller.selectedType.value ==
                                        AppConstants.text,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Obx(() => Expanded(
                                            child: CustomTextBold(
                                              'Replying to ${controller.selectedPersonName.value.toString()}',
                                            ),
                                          )),
                                          GestureDetector(
                                              onTap: () {
                                                controller.selectedType
                                                    .value = "";
                                                controller.selectedText
                                                    .value = "";
                                                controller
                                                    .selectedPersonName
                                                    .value = "";
                                                controller
                                                    .isMessageSelected(
                                                    false);
                                              },
                                              child: Image.asset(
                                                  Images.close,
                                                  height: 12,
                                                  width: 12))
                                        ],
                                      ),
                                      Obx(() => CustomTextRegular(
                                          controller.selectedText.value
                                              .toString()))
                                    ],
                                  ),
                                ));
                          } else if (controller
                              .isMessageSelected.isTrue &&
                              controller.selectedType.value ==
                                  AppConstants.image) {
                            return Visibility(
                                visible:
                                controller.isMessageSelected.isTrue &&
                                    controller.selectedType.value ==
                                        AppConstants.image,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Obx(() => Expanded(
                                            child: CustomTextBold(
                                              'Replying to ${controller.selectedPersonName.value.toString()}',
                                            ),
                                          )),
                                          GestureDetector(
                                              onTap: () {
                                                controller.selectedType
                                                    .value = "";
                                                controller.selectedText
                                                    .value = "";
                                                controller
                                                    .selectedPersonName
                                                    .value = "";
                                                controller
                                                    .isMessageSelected(
                                                    false);
                                              },
                                              child: Image.asset(
                                                  Images.close,
                                                  height: 12,
                                                  width: 12))
                                        ],
                                      ),
                                      Obx(() => CustomNetworkImage(
                                          imageUrl: controller
                                              .selectedText.value
                                              .toString(),
                                          height: 45,
                                          width: 45))
                                    ],
                                  ),
                                ));
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),

                      //SendMessage
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  imagePickerController
                                      .showSelectBottomSheet();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6.0, right: 4),
                                  child: Image.asset(Images.addImage,
                                      height: 30, width: 30),
                                )),
                            Flexible(
                                child: TextField(
                                  controller: _messageController,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: ColorResources.black),
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter Message...'),
                                )),
                            ElevatedButton(
                                onPressed: () async {
                                  if (_messageController
                                      .text.isNotEmpty) {
                                    String? uniId =
                                    await SharedPreferencesHelper
                                        .getData(
                                        AppConstants.userUniId);
                                    ChatMessageModel chatMessage;
                                    if (controller
                                        .isMessageSelected.isTrue) {
                                      chatMessage = ChatMessageModel(
                                        senderUniId: uniId,
                                        date: controller
                                            .getCurrentDateTime(),
                                        fileUrl: "",
                                        messageType: AppConstants.text,
                                        name: controller.customerName,
                                        profileImageUrl:
                                        controller.customerImage,
                                        selectedText: controller
                                            .selectedText.value
                                            .toString(),
                                        selectedType: controller
                                            .selectedType.value
                                            .toString(),
                                        text: _messageController.text
                                            .toString(),
                                      );
                                    } else {
                                      chatMessage = ChatMessageModel(
                                        senderUniId: uniId,
                                        date: controller
                                            .getCurrentDateTime(),
                                        fileUrl: "",
                                        messageType: AppConstants.text,
                                        name: controller.customerName,
                                        profileImageUrl:
                                        controller.customerImage,
                                        selectedText: "",
                                        selectedType: "",
                                        text: _messageController.text
                                            .toString(),
                                      );
                                    }
                                    controller.sendMessage(
                                        chatMessage, null, '');

                                    _messageController.clear();

                                    controller.selectedType.value = "";
                                    controller.selectedText.value = "";
                                    controller.selectedPersonName.value =
                                    "";
                                    controller.isMessageSelected(false);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    backgroundColor:
                                    ColorResources.colorPrimary),
                                child: const Icon(
                                  Icons.send,
                                  color: ColorResources.white,
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
