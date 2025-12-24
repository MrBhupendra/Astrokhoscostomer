import 'package:astro_brahmand/model/upcoming_live_astrologer_model.dart';
import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_bold.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../utill/app_strings.dart';
import '../../utill/dimensions.dart';
import '../screen/agora/live_stream/controller/live_stream_controller.dart';
import 'custom_snack_bar.dart';

class UpcomingLiveAstrologerWidget extends StatelessWidget {
  final UpcomingLiveAstrologerData astrologer;
  final Function? onPressed;
  UpcomingLiveAstrologerWidget(this.astrologer, {this.onPressed, super.key});
  final LiveStreamController controller = Get.put(LiveStreamController());
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CustomNetworkImage(
                      imageUrl: astrologer.astrologer!.astroImg.toString(),
                      height: 100,
                      width: 85
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ColorResources.green,
                              ),
                              child: CustomTextRegular(
                                "SCHEDULED",
                                color: ColorResources.white,
                                fontSize: Dimensions.fontSizeExtraSmall,
                              ),
                            ),
                          ],
                        ),
                        CustomTextRegular(
                          astrologer.astrologer!.displayName.toString(),
                          maxLines: 1,
                          fontSize: Dimensions.fontSizeDefault,
                          color: ColorResources.black,
                        ),
                        CustomTextBold(
                          astrologer.topic.toString(),
                          maxLines: 2,
                          color: ColorResources.black1,
                        ),
                        const Gap(2),
                        CustomTextRegular(
                          "${CommonMethods().formatDateTimeOutputIndividually(astrologer.date.toString(), astrologer.time.toString())}",
                          // "${astrologer.date.toString()},${astrologer.time.toString()}",
                          maxLines: 1,
                          fontSize: Dimensions.fontSizeDefault,
                          color: ColorResources.colorSecondaryDark,
                        ),
                        const Gap(5),
                        GestureDetector(
                          onTap: () {
                            controller.notifyMe("1", astrologer.astrologer!.astrologerUniId.toString());
                            CustomSnackBar.showTop(AppStrings.notifyCustomSnackBar);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: ColorResources.orange,
                                ),
                                child: CustomTextRegular(
                                  "Notify Me",
                                  color: ColorResources.white,
                                  fontSize: Dimensions.fontSizeSmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

