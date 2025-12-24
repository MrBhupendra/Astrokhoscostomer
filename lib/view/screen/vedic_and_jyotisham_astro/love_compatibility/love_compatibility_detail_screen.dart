import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../model/menu_model.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../controller/love_compatibility_controller.dart';
import '../widget/MarksProgress.dart';
import 'love_compatibility_simmer.dart';

class LoveCompatibilityScreen extends StatelessWidget  {
  LoveCompatibilityScreen({super.key});
  LoveCompatibilityController controller = Get.find();
  final List<MenuModel> horoscopeListCo = [];

  @override
  Widget build(BuildContext context) {
    getHoroscopeList();
    controller.isSuccess(false);
    controller.getLoveCompat(horoscopeListCo[controller.girlSelectedNumber.value].number, horoscopeListCo[controller.boySelectedNumber.value].number);
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.loveCompatibility.tr),
        body: Container(
          decoration:  const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.loveComatibilityBg),
              fit: BoxFit.cover,
            ),

          ),
          child: Stack(
            children: [
              Container(
                color: ColorResources.colorPrimary.withOpacity(0.2),
              ),
              Obx(
                    () {
                  if (controller.isSuccess.isTrue) {
                    return Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(Dimensions.gapExtraLarge),
                          Stack(
                            alignment:Alignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: ColorResources.colorPrimaryLight,
                                          border: Border.all(
                                            color: ColorResources.colorPrimaryVariant,
                                            width: 2.0,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(Dimensions.borderRadiusRoundedall),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                horoscopeListCo[controller.boySelectedNumber.value].image,
                                                width: 40,
                                                height: 40,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Gap(Dimensions.gapDefault),
                                      CustomTextMedium(horoscopeListCo[controller.boySelectedNumber.value].title.toString(),color: ColorResources.white,),
                                    ],
                                  ),
                                  const Gap(10),
                                  Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: ColorResources.colorPrimaryLight,
                                          border: Border.all(
                                            color: ColorResources.colorPrimaryVariant,
                                            width: 2.0,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(Dimensions.borderRadiusRoundedall),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                horoscopeListCo[controller.girlSelectedNumber.value].image,
                                                width: 40,
                                                height: 40,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Gap(Dimensions.gapDefault),
                                      CustomTextMedium(horoscopeListCo[controller.girlSelectedNumber.value].title.toString(),color: ColorResources.white,),
                                    ],
                                  ),

                                ],
                              ),
                              Center(child: Image.asset(Images.heart,height: 40,width: 40,color: ColorResources.cris)),
                            ],
                          ),
                          const Gap(Dimensions.gapExtraLarge),

                          CustomTextMedium(AppStrings.compatibilityScore.tr,color: ColorResources.white),
                          MarksProgress(totalMarks: 100, obtainedMarks: controller.loveCompatModel.response!.score! ),
                          CustomTextRegular('${controller.loveCompatModel.response!.score.toString()}%',color: ColorResources.white),

                          const Gap(Dimensions.gapLarge),
                          Container(
                            padding: const EdgeInsets.all(Dimensions.paddingSizeOverSmall),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextMedium("Are ${horoscopeListCo[controller.boySelectedNumber.value].title} and ${horoscopeListCo[controller.girlSelectedNumber.value].title} compatible",textAlign: TextAlign.start,color: ColorResources.colorPrimary,),
                                const Gap(Dimensions.gapExtraSmall),
                                CustomTextRegular(controller.loveCompatModel.response!.botResponse.toString())
                              ],
                            ),
                          )

                        ],
                      ),
                    );
                  }
                  else if (controller.isLoading.isTrue) {
                    return ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return const LoveCompatibilitySimmer();
                      },
                    );
                  } else {
                    return const EmptyScreen();
                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }


  void getHoroscopeList() {
    horoscopeListCo.clear();
    horoscopeListCo.add(MenuModel(AppStrings.aries.tr, Images.aries, '1'));
    horoscopeListCo.add(MenuModel(AppStrings.taurus.tr, Images.taurus, '2'));
    horoscopeListCo.add(MenuModel(AppStrings.gemini.tr, Images.gemini, '3'));
    horoscopeListCo.add(MenuModel(AppStrings.cancer.tr, Images.cancer, '4'));
    horoscopeListCo.add(MenuModel(AppStrings.leo.tr, Images.leo, '5'));
    horoscopeListCo.add(MenuModel(AppStrings.virgo.tr, Images.virgo, '6'));
    horoscopeListCo.add(MenuModel(AppStrings.libra.tr, Images.libra, '7'));
    horoscopeListCo.add(MenuModel(AppStrings.scorpio.tr, Images.scorpio, '8'));
    horoscopeListCo.add(MenuModel(AppStrings.sagittarius.tr, Images.sagittarius, '9'));
    horoscopeListCo.add(MenuModel(AppStrings.capricorn.tr, Images.capricorn, '10'));
    horoscopeListCo.add(MenuModel(AppStrings.aquarius.tr, Images.aquarius, '11'));
    horoscopeListCo.add(MenuModel(AppStrings.pisces.tr, Images.pisces, '12'));
  }
}