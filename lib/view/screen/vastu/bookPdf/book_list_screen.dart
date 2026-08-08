import 'dart:async';

import 'package:astro_brahmand/view/widget/simmer_widget/simmer_grid_container2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/view/screen/vastu/widget/books_product_widget.dart';

import '../../../../utill/app_constants.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/images.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../../widget/custom_text_show_more.dart';
import '../controller/book_pdf_controller.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class BooksListScreen extends StatelessWidget {
  const BooksListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic arguments = Get.arguments;
    String title = '';
    String categoryId = '';

    if (arguments is Map<String, dynamic>) {
      title = arguments['title'] ?? '';
      categoryId = arguments['id'] ?? '';
    }

    final BookPdfController controller = Get.put<BookPdfController>(BookPdfController());
    controller.offsetCount = 0;
    controller.isProductsSuccess(false);
    AppLogger.d("categoryId Screen-> $categoryId");
    controller.getBooksList(categoryId, controller.offsetCount, "");

   controller.scrollController.addListener(() {
      if (controller.scrollController.position.pixels == controller.scrollController.position.maxScrollExtent) {
        if(controller.isProductsLoading.isFalse && !controller.isNoMoreData) {
          controller.getBooksList(categoryId, controller.offsetCount, controller.searchQuery.value);
        }
      }
    });

    void search(String query) {
      if (controller.debounce?.isActive ?? false) controller.debounce!.cancel();
      controller.debounce = Timer(const Duration(seconds: 1), () {
        controller.searchQuery.value = query;
        controller.offsetCount = 0;
        // isNoMoreData = false;
        // booksList.clear();
        AppLogger.d("categoryId-> $categoryId");
        controller.getBooksList(categoryId, controller.offsetCount, query);
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: title),
        body:Obx(
              () {
            if (controller.isProductsSuccess.isTrue) {
              return Column(
                children: [
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
                  //           AppStrings.ebookLearn.tr,
                  //           color: ColorResources.colorPrimaryMedium,
                  //           textAlign: TextAlign.center,
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(
                  //             right: 10.0,
                  //             left: 10,
                  //             top: 10,
                  //           ),
                  //           child: CustomTextShowMore(
                  //               fullText: AppStrings.ebookLearnDescription.tr),
                  //         ),
                  //         const Gap(5.0),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Search Box
                  Padding(
                    padding: const EdgeInsets.all(8),
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
                          search(value);
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Search $title E-book',
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
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 8,right: 8,bottom: 10,top: 2),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: ColorResources.white,
                  //       borderRadius: BorderRadius.circular(10),
                  //       boxShadow: const [
                  //         BoxShadow(
                  //           offset: Offset(1, 1),
                  //           blurRadius: 3,
                  //           color: Colors.grey,
                  //         ),
                  //       ],
                  //     ),
                  //     child: Column(
                  //       children: [
                  //         const Gap(5.0),
                  //         CustomTextMedium(
                  //           AppStrings.ebookLearn.tr,
                  //           color: ColorResources.colorPrimaryMedium,
                  //           textAlign: TextAlign.center,
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.only(
                  //             right: 10.0,
                  //             left: 10,
                  //             top: 10,
                  //           ),
                  //           child: CustomTextShowMore(
                  //             fullText: AppStrings.ebookLearnDescription.tr,
                  //           ),
                  //         ),
                  //         const Gap(5.0),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 2.0,
                          childAspectRatio: 0.83,
                        ),
                        shrinkWrap: true,
                        itemCount: controller.booksList.length,
                        controller: controller.scrollController,
                        itemBuilder: (context, index) {
                          return BooksProductWidget(
                            controller.booksList[index],
                            onPressed: () {
                              if (controller.booksList[index].paymentStatus ==
                                  AppConstants.success) {
                                Get.toNamed('/pdf_viewer', arguments: {
                                  'title': controller.booksList[index].title.toString(),
                                  'url': controller.booksList[index].mainPdf.toString(),
                                });
                              } else {
                                Get.toNamed("/bookDetail",
                                    arguments: controller.booksList[index]);
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ),

                  Obx(() => Visibility(
                    visible: controller.isProductsLoading.isTrue,
                    child: CustomTextRegular('Loading...'),
                  ))
                ],
              );
            }
            else if (controller.isProductsLoading.isTrue) {
              return const SimmerGridContainer2();
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorResources.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(1, 1),
                              blurRadius: 3,
                              color: Colors.grey),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Gap(5.0),
                          CustomTextMedium(
                            AppStrings.ebookLearn.tr,
                            color: ColorResources.colorPrimaryMedium,
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 10.0,
                              left: 10,
                              top: 10,
                            ),
                            child: CustomTextShowMore(
                                fullText: AppStrings.ebookLearnDescription.tr),
                          ),
                          const Gap(5.0),
                        ],
                      ),
                    ),
                  ),
                  const EmptyScreen(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
