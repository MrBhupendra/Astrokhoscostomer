import 'package:astro_brahmand/view/screen/chat/widget/chat_image_widget.dart';
import 'package:astro_brahmand/view/screen/chat/widget/chat_message_widget.dart';
import 'package:astro_brahmand/view/screen/chat/widget/chat_product_widget.dart';
import 'package:astro_brahmand/view/screen/chat/widget/chat_voice_note_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../widget/custom_round_network_image.dart';
import '../../widget/custom_text_medium.dart';
import 'controller/chat_history_controller.dart';
import 'model/chat_message_model.dart';

class ChatHistoryScreen extends GetView<ChatHistoryController> {
  ChatHistoryScreen({super.key}){
    controller.scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToTop();
    });
  }

  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _showScrollToTop = ValueNotifier(false);

  void _scrollListener() {
    // Show the "scroll to top" button when not at the top
    if (controller.scrollController.offset > 15.0) {
      _showScrollToTop.value = true;
    } else {
      _showScrollToTop.value = false;
    }
  }

  void _scrollToTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.scrollController.hasClients) {
        controller.scrollController.animateTo(
          0, // Scroll to the top
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.offsetCount = 1;
    controller.isChatHistorySuccess(false);
    controller.getChatHistory(controller.channelName.toString(), "0", controller.offsetCount);

    controller.scrollController.addListener(() {
      if (controller.scrollController.position.pixels ==
          controller.scrollController.position.maxScrollExtent) {
        if (controller.isChatHistoryLoading.isFalse &&
            !controller.isNoMoreData) {
          controller.getChatHistory(
              controller.channelName.toString(), "0", controller.offsetCount);
        }
      }
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorResources.colorPrimary,
          automaticallyImplyLeading: false,
          title: Row(children: [
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
                imageUrl: controller.astrologerImage.toString(),
                height: 40,
                width: 40),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextMedium(controller.astrologerName.toString(),
                      fontSize: 16, color: ColorResources.toolbarText),
                ],
              ),
            ),
          ]),
          titleSpacing: 0,
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.chatBackground), fit: BoxFit.fill)),
          child: Column(
            children: [
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
                        return ChatMessageWidget(message, controller.uniId,isLastMessage: index == 0,);
                      } else if (message.messageType == AppConstants.image) {
                        return ChatImageWidget(message, controller.uniId);
                      }else if (message.messageType == AppConstants.voiceNote) {
                        return ChatVoiceNoteWidget(message, controller.uniId);
                      } else if (message.messageType == AppConstants.product || message.messageType == AppConstants.service) {
                        return ChatProductWidget(message, controller.uniId,message.messageType);
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ),
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
                  Column(
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
              ],
            );
          },
        ),
      ),
    );
  }
}
