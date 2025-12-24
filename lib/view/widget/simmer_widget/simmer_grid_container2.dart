import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';

class SimmerGridContainer2 extends StatelessWidget {
  const SimmerGridContainer2({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 8.0, horizontal: Dimensions.paddingSizeSmall),
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    childAspectRatio: 1.00,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10
                ),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: ColorResources.simmerBaseColor,
                    highlightColor: ColorResources.simmerHighlightColor,
                    child: Container(
                      // width: double.infinity,
                      height: 150,
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
