import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';

class SimmerGridContainer extends StatelessWidget {
  const SimmerGridContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 8.0, horizontal: Dimensions.paddingSizeSmall),
          child: Column(
            children: [
              // search container
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10.0),
              //   child: Shimmer.fromColors(
              //     baseColor: ColorResources.simmerBaseColor,
              //     highlightColor: ColorResources.simmerHighlightColor,
              //     child: Container(
              //       width: double.infinity,
              //       height: 45,
              //       decoration: BoxDecoration(
              //         color: ColorResources.colorPrimaryVariant,
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //     ),
              //   ),
              // ),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  // crossAxisSpacing: 4,
                  // childAspectRatio: 0.85
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: ColorResources.simmerBaseColor,
                    highlightColor: ColorResources.simmerHighlightColor,
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        color: ColorResources.colorPrimaryVariant,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        )
    );
  }
}
