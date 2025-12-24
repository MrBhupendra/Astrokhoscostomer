import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';

import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_show_more.dart';

class SanjeeviniDetailScreen extends StatelessWidget {
  const SanjeeviniDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    // String title = arguments['title'] ?? '';
    // String image = arguments['image'] ?? '';

    dynamic arguments = Get.arguments;
    String title = '';
    String image = '';

    if (arguments is Map<String, dynamic>) {
      title = arguments['title'] ?? '';
      image = arguments['image'] ?? '';
    }

    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(title: title),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                      AppStrings.howUseSanjeevini.tr,
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
                          fullText: AppStrings.sanjeeviniUse.tr),
                    ),
                    const Gap(5.0),
                  ],
                ),
              ),
            ),
            const Gap(10.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomNetworkImage(
                  imageUrl: image,
                  height: 500,
                  width: Get.width),
            )
          ],
        ),
      ),
    ));
  }
}
