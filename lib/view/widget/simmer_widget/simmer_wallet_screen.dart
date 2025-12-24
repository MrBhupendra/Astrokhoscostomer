import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';

class SimmerWalletScreen extends StatelessWidget {
  const SimmerWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: Dimensions.paddingSizeOverSmall
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(15),
              Shimmer.fromColors(
                baseColor: ColorResources.simmerBaseColor,
                highlightColor: ColorResources.simmerHighlightColor,
                child: Container(
                  width: Get.width,
                  height: 220.0,
                  decoration: BoxDecoration(
                    color: ColorResources.colorPrimaryVariant,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const Gap(20),
              Shimmer.fromColors(
                baseColor: ColorResources.simmerBaseColor,
                highlightColor: ColorResources.simmerHighlightColor,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.9)
                  ),
                  width: Get.width * 0.4,
                  height: 12.0,
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
                  width: Get.width * 0.2,
                  height: 10.0,
                  // color: ColorResources.white,
                ),
              ),
              const Gap(8),
              // voucher gridview
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 6),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    // crossAxisSpacing: 4,
                    // childAspectRatio: 0.85
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  // scrollDirection: Axis.horizontal,
                  itemCount: 6,
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
              ),
              const Gap(8),
              // Pack type
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 0.0, horizontal: 4),
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: ColorResources.white,
                    borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                    border: Border.all(color: ColorResources.black7),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: ColorResources.simmerBaseColor,
                          highlightColor: ColorResources.simmerHighlightColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.withOpacity(0.9)
                                ),
                                width: Get.width * 0.3,
                                height: 12.0,
                                // color: ColorResources.white,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.withOpacity(0.9)
                                ),
                                width: Get.width * 0.2,
                                height: 12.0,
                                // color: ColorResources.white,
                              ),
                            ],
                          ),
                        ),
                        const Gap(8),
                        Shimmer.fromColors(
                          baseColor: ColorResources.simmerBaseColor,
                          highlightColor: ColorResources.simmerHighlightColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.withOpacity(0.9)
                                ),
                                width: Get.width * 0.25,
                                height: 12.0,
                                // color: ColorResources.white,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.withOpacity(0.9)
                                ),
                                width: Get.width * 0.15,
                                height: 12.0,
                                // color: ColorResources.white,
                              ),
                            ],
                          ),
                        ),
                        const Gap(8),
                        Shimmer.fromColors(
                          baseColor: ColorResources.simmerBaseColor,
                          highlightColor: ColorResources.simmerHighlightColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.withOpacity(0.9)
                                ),
                                width: Get.width * 0.3,
                                height: 12.0,
                                // color: ColorResources.white,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.withOpacity(0.9)
                                ),
                                width: Get.width * 0.2,
                                height: 12.0,
                                // color: ColorResources.white,
                              ),
                            ],
                          ),
                        ),
                        const Gap(8),
                        Shimmer.fromColors(
                          baseColor: ColorResources.simmerBaseColor,
                          highlightColor: ColorResources.simmerHighlightColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.withOpacity(0.9)
                                ),
                                width: Get.width * 0.25,
                                height: 12.0,
                                // color: ColorResources.white,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.withOpacity(0.9)
                                ),
                                width: Get.width * 0.15,
                                height: 12.0,
                                // color: ColorResources.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
