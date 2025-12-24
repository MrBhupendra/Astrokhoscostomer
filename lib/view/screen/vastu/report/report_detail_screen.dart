
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_elevated_button.dart';
import '../../../widget/custom_network_image.dart';
import '../../vedic_and_jyotisham_astro/model/report_kundli_list_model.dart';

class ReportDetailScreen extends StatelessWidget {
  ReportDetailScreen({super.key});

  final ReportData reportData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorResources.white,
        appBar: CustomAppBar(title: reportData.title.toString()),
        body: Column(
          children: [
            Expanded(child: SingleChildScrollView(
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 8),
                child: Column(
                  children: [

                    Row(
                      children: [
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 2.0,
                            // Adjust the aspect ratio as needed
                            child:
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CustomNetworkImage(
                                imageUrl: reportData.paidKundliManualImage.toString(),
                                height: 200, width: Get.width * 0.8,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(15),
                    Row(
                      children: [
                        Expanded(
                          child:  CustomTextMedium(
                            reportData.title.toString(),
                            maxLines: 2,
                            fontSize: Dimensions.fontSizeExtraLarge,
                          ),
                        ),
                      ],
                    ),
                    const Gap(8),
                    HtmlWidget(
                      reportData.description.toString(),
                      textStyle: const TextStyle(
                        color: ColorResources.black,
                      ),
                    ),
                    const Gap(5),
                  ],
                ),
              ),
            )),
            Container(
              color: ColorResources.white,
              child: Padding(
                padding:
                const EdgeInsets.all(Dimensions.paddingSizeMediumSmall),
                child: CustomElevatedButton(
                  onPressed: (){
                    Get.toNamed("/report_horo_submit",arguments: reportData);
                  },
                  text: "BUY NOW",
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
}
