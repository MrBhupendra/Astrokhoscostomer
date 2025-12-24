import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';

class SimmerDashContainer extends StatelessWidget {
  const SimmerDashContainer({super.key});

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
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
