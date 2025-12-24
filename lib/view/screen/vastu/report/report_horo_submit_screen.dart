import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:astro_brahmand/view/widget/custom_language_widget.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../model/vedic_data.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/common_methods.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_elevated_button.dart';
import '../../../widget/custom_gender_widget.dart';
import '../../../widget/custom_text_field.dart';
import '../../../widget/custom_text_medium.dart';
import '../../searchPlace/search_place_screen.dart';
import '../../vedic_and_jyotisham_astro/model/report_kundli_list_model.dart';
import 'controller/report_horo_controller.dart';

class ReportHoroSubmitScreen extends StatelessWidget {
  // final String type;
  ReportHoroSubmitScreen({super.key});

  final ReportHoroController controller = Get.put(ReportHoroController());
  final ReportData reportData = Get.arguments;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _birthTimeController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _kundliLatitude = TextEditingController();
  final TextEditingController _kundliLongitude = TextEditingController();
  final TextEditingController _kundliTimezone = TextEditingController();

  // partner detail
  final TextEditingController _partnerNameController = TextEditingController();
  final TextEditingController _partnerBirthDateController = TextEditingController();
  final TextEditingController _partnerBirthTimeController = TextEditingController();
  final TextEditingController _partnerBirthPlaceController = TextEditingController();
  final TextEditingController _partnerLatitude = TextEditingController();
  final TextEditingController _partnerLongitude = TextEditingController();
  final TextEditingController _partnerTimezone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.kundliReport.tr),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(Dimensions.gapExtraLarge),
                    CustomText(hintText: AppStrings.name.tr),
                    const SizedBox(height: Dimensions.sizedBoxExtraSmall),
                    CustomTextField(
                      controller: _nameController,
                      hintText: AppStrings.enterFullName.tr,
                      keyboardType: TextInputType.name,
                    ),
                    const Gap(Dimensions.gapLarge),
                    CustomText(hintText: AppStrings.dateOfBirth.tr),
                    const SizedBox(height: Dimensions.sizedBoxExtraSmall),
                    GestureDetector(
                      onTap: () async {
                        CommonMethods().showDatePickerDialog(context,_birthDateController);
                      },
                      child: CustomTextField(
                        controller: _birthDateController,
                        hintText: AppStrings.enterDateOfBirth.tr,
                        enabled: false,
                      ),
                    ),
                    const Gap(Dimensions.gapLarge),
                    CustomText(hintText: AppStrings.timeOfBirth.tr),
                    const SizedBox(height: Dimensions.sizedBoxExtraSmall),
                    GestureDetector(
                      onTap: () async {
                        CommonMethods().showTimerPickerDialog(context,_birthTimeController);
                      },
                      child: CustomTextField(
                        controller: _birthTimeController,
                        hintText: AppStrings.enterTimeOfBirth.tr,
                        enabled: false,
                      ),
                    ),
                    const Gap(Dimensions.gapLarge),
                    CustomText(hintText: AppStrings.placeOfBirth.tr),
                    const SizedBox(height: Dimensions.sizedBoxExtraSmall),
                    GestureDetector(
                      onTap: () async {
                        String? placeApiKey = await SharedPreferencesHelper.getData(AppConstants.placeApiKey);
                        var result = await Get.to(SearchPlaceScreen(placeApiKey.toString()));
                        if (result != null) {
                          _birthPlaceController.text = result['name'].toString();
                          _kundliLatitude.text = result['latitude'].toString();
                          _kundliLongitude.text = result['longitude'].toString();
                          _kundliTimezone.text = result['offset'].toString();
                        }
                      },
                      child: CustomTextField(
                        controller: _birthPlaceController,
                        hintText: AppStrings.enterPlaceOfBirth.tr,
                        enabled: false,
                      ),
                    ),
                    const Gap(Dimensions.gapMedium),
                    const CustomText(hintText: "Gender"),
                    const SizedBox(
                        height: Dimensions.sizedBoxExtraSmall),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                      ),
                      child: CustomGenderWidget(
                        onGenderChanged: (value) {
                          controller.setGender(value!);
                        },
                      ),
                    ),

                    // Obx(() => Text('Selected Gender: ${controller.selectedGender.value}')),
                    const Gap(Dimensions.gapMedium),
                    const CustomText(hintText: "Report Language"),
                    const SizedBox(height: Dimensions.sizedBoxExtraSmall),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                      ),
                      child: CustomLanguageWidget(
                        onLanguageChanged: (value) {
                          controller.setLanguage(value!);
                        },
                      ),
                    ),
                    const Gap(Dimensions.gapLarge),

                    Visibility(
                      visible: reportData.maritalStatus == AppConstants.married,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextMedium("Partner Detail",fontSize: Dimensions.fontSizeExtraLarge),
                          const Gap(Dimensions.gapMedium),
                          CustomTextField(
                            controller: _partnerNameController,
                            hintText: "Partner Name",
                            keyboardType: TextInputType.name,
                          ),
                          const Gap(Dimensions.gapLarge),
                          CustomText(hintText: AppStrings.dateOfBirth.tr),
                          const SizedBox(height: Dimensions.sizedBoxExtraSmall),
                          GestureDetector(
                            onTap: () async {
                              CommonMethods().showDatePickerDialog(context,_partnerBirthDateController);
                            },
                            child: CustomTextField(
                              controller: _partnerBirthDateController,
                              hintText: AppStrings.enterDateOfBirth.tr,
                              enabled: false,
                            ),
                          ),
                          const Gap(Dimensions.gapLarge),
                          CustomText(hintText: AppStrings.timeOfBirth.tr),
                          const SizedBox(height: Dimensions.sizedBoxExtraSmall),
                          GestureDetector(
                            onTap: () async {
                              CommonMethods().showTimerPickerDialog(context,_partnerBirthTimeController);
                            },
                            child: CustomTextField(
                              controller: _partnerBirthTimeController,
                              hintText: AppStrings.enterTimeOfBirth.tr,
                              enabled: false,
                            ),
                          ),
                          const Gap(Dimensions.gapLarge),
                          CustomText(hintText: AppStrings.placeOfBirth.tr),
                          const SizedBox(height: Dimensions.sizedBoxExtraSmall),
                          GestureDetector(
                            onTap: () async {
                              String? placeApiKey = await SharedPreferencesHelper.getData(AppConstants.placeApiKey);
                              var result = await Get.to(SearchPlaceScreen(placeApiKey.toString()));
                              if (result != null) {
                                _partnerBirthPlaceController.text = result['name'].toString();
                                _partnerLatitude.text = result['latitude'].toString();
                                _partnerLongitude.text = result['longitude'].toString();
                                _partnerTimezone.text = result['offset'].toString();
                              }
                            },
                            child: CustomTextField(
                              controller: _partnerBirthPlaceController,
                              hintText: AppStrings.enterPlaceOfBirth.tr,
                              enabled: false,
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
              // const Gap(Dimensions.gapExtraLarge),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeSmall),
                child: CustomElevatedButton(
                  text: AppStrings.payNow.tr,
                  backgroundColor: ColorResources.colorPrimary,
                  textColor: ColorResources.toolbarText,
                  onPressed: () {
                    if(reportData.maritalStatus == AppConstants.single){
                      if (_formKey.currentState!.validate()) {
                        if(controller.selectedGender.value.isEmpty){
                          CustomSnackBar.showBottom("Please select gender");
                        }else if(controller.selectedLanguage.value.isEmpty){
                          CustomSnackBar.showBottom("Please select language");
                        }else{
                          controller.getHoroReportCalculation(
                            reportData.id.toString(),
                            reportData.maritalStatus.toString(),
                            0,
                            "Open",
                            KundliMatchData(
                                _nameController.text.toString(),
                                _birthDateController.text.toString(),
                                _birthTimeController.text.toString(),
                                _kundliTimezone.text.toString(),
                                _kundliLatitude.text.toString(),
                                _kundliLongitude.text.toString(),
                                _birthPlaceController.text.toString(),
                                controller.selectedGender.value.toString(),
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                "",
                                controller.selectedLanguage.value.toString()),
                          );
                        }

                      }
                    }else{
                      if (_formKey.currentState!.validate()) {
                        controller.getHoroReportCalculation(
                          reportData.id.toString(),
                          reportData.maritalStatus.toString(),
                          0,
                          "Open",
                          KundliMatchData(
                            _nameController.text.toString(),
                            _birthDateController.text.toString(),
                            _birthTimeController.text.toString(),
                            _kundliTimezone.text.toString(),
                            _kundliLatitude.text.toString(),
                            _kundliLongitude.text.toString(),
                            _birthPlaceController.text.toString(),
                            controller.selectedGender.value.toString(),
                            _partnerNameController.text.toString(),
                            _partnerBirthDateController.text.toString(),
                            _partnerBirthTimeController.text.toString(),
                            _partnerTimezone.text.toString(),
                            _partnerLatitude.text.toString(),
                            _partnerLongitude.text.toString(),
                            _partnerBirthPlaceController.text.toString(),
                            controller.selectedLanguage.value.toString(),
                          ),
                        );
                      }
                    }

                  },
                ),
              ),
              // const Gap(Dimensions.gapLarge),
            ],
          ),
        ),
      ),
    );
  }
}
