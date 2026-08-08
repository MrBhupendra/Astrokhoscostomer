import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/view/screen/astro_shop/controller/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_elevated_button.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_text_regular.dart';
import '../../widget/simmer_widget/simmer_list_view.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class SaveAddressScreen extends GetView<ProductsController> {
  const SaveAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppLogger.d("Sk1");
    controller.getUserAddress();
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.savedAddresses.tr),
        body: Stack(
          children: [
            Obx(
              () {
                if (controller.isAddressSuccess.isTrue) {
                  AppLogger.d("Sk2");
                  // controller.getUserAddress();
                  return RefreshIndicator(
                    onRefresh: () async {
                      controller.getUserAddress();
                    },
                    child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeExtraSmall,
                              vertical: Dimensions.paddingSizeExtraOverSmall),
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    controller.userAddressModel.data?.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: Dimensions.paddingSizeExtraOverSmall),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: ColorResources.white,
                                          borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.3),
                                              spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: const Offset(0, 1),
                                            )
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: Dimensions.paddingSizeDefault,
                                            vertical: Dimensions.paddingSizeSmall),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Gap(5),
                                            CustomTextRegular(
                                              controller.userAddressModel
                                                  .data![index].name
                                                  .toString(),
                                              maxLines: 1,
                                            ),
                                            const Gap(2),
                                            CustomTextRegular(
                                              "${controller.userAddressModel.data![index].houseNo}, ${controller.userAddressModel.data![index].streetArea}",
                                              maxLines: 3,
                                            ),
                                            const Gap(2),
                                            CustomTextRegular(controller
                                                .userAddressModel
                                                .data![index]
                                                .landmark
                                                .toString()),
                                            const Gap(2),
                                            CustomTextRegular(controller
                                                .userAddressModel
                                                .data![index]
                                                .pincode
                                                .toString()),
                                            const Gap(2),
                                            CustomTextRegular(controller
                                                .userAddressModel
                                                .data![index]
                                                .phone
                                                .toString()),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                CustomButton(
                                                  AppStrings.select.tr,
                                                  color: ColorResources.toolbarText,
                                                  fontSize:
                                                      Dimensions.fontSizeSmall,
                                                  minimumSize:
                                                      const Size(45, 30),
                                                  onPressed: () {
                                                     Get.toNamed("/payment_summary",arguments: {
                                                       "addressId" : controller
                                                           .userAddressModel
                                                           .data![index]
                                                           .id
                                                           .toString()
                                                     });
                                                  },
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const Gap(70),
                            ],
                          )),
                    ),
                  );
                }
                else if (controller.isAddressLoading.isTrue) {
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: ColorResources.white,
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeMediumSmall),
                  child: CustomElevatedButton(
                    onPressed: () {
                      Get.toNamed("/add_address");
                    },
                    text: AppStrings.addNewAddresses.tr,
                    backgroundColor: ColorResources.colorPrimary,
                    textColor: ColorResources.toolbarText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
