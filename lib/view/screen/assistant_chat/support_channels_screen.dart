import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:astro_brahmand/view/screen/assistant_chat/controller/support_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_round_network_image.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import '../../widget/simmer_widget/simmer_list_view.dart';
import '../chat/controller/chat_intake_form_controller.dart';

class SupportChannelsScreen extends StatefulWidget {
  final String type;
  const SupportChannelsScreen(this.type, {super.key});

  @override
  State<SupportChannelsScreen> createState() => _SupportChannelsScreenState();
}

class _SupportChannelsScreenState extends State<SupportChannelsScreen> {
  late final SupportTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(SupportTabController());
    _controller.assistantListContextType = widget.type;
    if (widget.type == 'Astrologer') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.getChatChannelsList(1);
      });
    }
  }

  Widget _trailingWithBadge(int unread) {
    final label = unread > 99 ? '99+' : '$unread';
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (unread > 0) ...[
          Container(
            constraints: const BoxConstraints(minWidth: 22, minHeight: 22),
            padding: EdgeInsets.symmetric(
              horizontal: unread > 9 ? 6 : 0,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: ColorResources.red,
              borderRadius: BorderRadius.circular(11),
            ),
            alignment: Alignment.center,
            child: CustomTextMedium(
              label,
              fontSize: Dimensions.fontSizeSmall,
              color: ColorResources.white,
            ),
          ),
          const Gap(Dimensions.gapSmall),
        ],
        const Icon(Icons.arrow_forward_ios_rounded,
            size: 18, color: ColorResources.colorPrimary),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.type == 'Astrologer') {
        if (_controller.isSuccess.isTrue) {
          return RefreshIndicator(
            onRefresh: () async {
              await _controller.getChatChannelsList(1);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraSmall,
                  vertical: Dimensions.paddingSizeExtraSmall),
              child: ListView.builder(
                itemCount: _controller.chatChannelListModel.data?.length,
                itemBuilder: (context, index) {
                  final row = _controller.chatChannelListModel.data![index];
                  final uniq = row.uniqeid?.toString() ?? '';
                  final unread = _controller.unreadByUniqeid[uniq] ?? 0;
                  return GestureDetector(
                    onTap: () async {
                      ChatIntakeFormController chatIntakeFormController =
                          Get.put(ChatIntakeFormController());
                      chatIntakeFormController.setAstrologerData(
                          row.displayName.toString(),
                          row.astroImg.toString(),
                          row.astrologerUniId.toString(),
                          AppConstants.chat,
                          0);

                      String customerUniUd = row.customerUniId.toString();
                      String astrologerUniId = row.astrologerUniId.toString();
                      String uniqueId = row.uniqeid.toString();
                      String channelName = '$customerUniUd-$astrologerUniId';
                      Get.toNamed('/assistantChatScreen', arguments: {
                        'channelName': channelName,
                        'uniqueId': uniqueId
                      })?.then((_) => _controller.getChatChannelsList(1));
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
                                    imageUrl: row.astroImg.toString(),
                                    height: 45,
                                    width: 45),
                                const Gap(Dimensions.gapMedium),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomTextMedium(
                                          '${row.displayName.toString()} ${"'s"} Assistant',
                                          fontSize: Dimensions.fontSizeLarge),
                                      CustomTextRegular(
                                          CommonMethods()
                                              .formatDateTimeOutput(
                                                  row.updatedAt.toString()),
                                          color: ColorResources.black1,
                                          fontSize:
                                              Dimensions.fontSizeSmall),
                                    ],
                                  ),
                                ),
                                _trailingWithBadge(unread),
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
        if (_controller.isLoading.isTrue) {
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

      return const EmptyScreen();
    });
  }
}
