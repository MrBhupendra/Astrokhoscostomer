import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_round_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../model/astrologer_model.dart';
import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';
import 'custom_text_medium.dart';
import 'custom_text_regular.dart';

class DashLiveAstrologerWidget extends StatelessWidget {
  final AstrologerData astrologer;
  final Function? onActionPressed;

  const DashLiveAstrologerWidget(this.astrologer, {this.onActionPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0,left: 4,top: 4),
      child: GestureDetector(
        onTap: () {
          if (onActionPressed != null) {
            onActionPressed!();
          }
        },
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.transparent, // Optional: set a transparent background
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: ColorResources.colorPrimary,width: 2),
                      ),
                      child: CustomRoundNetworkImage(
                          imageUrl: astrologer.astroImg.toString(),
                          height: 80,
                          width: 80
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 71,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              )
                            ]),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: const Text(
                                ' ',
                                style: TextStyle(fontSize: 10),
                              ),
                            ),
                            const Gap(1),
                            CustomTextRegular("LIVE",color: ColorResources.colorPrimary,fontSize: Dimensions.fontSizeSmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(2),
            ConstrainedBox(
              constraints: const BoxConstraints(
                  maxWidth: 85
              ),
              child: CustomTextRegular(
                astrologer.displayName.toString(),
                // fontSize: Dimensions.fontSizeHomeText,
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
          ],
        )
        // Container(
        //   width: 110,
        //   decoration: BoxDecoration(
        //     color: Colors.transparent,
        //     borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
        //   ),
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
        //     child: Stack(
        //       children: [
        //         Positioned.fill(
        //           child: CustomNetworkImage(
        //             imageUrl: astrologer.astroImg.toString(), // Replace with your image URL
        //             fit: BoxFit.cover, height: Get.height, // Optional error widget
        //           ),
        //         ),
        //         Positioned.fill(
        //           child: Container(
        //             color: Colors.black.withOpacity(0.3), // Black transparent overlay
        //           ),
        //         ),
        //         Positioned(
        //           bottom: 0,
        //           left: 0,
        //           right: 0,
        //           child: Padding(
        //             padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6),
        //             child: CustomTextMedium(astrologer.displayName.toString(),maxLines: 1,textAlign: TextAlign.center,fontSize: Dimensions.fontSizeDefault,color: ColorResources.white,)
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
