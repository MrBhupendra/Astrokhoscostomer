import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../../utill/shared_preference.dart';
import '../../widget/custom_network_image.dart';
import '../../widget/custom_round_network_image.dart';
import '../../widget/custom_snack_bar.dart';
import '../../widget/custom_text_bold.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import '../chat/controller/chat_intake_form_controller.dart';
import '../chat/controller/image_picker_controller.dart';
import '../chat/model/chat_message_model.dart';
import '../chat/widget/chat_image_widget.dart';
import '../chat/widget/chat_message_widget.dart';
import '../chat/widget/chat_product_widget.dart';
import '../chat/widget/chat_voice_note_widget.dart';
import '../splash/controller/config_controller.dart';
import 'controller/assistant_chat_controller.dart';

class AssistantChatScreen extends StatelessWidget {
  AssistantChatScreen({super.key}){
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToTop();
    });
  }

  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _showScrollToTop = ValueNotifier(false);

  void _scrollListener() {
    // Show the "scroll to top" button when not at the top
    if (_scrollController.offset > 15.0) {
      _showScrollToTop.value = true;
    } else {
      _showScrollToTop.value = false;
    }
  }

  void _scrollToTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0, // Scroll to the top
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  final AssistantChatController controller = Get.put(AssistantChatController());
  final ImagePickerController imagePickerController = Get.put(ImagePickerController());
  final ChatIntakeFormController chatIntakeFormController = Get.find();

  //For Bg Notification
  final ConfigController configController = Get.find();

  @override
  Widget build(BuildContext context) {
    configController.setCurrentScreen(AppConstants.chat);
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
                            '${chatIntakeFormController.astrologerName.toString()} ${"'s"} Assistant',
                            fontSize: 16,
                            color: ColorResources.toolbarText),
                      ],
                    ),
                  ),
                ]),
            titleSpacing: 0,
          ),
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Images.chatBackground),
                    fit: BoxFit.fill)),
            child: Column(
              children: [
                //Loading
                Obx(() => Visibility(
                    visible: controller.isChatHistoryLoading.isTrue,
                    child: const Text("Loading.."))),
                Expanded(
                  child: Obx(
                        () => ListView.builder(
                      itemCount: controller.chatHistoryList.length,
                      controller: _scrollController,
                      reverse: true,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        ChatMessageModel message =
                        controller.chatHistoryList[index];
                        if (message.messageType == AppConstants.text) {
                          return SwipeTo(
                            child: ChatMessageWidget(message, controller.uniId,isLastMessage: index == 0,),
                            onRightSwipe: (details) {
                              controller.selectedType.value =
                                  AppConstants.text;
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
                        }
                        else if (message.messageType == AppConstants.image) {
                          return SwipeTo(
                            child: ChatImageWidget(message, controller.uniId),
                            onRightSwipe: (details) {
                              controller.selectedType.value = AppConstants.image;
                              controller.selectedText.value = controller.chatHistoryList[index].fileUrl.toString();
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
                        else if (message.messageType == AppConstants.voiceNote) {
                          return SwipeTo(
                            child: ChatVoiceNoteWidget(message, controller.uniId),
                            onRightSwipe: (details) {
                              // controller.selectedType.value = AppConstants.voiceNote;
                              // controller.selectedText.value = controller.chatHistoryList[index].fileUrl.toString();
                              // controller.selectedPersonName.value = (controller
                              //     .chatHistoryList[index].senderUniId
                              //     .toString() ==
                              //     controller.uniId
                              //     ? "You"
                              //     : controller.chatHistoryList[index].name
                              //     .toString());
                              // controller.isMessageSelected(true);
                            },
                          );
                        }
                        else if (message.messageType == AppConstants.product || message.messageType == AppConstants.service) {
                          return SwipeTo(
                            child: ChatProductWidget(message, controller.uniId, message.messageType),
                            onRightSwipe: (details) {
                              // controller.selectedType.value = AppConstants.product;
                              // controller.selectedText.value = controller.chatHistoryList[index].fileUrl.toString();
                              // controller.selectedPersonName.value = (controller
                              //     .chatHistoryList[index].senderUniId
                              //     .toString() ==
                              //     controller.uniId
                              //     ? "You"
                              //     : controller.chatHistoryList[index].name
                              //     .toString());
                              // controller.isMessageSelected(true);
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
                          topLeft: Radius.circular(15))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Typing Indicators
                      Obx(
                            () {
                          if (controller.isAstrologerTyping.isTrue) {
                            return Visibility(
                                visible: controller.isAstrologerTyping.isTrue,
                                child: Container(
                                  color: ColorResources.blackTransparent,
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 0),
                                  child: Row(
                                    children: [
                                      CustomTextRegular("Typing"),
                                      Lottie.asset(
                                        Images.animTyping,
                                        width: 40,
                                        height: 40,
                                        // fit: BoxFit.contain,
                                      ),
                                    ],
                                  ),
                                ));
                          }else{
                            return const SizedBox();
                          }
                        },
                      ),

                      //Voice Note Uploading
                      Obx(
                            () {
                          if (controller.isRecordingUploading.isTrue) {
                            return Visibility(
                                visible: controller.isRecordingUploading.isTrue,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                                  child: CustomTextRegular('Uploading recording...'),
                                ));
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),

                      //Recording note
                      // Obx(
                      //       () {
                      //     if (controller.isRecording.isTrue) {
                      //       return Visibility(
                      //         visible: controller.isRecording.isTrue,
                      //         child: Padding(
                      //           padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                      //           child: CustomTextRegular(
                      //               'Recording...'),
                      //         ),
                      //       );
                      //     } else {
                      //       return const SizedBox.shrink();
                      //     }
                      //   },
                      // ),
                      Obx(
                            () {
                          if (controller.isRecording.isTrue) {
                            return Visibility(
                              visible: controller.isRecording.isTrue,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                                child: Row(
                                  children: [
                                    CustomTextRegular('Recording...'),
                                    const Gap(5),
                                    if (controller.isRecording.value)
                                      CustomTextRegular('${(controller.recordingDuration ~/ 60).toString().padLeft(2, '0')}:${(controller.recordingDuration % 60).toString().padLeft(2, '0')}'),
                                  ],
                                ),
                              ),
                            );
                            // if (controller.isRecording.value)
                            //   Padding(
                            //     padding: const EdgeInsets.only(bottom: 5.0),
                            //     child: Text(
                            //       "${(controller.recordingDuration ~/ 60).toString().padLeft(2, '0')}:${(controller.recordingDuration % 60).toString().padLeft(2, '0')}",
                            //       style: const TextStyle(
                            //         color: Colors.red, // Red color for visibility
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //   ),
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),

                      //Image Uploading
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
                                    controller.selectedType
                                        .value ==
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
                                                controller
                                                    .selectedType
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
                          }
                          else if (controller
                              .isMessageSelected.isTrue &&
                              controller.selectedType.value ==
                                  AppConstants.image) {
                            return Visibility(
                                visible:
                                controller.isMessageSelected.isTrue &&
                                    controller.selectedType
                                        .value ==
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
                                                controller
                                                    .selectedType
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

                      // //SendMessage
                      // Padding(
                      //   padding:
                      //   const EdgeInsets.symmetric(vertical: 2.0),
                      //   child: Row(
                      //     children: [
                      //       GestureDetector(
                      //           onTap: () {
                      //             imagePickerController.showSelectBottomSheet();
                      //           },
                      //           child: Padding(
                      //             padding: const EdgeInsets.only(left: 8.0, right: 8),
                      //             child: Image.asset(Images.icAttachment, height: 20, width: 20),
                      //           )
                      //       ),
                      //       Flexible(child: TextField(
                      //         controller: controller.messageController,
                      //         style: const TextStyle(
                      //             fontSize: 16,
                      //             color: ColorResources.black),
                      //         decoration: const InputDecoration(
                      //             border: InputBorder.none,
                      //             hintText: 'Enter Message...'),
                      //       )),
                      //       ElevatedButton(
                      //           onPressed: () async {
                      //             if (controller.messageController.text.isNotEmpty) {
                      //               String? uniId =
                      //               await SharedPreferencesHelper.getData(AppConstants.userUniId);
                      //               ChatMessageModel chatMessage;
                      //               if (controller.isMessageSelected.isTrue) {
                      //                 chatMessage = ChatMessageModel(
                      //                   senderUniId: uniId,
                      //                   date: controller
                      //                       .getCurrentDateTime(),
                      //                   fileUrl: "",
                      //                   messageType: AppConstants.text,
                      //                   name: controller.customerName,
                      //                   profileImageUrl:
                      //                   controller.customerImage,
                      //                   selectedText: controller
                      //                       .selectedText.value
                      //                       .toString(),
                      //                   selectedType: controller
                      //                       .selectedType.value
                      //                       .toString(),
                      //                   text: controller.messageController.text
                      //                       .toString(),
                      //                 );
                      //               } else {
                      //                 chatMessage = ChatMessageModel(
                      //                   senderUniId: uniId,
                      //                   date: controller
                      //                       .getCurrentDateTime(),
                      //                   fileUrl: "",
                      //                   messageType: AppConstants.text,
                      //                   name: controller.customerName,
                      //                   profileImageUrl:
                      //                   controller.customerImage,
                      //                   selectedText: "",
                      //                   selectedType: "",
                      //                   text: controller.messageController.text
                      //                       .toString(),
                      //                 );
                      //               }
                      //               controller.sendMessage(chatMessage, null, '');
                      //
                      //               controller.messageController.clear();
                      //
                      //               controller.selectedType.value = "";
                      //               controller.selectedText.value = "";
                      //               controller.selectedPersonName.value = "";
                      //               controller.isMessageSelected(false);
                      //             }
                      //           },
                      //           style: ElevatedButton.styleFrom(
                      //               shape: const CircleBorder(),
                      //               backgroundColor:
                      //               ColorResources.colorPrimary),
                      //           child: const Icon(
                      //             Icons.send,
                      //             color: ColorResources.white,
                      //           )),
                      //       GestureDetector(
                      //         onTap: () {
                      //           CustomSnackBar.showTop("Press and hold the button to record");
                      //         },
                      //         onLongPressStart: (_) => controller.checkPermissionStartRecording(),
                      //         onLongPressEnd: (_) => controller.stopRecording(),
                      //         child: Obx(() => AnimatedContainer(
                      //           duration: const Duration(milliseconds: 300),
                      //           alignment: Alignment.center, // Keep everything centered
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.center, // Keep mic and text centered
                      //             children: [
                      //               AnimatedContainer(
                      //                 duration: const Duration(milliseconds: 300),
                      //                 width: controller.isRecording.value ? 75 : 40, // Increase size of icon container
                      //                 height: controller.isRecording.value ? 75 : 40, // Height same as width to make it square
                      //                 decoration: BoxDecoration(
                      //                   color: ColorResources.colorPrimary,
                      //                   shape: BoxShape.circle, // Circular border around the mic
                      //                   border: Border.all(
                      //                     color: controller.isRecording.value ? ColorResources.colorPrimary : ColorResources.colorPrimary, // Border color based on recording state
                      //                     width: controller.isRecording.value ? 4 : 2, // Thicker border when recording
                      //                   ),
                      //                 ),
                      //                 child: Icon(
                      //                   Icons.mic,
                      //                   color: ColorResources.toolbarText,
                      //                   size: controller.isRecording.value ? 50 : 30, // Icon size remains same, the container size increases
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         )),
                      //       ),
                      //       const Gap(Dimensions.gapExtraSmall)
                      //     ],
                      //   ),
                      // ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                imagePickerController.showSelectBottomSheet();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0, right: 10),
                                child: Image.asset(Images.icAttachment, height: 20, width: 20),
                              ),
                            ),
                            Flexible(
                              child: TextField(
                                controller: controller.messageController,
                                style: const TextStyle(fontSize: 16, color: ColorResources.black),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter Message...',
                                ),
                                onChanged: (value) {
                                  controller.isTyping.value = value.isNotEmpty;
                                },
                              ),
                            ),
                            Obx(() {
                              return controller.isTyping.value
                                  ? GestureDetector(
                                    onTap: () async {
                                      if (controller.messageController.text.isNotEmpty) {
                                        String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
                                        ChatMessageModel chatMessage = ChatMessageModel(
                                          senderUniId: uniId,
                                          date: controller.getCurrentDateTime(),
                                          fileUrl: "",
                                          messageType: AppConstants.text,
                                          name: controller.customerName,
                                          profileImageUrl: controller.customerImage,
                                          selectedText: controller.isMessageSelected.isTrue
                                              ? controller.selectedText.value.toString()
                                              : "",
                                          selectedType: controller.isMessageSelected.isTrue
                                              ? controller.selectedType.value.toString()
                                              : "",
                                          text: controller.messageController.text.toString(),
                                        );

                                        controller.sendMessage(chatMessage, null, '');
                                        controller.messageController.clear();
                                        controller.selectedType.value = "";
                                        controller.selectedText.value = "";
                                        controller.selectedPersonName.value = "";
                                        controller.isMessageSelected(false);
                                        controller.isTyping.value = false; // Reset typing status
                                      }
                                    },
                                    child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                        color: ColorResources.colorPrimary,
                                        shape: BoxShape.circle
                                    ),
                                    child: Image.asset(Images.sendChat,height: 20,color: ColorResources.toolbarText)
                                    ),
                                  )
                                  : Obx(() {
                                return GestureDetector(
                                  onTap: () {
                                    CustomSnackBar.showTop("Press and hold the button to record");
                                  },
                                  onLongPressStart: (_) => controller.checkPermissionStartRecording(),
                                  onLongPressEnd: (_) => controller.stopRecording(),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        AnimatedContainer(
                                          duration: const Duration(milliseconds: 300),
                                          width: controller.isRecording.value ? 60 : 40,
                                          height: controller.isRecording.value ? 60 : 40,
                                          decoration: BoxDecoration(
                                            color: ColorResources.colorPrimary,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: controller.isRecording.value ? ColorResources.colorPrimary : ColorResources.colorPrimary,
                                              width: controller.isRecording.value ? 4 : 2,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.mic,
                                            color: ColorResources.toolbarText,
                                            size: controller.isRecording.value ? 35 : 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                            }),
                            const Gap(Dimensions.gapExtraSmall)
                          ],
                        ),
                      )


                    ],
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: ValueListenableBuilder<bool>(
            valueListenable: _showScrollToTop,
            builder: (context, value, child) {
              return Stack(
                children: [
                  // This is the background for your floating action button
                  if (value)
                    Positioned(
                      bottom: 40, // Adjust as needed
                      left: 295,  // Adjust as needed
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RawMaterialButton(
                            onPressed: _scrollToTop,
                            elevation: 0, // Remove elevation
                            shape: const CircleBorder(), // Circular shape
                            padding: EdgeInsets.zero, // Remove padding
                            fillColor: ColorResources.colorPrimary, // Set background color
                            child: Image.asset(
                              Images.bottomArrowOnChat,
                              height: 20,
                              color: ColorResources.toolbarText, // Icon color
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
