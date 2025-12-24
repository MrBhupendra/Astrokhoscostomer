import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';

class SimmerAstrologer extends StatelessWidget {
  const SimmerAstrologer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
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
        child: Shimmer.fromColors(
          baseColor: ColorResources.simmerBaseColor,
          highlightColor: ColorResources.simmerHighlightColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(8),
                    Image.asset(Images.pngProfile, height: Dimensions.profileImageHeightSmall, width: Dimensions.profileImageHeightSmall),
                    const Gap(8),
                    Container(
                      width: 30.0,
                      height: 6.0,
                      color: ColorResources.white,
                    ),
                    const Gap(8),
                    Container(
                      width: 40.0,
                      height: 6.0,
                      color: ColorResources.white,
                    ),
                  ],
                ),
                const Gap(20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 60.0,
                        height: 6.0,
                        color: ColorResources.white,
                      ),
                      const Gap(10),
                      Container(
                        width: 40.0,
                        height: 6.0,
                        color: ColorResources.white,
                      ),
                      const Gap(10),
                      Container(
                        width: 60.0,
                        height: 6.0,
                        color: ColorResources.white,
                      ),
                      const Gap(8),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 20.0,
                            height: 10.0,
                            color: ColorResources.white,
                          ),
                          const Gap(6),
                          Container(
                            width: 20.0,
                            height: 10.0,
                            color: ColorResources.white,
                          ),
                          const Gap(6),
                          Container(
                            width: 20.0,
                            height: 10.0,
                            color: ColorResources.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
