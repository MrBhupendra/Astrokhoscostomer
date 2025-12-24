import 'package:astro_brahmand/utill/images.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';

class SimmerDashAstrologer extends StatelessWidget {
  const SimmerDashAstrologer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: ColorResources.grey,
          borderRadius: BorderRadius.circular(
              Dimensions.borderRadiusLarge),
        ),
        child: Shimmer.fromColors(
          baseColor: ColorResources.simmerBaseColor,
          highlightColor: ColorResources.simmerHighlightColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.0),
                ),
                const Image(
                  image: AssetImage(Images.pngProfile),
                  height: 65,
                ),
                const Gap(Dimensions.gapDefault),
                Container(
                  width: 60.0,
                  height: 8.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                ),
                Container(
                  width: 40.0,
                  height: 6.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                ),
                Container(
                  width: 30.0,
                  height: 6.0,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
