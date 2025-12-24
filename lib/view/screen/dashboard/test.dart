// import 'package:astro_brahmand/view/widget/call_chat_astrologer_widget.dart';
// import 'package:astro_brahmand/view/widget/custom_empty_screen.dart';
// import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import '../../../controller/all_astrologer_controller.dart';
// import '../../../utill/app_strings.dart';
// import '../../../utill/color_resources.dart';
// import '../../../utill/dimensions.dart';
// import '../../../utill/images.dart';
// import '../../widget/call_filter_item_list_widget.dart';
// import '../../widget/custom_network_image.dart';
// import '../../widget/custom_progress_indicator.dart';
// import '../../widget/filter_item_list_widget.dart';
// import '../../widget/simmer_widget/simmer_astrologer.dart';
// import 'controller/call_astrologer_controller.dart';
//
// class CallChatAstrologerScreen extends StatelessWidget {
//   final String type;
//   const CallChatAstrologerScreen(this.type, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     CallAstrologerController controller = Get.put<CallAstrologerController>(CallAstrologerController());
//     AllAstrologerController astrologerController = Get.put<AllAstrologerController>(AllAstrologerController());
//     controller.selectedType = type;
//     controller.offsetCount = 0;
//     controller.getCategory();
//     controller.setIndex(0);
//     controller.getAllAstrologer(controller.offsetCount,controller.selectedType,"","init");
//
//     //Scroll
//     controller.scrollController.addListener(() {
//       if (controller.scrollController.position.pixels == controller.scrollController.position.maxScrollExtent) {
//         if(controller.isAstrologerLoading.isFalse && !controller.isNoMoreData) {
//           controller.getAllAstrologer(controller.offsetCount,controller.selectedType,controller.categorySelected,"scroll",
//             skills: controller.selectedSkills.join(','),
//             languages: controller.selectedLanguages.join(','),
//             categories: controller.selectedCategories.join(','),
//             gender: controller.selectedGender.join(','),
//             sortBy: controller.selectedSort.value,
//           );
//         }
//       }
//     });
//
//     return RefreshIndicator(
//       onRefresh: () async {
//         controller.offsetCount = 0;
//         controller.getAllAstrologer(controller.offsetCount,controller.selectedType,controller.categorySelected,"refresh");
//       },
//       child: Column(
//         children: [
//           Obx(() => Visibility(
//             visible: controller.isCategorySuccess.isTrue,
//             child: SizedBox(
//               height: 48,
//               child: ListView.builder(
//                 physics: const BouncingScrollPhysics(),
//                 itemCount: (controller.categoryModel.data?.length ?? 0) + 2, // +1 for the "All" option
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, index) {
//                   if (index == 0) {
//                     // FILTER item
//                     return Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             showFilterBottomSheet(context);
//                             // controller.setIndex(0); // Set index to 0 for "FILTER"
//                             // Add logic for the FILTER item tap
//                           },
//                           child: Obx(() => AnimatedContainer(
//                             duration: const Duration(milliseconds: 300),
//                             margin: const EdgeInsets.all(5),
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(12),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.3),
//                                     spreadRadius: 1,
//                                     blurRadius: 2,
//                                     offset: const Offset(0, 2),
//                                   )
//                                 ]),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
//                               child: Row(
//                                 children: [
//                                   Obx(() => Badge(
//                                       isLabelVisible: controller.selectedSkills.isNotEmpty ||
//                                           controller.selectedLanguages.isNotEmpty ||
//                                           controller.selectedCategories.isNotEmpty ||
//                                           controller.selectedGender.isNotEmpty ||
//                                           controller.selectedSort.value.isNotEmpty,
//                                       backgroundColor: Colors.green,
//                                       child: const Icon(Icons.filter_alt, color: ColorResources.colorPrimaryDark))),
//                                   const Gap(5),
//                                   CustomTextRegular(
//                                     'Filter',
//                                     color: controller.selectedIndex.value == 0
//                                         ? ColorResources.colorPrimaryDark
//                                         : ColorResources.black4,
//                                   ),
//                                   // const Gap(2),
//                                   // This container show when selected filter not empty
//                                   // Obx(() => Visibility(
//                                   //   visible: controller.selectedSkills.isNotEmpty ||
//                                   //       controller.selectedLanguages.isNotEmpty ||
//                                   //       controller.selectedCategories.isNotEmpty ||
//                                   //       controller.selectedGender.isNotEmpty ||
//                                   //       controller.selectedSort.value.isNotEmpty,
//                                   //   child: Container(
//                                   //     width: 8,
//                                   //     height: 8,
//                                   //     decoration: const BoxDecoration(
//                                   //       color: Colors.red, // Color of the dot
//                                   //       shape: BoxShape.circle,
//                                   //     ),
//                                   //   ),
//                                   // )),
//
//                                 ],
//                               ),
//                             ),
//                           )),
//                         ),
//                       ],
//                     );
//                   }
//                   else if (index == 1) {
//                     return Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             controller.setIndex(1);
//                             controller.resetFilters();
//                             controller.getAllAstrologer(controller.offsetCount, controller.selectedType, controller.categorySelected, "init");
//                           },
//                           child: Obx(() => AnimatedContainer(
//                             duration: const Duration(milliseconds: 300),
//                             margin: const EdgeInsets.all(5),
//                             decoration: BoxDecoration(
//                               color: controller.selectedIndex.value == 1 ? Colors.white70 : Colors.white54,
//                               borderRadius: controller.selectedIndex.value == 1 ? BorderRadius.circular(12) : BorderRadius.circular(10),
//                               border: controller.selectedIndex.value == 1 ? Border.all(color: ColorResources.colorPrimaryDark, width: 1.5) : Border.all(color: ColorResources.black6, width: 1.0),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
//                               child: Row(
//                                 children: [
//                                   Image.asset(Images.allCategory,
//                                     width: controller.selectedIndex.value == index ? 25 : 23,
//                                     height: controller.selectedIndex.value == index ? 25 : 23,
//                                     color: ColorResources.colorPrimaryDark,
//                                   ),
//                                   const Gap(5),
//                                   CustomTextRegular(
//                                     AppStrings.all,
//                                     color: controller.selectedIndex.value == 1 ? ColorResources.colorPrimaryDark : ColorResources.black4,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )),
//                         ),
//                       ],
//                     );
//                   }
//                   else {
//                     final selectedIndex = index - 2;
//                     return GestureDetector(
//                       onTap: () {
//                         controller.setIndex(index); // Set index to current index
//                         controller.resetFilters();
//                         controller.categorySelected = controller.categoryModel.data![selectedIndex].id.toString(); // Adjusted index
//                         controller.getAllAstrologer(controller.offsetCount, controller.selectedType, controller.categorySelected, "filter");
//                       },
//                       child: Obx(() => AnimatedContainer(
//                         duration: const Duration(milliseconds: 300),
//                         margin: const EdgeInsets.all(5),
//                         decoration: BoxDecoration(
//                           color: controller.selectedIndex.value == index ? Colors.white70 : Colors.white54,
//                           borderRadius: controller.selectedIndex.value == index ? BorderRadius.circular(12) : BorderRadius.circular(10),
//                           border: controller.selectedIndex.value == index ? Border.all(color: ColorResources.colorPrimaryDark, width: 1.5) : Border.all(color: ColorResources.black6, width: 1.0),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
//                           child: Row(
//                             children: [
//                               CustomNetworkImage(
//                                 height: controller.selectedIndex.value == index ? 22 : 20,
//                                 imageUrl: controller.categoryModel.data![selectedIndex].categoryImages.toString(), // Adjusted index
//                                 width: controller.selectedIndex.value == index ? 22 : 20,
//                               ),
//                               const Gap(5),
//                               CustomTextRegular(
//                                 controller.categoryModel.data![selectedIndex].categoryTitle.toString(),
//                                 color: controller.selectedIndex.value == index ? ColorResources.colorPrimaryDark : ColorResources.black4,
//
//                               ),
//                             ],
//                           ),
//                         ),
//                       )),
//                     );
//                   }
//                 },
//               ),
//             ),
//           )),
//
//           Obx(
//                 () {
//               if (controller.isAstrologerSuccess.isTrue) {
//                 return Expanded(
//                   child: ListView.builder(
//                     itemCount: controller.astrologerListData.length,
//                     controller: controller.scrollController,
//                     itemBuilder: (context, index) {
//                       return CallChatAstrologerWidget(
//                         controller.astrologerListData[index],
//                         onPressed: () {
//                           astrologerController.selectedAstrologerData.value = controller.astrologerListData[index];
//                           Get.toNamed("/astroProfile");
//                         },
//                         type: type,
//                       );
//                     },
//                   ),
//                 );
//               } else if (controller.isAstrologerLoading.isTrue) {
//                 return Expanded(
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: 6,
//                     itemBuilder: (context, index) {
//                       return const SimmerAstrologer();
//                     },
//                   ),
//                 );
//               } else {
//                 return const EmptyScreen();
//               }
//             },
//           ),
//           Obx(() => Visibility(
//             visible: controller.isAstrologerLoading.isTrue,
//             child: const Text('Loading'),
//           ),)
//         ],
//       ),
//     );
//   }
//
//   void showFilterBottomSheet(BuildContext context) {
//     CallAstrologerController controller = Get.put<CallAstrologerController>(CallAstrologerController());
//     // controller.getFilters();
//     controller.resetFilters();
//     controller.selectedIndexFilter.value = 1;
//     ValueNotifier<bool> popularity = ValueNotifier(false);
//
//     void updateStatus(bool? value, String filterType, String filterValue) {
//       if (value == true) {
//         if (filterType == 'skill') {
//           controller.selectedSkills.add(filterValue);
//         } else if (filterType == 'language') {
//           controller.selectedLanguages.add(filterValue);
//         } else if (filterType == 'category') {
//           controller.selectedCategories.add(filterValue);
//         } else if (filterType == 'gender') {
//           controller.selectedGender.add(filterValue);
//         } else if (filterType == 'sort') {
//           controller.selectedSort.value = filterValue;
//         }
//       } else {
//         if (filterType == 'skill') {
//           controller.selectedSkills.remove(filterValue);
//         } else if (filterType == 'language') {
//           controller.selectedLanguages.remove(filterValue);
//         } else if (filterType == 'category') {
//           controller.selectedCategories.remove(filterValue);
//         } else if (filterType == 'gender') {
//           controller.selectedGender.remove(filterValue);
//         } else if (filterType == 'sort') {
//           controller.selectedSort.value = '';
//         }
//       }
//     }
//
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.borderRadiusSmall))),
//       builder: (BuildContext context) {
//         return Obx(() {
//           if (controller.isFilterSuccess.isTrue) {
//             return SizedBox(
//               width: Get.width,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: Dimensions.paddingSizeMediumSmall,right: Dimensions.paddingSizeExtraSmall),
//                     child: Row(
//                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(child: CustomTextRegular(AppStrings.sortFilter,fontSize: Dimensions.fontSizeLarge)),
//                         IconButton(
//                           onPressed: () {
//                             Get.back();
//                           },
//                           icon: const Icon(Icons.close,size: Dimensions.iconSizeMediumSmall),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Divider(height: 1.0, color: ColorResources.black6),
//                   Expanded(
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           flex: 1,
//                           child: ListView(
//                             shrinkWrap: true,
//                             children: [
//                               callFilterItemListWidget(controller, 1, AppStrings.sort),
//                               callFilterItemListWidget(controller, 2, AppStrings.skills),
//                               callFilterItemListWidget(controller, 3, AppStrings.language),
//                               callFilterItemListWidget(controller, 4, AppStrings.category),
//                               callFilterItemListWidget(controller, 5, AppStrings.gender),
//                             ],
//                           ),
//                         ),
//                         const VerticalDivider(
//                           width: 0.5,
//                           thickness: 0.5,
//                           color: Colors.grey,
//                         ),
//                         Expanded(
//                           flex: 3,
//                           child: Obx(() {
//                             int selectedIndexFilter = controller.selectedIndexFilter.value;
//                             if (selectedIndexFilter == 1) {
//                               return  ListView(
//                                 shrinkWrap: true,
//                                 children: [
//                                   filterOptionWidget('Price: High to Low', controller.selectedSort.value == 'price-desc', (newValue) {
//                                     updateStatus(newValue, 'sort', 'price-desc');
//                                   }),
//                                   filterOptionWidget('Price: Low to High', controller.selectedSort.value == 'price-asc', (newValue) {
//                                     updateStatus(newValue, 'sort', 'price-asc');
//                                   }),
//                                   filterOptionWidget('Experience: High to Low', controller.selectedSort.value == 'experience-desc', (newValue) {
//                                     updateStatus(newValue, 'sort', 'experience-desc');
//                                   }),
//                                   filterOptionWidget('Experience: Low to High', controller.selectedSort.value == 'experience-asc', (newValue) {
//                                     updateStatus(newValue, 'sort', 'experience-asc');
//                                   }),
//                                   filterOptionWidget('Rating: High to Low', controller.selectedSort.value == 'rating', (newValue) {
//                                     updateStatus(newValue, 'sort', 'rating');
//                                   }),
//                                   filterOptionWidget('Trending: High to Low', controller.selectedSort.value == 'trending', (newValue) {
//                                     updateStatus(newValue, 'sort', 'trending');
//                                   }),
//                                 ],
//                               );
//                             }
//                             else if (selectedIndexFilter == 2) {
//                               return Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Flexible(
//                                         child: TextButton(
//                                           onPressed: () {
//                                             // Select all skills
//                                             controller.selectedSkills.value = controller.skillList
//                                                 .map((skill) => (skill.id ?? '').toString())
//                                                 .toSet()
//                                                 .toList();
//                                           },
//                                           child: CustomTextRegular(AppStrings.selectAll,color: ColorResources.colorPrimaryDark),
//                                         ),
//                                       ),
//                                       Flexible(
//                                         child: TextButton(
//                                           onPressed: () {
//                                             // Clear all selected skills
//                                             controller.selectedSkills.value = [];
//                                           },
//                                           child: CustomTextRegular(AppStrings.clear,color: ColorResources.colorPrimaryDark),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Expanded(
//                                     child: ListView.builder(
//                                       shrinkWrap: true,
//                                       itemCount: controller.skillList.length,
//                                       itemBuilder: (context, index) {
//                                         final skill = controller.skillList[index];
//                                         final skillIdString = (skill.id ?? '').toString();
//                                         return Row(
//                                           children: [
//                                             Obx(() => Checkbox(
//                                               value: controller.selectedSkills.contains(skillIdString),
//                                               onChanged: (bool? value) {
//                                                 updateStatus(value, 'skill', skillIdString);
//                                               },
//                                               activeColor: ColorResources.colorPrimary,
//                                               side: WidgetStateBorderSide.resolveWith(
//                                                     (Set<WidgetState> states) {
//                                                   if (states.contains(WidgetState.selected)) {
//                                                     return const BorderSide(color: ColorResources.colorPrimary);
//                                                   }
//                                                   return const BorderSide(color: ColorResources.colorPrimary);
//                                                 },
//                                               ),
//                                             )),
//                                             CustomTextRegular(skill.skillName ?? ''),
//                                           ],
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             }
//                             else if (selectedIndexFilter == 3) {
//                               return Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Flexible(
//                                         child: TextButton(
//                                           onPressed: () {
//                                             // Select all skills
//                                             controller.selectedLanguages.value = controller.languageList
//                                                 .map((language) => (language.id ?? '').toString())
//                                                 .toSet()
//                                                 .toList();
//                                           },
//                                           child: CustomTextRegular(AppStrings.selectAll,color: ColorResources.colorPrimaryDark,),
//                                         ),
//                                       ),
//                                       Flexible(
//                                         child: TextButton(
//                                           onPressed: () {
//                                             // Clear all selected skills
//                                             controller.selectedLanguages.value = [];
//                                           },
//                                           child: CustomTextRegular(AppStrings.clear,color: ColorResources.colorPrimaryDark,),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Expanded(
//                                     child: ListView.builder(
//                                       shrinkWrap: true,
//                                       itemCount: controller.languageList.length,
//                                       itemBuilder: (context, index) {
//                                         final language = controller.languageList[index];
//                                         final languageId = (language.id ?? 0).toInt();
//                                         final languageIdString = languageId.toString();
//                                         return Row(
//                                           children: [
//                                             Obx(() => Checkbox(
//                                               value: controller.selectedLanguages.contains(languageIdString),
//                                               onChanged: (bool? value) {
//                                                 controller.updateStatus(value, 'language', language.languageName ?? '', languageId);
//                                               },
//                                               activeColor: ColorResources.colorPrimary,
//                                               side: WidgetStateBorderSide.resolveWith(
//                                                     (Set<WidgetState> states) {
//                                                   if (states.contains(WidgetState.selected)) {
//                                                     return const BorderSide(color: ColorResources.colorPrimary);
//                                                   }
//                                                   return const BorderSide(color: ColorResources.colorPrimary);
//                                                 },
//                                               ),
//                                             )),
//                                             CustomTextRegular(language.languageName?? ''),
//                                           ],
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             }
//                             else if (selectedIndexFilter == 4) {
//                               return Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Flexible(
//                                         child: TextButton(
//                                           onPressed: () {
//                                             // Select all categories
//                                             controller.selectedCategories.value = controller.categoryList
//                                                 .map((category) => (category.id ?? '').toString())
//                                                 .toSet()
//                                                 .toList();
//                                           },
//                                           child: CustomTextRegular(AppStrings.selectAll, color: ColorResources.colorPrimaryDark),
//                                         ),
//                                       ),
//                                       Flexible(
//                                         child: TextButton(
//                                           onPressed: () {
//                                             // Clear all selected categories
//                                             controller.selectedCategories.value = [];
//                                           },
//                                           child: CustomTextRegular(AppStrings.clear, color: ColorResources.colorPrimaryDark),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Expanded(
//                                     child: ListView.builder(
//                                       shrinkWrap: true,
//                                       itemCount: controller.categoryList.length,
//                                       itemBuilder: (context, index) {
//                                         final category = controller.categoryList[index];
//                                         final categoryIdString = (category.id ?? '').toString();
//                                         return Row(
//                                           children: [
//                                             Obx(() => Checkbox(
//                                               value: controller.selectedCategories.contains(categoryIdString),
//                                               onChanged: (bool? value) {
//                                                 updateStatus(value, 'category', categoryIdString);
//                                               },
//                                               activeColor: ColorResources.colorPrimary,
//                                               side: WidgetStateBorderSide.resolveWith(
//                                                     (Set<WidgetState> states) {
//                                                   if (states.contains(WidgetState.selected)) {
//                                                     return const BorderSide(color: ColorResources.colorPrimary);
//                                                   }
//                                                   return const BorderSide(color: ColorResources.colorPrimary);
//                                                 },
//                                               ),
//                                             )),
//                                             CustomTextRegular(category.categoryTitle ?? ''),
//                                           ],
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             }
//                             else if (selectedIndexFilter == 5) {
//                               return Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Flexible(
//                                         child: TextButton(
//                                           onPressed: () {
//                                             // Clear all selected skills
//                                             controller.selectedGender.value = [];
//                                           },
//                                           child: CustomTextRegular(AppStrings.clear,color: ColorResources.colorPrimaryDark,),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   ListView(
//                                     shrinkWrap: true,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Obx(() => Radio<String>(
//                                             value: 'Male',
//                                             groupValue: controller.selectedGender.isEmpty ? null : controller.selectedGender.first,
//                                             onChanged: (String? value) {
//                                               if (value != null) {
//                                                 controller.selectedGender.value = [value];
//                                               }
//                                             },
//                                             activeColor: ColorResources.colorPrimary,
//                                           )),
//                                           CustomTextRegular(AppStrings.male),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Obx(() => Radio<String>(
//                                             value: 'Female',
//                                             groupValue: controller.selectedGender.isEmpty ? null : controller.selectedGender.first,
//                                             onChanged: (String? value) {
//                                               if (value != null) {
//                                                 controller.selectedGender.value = [value];
//                                               }
//                                             },
//                                             activeColor: ColorResources.colorPrimary,
//                                           )),
//                                           CustomTextRegular(AppStrings.female),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               );
//                             }
//                             else {
//                               return Center(child: CustomTextRegular(AppStrings.dataUnavailable));
//                             }
//                           }),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Divider(height: 1.0),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       right: Dimensions.paddingSizeSmall,
//                       top: Dimensions.paddingSizeOverSmall,
//                       bottom: Dimensions.paddingSizeOverSmall,
//                       left: Dimensions.paddingSizeSmall,
//                     ),
//                     child: Row(
//                       // mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust for better layout
//                       children: [
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () {
//                               // Clear all filters
//                               controller.clearAllFilters(); // Assuming you have a method to clear all filters
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: ColorResources.colorPrimaryLight, // Change the color if needed
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
//                               ),
//                               minimumSize: const Size(150, 45),
//                             ),
//                             child: CustomTextRegular("Clear All", color: ColorResources.black),
//                           ),
//                         ),
//                         const Gap(10),
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () async {
//                               controller.applyFilters();
//                               Get.back();
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: ColorResources.colorPrimary,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
//                               ),
//                               minimumSize: const Size(150, 45),
//                             ),
//                             child: CustomTextRegular(AppStrings.apply, color: ColorResources.toolbarText),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }else if(controller.isFilterLoading.isTrue){
//             return const CustomProgressIndicator();
//           }else{
//             return const EmptyScreen();
//           }
//         });
//       },
//     );
//   }
// }
