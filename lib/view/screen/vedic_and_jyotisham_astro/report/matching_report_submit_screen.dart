import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/common_methods.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_elevated_button.dart';
import '../../../widget/custom_text_field.dart';
import '../../../widget/custom_text_medium.dart';
import '../../searchPlace/search_place_screen.dart';
import '../model/vedic_data.dart';
import 'controller/report_controller.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class MatchingReportSubmitScreen extends StatelessWidget {
  MatchingReportSubmitScreen({super.key});

  final FocusNode _maleNameFocusNode = FocusNode();
  final FocusNode _maleBirthdateFocusNode = FocusNode();
  final FocusNode _maleBirthTimeFocusNode = FocusNode();
  final FocusNode _maleBirthPlaceFocusNode = FocusNode();

  final FocusNode _femaleNameFocusNode = FocusNode();
  final FocusNode _femaleBirthdateFocusNode = FocusNode();
  final FocusNode _femaleBirthTimeFocusNode = FocusNode();
  final FocusNode _femaleBirthPlaceFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _maleNameController = TextEditingController();
  final TextEditingController _maleBirthDateController = TextEditingController();
  final TextEditingController _maleBirthTimeController = TextEditingController();
  final TextEditingController _maleBirthPlaceController = TextEditingController();
  final TextEditingController _maleLatitude = TextEditingController();
  final TextEditingController _maleLongitude = TextEditingController();

  final TextEditingController _femaleNameController = TextEditingController();
  final TextEditingController _femaleBirthDateController = TextEditingController();
  final TextEditingController _femaleBirthTimeController = TextEditingController();
  final TextEditingController _femaleBirthPlaceController = TextEditingController();
  final TextEditingController _femalelatitude = TextEditingController();
  final TextEditingController _femalelongitude = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final ReportController controller = Get.put(ReportController());
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: "Matching Pdf Report"),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Male Details Section
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimensions.paddingSizeDefault,
                    left: Dimensions.paddingSizeDefault),
                child: CustomTextMedium(
                  AppStrings.maleDetails.tr,
                  textAlign: TextAlign.start,
                  fontSize: Dimensions.fontSizeExtraLarge,
                ),
              ),
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
                      controller: _maleNameController,
                      hintText: 'Enter your full name',
                      keyboardType: TextInputType.name,
                    ),
                    const Gap(Dimensions.gapLarge),
                    CustomText(hintText: AppStrings.dateOfBirth.tr),
                    const SizedBox(height: Dimensions.sizedBoxExtraSmall),
                    GestureDetector(
                      onTap: () async {
                        CommonMethods().showDatePickerDialog(context,_maleBirthDateController);
                      },
                      child: CustomTextField(
                        controller: _maleBirthDateController,
                        hintText: AppStrings.enterDateOfBirth.tr,
                        enabled: false,
                      ),
                    ),
                    const Gap(Dimensions.gapLarge),
                    CustomText(hintText: AppStrings.timeOfBirth.tr),
                    const SizedBox(height: Dimensions.sizedBoxExtraSmall),
                    GestureDetector(
                      onTap: () async {
                        CommonMethods().showTimerPickerDialog(context,_maleBirthTimeController);
                      },
                      child: CustomTextField(
                        controller: _maleBirthTimeController,
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
                          _maleBirthPlaceController.text = result['name'].toString();
                          _maleLatitude.text = result['latitude'].toString();
                          _maleLongitude.text = result['longitude'].toString();
                        }
                      },
                      child: CustomTextField(
                        controller: _maleBirthPlaceController,
                        hintText: AppStrings.enterPlaceOfBirth.tr,
                        enabled: false,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(Dimensions.gapLarge),
              // Female Details Section
              Padding(
                padding: const EdgeInsets.only(
                    top: Dimensions.paddingSizeDefault,
                    left: Dimensions.paddingSizeDefault),
                child: CustomTextMedium(
                  AppStrings.femaleDetails.tr,
                  textAlign: TextAlign.start,
                  fontSize: Dimensions.fontSizeExtraLarge,
                ),
              ),
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
                      controller: _femaleNameController,
                      hintText: AppStrings.enterFullName.tr,
                      keyboardType: TextInputType.name,
                    ),
                    const Gap(Dimensions.gapLarge),
                    CustomText(hintText:AppStrings.dateOfBirth.tr),
                    const SizedBox(height: Dimensions.sizedBoxExtraSmall),
                    GestureDetector(
                      onTap: () async {
                        CommonMethods().showDatePickerDialog(context,_femaleBirthDateController);
                      },
                      child: CustomTextField(
                        controller: _femaleBirthDateController,
                        hintText: AppStrings.enterDateOfBirth.tr,
                        enabled: false,
                      ),
                    ),
                    const Gap(Dimensions.gapLarge),
                    CustomText(hintText: AppStrings.timeOfBirth.tr),
                    const SizedBox(height: Dimensions.sizedBoxExtraSmall),
                    GestureDetector(
                      onTap: () async {
                        CommonMethods().showTimerPickerDialog(context,_femaleBirthTimeController);
                      },
                      child: CustomTextField(
                        controller: _femaleBirthTimeController,
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
                          _femaleBirthPlaceController.text = result['name'].toString();
                          _femalelatitude.text = result['latitude'].toString();
                          _femalelongitude.text = result['longitude'].toString();
                        }
                      },
                      child: CustomTextField(
                        controller: _femaleBirthPlaceController,
                        hintText: AppStrings.enterPlaceOfBirth.tr,
                        enabled: false,
                      ),
                    ),
                    const Gap(Dimensions.gapExtraLarge),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault),
                child: CustomElevatedButton(
                  text: AppStrings.payNow.tr,
                  // text: "${AppStrings.payNow.tr} (${AppStrings.rupeeSign}${controller.reportCalculationModel.data?.finalamount})",
                  backgroundColor: ColorResources.colorPrimaryVariant,
                  textColor: ColorResources.toolbarText,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller.paidKundliCalculation(AppConstants.reportMatching, 0, "Open", KundliMatchData(
                        _maleNameController.text.toString(),
                        _maleBirthDateController.text.toString(),
                        _maleBirthTimeController.text.toString(),
                        AppConstants.staticTimezone,
                        _maleLatitude.text.toString(),
                        _maleLongitude.text.toString(),
                        _maleBirthPlaceController.text.toString(),
                        "",
                        _femaleNameController.text.toString(),
                        _femaleBirthDateController.text.toString(),
                        _femaleBirthTimeController.text.toString(),
                        AppConstants.staticTimezone,
                        _femalelatitude.text.toString(),
                        _femalelongitude.text.toString(),
                        _femaleBirthPlaceController.text.toString(),
                        "en",
                      ));
                    AppLogger.d("Sending request with payload: $KundliMatchData");
                    }
                  },
                ),
              ),
              const Gap(Dimensions.gapExtraLarge),
            ],
          ),
        ),
      ),
    );
  }
}
