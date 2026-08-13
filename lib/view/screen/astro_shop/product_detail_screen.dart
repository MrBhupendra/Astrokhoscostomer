import 'package:astro_brahmand/utill/app_fonts.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/view/screen/astro_shop/controller/products_controller.dart';
import 'package:astro_brahmand/view/widget/custom_elevated_button.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_bold.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';

import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/shared_preference.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/gallery_image_slider_widget.dart';
import '../splash/controller/config_controller.dart';

class ProductDetailScreen extends GetView<ProductsController> {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(controller.productData.quantity!.toInt() > 0){
        controller.isOutOfStock.value = false;
        controller.resetControllerValue( controller.productData.id.toString(), controller.productData.vendorUniId.toString(),isApi: true);
      }else{
        controller.isOutOfStock.value = true;
        controller.resetControllerValue( controller.productData.id.toString(), controller.productData.vendorUniId.toString(),isApi: false);
      }
    });

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.productDetail.tr),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeMediumSmall,
                      vertical: Dimensions.paddingSizeSmall),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image.asset(Images.testProduct,height: 200,width: Get.width,),
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                      //   child: CustomNetworkImage(
                      //       imageUrl: controller.productData.productImage.toString(),
                      //       height: 200,
                      //       width: Get.width
                      //   ),
                      // ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: ColorResources.black4),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: CustomNetworkImage(
                                imageUrl: controller.productData.productImage.toString(),
                                height: 220,
                                width: Get.width * 0.8
                            ),
                          ),
                        ),
                      ),
                      // Gallery images
                      if (controller.productData.galleryImageList!.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.symmetric(vertical: Dimensions.gapDefault),
                          height: 100.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.productData.galleryImageList?.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        GalleryImageSliderWidget(
                                          imageUrls: controller
                                              .productData
                                              .galleryImageList!,
                                          initialIndex: index,
                                        ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 8.0),
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    child: CustomNetworkImage(
                                        imageUrl: controller
                                            .productData
                                            .galleryImageList![index],
                                        height: 70,
                                        width: 80),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      const Gap(15),
                      CustomTextMedium(
                          controller.productData.productName.toString(),
                          fontSize: Dimensions.fontSizeLarge),
                      const Gap(5),

                      const Divider(),
                      CustomTextMedium(
                          "${AppStrings.youSave.tr} ${configController.currencySymbol} ${((controller.productData.mrp ?? 0) - (controller.productData.price ?? 0)).toString()}",
                          color: ColorResources.colorPrimaryDark),
                      const Gap(4),
                      Row(
                        children: [
                          CustomTextBold(
                            "${configController.currencySymbol} ${controller.productData.price.toString()}/-",
                            fontSize: Dimensions.fontSizeLarge,
                            color: ColorResources.colorFontRed,
                          ),
                          const Gap(4),
                          Text(
                            "M.R.P: ${controller.productData.mrp.toString()}",
                            style: const TextStyle(
                                fontSize: Dimensions.fontSizeSmall,
                                color: ColorResources.black2,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ],
                      ),
                      const Gap(4),
                      Obx(
                        () => Visibility(
                          visible: controller.subTotalAmount.toString() != '0',
                          child: CustomTextBold(
                            "${AppStrings.totalAmount.tr} ${configController.currencySymbol} ${controller.subTotalAmount.toString()}/-",
                            fontSize: Dimensions.fontSizeLarge,
                            color: ColorResources.colorFontRed,
                          ),
                        ),
                      ),

                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            CustomTextMedium(AppStrings.quantity.tr,
                                fontSize: Dimensions.fontSizeFifteen),
                            const Gap(10),
                            IconButton(
                              icon: const Icon(
                                Icons.remove_circle,
                                size: 35,
                                color: ColorResources.colorPrimaryDark,
                              ),
                              onPressed: () async {
                                bool isLogin =
                                    await SharedPreferencesHelper.getIsLogin();
                                if (isLogin) {
                                  controller.decrement(
                                      controller.productData.id.toString(),
                                      controller.productData.vendorUniId
                                          .toString());
                                } else {
                                  Get.toNamed('/login');
                                }
                              },
                            ),
                            // CustomTextRegular("0",color: ColorResources.colorPrimary),
                            Obx(() => CustomTextRegular(
                                controller.productQty.value.toString(),
                                color: ColorResources.colorPrimaryDark)),
                            IconButton(
                              icon: const Icon(
                                Icons.add_circle_rounded,
                                size: 35,
                                color: ColorResources.colorPrimaryDark,
                              ),
                              onPressed: () async {
                                bool isLogin =
                                    await SharedPreferencesHelper.getIsLogin();
                                if (isLogin) {
                                  controller.increment(
                                      controller.productData.id.toString(),
                                      controller.productData.vendorUniId
                                          .toString());
                                } else {
                                  Get.toNamed('/login');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      
                      CustomTextMedium(AppStrings.productDescription.tr, color: ColorResources.black1),
                      const Gap(5),
                      HtmlWidget(
                        controller.productData.productDescription.toString(),
                        textStyle: const TextStyle(
                          color: ColorResources.black2,
                          fontSize: Dimensions.fontSizeSmall,
                          fontFamily: AppFonts.euclidRegular,
                          fontFamilyFallback: AppFonts.fallback,
                        ),
                      ),

                      const Gap(80),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: ColorResources.white,
              child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeMediumSmall),
                  child: Obx(()=>
                      CustomElevatedButton(
                        onPressed: () async {
                          bool isLogin = await SharedPreferencesHelper.getIsLogin();
                          if (isLogin) {
                            if(controller.isOutOfStock.isFalse){
                              if (controller.productQty.value != 0) {
                                Get.toNamed("/save_address");
                              } else {
                                CustomSnackBar.showTop(AppStrings.pleaseAddLeastProceed.tr);
                              }
                            }else{
                              CustomSnackBar.showBottom(AppStrings.outOfStock.tr);
                            }

                          } else {
                            Get.toNamed('/login');
                          }
                        },
                        text: controller.isOutOfStock.isFalse ? AppStrings.buyNow.tr : AppStrings.outOfStock.tr,
                        backgroundColor: controller.isOutOfStock.isFalse ? ColorResources.colorPrimary : ColorResources.grey,
                        textColor: controller.isOutOfStock.isFalse ? ColorResources.toolbarText : Colors.black,
                      ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

}
