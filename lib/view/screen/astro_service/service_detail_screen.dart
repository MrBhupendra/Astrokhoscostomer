import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/view/widget/custom_elevated_button.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../widget/custom_app_bar.dart';
import 'controller/service_controller.dart';

class ServiceDetailScreen extends GetView<ServiceController> {
  const ServiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    resetControllerValue();
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.serviceDetail.tr),
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
                                imageUrl: controller.serviceData.serviceImage.toString(),
                                height: 220,
                                width: Get.width * 0.8
                            ),
                          ),
                        ),
                      ),
                      const Gap(15),
                      CustomTextMedium(controller.serviceData.serviceName.toString(),fontSize: Dimensions.fontSizeLarge),
                      const Gap(5),
                      const Divider(),
                      const Gap(5),
                      HtmlWidget(
                        controller.serviceData.serviceDescription.toString(),
                        textStyle: const TextStyle(
                          color: ColorResources.black2,
                        ),
                      ),
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
                  onPressed: (){
                    Get.toNamed("/service_astrologer_list",arguments: {
                      'astrologerId': ""
                    });
                  },
                  text: AppStrings.bookNow.tr,
                  backgroundColor: ColorResources.colorPrimary,
                  textColor: ColorResources.toolbarText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void resetControllerValue() {
    controller.myWalletAmount.value = '0';
    controller.walletPayableAmount.value = '0';
    controller.totalPayableAmount.value = '0';
    controller.subTotalAmount.value = '0';
    controller.gstPercent.value = '0';
    controller.gstAmount.value = '0';
    controller.refDiscount.value = '0';
    controller.offerDiscount.value = '0';
    controller.refId.value = '0';
    controller.offerMsg.value = '';
  }
}
