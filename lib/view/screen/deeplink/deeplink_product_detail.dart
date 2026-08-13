import 'package:astro_brahmand/utill/app_fonts.dart';
import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/view/screen/astro_shop/controller/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/shared_preference.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_elevated_button.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_network_image.dart';
import '../../widget/custom_snack_bar.dart';
import '../../widget/custom_text_bold.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import '../../widget/simmer_widget/simmer_grid_container.dart';
import '../splash/controller/config_controller.dart';

class DeeplinkProductDetail extends StatelessWidget {
  const DeeplinkProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();
    String productSlug = Get.parameters['slug'] ?? " ";
    String astrologerRefId = Get.parameters['id'] ?? " ";

    final ProductsController controller = Get.put(ProductsController());
    controller.getProductDetail(productSlug.toString(), "");
    controller.refId.value = astrologerRefId.toString();

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.productDetail.tr),
        body: Obx(
              () {
            if (controller.isProductDetailSuccess.isTrue) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeDefault,
                            vertical: Dimensions.paddingSizeSmall),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image.asset(Images.testProduct,height: 200,width: Get.width,),
                            CustomNetworkImage(
                                imageUrl: controller.productData.productImage.toString(),
                                height: 200,
                                width: Get.width
                            ),
                            const Gap(15),
                            CustomTextMedium(controller.productData.productName.toString(),fontSize: Dimensions.fontSizeLarge),
                            const Gap(5),

                            const Divider(),
                            CustomTextMedium("${AppStrings.youSave.tr} ${configController.currencySymbol} ${((controller.productData.mrp ?? 0) - (controller.productData.price ?? 0)).toString()}",color: ColorResources.colorPrimaryDark),
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
                                  "M.R.P: ${controller.productData.mrp.toString()}",style: const TextStyle(
                                    fontSize: Dimensions.fontSizeSmall,
                                    color: ColorResources.black2,
                                    decoration: TextDecoration.lineThrough
                                ),
                                ),
                              ],
                            ),
                            const Gap(4),
                            Obx(() =>  Visibility(
                              visible: controller.subTotalAmount.toString() != '0',
                              child: CustomTextBold(
                                "${AppStrings.totalAmount.tr} ${configController.currencySymbol} ${controller.subTotalAmount.toString()}/-",
                                fontSize: Dimensions.fontSizeLarge,
                                color: ColorResources.colorFontRed,
                              ),
                            ),),

                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  CustomTextMedium(AppStrings.quantity.tr,fontSize: Dimensions.fontSizeFifteen),
                                  const Gap(10),
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle,size: 35,color: ColorResources.colorPrimaryDark,),
                                    onPressed: () async {
                                      bool isLogin = await SharedPreferencesHelper.getIsLogin();
                                      if(isLogin){
                                        controller.decrement(controller.productData.id.toString(),controller.productData.vendorUniId.toString());
                                      }else{
                                        Get.toNamed('/login');
                                      }
                                    },
                                  ),
                                  // CustomTextRegular("0",color: ColorResources.colorPrimary),
                                  Obx(() => CustomTextRegular(controller.productQty.value.toString(), color: ColorResources.colorPrimaryDark)),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_rounded,size: 35,color: ColorResources.colorPrimaryDark,),
                                    onPressed: () async {
                                      bool isLogin = await SharedPreferencesHelper.getIsLogin();
                                      if(isLogin){
                                        controller.increment(controller.productData.id.toString(),controller.productData.vendorUniId.toString());
                                      }else{
                                        Get.toNamed('/login');
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),

                            CustomTextMedium(AppStrings.productDescription.tr,color: ColorResources.black1),
                            const Gap(5),
                            // CustomTextRegular(
                            //   productsData.productDescription.toString(),
                            //   fontSize: Dimensions.fontSizeSmall,
                            //   color: ColorResources.black2,
                            // ),
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
                      padding:
                      const EdgeInsets.all(Dimensions.paddingSizeMediumSmall),
                      child: CustomElevatedButton(
                        onPressed: () async {
                          bool isLogin = await SharedPreferencesHelper.getIsLogin();
                          if(isLogin){
                            if(controller.productQty.value != 0){
                              Get.toNamed("/save_address");
                            }else{
                              CustomSnackBar.showTop(AppStrings.pleaseAddLeastProceed.tr);
                            }
                          }else{
                            Get.toNamed('/login');
                          }
                        },
                        text: AppStrings.buyNow.tr,
                        backgroundColor: ColorResources.colorPrimary,
                        textColor: ColorResources.toolbarText,
                      ),
                    ),
                  ),
                ],
              );
            }
            else if (controller.isProductDetailLoading.isTrue) {
              return ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const SimmerGridContainer();
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
