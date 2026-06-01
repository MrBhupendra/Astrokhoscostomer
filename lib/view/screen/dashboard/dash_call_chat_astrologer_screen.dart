import 'package:astro_brahmand/view/widget/call_chat_astrologer_widget.dart';
import 'package:astro_brahmand/view/widget/custom_empty_screen.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../controller/all_astrologer_controller.dart';
import '../../../utill/app_features.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/common_methods.dart';
import '../../../utill/images.dart';
import '../../widget/custom_network_image.dart';
import '../../widget/simmer_widget/simmer_astrologer.dart';
import 'controller/call_astrologer_controller.dart';

class CallChatAstrologerScreen extends StatefulWidget {
  final String type;

  const CallChatAstrologerScreen(this.type, {super.key});

  @override
  State<CallChatAstrologerScreen> createState() =>
      _CallChatAstrologerScreenState();
}

class _CallChatAstrologerScreenState extends State<CallChatAstrologerScreen> {
  final CallAstrologerController controller =
      Get.isRegistered<CallAstrologerController>()
          ? Get.find<CallAstrologerController>()
          : Get.put(CallAstrologerController());
  final AllAstrologerController astrologerController =
      Get.isRegistered<AllAstrologerController>()
          ? Get.find<AllAstrologerController>()
          : Get.put(AllAstrologerController());

  late final ScrollController _listScrollController;
  bool _scrollListenerAttached = false;

  @override
  void initState() {
    super.initState();
    _listScrollController = ScrollController();
    _attachScrollListener();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      controller.initializeForDashboard(widget.type);
    });
  }

  @override
  void didUpdateWidget(CallChatAstrologerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.type != widget.type) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        controller.initializeForDashboard(widget.type);
      });
    }
  }

  void _attachScrollListener() {
    if (_scrollListenerAttached) return;
    _scrollListenerAttached = true;
    _listScrollController.addListener(_onListScroll);
  }

  void _onListScroll() {
    if (!_listScrollController.hasClients) return;
    if (_listScrollController.positions.length != 1) return;

    final position = _listScrollController.position;
    if (position.pixels >= position.maxScrollExtent - 48) {
      controller.loadMoreAstrologersForDashboard();
    }
  }

  @override
  void dispose() {
    if (_scrollListenerAttached) {
      _listScrollController.removeListener(_onListScroll);
    }
    _listScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.resetOffset();
        controller.fetchAstrologersForDashboard();
      },
      child: Column(
        children: [
          if (AppFeatures.categoryFilterInSearch &&
                  controller.isCategoryId.toString().isEmpty ||
              controller.isCategoryId == null)
            Obx(() => Visibility(
                  visible: controller.isFilterSuccess.isTrue,
                  child: SizedBox(
                    height: 48,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: (controller.categoryList.length) + 2,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  CommonMethods()
                                      .showFilterBottomSheet(context, controller);
                                },
                                child: Obx(() => AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.3),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: const Offset(0, 2),
                                            )
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 8),
                                        child: Row(
                                          children: [
                                            Obx(() => Badge(
                                                isLabelVisible: controller
                                                        .filterSelectedSkills
                                                        .isNotEmpty ||
                                                    controller
                                                        .filterSelectedLanguages
                                                        .isNotEmpty ||
                                                    controller
                                                        .filterSelectedGender
                                                        .value
                                                        .isNotEmpty ||
                                                    controller
                                                        .filterSelectedSort
                                                        .value
                                                        .isNotEmpty,
                                                backgroundColor: Colors.green,
                                                child: const Icon(Icons.filter_alt,
                                                    color: ColorResources
                                                        .colorPrimaryDark))),
                                            const Gap(5),
                                            CustomTextRegular(
                                              'Filter',
                                              color: controller
                                                          .topSelectedCategoryIndex
                                                          .value ==
                                                      0
                                                  ? ColorResources.colorPrimaryDark
                                                  : ColorResources.black4,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          );
                        }
                        if (index == 1) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.setTopCategoryFilterIndex(1);
                                  controller.resetOffset();
                                  controller.resetCategory();
                                  controller.fetchAstrologersForDashboard();
                                },
                                child: Obx(() => AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: controller
                                                    .topSelectedCategoryIndex
                                                    .value ==
                                                1
                                            ? Colors.white70
                                            : Colors.white54,
                                        borderRadius: controller
                                                    .topSelectedCategoryIndex
                                                    .value ==
                                                1
                                            ? BorderRadius.circular(12)
                                            : BorderRadius.circular(10),
                                        border: controller
                                                    .topSelectedCategoryIndex
                                                    .value ==
                                                1
                                            ? Border.all(
                                                color: ColorResources
                                                    .colorPrimaryDark,
                                                width: 1.5)
                                            : Border.all(
                                                color: ColorResources.black6,
                                                width: 1.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 8),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              Images.allCategory,
                                              width: controller
                                                          .topSelectedCategoryIndex
                                                          .value ==
                                                      index
                                                  ? 25
                                                  : 23,
                                              height: controller
                                                          .topSelectedCategoryIndex
                                                          .value ==
                                                      index
                                                  ? 25
                                                  : 23,
                                              color: ColorResources
                                                  .colorPrimaryDark,
                                            ),
                                            const Gap(5),
                                            CustomTextRegular(
                                              AppStrings.all,
                                              color: controller
                                                          .topSelectedCategoryIndex
                                                          .value ==
                                                      1
                                                  ? ColorResources.colorPrimaryDark
                                                  : ColorResources.black4,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          );
                        } else {
                          final selectedIndex = index - 2;
                          return GestureDetector(
                            onTap: () {
                              controller.setTopCategoryFilterIndex(index);
                              controller.resetOffset();
                              controller.resetCategory();
                              controller.filterSelectedCategories.add(
                                  controller.categoryList[selectedIndex].id
                                      .toString());
                              controller.fetchAstrologersForDashboard();
                            },
                            child: Obx(() => AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: controller
                                                .topSelectedCategoryIndex
                                                .value ==
                                            index
                                        ? Colors.white70
                                        : Colors.white54,
                                    borderRadius: controller
                                                .topSelectedCategoryIndex
                                                .value ==
                                            index
                                        ? BorderRadius.circular(12)
                                        : BorderRadius.circular(10),
                                    border: controller
                                                .topSelectedCategoryIndex
                                                .value ==
                                            index
                                        ? Border.all(
                                            color:
                                                ColorResources.colorPrimaryDark,
                                            width: 1.5)
                                        : Border.all(
                                            color: ColorResources.black6,
                                            width: 1.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 8),
                                    child: Row(
                                      children: [
                                        CustomNetworkImage(
                                          height: controller
                                                      .topSelectedCategoryIndex
                                                      .value ==
                                                  index
                                              ? 22
                                              : 20,
                                          imageUrl: controller
                                              .categoryList[selectedIndex]
                                              .categoryImages
                                              .toString(),
                                          width: controller
                                                      .topSelectedCategoryIndex
                                                      .value ==
                                                  index
                                              ? 22
                                              : 20,
                                        ),
                                        const Gap(5),
                                        CustomTextRegular(
                                          controller
                                              .categoryList[selectedIndex]
                                              .categoryTitle
                                              .toString(),
                                          color: controller
                                                      .topSelectedCategoryIndex
                                                      .value ==
                                                  index
                                              ? ColorResources.colorPrimaryDark
                                              : ColorResources.black4,
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          );
                        }
                      },
                    ),
                  ),
                )),
          Padding(
            padding: const EdgeInsets.only(
                left: 8, right: 8, bottom: 4, top: 8),
            child: Container(
              decoration: BoxDecoration(
                color: ColorResources.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 3.0,
                    spreadRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                onChanged: controller.searchAstrologers,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: AppStrings.searchAstrologerHere.tr,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      Images.search,
                      width: 18,
                      height: 18,
                      color: ColorResources.colorPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () {
              if (controller.isAstrologerSuccess.isTrue) {
                return Expanded(
                  child: ListView.builder(
                    key: PageStorageKey<String>('astrologer_list_${widget.type}'),
                    itemCount: controller.astrologerListData.length,
                    controller: _listScrollController,
                    itemBuilder: (context, index) {
                      return CallChatAstrologerWidget(
                        controller.astrologerListData[index],
                        onPressed: () {
                          astrologerController.selectedAstrologerData.value =
                              controller.astrologerListData[index];
                          Get.toNamed("/astroProfile");
                        },
                        type: controller.isDashboardType.toString(),
                      );
                    },
                  ),
                );
              } else if (controller.isAstrologerLoading.isTrue) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) =>
                        const SimmerAstrologer(),
                  ),
                );
              } else {
                return const Expanded(child: EmptyScreen());
              }
            },
          ),
          Obx(
            () => Visibility(
              visible: controller.isAstrologerLoading.isTrue &&
                  controller.isAstrologerSuccess.isTrue,
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Text('Loading..'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
