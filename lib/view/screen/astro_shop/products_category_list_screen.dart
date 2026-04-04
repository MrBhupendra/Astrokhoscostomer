import 'package:astro_brahmand/view/widget/simmer_widget/simmer_grid_container.dart';
import 'package:flutter/material.dart';
import 'package:astro_brahmand/view/screen/astro_shop/controller/products_controller.dart';
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/view/widget/product_category_widget.dart';

import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../widget/custom_empty_screen.dart';

class ProductsCategoryListScreen extends GetView<ProductsController> {
  const ProductsCategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getProductCategory("", "");

    // TextEditingController searchController = TextEditingController();
    //
    // void performSearch(String query) {
    //   Future.delayed(const Duration(seconds: 2), () {
    //     controller.getProductCategory("", query);
    //   });
    // }
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.astroShop.tr),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.getProductCategory("", "");
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
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
                      controller.searchProductCategory(value);
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: AppStrings.searchProductCategory.tr,
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
              Expanded(
                child: Obx(
                  () {
                    if (controller.isProductCategorySuccess.isTrue) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 0.0),
                          child: GridView.builder(
                            itemCount: controller.productCategoryModel.data?.length ?? 0,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 0.0,
                              crossAxisSpacing: 0.0,
                              childAspectRatio: 0.75,
                            ),
                            itemBuilder: (context, index) {
                              return ProductCategoryWidget(
                                controller.productCategoryModel.data![index],
                                onPressed: () {
                                  Get.toNamed('/products', arguments: {
                                    'id': controller.productCategoryModel.data![index].id.toString(),
                                    'title': controller.productCategoryModel.data![index].title.toString()
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      );
                    }
                    else if (controller.isProductCategoryLoading.isTrue) {
                      return const SimmerGridContainer();
                    } else {
                      return const EmptyScreen();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
