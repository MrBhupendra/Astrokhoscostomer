import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_text_bold.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import '../controller/kundli_controller.dart';
import '../model/vedic_data.dart';

class KundliDoshScreen extends StatelessWidget {
  final KundliData data;
  KundliDoshScreen(this.data, {super.key});

  final KundliController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getMangalDosh(data);
    controller.getKaalsarpDosh(data);
    controller.getManglikDosh(data);
    controller.getPitraDosh(data);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: Dimensions.paddingSizeDefault),
        child: Column(
          children: [
            const Gap(Dimensions.gapDefault),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: Get.width * 0.4,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                        color: ColorResources.colorPrimary
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: CustomTextMedium(AppStrings.mangalDosh.tr,fontSize: Dimensions.fontSizeLarge,color: ColorResources.toolbarText,textAlign: TextAlign.center,),
                    )
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: Dimensions.paddingSizeExtraSmall),
            child: Obx(() {
              if (controller.isMangalDoshLoading.isTrue) {
                return ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const SimmerListView();
                  },
                );
              } else if (controller.isMangalDoshSuccess.isTrue) {
                return Column(
                  children: [
                    const Gap(Dimensions.gapDefault),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorResources.white,
                        borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(Dimensions.gapDefault),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    CustomTextBold(AppStrings.mangal.tr, color: ColorResources.black, fontSize: Dimensions.fontSizeLarge),
                                    CustomTextBold(AppStrings.dosh.tr, color: ColorResources.black5, fontSize: Dimensions.fontSizeLarge),
                                  ],
                                ),
                                const Gap(Dimensions.gapDefault),
                                CustomPaint(
                                  painter: PercentageBorderPainter(
                                    percentage: "${controller.mangalDoshModel.response?.score}", // Change this percentage as needed
                                    selectedColor: Colors.green,
                                    unselectedColor: ColorResources.black7,
                                  ),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      // shape: BoxShape.circle,
                                      // color: ColorResources.white,
                                      // borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right:21,left: 21,top: 16,bottom: 16),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CustomTextRegular("${controller.mangalDoshModel.response?.isDoshaPresent}", color: ColorResources.black2),
                                          CustomTextBold("${controller.mangalDoshModel.response?.score}%"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(Dimensions.gapDefault),
                            CustomTextRegular("${controller.mangalDoshModel.response?.botResponse}", textAlign: TextAlign.left)
                          ],
                        ),
                      ),
                    ),
                    const Gap(Dimensions.gapDefault),
                    Visibility(
                      visible: controller.mangalDoshModel.response?.factors != null &&
                          (controller.mangalDoshModel.response?.factors?.moon?.isNotEmpty == true ||
                              controller.mangalDoshModel.response?.factors?.venus?.isNotEmpty == true ||
                              controller.mangalDoshModel.response?.factors?.saturn?.isNotEmpty == true ||
                              controller.mangalDoshModel.response?.factors?.mars?.isNotEmpty == true),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorResources.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(Dimensions.gapDefault),
                          child: Column(
                            children: [
                              Visibility(
                                visible: controller.mangalDoshModel.response?.factors?.moon?.isNotEmpty == true,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextMedium(AppStrings.moon.tr, color: ColorResources.colorPrimaryDark, fontSize: 15),
                                    CustomTextRegular("${controller.mangalDoshModel.response?.factors?.moon}", textAlign: TextAlign.left)
                                  ],
                                ),
                              ),
                              const Gap(Dimensions.gapDefault),
                              Visibility(
                                visible: controller.mangalDoshModel.response?.factors?.venus?.isNotEmpty == true,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextMedium(AppStrings.venus.tr, color: ColorResources.colorPrimaryDark, fontSize: 15),
                                    CustomTextRegular("${controller.mangalDoshModel.response?.factors?.venus}", textAlign: TextAlign.left)
                                  ],
                                ),
                              ),
                              const Gap(Dimensions.gapDefault),
                              Visibility(
                                visible: controller.mangalDoshModel.response?.factors?.saturn?.isNotEmpty == true,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextMedium(AppStrings.saturn.tr, color: ColorResources.colorPrimaryDark, fontSize: 15),
                                    CustomTextRegular("${controller.mangalDoshModel.response?.factors?.saturn}", textAlign: TextAlign.left)
                                  ],
                                ),
                              ),Visibility(
                                visible: controller.mangalDoshModel.response?.factors?.mars?.isNotEmpty == true,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextMedium(AppStrings.mars.tr, color: ColorResources.colorPrimaryDark, fontSize: 15),
                                    CustomTextRegular("${controller.mangalDoshModel.response?.factors?.mars}", textAlign: TextAlign.left)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const SimmerListView();
                  },
                );
              }
            }),
          ),
          const Gap(Dimensions.gapDefault),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: Get.width * 0.4,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                      color: ColorResources.colorPrimary
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CustomTextMedium(AppStrings.kaalsarpDosh.tr,fontSize: Dimensions.fontSizeLarge,color: ColorResources.toolbarText,textAlign: TextAlign.center,),
                  )
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: Dimensions.paddingSizeExtraSmall),
            child: Obx(() {
              if(controller.isKaalsarpDoshSuccess.isTrue){
                return Column(
                  children: [
                    const Gap(Dimensions.gapDefault),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomTextMedium(AppStrings.kaalsarpDosha.tr,color: ColorResources.colorPrimaryDark,),
                      ],
                    ),
                    const Gap(Dimensions.gapDefault),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorResources.colorTableRowEven,
                        borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding:  const EdgeInsets.all(Dimensions.gapDefault),
                        child: CustomTextRegular("${controller.kaalsarpDoshModel.response?.botResponse}", textAlign: TextAlign.left),
                      ),
                    ),
                    const Gap(Dimensions.gapDefault),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorResources.colorTableRowEven,
                        borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomTextMedium(AppStrings.report.tr,color: ColorResources.colorPrimaryDark,),
                              ],
                            ),
                            const Gap(Dimensions.gapDefault),
                            CustomTextRegular("${controller.kaalsarpDoshModel.response?.remedies}", textAlign: TextAlign.left)
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }else if(controller.isKaalsarpDoshLoading.isTrue){
                return ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const SimmerListView();
                  },
                );
              } else{
                return ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const SimmerListView();
                  },
                );
              }
            }),
          ),
          const Gap(Dimensions.gapDefault),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: Get.width * 0.4,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                      color: ColorResources.colorPrimary
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CustomTextMedium(AppStrings.manglikDosh.tr,fontSize: Dimensions.fontSizeLarge,color: ColorResources.toolbarText,textAlign: TextAlign.center,),
                  )
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: Dimensions.paddingSizeExtraSmall),
            child: Obx(() {
              if (controller.isManglikDoshLoading.isTrue) {
                return ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const SimmerListView();
                  },
                );
              } else if (controller.isManglikDoshSuccess.isTrue) {
                return Column(
                  children: [
                    const Gap(Dimensions.gapDefault),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorResources.white,
                        borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(Dimensions.gapDefault),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    CustomTextBold(AppStrings.manglik.tr, color: ColorResources.black, fontSize: Dimensions.fontSizeLarge),
                                    CustomTextBold(AppStrings.dosh.tr, color: ColorResources.black5, fontSize: Dimensions.fontSizeLarge),
                                  ],
                                ),
                                const Gap(Dimensions.gapDefault),

                                CustomPaint(
                                  painter: PercentageBorderPainter(
                                    percentage: "${controller.manglikModel.response?.score}", // Change this percentage as needed
                                    selectedColor: Colors.green,
                                    unselectedColor: ColorResources.black7,
                                  ),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      // shape: BoxShape.circle,
                                      // color: ColorResources.white,
                                      // borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(right:23,left: 23,top: 19,bottom: 19),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CustomTextRegular("${controller.mangalDoshModel.response?.isDoshaPresent}", color: ColorResources.black2),
                                          CustomTextBold("${controller.manglikModel.response?.score}%"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(Dimensions.gapDefault),
                            CustomTextRegular("${controller.manglikModel.response?.botResponse}", textAlign: TextAlign.left)
                          ],
                        ),
                      ),
                    ),
                    const Gap(Dimensions.gapDefault),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorResources.white,
                        borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(Dimensions.gapDefault),
                          child: CustomTextRegular("${controller.manglikModel.response?.aspects}", textAlign: TextAlign.left)
                      ),
                    ),
                  ],
                );
              } else {
                return ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const SimmerListView();
                  },
                );
              }
            }),
          ),
          const Gap(Dimensions.gapDefault),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: Get.width * 0.4,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                      color: ColorResources.colorPrimary
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CustomTextMedium(AppStrings.pitraDosh.tr,fontSize: Dimensions.fontSizeLarge,color: ColorResources.toolbarText,textAlign: TextAlign.center,),
                  )
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: Dimensions.paddingSizeExtraSmall),
            child: Obx(() {
              if (controller.isPitraDoshLoading.isTrue) {
                return ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const SimmerListView();
                  },
                );
              } else if (controller.isPitraDoshSuccess.isTrue) {
                return Column(
                  children: [
                    const Gap(Dimensions.gapDefault),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorResources.white,
                        borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(Dimensions.gapDefault),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Gap(Dimensions.gapDefault),
                                Column(
                                  children: [
                                    CustomTextBold(AppStrings.doshPresent.tr, color: ColorResources.black, fontSize: Dimensions.fontSizeLarge),
                                    CustomTextRegular("${controller.pitraDoshModel.response?.isDoshaPresent}", color: ColorResources.black2),
                                  ],
                                )
                              ],
                            ),
                            const Gap(Dimensions.gapDefault),
                            CustomTextRegular("${controller.pitraDoshModel.response?.botResponse}", textAlign: TextAlign.left)
                          ],
                        ),
                      ),
                    ),
                    const Gap(Dimensions.gapDefault),
                    Visibility(
                      visible: controller.pitraDoshModel.response?.effects?.isNotEmpty == true,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorResources.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(Dimensions.gapDefault),
                            child: Column(
                              children: [
                                CustomTextMedium(AppStrings.effects.tr,color: ColorResources.colorPrimaryDark,),
                                const Gap(Dimensions.gapDefault),
                                CustomTextRegular("${controller.pitraDoshModel.response?.effects}", textAlign: TextAlign.left),
                              ],
                            )
                        ),
                      ),
                    ),
                    const Gap(Dimensions.gapDefault),
                    Visibility(
                      visible: controller.pitraDoshModel.response?.remedies?.isNotEmpty == true,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorResources.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(Dimensions.gapDefault),
                            child: Column(
                              children: [
                                CustomTextMedium(AppStrings.remedies.tr,color: ColorResources.colorPrimaryDark,),
                                const Gap(Dimensions.gapDefault),
                                CustomTextRegular("${controller.pitraDoshModel.response?.remedies}", textAlign: TextAlign.left),
                              ],
                            )
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const SimmerListView();
                  },
                );
              }
            }),
          ),
        ],
        ),
      ),
    );

  }
}


class PercentageBorderPainter extends CustomPainter {
  final String percentage;
  final Color selectedColor;
  final Color unselectedColor;

  PercentageBorderPainter({
    required this.percentage,
    required this.selectedColor,
    required this.unselectedColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..strokeWidth = 8 // Adjust thickness here
      ..style = PaintingStyle.stroke;

    const startAngle = -90.0; // Start from top center

    // Convert the percentage string to a double
    final percentageDouble = double.tryParse(percentage) ?? 0.0;

    final sweepAngle = 360.0 * (percentageDouble / 100.0);

    // Draw selected part
    paint.color = selectedColor;
    canvas.drawArc(rect.deflate(paint.strokeWidth / 2), radians(startAngle),
        radians(sweepAngle), false, paint);

    // Draw unselected part
    paint.color = unselectedColor;
    canvas.drawArc(
        rect.deflate(paint.strokeWidth / 2),
        radians(startAngle + sweepAngle),
        radians(360.0 - sweepAngle),
        false,
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  double radians(double degrees) => degrees * (3.141592653589793 / 180.0);
}

