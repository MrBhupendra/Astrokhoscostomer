import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import '../controller/shubhmuhrat_conttroller.dart';


class HoraScreen extends StatelessWidget {
  HoraScreen({super.key});

  final ShubhmuhratController controller = Get.put(ShubhmuhratController());

  @override
  Widget build(BuildContext context) {
    controller.getHora();
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
              () {
            if (controller.isHoraSuccess.isTrue) {
              return ListView.builder(
                itemCount: controller.horaModel.response?.horas?.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              )
                            ],
                            color: ColorResources.white,
                            borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault), // Adjust the radius as needed
                            border: Border.all(
                              color: ColorResources.colorPrimaryVariant,
                              width: 1, // Adjust the border width as needed
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall,left:  Dimensions.paddingSizeSmall,top:  Dimensions.paddingSizeSmall),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomTextMedium(controller.horaModel.response!.horas![index].hora.toString(),fontSize: Dimensions.fontSizeExtraLarge,color: ColorResources.colorPrimaryDark),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall,left: Dimensions.paddingSizeSmall,top: Dimensions.paddingSizeSmall),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomTextMedium(AppStrings.startDate.tr,color: ColorResources.colorPrimary),
                                          CustomTextRegular(controller.horaModel.response!.horas![index].start.toString(),fontSize: Dimensions.fontSizeSmall),
                                        ],
                                      ),
                                    ),
                                    const Gap(Dimensions.gapDefault),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomTextMedium(AppStrings.endDate.tr,color: ColorResources.colorPrimary),
                                          CustomTextRegular(controller.horaModel.response!.horas![index].end.toString(),fontSize: Dimensions.fontSizeSmall),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Gap(Dimensions.gapDefault),
                              Container(
                                decoration: const BoxDecoration(
                                  color: ColorResources.colorPrimaryLight,
                                ),
                                child:  Padding(
                                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                  child: Row(
                                    children: [
                                      Expanded(child: CustomTextMedium(AppStrings.luckyGem.tr,fontSize: Dimensions.fontSizeLarge,color: ColorResources.colorPrimary,)),
                                      Expanded(child: CustomTextMedium(controller.horaModel.response!.horas![index].luckyGem.toString(),fontSize: Dimensions.fontSizeLarge,color: ColorResources.colorPrimary,)),
                                    ],
                                  ),
                                ),
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
                                        child: CustomTextMedium(AppStrings.benefits.tr,fontSize: Dimensions.fontSizeLarge,color: ColorResources.toolbarText,textAlign: TextAlign.center,),
                                      )
                                  ),
                                ],
                              ),
                              const Gap(Dimensions.gapDefault),
                              Container(
                                decoration:  BoxDecoration(
                                  color: ColorResources.colorPrimaryLight,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child:  Padding(
                                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                  child: CustomTextRegular(controller.horaModel.response!.horas![index].benefits.toString(),textAlign: TextAlign.center,),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                  }

              );
            } else if (controller.isHoraLoading.isTrue) {
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
        ),
        ),
      );

  }
}
