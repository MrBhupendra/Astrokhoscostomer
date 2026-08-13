import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_dialog_widget.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_network_image.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import '../../widget/simmer_widget/simmer_list_view.dart';
import 'controller/notification_controller.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late final NotificationController controller;

  @override
  void initState() {
    super.initState();
    controller = NotificationController.to;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.onNotificationScreenOpened();
    });
  }

  @override
  void dispose() {
    controller.onNotificationScreenClosed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        final prev = Get.previousRoute.toString();
        final canPop = Get.key.currentState?.canPop() ?? false;
        if (!canPop ||
            prev.isEmpty ||
            prev == '/' ||
            prev == '/splash') {
          Get.offAllNamed('/dashboard');
        } else {
          Get.back();
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                const Size.fromHeight(kToolbarHeight), // or any height you want
            child: Obx(() => CustomAppBar(
                  title: AppStrings.notifications.tr,
                  icon: controller.notificationListData.isNotEmpty
                      ? Icons.delete
                      : null,
                  onActionPressed: controller.notificationListData.isNotEmpty
                      ? () {
                          Get.dialog(
                              CustomDialogWidget(
                                  imagePath: Images.delete,
                                  title: AppStrings.delete.tr,
                                  onYesPressed: () async {
                                    await controller.deleteAllNotifications(
                                        1, "", null);
                                  },
                                  description:
                                      AppStrings.deleteAllNotification.tr),
                              barrierDismissible: false);
                        }
                      : null, // Disable the action if the list is empty
                      onBackPressed: () {
                        final prev = Get.previousRoute.toString();
                        final canPop =
                            Get.key.currentState?.canPop() ?? false;
                        if (!canPop ||
                            prev.isEmpty ||
                            prev == '/' ||
                            prev == '/splash') {
                          Get.offAllNamed('/dashboard');
                        } else {
                          Get.back();
                        }
                      },
                )),
          ),
          // appBar: CustomAppBar(title: AppStrings.notifications.tr,icon: Icons.delete,onActionPressed: (){
          //   Get.dialog(
          //       CustomDialogWidget(
          //           imagePath: Images.delete,
          //           title: AppStrings.delete.tr,
          //           onYesPressed: () async {
          //             await controller.deleteAllNotifications(1,"",null);
          //           },
          //           description: AppStrings.deleteAllNotification.tr
          //       ),
          //       barrierDismissible: false
          //   );
          // }),
          body: RefreshIndicator(
            onRefresh: () async {
              controller.offsetCount = 0;
              controller.getNotifications(controller.offsetCount);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Obx(
                () {
                  controller.shouldRefreshScreen.value;
                  if (controller.isSuccess.isTrue) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.notificationListData.length,
                            controller: controller.scrollController,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: Dimensions.paddingSizeExtraSmall,
                                    right: Dimensions.paddingSizeExtraOverSmall,
                                    left: Dimensions.paddingSizeExtraOverSmall,
                                    bottom: 2),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: ColorResources.white,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.borderRadiusDefault),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: const Offset(0, 1),
                                        )
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: Dimensions.paddingSizeSmall,
                                        horizontal:
                                            Dimensions.paddingSizeOverSmall),
                                    child: Dismissible(
                                      key: Key(controller
                                          .notificationListData[index].id
                                          .toString()),
                                      background: Container(
                                        color: Colors.red,
                                        alignment: Alignment.centerRight,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: const Icon(Icons.delete,
                                            color: Colors.white),
                                      ),
                                      direction: DismissDirection.endToStart,
                                      onDismissed: (direction) async {
                                        await controller.deleteAllNotifications(
                                            0,
                                            controller
                                                .notificationListData[index].id
                                                .toString(),
                                            index);
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (controller
                                                      .notificationListData[
                                                          index]
                                                      .image !=
                                                  null &&
                                              controller
                                                  .notificationListData[index]
                                                  .image
                                                  .toString()
                                                  .isNotEmpty)
                                            CustomNetworkImage(
                                              imageUrl: controller
                                                  .notificationListData[index]
                                                  .image
                                                  .toString(),
                                              height: 60,
                                              width: 60,
                                            ),
                                          if (controller
                                                  .notificationListData[index]
                                                  .image ==
                                              null)
                                            const Icon(
                                              Icons.notifications_active,
                                              color: ColorResources
                                                  .colorPrimaryMedium,
                                            ),
                                          const Gap(Dimensions.gapMedium),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: CustomTextMedium(
                                                        controller
                                                            .notificationListData[
                                                                index]
                                                            .title
                                                            .toString(),
                                                        fontSize: Dimensions
                                                            .fontSizeLarge,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Gap(Dimensions
                                                    .gapExtraExtraSmall),
                                                CustomTextRegular(
                                                  controller
                                                      .notificationListData[
                                                          index]
                                                      .msg
                                                      .toString(),
                                                  color: ColorResources.black2,
                                                ),
                                                const Gap(2),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    CustomTextRegular(
                                                      CommonMethods()
                                                          .formatDateTimeOutput(
                                                        (controller
                                                                        .notificationListData[
                                                                            index]
                                                                        .createdAt !=
                                                                    null &&
                                                                controller
                                                                    .notificationListData[
                                                                        index]
                                                                    .createdAt!
                                                                    .trim()
                                                                    .isNotEmpty)
                                                            ? controller
                                                                    .notificationListData[
                                                                        index]
                                                                    .createdAt ??
                                                                ""
                                                            : (controller
                                                                    .notificationListData[
                                                                        index]
                                                                    .updatedAt ??
                                                                ""),
                                                      ),
                                                      fontSize: Dimensions
                                                          .fontSizeExtraSmall,
                                                      color:
                                                          ColorResources.black3,
                                                      textAlign: TextAlign.end,
                                                    ),
                                                  ],
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
                            },
                          ),
                        ),
                        Obx(
                          () => Visibility(
                            visible: controller.isLoading.isTrue,
                            child: const Text('Loading..'),
                          ),
                        )
                      ],
                    );
                  } else if (controller.isLoading.isTrue) {
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
            ),
          ),
        ),
      ),
    );
  }
}
