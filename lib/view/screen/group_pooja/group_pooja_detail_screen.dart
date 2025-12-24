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
import 'controller/group_pooja_controller.dart';


class GroupPoojaDetailScreen extends GetView<GroupPoojaController> {
  const GroupPoojaDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    resetControllerValue();
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.groupPoojaDetail.tr),
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                        child: CustomNetworkImage(
                            imageUrl: controller.groupPoojaListData.groupPujaImage.toString(),
                            height: 200,
                            width: Get.width
                        ),
                      ),
                      const Gap(15),
                      CustomTextMedium(controller.groupPoojaListData.groupPujaName.toString(),fontSize: Dimensions.fontSizeLarge),
                      const Gap(5),
                      const Divider(),
                      const Gap(5),
                      HtmlWidget(
                        controller.groupPoojaListData.groupPujaDescription.toString(),
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
                    Get.toNamed("/group_pooja_astrologer_list",arguments: {
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
    controller.refId.value = '0';
  }
}
