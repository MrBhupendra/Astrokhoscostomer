import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utill/shared_preference.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_text_regular.dart';
import '../../widget/group_pooja_astrologer_widget.dart';
import '../../widget/simmer_widget/simmer_astrologer.dart';
import 'controller/group_pooja_controller.dart';

class GroupPoojaAstrologerListScreen extends GetView<GroupPoojaController> {
  const GroupPoojaAstrologerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    String astrologerID = arguments['astrologerId'] ?? '';
    controller.astrologerOffsetCount = 0;
    controller.getGroupPujaAstrologerList(controller.astrologerOffsetCount, controller.groupPoojaListData.id.toString(),astrologerUniId: astrologerID);
    //Scroll
    controller.astrologerScrollController.addListener(() {
      if (controller.astrologerScrollController.position.pixels ==
          controller.astrologerScrollController.position.maxScrollExtent) {
        if (controller.isAstrologerLoading.isFalse && !controller.astrologerIsNoMoreData) {
          controller.getGroupPujaAstrologerList(controller.astrologerOffsetCount,
              controller.groupPoojaListData.id.toString());
        }
      }
    });
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(title: controller.groupPoojaListData.groupPujaName.toString()),
      body: Obx(
        () {
          if (controller.isAstrologerSuccess.isTrue) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.groupPoojaAstrologerListData.length,
                    controller: controller.astrologerScrollController,
                    itemBuilder: (context, index) {
                      return GroupPoojaAstrologerWidget(
                        controller.groupPoojaAstrologerListData[index],
                        onPressed: () async {
                          bool isLogin =
                              await SharedPreferencesHelper.getIsLogin();
                          if (isLogin) {
                            controller.getGroupPoojaCalculation(
                                controller.groupPoojaAstrologerListData[index].id
                                    .toString(),
                                controller.groupPoojaAstrologerListData[index]
                                    .astrologerUniId
                                    .toString(),
                                0,
                                controller.groupPoojaListData,
                                "Open",
                                controller. groupPoojaAstrologerListData[index].duration.toString(),
                                context);
                          } else {
                            Get.toNamed('/login');
                          }
                        },
                        onSelect: () async {
                          bool isLogin =
                              await SharedPreferencesHelper.getIsLogin();
                          if (isLogin) {
                            controller.getGroupPoojaCalculation(
                                controller.groupPoojaAstrologerListData[index].id
                                    .toString(),
                                controller.groupPoojaAstrologerListData[index]
                                    .astrologerUniId
                                    .toString(),
                                0,
                                controller.groupPoojaListData,
                                "Open",
                                controller.groupPoojaAstrologerListData[index].duration.toString(),
                                context);
                          } else {
                            Get.toNamed('/login');
                          }
                        },
                      );
                    },
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.isAstrologerLoading.isTrue,
                    child: CustomTextRegular('Loading...'),
                  ),
                )
              ],
            );
          }
          else if (controller.isAstrologerLoading.isTrue) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (context, index) {
                return const SimmerAstrologer();
              },
            );
          }
          else {
            return const EmptyScreen();
          }
        },
      ),
    ));
  }
}
