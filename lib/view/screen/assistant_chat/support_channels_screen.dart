import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:astro_brahmand/view/screen/assistant_chat/controller/support_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../utill/app_constants.dart';
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

class SupportChannelsScreen extends StatelessWidget {
  final String type;
  const SupportChannelsScreen(this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    SupportTabController controller = Get.put<SupportTabController>(SupportTabController());
    if(type == "Astrologer"){
      controller.getChatChannelsList(1);
    }

    return Obx(
          () {
        if(type == "Astrologer"){
          if(controller.isSuccess.isTrue){
            return RefreshIndicator(
              onRefresh: () async {
                await controller.getChatChannelsList(1);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeExtraSmall,
                    vertical: Dimensions.paddingSizeExtraSmall),
                child: ListView.builder(
                  itemCount: controller.chatChannelListModel.data?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        //FOR CHAT INIT
                        ChatIntakeFormController chatIntakeFormController = Get.put(ChatIntakeFormController());
                        chatIntakeFormController.setAstrologerData(controller.chatChannelListModel.data![index].displayName.toString(), controller.chatChannelListModel.data![index].astroImg.toString(), controller.chatChannelListModel.data![index].astrologerUniId.toString(),AppConstants.chat,0);

                        String customerUniUd = controller.chatChannelListModel.data![index].customerUniId.toString();
                        String astrologerUniId = controller.chatChannelListModel.data![index].astrologerUniId.toString();
                        String uniqueId = controller.chatChannelListModel.data![index].uniqeid.toString();
                        String channelName = '$customerUniUd-$astrologerUniId';
                        Get.toNamed('/assistantChatScreen', arguments: {
                          'channelName': channelName,
                          'uniqueId': uniqueId
                        });
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
                                    '${controller.chatChannelListModel.data![index].displayName.toString()} ${"'s"} Assistant',
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
        }

        else{
          return const EmptyScreen();
        }
      },
    );
  }
}