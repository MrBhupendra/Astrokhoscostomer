import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../model/menu_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import '../controller/matching_controller.dart';
import '../model/vedic_data.dart';
import '../widget/custom_matching_score.dart';
import '../widget/custom_table_row.dart';
import '../widget/matching_nakshtra_custom_bottom.dart';

class MatchingNakshatraScreen extends StatelessWidget {
  KundliMatchData data;
  MatchingNakshatraScreen(this.data ,{super.key});

  MatchingController  controller = Get.find();

  final List<MenuModel> horoscopeListCo = [];

  @override
  Widget build(BuildContext context) {
    getHoroscopesSign();
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Column(
              children: [
                const Gap(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomBottomSheet(
                              horoscopeListCo: horoscopeListCo,
                              onItemSelected: (selectedIndex) {
                                controller.updateBoySelectedNumber(selectedIndex);
                              },
                            );
                          },
                        );
                      },
                      child: controller.boySelectedNumber.value != -1
                          ? Row(
                        children: [
                          Column(
                            children: [
                              const Gap(Dimensions.gapExtraLarge),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: ColorResources.colorPrimaryLight,
                                  border: Border.all(
                                    color: ColorResources.colorPrimaryVariant,
                                    width: 3.0,
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
                                        width: 50,
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Gap(Dimensions.gapDefault),
                              CustomTextMedium(horoscopeListCo[controller.boySelectedNumber.value].title.toString()),
                            ],
                          ),
                          const Gap(Dimensions.gapSizeFifty),
                        ],

                      )
                          : Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorResources.colorPrimaryLight,
                              border: Border.all(
                                color: ColorResources.colorPrimaryVariant,
                                width: 3.0,
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
                                    Images.male,
                                    width: 50,
                                    height: 30,
                                  ),
                                  Text(AppStrings.male.tr)
                                ],
                              ),
                            ),
                          ),
                          const Gap(30),
                        ],
                      ),
                    )),
                    Obx(() => GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomBottomSheet(
                              horoscopeListCo: horoscopeListCo,
                              onItemSelected: (selectedIndex) {
                                controller.updateGirlSelectedNumber(selectedIndex);
                              },
                            );
                          },
                        );
                      },
                      child: controller.girlSelectedNumber.value != -1
                          ? Row(
                        children: [
                          Column(
                            children: [
                              const Gap(Dimensions.gapExtraLarge),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: ColorResources.colorPrimaryLight,
                                  border: Border.all(
                                    color: ColorResources.colorPrimaryVariant,
                                    width: 3.0,
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
                                        width: 50,
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Gap(Dimensions.gapDefault),
                              CustomTextMedium(horoscopeListCo[controller.girlSelectedNumber.value].title.toString()),
                            ],
                          ),
                        ],
                      )
                          : Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorResources.colorPrimaryLight,
                              border: Border.all(
                                color: ColorResources.colorPrimaryVariant,
                                width: 3.0,
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
                                    Images.female,
                                    width: 50,
                                    height: 30,
                                  ),
                                  Text(AppStrings.female.tr)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),

                  ],
                ),
                const Gap(30),
                Obx(() => Visibility(
                  visible: controller.boySelectedNumber.value != -1 &&
                      controller.girlSelectedNumber.value != -1 &&
                      controller.showButton.value,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorResources.colorPrimaryVariant,
                    ),
                    onPressed: () {
                      controller.getNakshatra(
                          int.parse(horoscopeListCo[controller.girlSelectedNumber.value].number),
                          int.parse(horoscopeListCo[controller.boySelectedNumber.value].number) );
                    },
                    child: Text(AppStrings.showNow.tr,
                      style: const TextStyle(
                        color: ColorResources.toolbarText ,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                    ),
                  ),
                ),),

                Visibility(
                  visible: controller.showButton.isFalse &&
                      controller.isNakshatraLoading.isFalse &&
                      controller.nakshatraModel.status != 200,
                  child: const EmptyScreen(),
                ),
                Obx(() {
                  if (controller.isNakshatraLoading.value) {
                    return ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return const SimmerListView();
                      },
                    );
                  } else if (controller.isNakshatraSuccess.value) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall, top: Dimensions.paddingSizeDefault),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomTextMedium(AppStrings.dashakootMatchingPoint.tr, fontSize: Dimensions.fontSizeLarge),
                            ],
                          ),
                        ),
                        const Gap(20),
                        CustomMatchingScore(score: '${controller.nakshatraModel.response?.score}/${AppConstants.dashakootscore}',),
                        Padding(
                          padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeSmall, top: Dimensions.paddingSizeSmall),
                          child: CustomTextRegular('${controller.nakshatraModel.response?.botResponse}', fontSize: Dimensions.fontSizeSmall),
                        ),
                        const Gap(20),
                        Row(
                          children: [
                            Container(
                              width: 250,
                              decoration: const BoxDecoration(
                                color: ColorResources.colorPrimaryVariant,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimensions.borderRadiusRounded),
                                  bottomRight: Radius.circular(Dimensions.borderRadiusRounded),
                                ),
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeSmall, left: Dimensions.paddingSizeSmall),
                                child: CustomTextMedium(
                                  AppStrings.gunaMilan.tr,
                                  fontSize: Dimensions.fontSizeLarge,
                                  color: ColorResources.toolbarText,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault,left:Dimensions.paddingSizeSmall,right:Dimensions.paddingSizeDefault),
                          child: Column(
                            children: [
                              CustomTableRowRadius(
                                  title: AppStrings.guna.tr,
                                  boy:AppStrings.points.tr,
                                  girl: AppStrings.description.tr,
                                  color: ColorResources.colorPrimary
                              ),
                              CustomTableRow(
                                  title: "${controller.nakshatraModel.response?.dina?.name}",
                                  boy: "${controller.nakshatraModel.response?.dina?.dina}/${controller.nakshatraModel.response?.dina?.fullScore}",
                                  girl: "${controller.nakshatraModel.response?.dina?.description}",
                                  color: ColorResources.colorPrimaryLight
                              ),
                              CustomTableRow(
                                  title: "${controller.nakshatraModel.response?.gana?.name}",
                                  boy: "${controller.nakshatraModel.response?.gana?.gana}/${controller.nakshatraModel.response?.gana?.fullScore}",
                                  girl: "${controller.nakshatraModel.response?.gana?.description}",
                                  color: ColorResources.colorTableRow
                              ),
                              CustomTableRow(
                                  title: "${controller.nakshatraModel.response?.mahendra?.name}",
                                  boy: "${controller.nakshatraModel.response?.mahendra?.mahendra}/${controller.nakshatraModel.response?.mahendra?.fullScore}",
                                  girl: "${controller.nakshatraModel.response?.mahendra?.description}",
                                  color: ColorResources.colorPrimaryLight
                              ),
                              CustomTableRow(
                                  title: "${controller.nakshatraModel.response?.sthree?.name}",
                                  boy: "${controller.nakshatraModel.response?.sthree?.sthree}/${controller.nakshatraModel.response?.sthree?.fullScore}",
                                  girl: "${controller.nakshatraModel.response?.sthree?.description}",
                                  color: ColorResources.colorTableRow
                              ),
                              CustomTableRow(
                                  title: "${controller.nakshatraModel.response?.yoni?.name}",
                                  boy: "${controller.nakshatraModel.response?.yoni?.yoni}/${controller.nakshatraModel.response?.yoni?.fullScore}",
                                  girl: "${controller.nakshatraModel.response?.yoni?.description}",
                                  color: ColorResources.colorPrimaryLight
                              ),
                              CustomTableRow(
                                  title: "${controller.nakshatraModel.response?.rasi?.name}",
                                  boy: "${controller.nakshatraModel.response?.rasi?.rasi}/${controller.nakshatraModel.response?.rasi?.fullScore}",
                                  girl: "${controller.nakshatraModel.response?.rasi?.description}",
                                  color: ColorResources.colorTableRow
                              ),
                              CustomTableRow(
                                  title: "${controller.nakshatraModel.response?.rasiathi?.name}",
                                  boy: "${controller.nakshatraModel.response?.rasiathi?.rasiathi}/${controller.nakshatraModel.response?.rasiathi?.fullScore}",
                                  girl: "${controller.nakshatraModel.response?.rasiathi?.description}",
                                  color: ColorResources.colorPrimaryLight
                              ),
                              CustomTableRow(
                                  title: "${controller.nakshatraModel.response?.vasya?.name}",
                                  boy: "${controller.nakshatraModel.response?.vasya?.vasya}/${controller.nakshatraModel.response?.vasya?.fullScore}",
                                  girl: "${controller.nakshatraModel.response?.vasya?.description}",
                                  color: ColorResources.colorTableRow
                              ),
                              CustomTableRow(
                                  title: "${controller.nakshatraModel.response?.rajju?.name}",
                                  boy: "${controller.nakshatraModel.response?.rajju?.rajju}/${controller.nakshatraModel.response?.rajju?.fullScore}",
                                  girl: "${controller.nakshatraModel.response?.rajju?.description}",
                                  color: ColorResources.colorPrimaryLight

                              ),
                              CustomTableRowBottum(
                                  title: "${controller.nakshatraModel.response?.vedha?.name}",
                                  boy: "${controller.nakshatraModel.response?.vedha?.vedha}/${controller.nakshatraModel.response?.vedha?.fullScore}",
                                  girl: "${controller.nakshatraModel.response?.vedha?.description}",
                                  color: ColorResources.colorTableRow
                              ),
                            ],
                          ),
                        ),
                        const Gap(10)
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getHoroscopesSign() {
    horoscopeListCo.clear();
    horoscopeListCo.add(MenuModel(AppStrings.ashwini.tr, Images.ashwini,'1'));
    horoscopeListCo.add(MenuModel(AppStrings.bharani.tr, Images.bharani,'2'));
    horoscopeListCo.add(MenuModel(AppStrings.krittika.tr, Images.krittika,'3'));
    horoscopeListCo.add(MenuModel(AppStrings.rohini.tr, Images.rohini,'4'));
    horoscopeListCo.add(MenuModel(AppStrings.mrigashira.tr, Images.mrigashira,'5'));
    horoscopeListCo.add(MenuModel(AppStrings.ardra.tr, Images.ardra,'6'));
    horoscopeListCo.add(MenuModel(AppStrings.punarvasu.tr, Images.punarvasu,'7'));
    horoscopeListCo.add(MenuModel(AppStrings.pushya.tr, Images.pushya,'8'));
    horoscopeListCo.add(MenuModel(AppStrings.ashlesha.tr, Images.ashlesha,'9'));
    horoscopeListCo.add(MenuModel(AppStrings.magha.tr, Images.magha,'10'));
    horoscopeListCo.add(MenuModel(AppStrings.purvaphalguni.tr, Images.purvaphalguni,'11'));
    horoscopeListCo.add(MenuModel(AppStrings.uttaraphalguni.tr, Images.uttaraphalguni,'12'));
    horoscopeListCo.add(MenuModel(AppStrings.hasta.tr, Images.hasta,'13'));
    horoscopeListCo.add(MenuModel(AppStrings.chitra.tr, Images.chitra,'14'));
    horoscopeListCo.add(MenuModel(AppStrings.swati.tr, Images.swati,'15'));
    horoscopeListCo.add(MenuModel(AppStrings.vishakha.tr, Images.vishakha,'16'));
    horoscopeListCo.add(MenuModel(AppStrings.anuradha.tr, Images.anuradha,'17'));
    horoscopeListCo.add(MenuModel(AppStrings.jyeshtha.tr, Images.jyeshtha,'18'));
    horoscopeListCo.add(MenuModel(AppStrings.mula.tr, Images.mula,'19'));
    horoscopeListCo.add(MenuModel(AppStrings.purvashadha.tr, Images.purvashadha,'20'));
    horoscopeListCo.add(MenuModel(AppStrings.uttarashadha.tr, Images.uttarashadha,'21'));
    horoscopeListCo.add(MenuModel(AppStrings.sravana.tr, Images.sravana,'22'));
    horoscopeListCo.add(MenuModel(AppStrings.dhanista.tr, Images.dhanista,'23'));
    horoscopeListCo.add(MenuModel(AppStrings.shatabhisha.tr, Images.shatabhisha,'24'));
    horoscopeListCo.add(MenuModel(AppStrings.purvabhadra.tr, Images.purvabhadra,'25'));
    horoscopeListCo.add(MenuModel(AppStrings.uttarabhadra.tr, Images.uttarabhadra,'26'));
    horoscopeListCo.add(MenuModel(AppStrings.revati.tr, Images.revati,'27'));
  }
}





