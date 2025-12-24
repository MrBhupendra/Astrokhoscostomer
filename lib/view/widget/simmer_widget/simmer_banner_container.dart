import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';

class SimmerBannerContainer extends StatelessWidget {
  const SimmerBannerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: Dimensions.paddingSizeSmall
          ),
          child: Shimmer.fromColors(
            baseColor: ColorResources.simmerBaseColor,
            highlightColor: ColorResources.simmerHighlightColor,
            child: Container(
              width: Get.width,
              height: 160.0,
              decoration: BoxDecoration(
                color: ColorResources.colorPrimaryVariant,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        )
    );
  }
}
