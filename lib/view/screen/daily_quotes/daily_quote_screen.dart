import 'package:astro_brahmand/utill/app_fonts.dart';
import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/view/screen/daily_quotes/controller/daily_quote_controller.dart';
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:astro_brahmand/view/widget/simmer_widget/simmer_list_view.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/common_methods.dart';
import '../../../utill/dimensions.dart';
import '../../widget/custom_empty_screen.dart';

class DailyQuoteScreen extends GetView<DailyQuoteController> {
  const DailyQuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.dailyQuotes.tr),
        body: Obx(
          () {
            if (controller.isSuccess.isTrue) {
              return Column(
                children: [
                  // filter part
                  // Visibility(
                  //   visible: controller.isCategorySuccess.isTrue,
                  //   child: SizedBox(
                  //     // width: double.infinity,
                  //     height: 48,
                  //     child: ListView.builder(
                  //         physics: const BouncingScrollPhysics(),
                  //         itemCount: controller.quoteCategoryModel.data?.length,
                  //         scrollDirection: Axis.horizontal,
                  //         itemBuilder: (context, index) {
                  //           return Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               GestureDetector(
                  //                   onTap: () {
                  //                     controller.selectCategory(index);
                  //                     controller.offsetCount = 0;
                  //                     String? selectedCategoryId = controller.quoteCategoryModel.data?[index].id.toString();
                  //                     controller.getQuote(controller.offsetCount,selectedCategoryId!);
                  //                     controller.dailyQuoteListData.clear();
                  //                   },
                  //                   child: Obx(() =>  AnimatedContainer(
                  //                     duration: const Duration(milliseconds: 300),
                  //                     margin: const EdgeInsets.all(5),
                  //                     // width: 90,
                  //                     // height: 35,
                  //                     decoration: BoxDecoration(
                  //                       color: controller.selectedIndex.value == index
                  //                           ? Colors.white70
                  //                           : Colors.white54,
                  //                       borderRadius: controller.selectedIndex.value == index
                  //                           ? BorderRadius.circular(12)
                  //                           : BorderRadius.circular(10),
                  //                       border: controller.selectedIndex.value == index
                  //                           ? Border.all(
                  //                           color: ColorResources.colorPrimary,
                  //                           width: 1.5)
                  //                           : Border.all(
                  //                           color: ColorResources.black6,
                  //                           width: 1.0),
                  //                     ),
                  //                     child: Padding(
                  //                       padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                  //                       child: Text(
                  //                        controller.quoteCategoryModel.data![index].title.toString(),
                  //                         style: TextStyle(
                  //                           fontWeight: FontWeight.w500,
                  //                           color: controller.selectedIndex.value == index
                  //                               ? ColorResources.colorPrimary
                  //                               : ColorResources.black4,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ))
                  //               ),
                  //             ],
                  //           );
                  //         }),
                  //   ),
                  // ),
                  // filter part end
                  Row(
                    children: [
                      Visibility(
                        visible: controller.isCategorySuccess.isTrue,
                        child: Flexible(
                          child: SizedBox(
                            height: 48,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: (controller.quoteCategoryModel.data?.length ?? 0) + 1,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  // Handling "All" option
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.selectCategory(0); // 0 for "All"
                                          controller.offsetCount = 0;
                                          controller.getQuote(controller.offsetCount,"");
                                          controller.dailyQuoteListData.clear();
                                        },
                                        child: Obx(() => AnimatedContainer(
                                          duration: const Duration(milliseconds: 300),
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: controller.selectedIndex.value == 0
                                                ? Colors.white70
                                                : Colors.white54,
                                            borderRadius: controller.selectedIndex.value == 0
                                                ? BorderRadius.circular(12)
                                                : BorderRadius.circular(10),
                                            border: controller.selectedIndex.value == 0
                                                ? Border.all(
                                                color: ColorResources.colorPrimary,
                                                width: 1.5)
                                                : Border.all(
                                                color: ColorResources.black6,
                                                width: 1.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 16),
                                            child: Text(
                                              AppStrings.all,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: controller.selectedIndex.value == 0
                                                    ? ColorResources.colorPrimaryDark
                                                    : ColorResources.black4,
                                              ),
                                            ),
                                          ),
                                        )),
                                      ),
                                    ],
                                  );
                                } else {
                                  // Handling other categories
                                  // final categoryIndex = index - 1;
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.selectCategory(index);
                                          controller.offsetCount = 0;
                                          String? selectedCategoryId = controller.quoteCategoryModel.data?[index - 1].id.toString();
                                          controller.getQuote(controller.offsetCount,selectedCategoryId!);
                                          controller.dailyQuoteListData.clear();
                                        },
                                        child: Obx(() => AnimatedContainer(
                                          duration: const Duration(milliseconds: 300),
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: controller.selectedIndex.value == index
                                                ? Colors.white70
                                                : Colors.white54,
                                            borderRadius: controller.selectedIndex.value == index
                                                ? BorderRadius.circular(12)
                                                : BorderRadius.circular(10),
                                            border: controller.selectedIndex.value ==
                                                index
                                                ? Border.all(
                                                color: ColorResources.colorPrimary,
                                                width: 1.5)
                                                : Border.all(
                                                color: ColorResources.black6,
                                                width: 1.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                                            child: Text(
                                              controller.quoteCategoryModel.data![index - 1].title.toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: controller.selectedIndex.value == index
                                                    ? ColorResources.colorPrimaryDark
                                                    : ColorResources.black4,
                                              ),
                                            ),
                                          ),
                                        )),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.dailyQuoteListData.length,
                      controller: controller.scrollController,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
                          child: Container(
                            // height: 200,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  ColorResources.colorPrimaryVariant,
                                  ColorResources.colorPrimaryLight
                                ], // Example gradient colors
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18.0, horizontal: 20),
                              child: Column(
                                children: [
                                  // const Gap(10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 10),
                                    child: HtmlWidget(
                                      controller.dailyQuoteListData[index].content.toString(),
                                      textStyle: const TextStyle(
                                        fontSize: Dimensions.fontSizeLarge,
                                        fontFamily: AppFonts.euclidRegular,
                                        fontFamilyFallback: AppFonts.fallback,
                                      ),
                                      // fontSize: Dimensions.fontSizeLarge,
                                      // textAlign: TextAlign.center,
                                    ),
                                  ),
                                  // Share part
                                  GestureDetector(
                                    onTap: () async {
                                      String quoteSlug = controller
                                          .dailyQuoteListData[index].slug
                                          .toString();
                                      String astroSlugUrl = controller
                                          .dailyQuoteListData[index].content
                                          .toString();
                                      CommonMethods().shareApp("dailyQuote",
                                          astroSlugUrl: astroSlugUrl,
                                          quoteSlug: quoteSlug);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  5.0), // Adjust padding as needed
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.share,
                                                      size: 14),
                                                  const Gap(5),
                                                  Text(AppStrings.share.tr),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // const Gap(10),
                                ],
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
    );
  }
}
