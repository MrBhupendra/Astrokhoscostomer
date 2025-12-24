import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';

class SimmerListView extends StatelessWidget {
  const SimmerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 4.0, horizontal: 4),
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
                color: ColorResources.white,
                borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                border: Border.all(color: ColorResources.black7),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                  )
                ]
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: ColorResources.simmerBaseColor,
                    highlightColor: ColorResources.simmerHighlightColor,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.9)
                      ),
                      width: Get.width * 0.7,
                      height: 10.0,
                      // color: ColorResources.white,
                    ),
                  ),
                  const Gap(8),
                  Shimmer.fromColors(
                    baseColor: ColorResources.simmerBaseColor,
                    highlightColor: ColorResources.simmerHighlightColor,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.9)
                      ),
                      width: Get.width * 0.5,
                      height: 8.0,
                      // color: ColorResources.white,
                    ),
                  ),
                  const Gap(8),
                  Shimmer.fromColors(
                    baseColor: ColorResources.simmerBaseColor,
                    highlightColor: ColorResources.simmerHighlightColor,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.9)
                      ),
                      width: Get.width * 0.6,
                      height: 8.0,
                      // color: ColorResources.white,
                    ),
                  ),
                  const Gap(8),
                  Shimmer.fromColors(
                    baseColor: ColorResources.simmerBaseColor,
                    highlightColor: ColorResources.simmerHighlightColor,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.9)
                      ),
                      width: Get.width * 0.4,
                      height: 8.0,
                      // color: ColorResources.white,
                    ),
                  ),
                  const Gap(8),
                  Shimmer.fromColors(
                    baseColor: ColorResources.simmerBaseColor,
                    highlightColor: ColorResources.simmerHighlightColor,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.9)
                      ),
                      width: Get.width * 0.5,
                      height: 8.0,
                      // color: ColorResources.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }
}
