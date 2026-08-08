import 'package:astro_brahmand/utill/app_features.dart';
import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:astro_brahmand/utill/images.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../controller/all_astrologer_controller.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../widget/astrologer_widget.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_network_image.dart';
import '../../widget/custom_text_regular.dart';
import '../../widget/simmer_widget/simmer_astrologer.dart';
import 'model/astrologer_request_model.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final AllAstrologerController controller = Get.put<AllAstrologerController>(AllAstrologerController());
  @override
  Widget build(BuildContext context) {
    AppLogger.d("AS1 [SearchScreen] build");
    controller.resetOffset();
    controller.resetSearch();
    controller.resetData();
    controller.resetCategory();
    controller.clearAllFilters();
    getArguments();
    controller.getFilters();
    controller.setTopCategoryFilterIndex(0);
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
      type: '',
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
            type: '',
            astrologerUniId: '',
            ));
        }
      }
    });

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
        appBar: CustomAppBar(
          title: AppStrings.search.tr,
          onBackPressed: () {
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
            //filter
            isClearFilterButton: Obx(() => Visibility(
              visible : controller.filterSelectedSkills.isNotEmpty ||
                  controller.filterSelectedLanguages.isNotEmpty ||
                  controller.filterSelectedGender.value.isNotEmpty ||
                  controller.filterSelectedSort.value.isNotEmpty,
                  //|| controller.filterSelectedCategories.isNotEmpty,
              child: Row( children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ColorResources.toolbarText)),
                  padding: const EdgeInsets.all(5),
                  child: CustomTextRegular("Clear Filter",color: ColorResources.toolbarText,fontSize: Dimensions.fontSizeSmall,),
                ),
                const Gap(10)
              ]),
            )),
            onClearFilterPressed: (){
              controller.clearAllFilters();
              controller.applyFilters();
            },

            badgeIcon: Obx(() => Badge(
              isLabelVisible: controller.filterSelectedSkills.isNotEmpty ||
                  controller.filterSelectedLanguages.isNotEmpty ||
                  controller.filterSelectedGender.value.isNotEmpty ||
                  controller.filterSelectedSort.value.isNotEmpty,
                 //|| controller.filterSelectedCategories.isNotEmpty,
              backgroundColor: Colors.red,
              child: const Icon(Icons.filter_alt_outlined,color: ColorResources.toolbarText,),
            )),
          onActionPressed: (){
            CommonMethods().showFilterBottomSheet(context,controller);
          }
          //filter END
          ),
        body: RefreshIndicator(
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
              type: '',
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
                    itemCount: (controller.categoryList.length) + 1, // +1 for the "All" option
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.setTopCategoryFilterIndex(0);
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
                                  type: '',
                                  astrologerUniId: '',
                                ));
                              },
                              child: Obx(() => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: controller.topSelectedCategoryIndex.value == 0 ? Colors.white70 : Colors.white54,
                                  borderRadius: controller.topSelectedCategoryIndex.value == 0 ? BorderRadius.circular(12) : BorderRadius.circular(10),
                                  border: controller.topSelectedCategoryIndex.value == 0 ? Border.all(color: ColorResources.colorPrimaryDark, width: 1.5) : Border.all(color: ColorResources.black6, width: 1.0),
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
                                        color: controller.topSelectedCategoryIndex.value == 0 ? ColorResources.colorPrimaryDark : ColorResources.black4,
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                            ),
                          ],
                        );
                      } else {
                        final selectedIndex = index - 1;
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
                              type: '',
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
                              return AstrologerWidget(
                                controller.astrologerListData[index],
                                onPressed: () {
                                  controller.selectedAstrologerData.value = controller.astrologerListData[index];
                                  Get.toNamed("/astroProfile");
                                },
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
        ),
        ),
      ),
    );
  }

  // void showFilterBottomSheet(BuildContext context) {
  //   controller.selectedIndexFilter.value = 1;
  //   void updateStatus(bool? value, String filterType, String filterValue) {
  //     if (value == true) {
  //       if (filterType == 'sort') {
  //         controller.filterSelectedSort.value = filterValue;
  //       }else if (filterType == 'skill') {
  //         controller.filterSelectedSkills.add(filterValue);
  //       } else if (filterType == 'language') {
  //         controller.filterSelectedLanguages.add(filterValue);
  //       } else if (filterType == 'gender') {
  //         controller.filterSelectedGender.value = filterValue;
  //       }
  //       // else if (filterType == 'category') {
  //       //   controller.filterSelectedCategories.add(filterValue);
  //       // }
  //     } else {
  //       if (filterType == 'sort') {
  //         controller.filterSelectedSort.value = '';
  //       } else if (filterType == 'skill') {
  //         controller.filterSelectedSkills.remove(filterValue);
  //       } else if (filterType == 'language') {
  //         controller.filterSelectedLanguages.remove(filterValue);
  //       } else if (filterType == 'gender') {
  //         controller.filterSelectedGender.value = '';
  //       }
  //       // else if (filterType == 'category') {
  //       //   controller.filterSelectedCategories.remove(filterValue);
  //       // }
  //     }
  //   }
  //
  //   showModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.borderRadiusSmall))),
  //     builder: (BuildContext context) {
  //       return Obx(() {
  //         if (controller.isFilterSuccess.isTrue) {
  //           return SizedBox(
  //             width: Get.width,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.only(left: Dimensions.paddingSizeMediumSmall,right: Dimensions.paddingSizeExtraSmall),
  //                   child: Row(
  //                     children: [
  //                       Expanded(child: CustomTextRegular(AppStrings.sortFilter,fontSize: Dimensions.fontSizeLarge)),
  //                       IconButton(
  //                         onPressed: () {
  //                           Get.back();
  //                         },
  //                         icon: const Icon(Icons.close,size: Dimensions.iconSizeMediumSmall),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 const Divider(height: 1.0, color: ColorResources.black6),
  //                 Expanded(
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Expanded(
  //                         flex: 1,
  //                         child: ListView(
  //                           shrinkWrap: true,
  //                           children: [
  //                             filterItemListWidget(controller.selectedIndexFilter,controller.isFilterSelected(1), 1, AppStrings.sort),
  //                             filterItemListWidget(controller.selectedIndexFilter,controller.isFilterSelected(2), 2, AppStrings.skills),
  //                             filterItemListWidget(controller.selectedIndexFilter,controller.isFilterSelected(3), 3, AppStrings.language),
  //                             filterItemListWidget(controller.selectedIndexFilter,controller.isFilterSelected(4), 4, AppStrings.gender),
  //                             //filterItemListWidget(controller, 5, AppStrings.category),
  //                           ],
  //                         ),
  //                       ),
  //                       const VerticalDivider(
  //                         width: 0.5,
  //                         thickness: 0.5,
  //                         color: Colors.grey,
  //                       ),
  //                       Expanded(
  //                         flex: 3,
  //                         child: Obx(() {
  //                           int selectedIndexFilter = controller.selectedIndexFilter.value;
  //                           if (selectedIndexFilter == 1) {
  //                             return  ListView(
  //                               shrinkWrap: true,
  //                               children: [
  //                                 filterOptionWidget('Price: High to Low', controller.filterSelectedSort.value == 'price-desc', (newValue) {
  //                                   updateStatus(newValue, 'sort', 'price-desc');
  //                                 }),
  //                                 filterOptionWidget('Price: Low to High', controller.filterSelectedSort.value == 'price-asc', (newValue) {
  //                                   updateStatus(newValue, 'sort', 'price-asc');
  //                                 }),
  //                                 filterOptionWidget('Experience: High to Low', controller.filterSelectedSort.value == 'experience-desc', (newValue) {
  //                                   updateStatus(newValue, 'sort', 'experience-desc');
  //                                 }),
  //                                 filterOptionWidget('Experience: Low to High', controller.filterSelectedSort.value == 'experience-asc', (newValue) {
  //                                   updateStatus(newValue, 'sort', 'experience-asc');
  //                                 }),
  //                                 filterOptionWidget('Rating: High to Low', controller.filterSelectedSort.value == 'rating', (newValue) {
  //                                   updateStatus(newValue, 'sort', 'rating');
  //                                 }),
  //                                 filterOptionWidget('Trending: High to Low', controller.filterSelectedSort.value == 'trending', (newValue) {
  //                                   updateStatus(newValue, 'sort', 'trending');
  //                                 }),
  //                               ],
  //                             );
  //                           }
  //                           else if (selectedIndexFilter == 2) {
  //                             return Column(
  //                               children: [
  //                                 Row(
  //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Flexible(
  //                                       child: TextButton(
  //                                         onPressed: () {
  //                                           // Select all skills
  //                                           controller.filterSelectedSkills.value = controller.skillList
  //                                               .map((skill) => (skill.id ?? '').toString())
  //                                               .toSet()
  //                                               .toList();
  //                                         },
  //                                         child: CustomTextRegular(AppStrings.selectAll,color: ColorResources.colorPrimaryDark),
  //                                       ),
  //                                     ),
  //                                     Flexible(
  //                                       child: TextButton(
  //                                         onPressed: () {
  //                                           // Clear all selected skills
  //                                           controller.filterSelectedSkills.value = [];
  //                                         },
  //                                         child: CustomTextRegular(AppStrings.clear,color: ColorResources.colorPrimaryDark),
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 Expanded(
  //                                   child: ListView.builder(
  //                                     shrinkWrap: true,
  //                                     itemCount: controller.skillList.length,
  //                                     itemBuilder: (context, index) {
  //                                       final skill = controller.skillList[index];
  //                                       final skillIdString = (skill.id ?? '').toString();
  //                                       return Row(
  //                                         children: [
  //                                           Obx(() => Checkbox(
  //                                             value: controller.filterSelectedSkills.contains(skillIdString),
  //                                             onChanged: (bool? value) {
  //                                               updateStatus(value, 'skill', skillIdString);
  //                                             },
  //                                             activeColor: ColorResources.colorPrimary,
  //                                             side: WidgetStateBorderSide.resolveWith(
  //                                                   (Set<WidgetState> states) {
  //                                                 if (states.contains(WidgetState.selected)) {
  //                                                   return const BorderSide(color: ColorResources.colorPrimary);
  //                                                 }
  //                                                 return const BorderSide(color: ColorResources.colorPrimary);
  //                                               },
  //                                             ),
  //                                           )),
  //                                           CustomTextRegular(skill.skillName ?? ''),
  //                                         ],
  //                                       );
  //                                     },
  //                                   ),
  //                                 ),
  //                               ],
  //                             );
  //                           }
  //                           else if (selectedIndexFilter == 3) {
  //                             return Column(
  //                               children: [
  //                                 Row(
  //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Flexible(
  //                                       child: TextButton(
  //                                         onPressed: () {
  //                                           // Select all skills
  //                                           controller.filterSelectedLanguages.value = controller.languageList
  //                                               .map((language) => (language.id ?? '').toString())
  //                                               .toSet()
  //                                               .toList();
  //                                         },
  //                                         child: CustomTextRegular(AppStrings.selectAll,color: ColorResources.colorPrimaryDark,),
  //                                       ),
  //                                     ),
  //                                     Flexible(
  //                                       child: TextButton(
  //                                         onPressed: () {
  //                                           // Clear all selected skills
  //                                           controller.filterSelectedLanguages.value = [];
  //                                         },
  //                                         child: CustomTextRegular(AppStrings.clear,color: ColorResources.colorPrimaryDark,),
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 Expanded(
  //                                   child: ListView.builder(
  //                                     shrinkWrap: true,
  //                                     itemCount: controller.languageList.length,
  //                                     itemBuilder: (context, index) {
  //                                       final language = controller.languageList[index];
  //                                       final languageIdString = (language.id ?? '').toString();
  //                                       return Row(
  //                                         children: [
  //                                           Obx(() => Checkbox(
  //                                             value: controller.filterSelectedLanguages.contains(languageIdString),
  //                                             onChanged: (bool? value) {
  //                                               updateStatus(value, 'language', languageIdString);
  //                                             },
  //                                             activeColor: ColorResources.colorPrimary,
  //                                             side: WidgetStateBorderSide.resolveWith(
  //                                                   (Set<WidgetState> states) {
  //                                                 if (states.contains(WidgetState.selected)) {
  //                                                   return const BorderSide(color: ColorResources.colorPrimary);
  //                                                 }
  //                                                 return const BorderSide(color: ColorResources.colorPrimary);
  //                                               },
  //                                             ),
  //                                           )),
  //                                           CustomTextRegular(language.languageName?? ''),
  //                                         ],
  //                                       );
  //                                     },
  //                                   ),
  //                                 ),
  //                               ],
  //                             );
  //                           }
  //                           else if (selectedIndexFilter == 4) {
  //                             return Column(
  //                               children: [
  //                                 Row(
  //                                   mainAxisAlignment: MainAxisAlignment.end,
  //                                   children: [
  //                                     Flexible(
  //                                       child: TextButton(
  //                                         onPressed: () {
  //                                           // Clear all selected skills
  //                                           controller.filterSelectedGender.value = '';
  //                                         },
  //                                         child: CustomTextRegular(AppStrings.clear,color: ColorResources.colorPrimaryDark),
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 ListView(
  //                                   shrinkWrap: true,
  //                                   children: [
  //                                     Row(
  //                                       children: [
  //                                         Obx(() => Radio<String>(
  //                                           value: 'male',
  //                                           groupValue: controller.filterSelectedGender.isEmpty ? null : controller.filterSelectedGender.value,
  //                                           onChanged: (String? value) {
  //                                             if (value != null) {
  //                                               controller.filterSelectedGender.value = value;
  //                                             }
  //                                           },
  //                                           activeColor: ColorResources.colorPrimary,
  //                                         )),
  //                                         CustomTextRegular(AppStrings.male),
  //                                       ],
  //                                     ),
  //                                     Row(
  //                                       children: [
  //                                         Obx(() => Radio<String>(
  //                                           value: 'female',
  //                                           groupValue: controller.filterSelectedGender.isEmpty ? null : controller.filterSelectedGender.value,
  //                                           onChanged: (String? value) {
  //                                             if (value != null) {
  //                                               controller.filterSelectedGender.value = value;
  //                                             }
  //                                           },
  //                                           activeColor: ColorResources.colorPrimary,
  //                                         )),
  //                                         CustomTextRegular(AppStrings.female),
  //                                       ],
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ],
  //                             );
  //                           }
  //                           // else if (selectedIndexFilter == 5) {
  //                           //   return Column(
  //                           //     children: [
  //                           //       Row(
  //                           //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           //         children: [
  //                           //           Flexible(
  //                           //             child: TextButton(
  //                           //               onPressed: () {
  //                           //                 // Select all categories
  //                           //                 controller.filterSelectedCategories.value = controller.categoryList
  //                           //                     .map((category) => (category.id ?? '').toString())
  //                           //                     .toSet()
  //                           //                     .toList();
  //                           //               },
  //                           //               child: CustomTextRegular(AppStrings.selectAll, color: ColorResources.colorPrimaryDark),
  //                           //             ),
  //                           //           ),
  //                           //           Flexible(
  //                           //             child: TextButton(
  //                           //               onPressed: () {
  //                           //                 // Clear all selected categories
  //                           //                 controller.filterSelectedCategories.value = [];
  //                           //               },
  //                           //               child: CustomTextRegular(AppStrings.clear, color: ColorResources.colorPrimaryDark),
  //                           //             ),
  //                           //           ),
  //                           //         ],
  //                           //       ),
  //                           //       Expanded(
  //                           //         child: ListView.builder(
  //                           //           shrinkWrap: true,
  //                           //           itemCount: controller.categoryList.length,
  //                           //           itemBuilder: (context, index) {
  //                           //             final category = controller.categoryList[index];
  //                           //             final categoryIdString = (category.id ?? '').toString();
  //                           //             return Row(
  //                           //               children: [
  //                           //                 Obx(() => Checkbox(
  //                           //                   value: controller.filterSelectedCategories.contains(categoryIdString),
  //                           //                   onChanged: (bool? value) {
  //                           //                     updateStatus(value, 'category', categoryIdString);
  //                           //                   },
  //                           //                   activeColor: ColorResources.colorPrimary,
  //                           //                   side: WidgetStateBorderSide.resolveWith(
  //                           //                         (Set<WidgetState> states) {
  //                           //                       if (states.contains(WidgetState.selected)) {
  //                           //                         return const BorderSide(color: ColorResources.colorPrimary);
  //                           //                       }
  //                           //                       return const BorderSide(color: ColorResources.colorPrimary);
  //                           //                     },
  //                           //                   ),
  //                           //                 )),
  //                           //                 CustomTextRegular(category.categoryTitle ?? ''),
  //                           //               ],
  //                           //             );
  //                           //           },
  //                           //         ),
  //                           //       ),
  //                           //     ],
  //                           //   );
  //                           // }
  //                           else {
  //                             return Center(child: CustomTextRegular(AppStrings.dataUnavailable));
  //                           }
  //                         }),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 const Divider(height: 1.0),
  //                 Padding(
  //                   padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall,top: Dimensions.paddingSizeOverSmall,bottom: Dimensions.paddingSizeOverSmall,left: Dimensions.paddingSizeSmall),
  //                   child: Row(
  //                     // mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       Expanded(
  //                         child: ElevatedButton(
  //                           onPressed: () {
  //                             controller.clearAllFilters();
  //                           },
  //                           style: ElevatedButton.styleFrom(
  //                             backgroundColor: ColorResources.colorPrimaryLight, // Change the color if needed
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
  //                             ),
  //                             minimumSize: const Size(150, 45),
  //                           ),
  //                           child: CustomTextRegular("Clear All", color: ColorResources.black),
  //                         ),
  //                       ),
  //                       const Gap(10),
  //                       Expanded(
  //                         child: ElevatedButton(
  //                             onPressed: () async {
  //                               controller.applyFilters();
  //                               Get.back();
  //                             },
  //                             style: ElevatedButton.styleFrom(
  //                                 backgroundColor: ColorResources.colorPrimary,
  //                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall)),
  //                                 minimumSize: const Size(150, 45)
  //                             ),
  //                             child: CustomTextRegular(AppStrings.apply,color: ColorResources.toolbarText)
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         }
  //         else if(controller.isFilterLoading.isTrue){
  //           return const CustomProgressIndicator();
  //         }else{
  //           return const EmptyScreen();
  //         }
  //       });
  //     },
  //   );
  // }

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
