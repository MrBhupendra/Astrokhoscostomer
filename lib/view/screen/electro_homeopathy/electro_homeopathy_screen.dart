import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../controller/all_astrologer_controller.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../../utill/shared_preference.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_service_button.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';

class ElectroHomeopathyScreen extends StatelessWidget {
  const ElectroHomeopathyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    AllAstrologerController controller = Get.put<AllAstrologerController>(AllAstrologerController());
    //TODO
    // controller.resetData();
    return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: AppStrings.electroHomeopathy.tr),
          body: Column(
            children: [
              Expanded(child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          Images.homeopathyBgBanner,
                          height: 160,
                          width: Get.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Gap(20),
                      CustomTextMedium(
                        "What is Electro Homeopathy?",
                        maxLines: 1,
                        fontSize: Dimensions.fontSizeExtraLarge,
                      ),
                      const Gap(5),
                      CustomTextRegular("Electro homeopathy, developed in the 19th century, is an alternative medicine combining homeopathy and plant-based remedies. It posits that diseases result from imbalances in the body's electrical energy, which can be corrected using specific herbal extracts. These remedies, called electricities are prepared through serial dilution and shaking, similar to homeopathy. Despite its historical roots, electro homeopathy lacks scientific validation and is often criticized as pseudoscience, with any perceived benefits likely attributed to the placebo effect. Its legal status varies by country.",fontSize: Dimensions.fontSizeDefault,color: ColorResources.black2,),
                      const Gap(10),
                    ],
                  ),
                ),
              )),
              Container(
                color: ColorResources.white,
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeOverSmall),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: CustomServiceButton(
                            onTap: () async {
                              //TODO HANDLE
                              // String? categoryId = await SharedPreferencesHelper.getData(AppConstants.homeopathyCategoryId);
                              // controller.categorySelected = categoryId.toString();
                              // Get.toNamed('/homeopathy_list_screen');
                            },
                            service: 'Proceed to ${AppStrings.electroHomeopathy.tr}',
                            backgroundColor: ColorResources.colorPrimary,
                            textColor: ColorResources.toolbarText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
