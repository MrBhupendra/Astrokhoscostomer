import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utill/app_constants.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_dialog_widget.dart';
import '../../../widget/custom_elevated_button.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_box_decoration.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import '../controller/kundli_intake_form_controller.dart';
import '../controller/matching_controller.dart';
import '../model/vedic_data.dart';


class MatchingSavedScreen extends StatelessWidget {
  MatchingSavedScreen({super.key});

  final MatchingController controller = Get.put(MatchingController());

  @override
  Widget build(BuildContext context) {

    controller.getSavedKundli(controller.offsetCount,AppConstants.vedicAstro);

    controller.scrollController.addListener(() {
      if (controller.scrollController.position.pixels ==
          controller.scrollController.position.maxScrollExtent) {
        if(controller.isSavedLoading.isFalse && !controller.isNoMoreData) {
          controller.getSavedKundli(controller.offsetCount,AppConstants.vedicAstro);
        }
      }
    });

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.dashKundliMatching.tr,),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 6.0),
          child: Column(
            children: [
              Expanded(
                child: Obx(
                      () {
                        if(controller.isRefresh.isTrue){
                          print("AS1 Refresh");
                          controller.getSavedKundli(0,AppConstants.vedicAstro);
                        }
                    if (controller.isSavedSuccess.isTrue) {
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: controller.matchingsavedKundliListData.length,
                              controller: controller.scrollController,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      KundliMatchData data = KundliMatchData(
                                        controller.matchingsavedKundliListData[index].requestBody!.boyName.toString(),
                                        controller.matchingsavedKundliListData[index].requestBody!.boyDob.toString(),
                                        controller.matchingsavedKundliListData[index].requestBody!.boyTob.toString(),
                                        controller.matchingsavedKundliListData[index].requestBody!.boyTz.toString(),
                                        controller.matchingsavedKundliListData[index].requestBody!.boyLat.toString(),
                                        controller.matchingsavedKundliListData[index].requestBody!.boyLon.toString(),
                                        controller.matchingsavedKundliListData[index].requestBody!.boyPlace.toString(),
                                        "",
                                        controller.matchingsavedKundliListData[index].requestBody!.girlName.toString(),
                                        controller.matchingsavedKundliListData[index].requestBody!.girlDob.toString(),
                                        controller.matchingsavedKundliListData[index].requestBody!.girlTob.toString(),
                                        controller.matchingsavedKundliListData[index].requestBody!.girlTz.toString(),
                                        controller.matchingsavedKundliListData[index].requestBody!.girlLat.toString(),
                                        controller.matchingsavedKundliListData[index].requestBody!.girlLon.toString(),
                                        controller.matchingsavedKundliListData[index].requestBody!.girlPlace.toString(),
                                        controller.matchingsavedKundliListData[index].requestBody!.language.toString(),
                                      );
                                      KundliIntakeFormController kundliIntakeFormController = Get.put(KundliIntakeFormController());
                                      kundliIntakeFormController.setKundliMatchingData(data);
                                      Get.toNamed('/matchingTabScreen', arguments: data);
                                    },
                                    child: Container(
                                      decoration: CustomBoxDecoration.getServiceDecoration(),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  // alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: ColorResources.colorPrimaryLight,
                                                    border: Border.all(
                                                      color: ColorResources.colorPrimaryVariant,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius: BorderRadius.circular(Dimensions.borderRadiusRounded),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(Dimensions.paddingSizeOverSmall),
                                                    child: Image.asset(
                                                      Images.male,
                                                      width: 24,
                                                    ),
                                                  ),
                                                ),
                                                const Gap(Dimensions.gapExtraSmall),
                                                Expanded(
                                                    child: CustomTextMedium(
                                                      controller.matchingsavedKundliListData[index].requestBody!.boyName.toString(),
                                                      fontSize: Dimensions.fontSizeLarge,
                                                    )),
                                                GestureDetector(
                                                  onTap: () {
                                                    final boyName = controller.matchingsavedKundliListData[index].requestBody!.boyName.toString();
                                                    final boyBirthDate = controller.matchingsavedKundliListData[index].requestBody!.boyDob.toString();
                                                    final boyBirthTime = controller.matchingsavedKundliListData[index].requestBody!.boyTob.toString();
                                                    final boyTz = controller.matchingsavedKundliListData[index].requestBody!.boyTz.toString();
                                                    final boyLat = controller.matchingsavedKundliListData[index].requestBody!.boyLat.toString();
                                                    final boyLong = controller.matchingsavedKundliListData[index].requestBody!.boyLon.toString();
                                                    final boyBirthPlace = controller.matchingsavedKundliListData[index].requestBody!.boyPlace.toString();
                                                    final girlName = controller.matchingsavedKundliListData[index].requestBody!.girlName.toString();
                                                    final girlBirthDate = controller.matchingsavedKundliListData[index].requestBody!.girlDob.toString();
                                                    final girlBirthTime = controller.matchingsavedKundliListData[index].requestBody!.girlTob.toString();
                                                    final girlTz = controller.matchingsavedKundliListData[index].requestBody!.girlTz.toString();
                                                    final girlLat = controller.matchingsavedKundliListData[index].requestBody!.girlLat.toString();
                                                    final girlLong= controller.matchingsavedKundliListData[index].requestBody!.girlLon.toString();
                                                    final girlBirthPlace = controller.matchingsavedKundliListData[index].requestBody!.girlPlace.toString();
                                                    final language= controller.matchingsavedKundliListData[index].requestBody!.language.toString();
                                                    final id = controller.matchingsavedKundliListData[index].id.toString();

                                                    controller.setMatchingEditData(KundliMatchData(boyName, boyBirthDate, boyBirthTime, boyTz, boyLat, boyLong, boyBirthPlace,"", girlName, girlBirthDate, girlBirthTime, girlTz, girlLat,girlLong, girlBirthPlace, language.toString()),id);

                                                    Get.toNamed('/matchingSubmitScreen', arguments: {
                                                      'title': "Edit Match Matching"
                                                    });

                                                  },



                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: ColorResources.colorPrimaryLight,
                                                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusRoundedall),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(Dimensions.paddingSizeOverSmall),
                                                      child: Image.asset(
                                                        Images.edit,
                                                        width: 18,
                                                        color: ColorResources.colorPrimary,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                const Gap(Dimensions.gapDefault),
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.dialog(
                                                        CustomDialogWidget(
                                                            imagePath: Images.deleteAcc,
                                                            title: AppStrings.confirmDelete.tr,
                                                            onYesPressed: () {
                                                              Get.back();
                                                              controller.matchingSaveDataDelete(
                                                                controller.matchingsavedKundliListData[index].id.toString(),
                                                                index,
                                                              );
                                                            },
                                                            // imageColor: ColorResources.colorFontRed,
                                                            description: AppStrings.areSureWantDeleteMatching.tr
                                                        ),
                                                        barrierDismissible: false
                                                    );
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: ColorResources.colorPrimaryLight,
                                                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusRoundedall),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(Dimensions.paddingSizeOverSmall),
                                                      child: Image.asset(
                                                        Images.delete,
                                                        width: 18,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Gap(Dimensions.gapDefault),
                                            Row(
                                              children: [
                                                CustomTextRegular(controller.matchingsavedKundliListData[index].requestBody!.boyDob.toString(),fontSize: Dimensions.fontSizeSmall),
                                                const Gap(Dimensions.gapExtraSmall),
                                                CustomTextRegular(controller.matchingsavedKundliListData[index].requestBody!.boyTob.toString(),fontSize: Dimensions.fontSizeSmall,color: ColorResources.colorPrimary,),
                                              ],
                                            ),
                                            const Gap(Dimensions.gapExtraSmall),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: CustomTextRegular(controller.matchingsavedKundliListData[index].requestBody!.boyPlace.toString())
                                                ),
                                              ],
                                            ),
                                            const Gap(Dimensions.gapDefault),
                                            Divider(color: ColorResources.colorPrimary.withOpacity(0.2)),
                                            const Gap(Dimensions.gapDefault),
                                            Row(
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: ColorResources.colorPrimaryLight,
                                                    border: Border.all(
                                                      color: ColorResources.colorPrimaryVariant,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius: const BorderRadius.all(
                                                      Radius.circular(Dimensions.borderRadiusRoundedall),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(Dimensions.paddingSizeOverSmall),
                                                    child: Image.asset(
                                                      Images.female,
                                                      width: 24,
                                                    ),
                                                  ),
                                                ),
                                                const Gap(Dimensions.gapExtraSmall),
                                                Expanded(
                                                    child: CustomTextMedium(
                                                      controller.matchingsavedKundliListData[index].requestBody!.girlName.toString(),
                                                      fontSize: Dimensions.fontSizeLarge,
                                                    )),
                                              ],
                                            ),
                                            const Gap(Dimensions.gapDefault),
                                            Row(
                                              children: [
                                                CustomTextRegular(controller.matchingsavedKundliListData[index].requestBody!.girlDob.toString(),fontSize: Dimensions.fontSizeSmall),
                                                const Gap(Dimensions.gapExtraSmall),
                                                Expanded(
                                                    child: CustomTextRegular(controller.matchingsavedKundliListData[index].requestBody!.girlTob.toString(),fontSize: Dimensions.fontSizeSmall,color: ColorResources.colorPrimary,)
                                                ),
                                              ],
                                            ),
                                            const Gap(Dimensions.gapExtraExtraSmall),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: CustomTextRegular(controller.matchingsavedKundliListData[index].requestBody!.girlPlace.toString(),)
                                                ),
                                                const Gap(Dimensions.gapDefault),
                                                const Padding(
                                                  padding: EdgeInsets.all(Dimensions.paddingSizeOverSmall),
                                                  child: Icon(
                                                    Icons.arrow_forward_ios_outlined,
                                                    color: ColorResources.colorPrimary,
                                                    size: 18,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Obx(() => Visibility(
                            visible: controller.isSavedLoading.isTrue,
                            child: const Text('Loading'),
                          ),)
                        ],
                      );
                    } else if (controller.isSavedLoading.isTrue) {
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
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeExtraOverSmall),
                child: CustomElevatedButton(
                  text: AppStrings.createNewMatch.tr,
                  backgroundColor: ColorResources.colorPrimary,
                  textColor: ColorResources.toolbarText,
                  onPressed: () {
                    Get.toNamed('/matchingSubmitScreen', arguments: {
                      'title': 'Create Kundli Matching'
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


