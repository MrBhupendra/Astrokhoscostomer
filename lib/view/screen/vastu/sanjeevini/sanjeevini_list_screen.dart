import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/view/screen/vastu/controller/sanjeevini_controller.dart';
import 'package:astro_brahmand/view/screen/vastu/widget/sanjeevini_list_widget.dart';
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:astro_brahmand/view/widget/custom_empty_screen.dart';
import 'package:astro_brahmand/view/widget/simmer_widget/simmer_list_view.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/images.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_show_more.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class SanjeeviniListScreen extends GetView<SanjeeviniController> {
  const SanjeeviniListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.jeevini.tr,
          icon: Icons.my_library_books_outlined,
          onActionPressed: () {
            Get.toNamed('/paid_orders_tab_screen', arguments: {'index': 0});
          },
        ),
        body: Obx(
          () {
            if (controller.isSanjeeviniSuccess.isTrue) {
              return Column(
                children: [
                  // // what is sanjeevini
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: ColorResources.white,
                  //       borderRadius: BorderRadius.circular(10),
                  //       boxShadow: const [
                  //         BoxShadow(
                  //             offset: Offset(1, 1),
                  //             blurRadius: 3,
                  //             color: Colors.grey
                  //         ),
                  //       ],
                  //     ),
                  //     child: Column(
                  //       children: [
                  //         const Gap(5.0),
                  //         CustomTextMedium(
                  //           AppStrings.whatIsSanjeevini.tr,
                  //           color: ColorResources.colorPrimaryMedium,
                  //           textAlign: TextAlign.center,
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.symmetric(horizontal: 10),
                  //           child: CustomTextShowMore(
                  //               fullText: AppStrings.sanjeeviniDefination.tr),
                  //         ),
                  //         const Gap(5.0),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Search Box
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, bottom: 6,top: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorResources.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 3.0,
                            spreadRadius: 1,
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (value) {
                          AppLogger.d("Search Value-> $value");
                          // Future.delayed(const Duration(seconds: 1), () {
                          //   controller.search(value);
                          // });
                          controller.search(value);
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          // filled: true,
                          // fillColor: ColorResources.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Search Jeevini',
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
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await controller.getSanjeeviniList(0, "");
                      },
                      child: ListView.builder(
                        itemCount: controller.sanjeeviniListData.length + 1,
                        controller: controller.scrollController,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            //For "What is Sanjeevini"
                            return Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4,top: 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorResources.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(1, 1),
                                      blurRadius: 3,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    const Gap(5.0),
                                    CustomTextMedium(
                                      AppStrings.whatIsSanjeevini.tr,
                                      color: ColorResources.colorPrimaryMedium,
                                      textAlign: TextAlign.center,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: CustomTextShowMore(
                                        fullText: AppStrings.sanjeeviniDefination.tr,
                                      ),
                                    ),
                                    const Gap(5.0),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            final itemIndex = index - 1;
                            return SanjeeviniWidget(onOpenPressed: () {
                              Get.toNamed('/sanjeeviniDetail', arguments: {
                                'image': controller.sanjeeviniListData[itemIndex].sanjeeviniImage.toString(),
                                'title': controller.sanjeeviniListData[itemIndex].title.toString()
                              });
                            }, onPaymentPressed: () {
                              controller.getSanjeeviniCalculation(
                                  controller.sanjeeviniListData[itemIndex].id.toString(),
                                  0,
                                  controller.sanjeeviniListData[itemIndex],
                                  "Open");
                            }, controller.sanjeeviniListData[itemIndex]);
                          }
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.isSanjeeviniLoading.isTrue,
                      child: CustomTextRegular('Loading...'),
                    ),
                  )
                ],
              );
            } else if (controller.isSanjeeviniLoading.isTrue) {
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
