
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utill/app_constants.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import '../controller/matching_controller.dart';
import '../model/vedic_data.dart';
import '../widget/custom_matching_score.dart';
import '../widget/matching_aggregate_data_widget.dart';

class MatchingAggregateScreen extends StatelessWidget {
 final KundliMatchData data;
  MatchingAggregateScreen(this.data ,{super.key});

  MatchingController  controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getAggregate(data);
    return Obx(() {
        if (controller.isAggregateSuccess.isTrue) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                      border: Border.all(
                          color: ColorResources.colorPrimaryDark), // Set the border color to red
                    ),
                    child: Column(
                      children: [
                        const Gap(Dimensions.gapDefault),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextMedium(AppStrings.aggregateMatchingPoint.tr,fontSize: Dimensions.fontSizeLarge,),
                          ],
                        ),
                        const Gap(Dimensions.gapDefault),
                        CustomMatchingScore(score: '${controller.aggregateModel.response?.score}/${AppConstants.aggregatescore}',),
                        Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          child: Card(
                            color: ColorResources.colorPrimaryLight,
                            child: Padding(
                              padding: const EdgeInsets.all( Dimensions.paddingSizeDefault),
                              child: Text('${controller.aggregateModel.response?.extendedResponse}',
                                  style: const TextStyle(
                                    color: ColorResources.black,

                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, bottom: Dimensions.paddingSizeDefault),
                          child:  CustomTextRegular(
                              '${controller.aggregateModel.response?.botResponse}',
                              fontSize: Dimensions.fontSizeSmall),
                        ),
                      ],
                    ),
                  ),
                  const Gap(Dimensions.gapDefault),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                      border: Border.all(color: ColorResources.colorPrimaryDark),
                    ),
                    child: Column(
                      children: [
                        const Gap(Dimensions.gapDefault),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextMedium(AppStrings.ashtakootMatchingPoint.tr,fontSize: Dimensions.fontSizeLarge,),
                          ],
                        ),
                        const Gap(Dimensions.gapDefault),
                        CustomMatchingScore(score: '${controller.aggregateModel.response?.ashtakootScore}',),
                        const Gap(Dimensions.gapDefault),
                      ],
                    ),
                  ),
                  const Gap(Dimensions.gapDefault),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                      border: Border.all(color: ColorResources.colorPrimaryDark),
                    ),
                    child: Column(
                      children: [
                        const Gap(Dimensions.gapDefault),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextMedium(AppStrings.dashakootMatchingPoint.tr,fontSize: Dimensions.fontSizeLarge,),
                          ],
                        ),
                        const Gap(Dimensions.gapDefault),
                        CustomMatchingScore(score: '${controller.aggregateModel.response?.dashkootScore}',),
                        const Gap(Dimensions.gapDefault),
                      ],
                    ),
                  ),
                  const Gap(Dimensions.gapDefault),
                  AggregateData(
                      boy: AppStrings.boy.tr ,
                      girl: AppStrings.girl.tr ,
                      title: AppStrings.mangalDosh.tr,
                      boydata: "${controller.aggregateModel.response?.mangaldoshPoints?.boy}",
                      girldata: "${controller.aggregateModel.response?.mangaldoshPoints?.girl}",
                      ortherdata: '${controller.aggregateModel.response?.mangaldosh}'),
                  const Gap(Dimensions.gapDefault),
                  AggregateData(
                      boy: AppStrings.boy.tr,
                      girl: AppStrings.girl.tr,
                      title: AppStrings.pitraDosh.tr,
                      boydata:
                      '${controller.aggregateModel.response?.pitradoshPoints?.boy}',
                      girldata:
                      '${controller.aggregateModel.response?.pitradoshPoints?.girl}',
                      ortherdata:
                      '${controller.aggregateModel.response?.pitradosh}'),
                  const Gap(Dimensions.gapDefault),
                  AggregateData(
                      boy: AppStrings.boy.tr,
                      girl: AppStrings.girl.tr,
                      title: AppStrings.kaalsarpDosh.tr,
                      boydata: ' ${controller.aggregateModel.response?.kaalsarpPoints?.boy}',
                      girldata: ' ${controller.aggregateModel.response?.kaalsarpPoints?.girl}',
                      ortherdata: '${controller.aggregateModel.response?.kaalsarpdosh}'),
                  const Gap(Dimensions.gapDefault),
                  AggregateData(
                      boy:AppStrings.boy.tr,
                      girl: AppStrings.girl.tr,
                      title: AppStrings.manglikDoshSaturn.tr,
                      boydata:
                      ' ${controller.aggregateModel.response?.manglikdoshSaturnPoints?.boy}',
                      girldata:
                      ' ${controller.aggregateModel.response?.manglikdoshSaturnPoints?.girl}',
                      ortherdata:
                      '${controller.aggregateModel.response?.manglikdoshSaturn}'),
                  const Gap(Dimensions.gapDefault),
                  AggregateData(
                      boy: AppStrings.boy.tr,
                      girl: AppStrings.girl.tr,
                      title: AppStrings.manglikDoshRahuketu.tr,
                      boydata:
                      ' ${controller.aggregateModel.response?.manglikdoshRahuketuPoints?.boy}',
                      girldata:
                      ' ${controller.aggregateModel.response?.manglikdoshRahuketuPoints?.girl}',
                      ortherdata:
                      '${controller.aggregateModel.response?.manglikdoshRahuketu}'),
                  const Gap(Dimensions.gapDefault)
                ],
              ),
            ),
          );
        } else if (controller.isAggregateLoading.isTrue) {
          return ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const SimmerListView();
            },
          );
        } else {
          return const EmptyScreen();
        }
      },
    );
  }
}
