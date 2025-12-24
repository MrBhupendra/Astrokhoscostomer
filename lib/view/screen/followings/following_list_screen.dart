import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/view/screen/followings/controller/following_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/all_astrologer_controller.dart';
import '../../widget/astrologer_widget.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/simmer_widget/simmer_astrologer.dart';

class FollowingListScreen extends GetView<FollowingController>{
  FollowingListScreen({super.key});
  final astrologerController = Get.put<AllAstrologerController>(AllAstrologerController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: AppStrings.followings.tr),
          body: RefreshIndicator(
            onRefresh: () async {
              controller.offsetCount = 0;
              controller.getFollowing(controller.offsetCount, 'refresh');
            },
            child: Obx(
                  () {
                if (controller.isSuccess.isTrue) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.astrologerListData.length,
                          controller: controller.scrollController,
                          itemBuilder: (context, index) {
                            return AstrologerWidget(
                              controller.astrologerListData[index],
                              onPressed: () {
                                astrologerController.selectedAstrologerData.value = controller.astrologerListData[index];
                                Get.toNamed("/astroProfile");
                              },
                            );
                          },
                        ),
                      ),
                      Obx(() => Visibility(
                        visible: controller.isLoading.isTrue,
                        child: const Text('Loading'),
                      ),)

                    ],
                  );
                }
                else if (controller.isLoading.isTrue) {
                  return ListView.builder(
                    itemCount: 5,
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
          ),
        ));
  }
}
