import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_default_dialog.dart';
import '../../widget/custom_dialog_widget.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_round_network_image.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import '../../widget/simmer_widget/simmer_list_view.dart';
import 'controller/chat_history_controller.dart';

class ChatChannelListScreen extends GetView<ChatHistoryController> {
  const ChatChannelListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(title: AppStrings.chatHistory.tr),
      body: Obx(
        () {
          if(controller.isSuccess.isTrue){
            return RefreshIndicator(
              onRefresh: () async {
                await controller.getChatChannelsList();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeExtraSmall,
                    vertical: Dimensions.paddingSizeExtraSmall),
                child: ListView.builder(
                  itemCount: controller.chatChannelListModel.data?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        controller.astrologerName = controller
                            .chatChannelListModel
                            .data![index]
                            .displayName
                            .toString();

                        controller.astrologerImage = controller
                            .chatChannelListModel
                            .data![index]
                            .astroImg
                            .toString();

                        controller.channelName = controller
                            .chatChannelListModel
                            .data![index]
                            .channelName
                            .toString();

                        Get.toNamed('/chatHistory');
                      },
                      onLongPress: (){
                        Get.dialog(
                            CustomDialogWidget(
                                imagePath: Images.delete,
                                title: AppStrings.delete.tr,
                                onYesPressed: () {
                                  num? id = controller.chatChannelListModel.data?[index].id;
                                  controller.deleteChatChannels(index, id!);
                                  Get.back();
                                },
                                // imageColor: ColorResources.colorFontRed,
                                description: AppStrings.deleteChatPopUP.tr
                            ),
                            barrierDismissible: false
                        );
                        // CustomDefaultDialog.showDialog(
                        //     AppStrings.delete.tr, AppStrings.deleteChatPopUP.tr,
                        //         () {
                        //           Get.back();
                        //           num? id = controller.chatChannelListModel.data?[index].id;
                        //           print(id);
                        //           controller.deleteChatChannels(index, id!);
                        //         },
                        //         () {
                        //           print("Get.back");
                        //       // Get.back();
                        //     });
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
                                  horizontal:
                                  Dimensions.paddingSizeMediumSmall,
                                  vertical: Dimensions.paddingSizeDefault),
                              child: Row(
                                children: [
                                  CustomRoundNetworkImage(
                                      imageUrl: controller
                                          .chatChannelListModel
                                          .data![index]
                                          .astroImg
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
                                            controller.chatChannelListModel
                                                .data![index].displayName
                                                .toString(),
                                            fontSize:
                                            Dimensions.fontSizeLarge),
                                        CustomTextRegular(
                                            CommonMethods().formatDateTimeOutput(controller.chatChannelListModel
                                                .data![index].updatedAt
                                                .toString()),
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
              ),
            );
          }
          if (controller.isLoading.isTrue) {
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
        },
      ),
    ));
  }
}
