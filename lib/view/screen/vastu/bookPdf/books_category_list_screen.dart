import 'package:astro_brahmand/view/widget/simmer_widget/simmer_grid_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/view/screen/vastu/widget/books_category_widget.dart';

import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_show_more.dart';
import '../controller/book_pdf_controller.dart';

class BooksCategoryListScreen extends StatelessWidget {
  const BooksCategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookPdfController controller = Get.put<BookPdfController>(BookPdfController());
    controller.getBooksCategoryList();
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.ebook.tr,
          icon: Icons.my_library_books_outlined,
          onActionPressed: () {
            Get.toNamed('/paid_orders_tab_screen', arguments: {'index': 2});
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorResources.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(1, 1),
                          blurRadius: 3,
                          color: Colors.grey
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Gap(5.0),
                      CustomTextMedium(
                        AppStrings.whatAreEbook.tr,
                        color: ColorResources.colorPrimaryMedium,
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 10.0,
                          left: 10,
                          top: 10,
                          bottom: 5
                        ),
                        child: CustomTextShowMore(fullText: AppStrings.ebookDefination.tr),
                      ),
                      // const Gap(5.0),
                    ],
                  ),
                ),
              ),
              Obx(
                () {
                  if (controller.isCategorySuccess.isTrue) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0,top: 6),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            // mainAxisSpacing: 4.0,
                            // crossAxisSpacing: 4.0,
                            childAspectRatio: 0.75
                        ),
                        // scrollDirection: Axis.horizontal,
                        itemCount: controller.bookPdfCategoryModel.data?.length,
                        itemBuilder: (context, index) {
                          return BooksCategoryWidget(
                            onPressed: () {
                              Get.toNamed('/booksList', arguments: {
                                'id': controller.bookPdfCategoryModel.data?[index].id.toString(),
                                'title': controller.bookPdfCategoryModel.data?[index].title.toString()
                              });
                            },
                              controller.bookPdfCategoryModel.data![index]);
                        },
                      ),
                    );
                  } else if (controller.isCategoryLoading.isTrue) {
                    return const SimmerGridContainer();
                  } else {
                    return const EmptyScreen();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
