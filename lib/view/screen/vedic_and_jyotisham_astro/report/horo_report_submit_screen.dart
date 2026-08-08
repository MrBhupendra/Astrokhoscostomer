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
import '../../searchPlace/search_place_screen.dart';
import '../model/vedic_data.dart';
import 'controller/report_controller.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class HoroReportSubmitScreen extends StatelessWidget {
  HoroReportSubmitScreen({super.key});

  final ReportController controller = Get.put(ReportController());

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _birthTimeController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _kundliLatitude = TextEditingController();
  final TextEditingController _kundliLongitude = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child:Scaffold(
        appBar: const CustomAppBar(title: "Horoscope Pdf Report"),
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
                      hintText: 'Enter your full name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.formError.tr;
                        } else if (!RegExp(r'^[a-zA-Z0-9 ]*$').hasMatch(value)) {
                          return AppStrings.specialCharacterError.tr;
                        }
                        return null;
                      },
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
                        hintText: 'Date of Birth',
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
                        hintText: 'Time of Birth',
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
                          _birthPlaceController.text =
                              result['name'].toString();
                          _kundliLatitude.text = result['latitude'].toString();
                          _kundliLongitude.text = result['longitude'].toString();
                        }
                      },
                      child: CustomTextField(
                        controller: _birthPlaceController,
                        hintText: 'Select Birth Place',
                        enabled: false,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(Dimensions.gapExtraExtraLarge),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault),
                child: CustomElevatedButton(
                  text: AppStrings.payNow.tr,
                  // text: "${AppStrings.payNow.tr} (${AppStrings.rupeeSign}${controller.reportCalculationModel.data?.finalamount})",
                  backgroundColor: ColorResources.colorPrimaryVariant,
                  textColor: ColorResources.toolbarText,
                  onPressed: () {
                    AppLogger.d("form data${_nameController.text},${_birthDateController.text},${_birthTimeController.text},${_kundliLatitude.text},${_kundliLongitude.text},${_birthPlaceController.text}");
                    if(_formKey.currentState!.validate()){

                      controller.paidKundliCalculation(AppConstants.reportHoroscope, 0, "Open",  KundliMatchData(
                          _nameController.text.toString(),
                          _birthDateController.text.toString(),
                          _birthTimeController.text.toString(),
                          AppConstants.staticTimezone,
                          _kundliLatitude.text.toString(),
                          _kundliLongitude.text.toString(),
                          _birthPlaceController.text.toString(),
                          "",
                          "",
                          "",
                          "",
                          "",
                          "",
                          "",
                          "",
                          "en"));
                    }
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
