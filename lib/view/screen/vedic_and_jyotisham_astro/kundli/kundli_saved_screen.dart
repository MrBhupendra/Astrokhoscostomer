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
import '../controller/kundli_controller.dart';
import '../controller/kundli_intake_form_controller.dart';
import '../model/vedic_data.dart';

class KundliSavedScreen extends StatelessWidget {
  KundliSavedScreen({super.key});

  final KundliController controller = Get.put(KundliController());

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
        appBar: CustomAppBar(title: AppStrings.kundli.tr),
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
                              itemCount: controller.savedKundliListData.length,
                              controller: controller.scrollController,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      KundliData data = KundliData(
                                        controller.savedKundliListData[index].requestBody!.name.toString(),
                                        controller.savedKundliListData[index].requestBody!.dob.toString(),
                                        controller.savedKundliListData[index].requestBody!.tob.toString(),
                                        controller.savedKundliListData[index].requestBody!.timezone.toString(),
                                        controller.savedKundliListData[index].requestBody!.lat.toString(),
                                        controller.savedKundliListData[index].requestBody!.lon.toString(),
                                        controller.savedKundliListData[index].requestBody!.place.toString(),
                                        controller.savedKundliListData[index].requestBody!.language.toString(),
                                      );
                                      KundliIntakeFormController kundliIntakeFormController = Get.put(KundliIntakeFormController());
                                      kundliIntakeFormController.setKundliData(data);
                                      Get.toNamed('/kundliTabScreen');
                                    },
                                    child: Container(
                                      decoration: CustomBoxDecoration.getBorderDecoration(),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: CustomTextMedium(
                                                      controller.savedKundliListData[index].requestBody!.name.toString(),
                                                      fontSize: Dimensions.fontSizeLarge,
                                                    )
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    final name = controller.savedKundliListData[index].requestBody!.name.toString();
                                                    final birthDate = controller.savedKundliListData[index].requestBody!.dob.toString();
                                                    final birthTime = controller.savedKundliListData[index].requestBody!.tob.toString();
                                                    final birthPlace = controller.savedKundliListData[index].requestBody!.place.toString();
                                                    final lat = controller.savedKundliListData[index].requestBody!.lat.toString();
                                                    final lon = controller.savedKundliListData[index].requestBody!.lon.toString();
                                                    final tz = controller.savedKundliListData[index].requestBody!.timezone.toString();
                                                    final language = controller.savedKundliListData[index].requestBody!.language.toString();
                                                    final id = controller.savedKundliListData[index].id.toString();
                                                    print("birthTime  => $birthTime");
                                                    controller.setKundliEditData(KundliData(name, birthDate, birthTime, tz, lat, lon, birthPlace, language.toString()),id);

                                                    Get.toNamed('/kundliSubmitScreen', arguments: {
                                                      'title': "Edit Kundli"
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
                                                              controller.deleteKundli(
                                                                controller.savedKundliListData[index].id.toString(),
                                                                index,
                                                              );
                                                            },
                                                            // imageColor: ColorResources.colorFontRed,
                                                            description: AppStrings.areSureWantDeleteKundli.tr
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
                                            const Gap(Dimensions.gapExtraExtraSmall),
                                            Row(
                                              children: [
                                                CustomTextRegular(controller.savedKundliListData[index].requestBody!.dob.toString(),fontSize: Dimensions.fontSizeSmall,),
                                                const Gap(Dimensions.gapExtraSmall),
                                                Expanded(
                                                    child: CustomTextRegular(controller.savedKundliListData[index].requestBody!.tob.toString(),color: ColorResources.colorPrimary,fontSize: Dimensions.fontSizeSmall)
                                                ),
                                              ],
                                            ),
                                            const Gap(Dimensions.gapExtraExtraSmall),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: CustomTextRegular(controller.savedKundliListData[index].requestBody!.place.toString(),)
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
                    text: AppStrings.createNewKundli.tr,
                    backgroundColor: ColorResources.colorPrimary,
                    textColor: ColorResources.toolbarText,
                    onPressed: () {
                      Get.toNamed('/kundliSubmitScreen', arguments: {
                        'title': "Create Kundli",
                      });
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
