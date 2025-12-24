import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';


class SimmerSubscriptionContainer extends StatelessWidget {
  const SimmerSubscriptionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: Dimensions.paddingSizeSmall
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            //     maxCrossAxisExtent: 250,
            //     childAspectRatio: 1.00,
            //     crossAxisSpacing: 8,
            //     mainAxisSpacing: 10
            // ),
            itemCount: 15,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: ColorResources.simmerBaseColor,
                highlightColor: ColorResources.simmerHighlightColor,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: Get.width,
                    height: 350.0,
                    decoration: BoxDecoration(
                      color: ColorResources.colorPrimaryVariant,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              );
            }
          ),
        )
    );
  }
}
