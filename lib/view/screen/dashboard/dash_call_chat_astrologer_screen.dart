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
import '../search/model/astrologer_request_model.dart';
import 'controller/call_astrologer_controller.dart';

class CallChatAstrologerScreen extends StatelessWidget {
  final String type;
  CallChatAstrologerScreen(this.type, {super.key});
  final CallAstrologerController controller = Get.put<CallAstrologerController>(CallAstrologerController());
  final AllAstrologerController astrologerController = Get.put<AllAstrologerController>(AllAstrologerController());
  @override
  Widget build(BuildContext context) {
    debugPrint("AS1 [CallChatAstrologerScreen] build");
    controller.isDashboardType = type;
    controller.resetOffset();
    controller.resetSearch();
    controller.resetData();
    controller.resetCategory();
    controller.clearAllFilters();
    //getArguments();
    controller.getFilters();
    controller.setTopCategoryFilterIndex(1);
    controller.getAllAstrologer(AstrologerRequestModel(
      offset: controller.offsetCount,
      search: controller.searchValue.value,
      gender: controller.filterSelectedGender.value,
      language: controller.filterSelectedLanguages.isNotEmpty ? controller.filterSelectedLanguages.toString() : '',
      category: controller.filterSelectedCategories.isNotEmpty ?  controller.filterSelectedCategories.toString() : '',
      skill:  controller.filterSelectedSkills.isNotEmpty ?  controller.filterSelectedSkills.toString() : '',
      sortBy: controller.filterSelectedSort.value,
      slug: controller.isSlug,
      isVirtual: controller.isVirtualAstrologer,
      slotPermission: controller.isSlotPermission,
      isSlotAvailable: controller.isSlotAvailable,
      type: controller.isDashboardType,
      astrologerUniId: '',
    ));


    controller.scrollController.addListener(() {
      if (controller.scrollController.position.pixels == controller.scrollController.position.maxScrollExtent) {
        if (controller.isAstrologerLoading.isFalse && !controller.isNoMoreData) {
          // Use the existing filter values when fetching more data on scroll
          controller.getAllAstrologer(AstrologerRequestModel(
            offset: controller.offsetCount,
            search: controller.searchValue.value,
            gender: controller.filterSelectedGender.value,
            language: controller.filterSelectedLanguages.isNotEmpty ? controller.filterSelectedLanguages.toString() : '',
            category: controller.filterSelectedCategories.isNotEmpty ?  controller.filterSelectedCategories.toString() : '',
            skill:  controller.filterSelectedSkills.isNotEmpty ?  controller.filterSelectedSkills.toString() : '',
            sortBy: controller.filterSelectedSort.value,
            slug: controller.isSlug,
            isVirtual: controller.isVirtualAstrologer,
            slotPermission: controller.isSlotPermission,
            isSlotAvailable: controller.isSlotAvailable,
            type: controller.isDashboardType,
            astrologerUniId: '',
          ));
        }
      }
    });

    return RefreshIndicator(
      onRefresh: () async {
        controller.resetOffset();
        controller.getAllAstrologer(AstrologerRequestModel(
          offset: controller.offsetCount,
          search: controller.searchValue.value,
          gender: controller.filterSelectedGender.value,
          language: controller.filterSelectedLanguages.isNotEmpty ? controller.filterSelectedLanguages.toString() : '',
          category: controller.filterSelectedCategories.isNotEmpty ?  controller.filterSelectedCategories.toString() : '',
          skill:  controller.filterSelectedSkills.isNotEmpty ?  controller.filterSelectedSkills.toString() : '',
          sortBy: controller.filterSelectedSort.value,
          slug: controller.isSlug,
          isVirtual: controller.isVirtualAstrologer,
          slotPermission: controller.isSlotPermission,
          isSlotAvailable: controller.isSlotAvailable,
          type: controller.isDashboardType,
          astrologerUniId: '',
        ));
      },
      child: Column(
        children: [
          if(AppFeatures.categoryFilterInSearch && controller.isCategoryId.toString().isEmpty || controller.isCategoryId == null)
            Obx(() => Visibility(
              visible: controller.isFilterSuccess.isTrue,
              child: SizedBox(
                height: 48,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: (controller.categoryList.length) + 2, // +2 for the "All" & "Filter option
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // FILTER item
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              CommonMethods().showFilterBottomSheet(context,controller);
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
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                child: Row(
                                  children: [
                                    Obx(() => Badge(
                                        isLabelVisible: controller.filterSelectedSkills.isNotEmpty ||
                                            controller.filterSelectedLanguages.isNotEmpty ||
                                            controller.filterSelectedGender.value.isNotEmpty ||
                                            controller.filterSelectedSort.value.isNotEmpty,
                                        backgroundColor: Colors.green,
                                        child: const Icon(Icons.filter_alt, color: ColorResources.colorPrimaryDark))),
                                    const Gap(5),
                                    CustomTextRegular(
                                      'Filter',
                                      color: controller.topSelectedCategoryIndex.value == 0
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
                              controller.getAllAstrologer(AstrologerRequestModel(
                                offset: controller.offsetCount,
                                search: controller.searchValue.value,
                                gender: controller.filterSelectedGender.value,
                                language: controller.filterSelectedLanguages.isNotEmpty ? controller.filterSelectedLanguages.toString() : '',
                                category: controller.filterSelectedCategories.isNotEmpty ?  controller.filterSelectedCategories.toString() : '',
                                skill:  controller.filterSelectedSkills.isNotEmpty ?  controller.filterSelectedSkills.toString() : '',
                                sortBy: controller.filterSelectedSort.value,
                                slug: controller.isSlug,
                                isVirtual: controller.isVirtualAstrologer,
                                slotPermission: controller.isSlotPermission,
                                isSlotAvailable: controller.isSlotAvailable,
                                type: controller.isDashboardType,
                                astrologerUniId: '',
                              ));
                            },
                            child: Obx(() => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: controller.topSelectedCategoryIndex.value == 1 ? Colors.white70 : Colors.white54,
                                borderRadius: controller.topSelectedCategoryIndex.value == 1 ? BorderRadius.circular(12) : BorderRadius.circular(10),
                                border: controller.topSelectedCategoryIndex.value == 1 ? Border.all(color: ColorResources.colorPrimaryDark, width: 1.5) : Border.all(color: ColorResources.black6, width: 1.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                child: Row(
                                  children: [
                                    Image.asset(Images.allCategory,
                                      width: controller.topSelectedCategoryIndex.value == index ? 25 : 23,
                                      height: controller.topSelectedCategoryIndex.value == index ? 25 : 23,
                                      color: ColorResources.colorPrimaryDark,
                                    ),
                                    const Gap(5),
                                    CustomTextRegular(
                                      AppStrings.all,
                                      color: controller.topSelectedCategoryIndex.value == 1 ? ColorResources.colorPrimaryDark : ColorResources.black4,
                                    ),
                                  ],
                                ),
                              ),
                            )),
                          ),
                        ],
                      );
                    }
                    else {
                      final selectedIndex = index - 2;
                      return GestureDetector(
                        onTap: () {
                          controller.setTopCategoryFilterIndex(index); // Set index to current index
                          controller.resetOffset();
                          controller.resetCategory();
                          controller.filterSelectedCategories.add(controller.categoryList[selectedIndex].id.toString());
                          controller.getAllAstrologer(AstrologerRequestModel(
                            offset: controller.offsetCount,
                            search: controller.searchValue.value,
                            gender: controller.filterSelectedGender.value,
                            language: controller.filterSelectedLanguages.isNotEmpty ? controller.filterSelectedLanguages.toString() : '',
                            category: controller.filterSelectedCategories.isNotEmpty ?  controller.filterSelectedCategories.toString() : '',
                            skill:  controller.filterSelectedSkills.isNotEmpty ?  controller.filterSelectedSkills.toString() : '',
                            sortBy: controller.filterSelectedSort.value,
                            slug: controller.isSlug,
                            isVirtual: controller.isVirtualAstrologer,
                            slotPermission: controller.isSlotPermission,
                            isSlotAvailable: controller.isSlotAvailable,
                            type: controller.isDashboardType,
                            astrologerUniId: '',
                          ));
                        },
                        child: Obx(() => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: controller.topSelectedCategoryIndex.value == index ? Colors.white70 : Colors.white54,
                            borderRadius: controller.topSelectedCategoryIndex.value == index ? BorderRadius.circular(12) : BorderRadius.circular(10),
                            border: controller.topSelectedCategoryIndex.value == index ? Border.all(color: ColorResources.colorPrimaryDark, width: 1.5) : Border.all(color: ColorResources.black6, width: 1.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                            child: Row(
                              children: [
                                CustomNetworkImage(
                                  height: controller.topSelectedCategoryIndex.value == index ? 22 : 20,
                                  imageUrl: controller.categoryList[selectedIndex].categoryImages.toString(), // Adjusted index
                                  width: controller.topSelectedCategoryIndex.value == index ? 22 : 20,
                                ),
                                const Gap(5),
                                CustomTextRegular(
                                  controller.categoryList[selectedIndex].categoryTitle.toString(),
                                  color: controller.topSelectedCategoryIndex.value == index ? ColorResources.colorPrimaryDark : ColorResources.black4,

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
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 8),
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
                onChanged: (value) {
                  controller.searchAstrologers(value);
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: AppStrings.searchAstrologerHere.tr,
                  // hintStyle: TextStyle(color: ColorResources.colorPrimary),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      Images.search,
                      width: 18,
                      height: 18,
                      color: ColorResources.colorPrimary,
                      // fit: BoxFit.cover,
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
                    itemCount: controller.astrologerListData.length,
                    controller: controller.scrollController,
                    itemBuilder: (context, index) {
                      return CallChatAstrologerWidget(
                        controller.astrologerListData[index],
                        onPressed: () {
                          astrologerController.selectedAstrologerData.value = controller.astrologerListData[index];
                          Get.toNamed("/astroProfile");
                        }, type: controller.isDashboardType.toString(),
                      );
                    },
                  ),
                );

              } else if (controller.isAstrologerLoading.isTrue) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return const SimmerAstrologer();
                    },
                  ),
                );
              } else {
                return const EmptyScreen();
              }
            },
          ),
          Obx(() => Visibility(
            visible: controller.isAstrologerLoading.isTrue,
            child: const Text('Loading..'),
          ),)
        ],
      ),
    );
  }

  void getArguments() {
    if(Get.arguments != null){
      Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
      controller.isCategoryId =  arguments['isCategoryId'] ?? '';
      controller.isSlug =  arguments['isSlug'] ?? '';
      controller.isVirtualAstrologer =  arguments['isVirtualAstrologer'] ?? '0';
      controller.isSlotPermission =  arguments['isSlotPermission'] ?? '0';
      controller.isSlotAvailable =  arguments['isSlotAvailable'] ?? '0';

      if(controller.isCategoryId != null && controller.isCategoryId!.isNotEmpty){
        controller.filterSelectedCategories.add(controller.isCategoryId.toString());
      }
    }
  }
}
