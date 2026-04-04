import 'package:flutter/cupertino.dart';
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
import '../controller/kundli_controller.dart';
import '../model/vedic_data.dart';

class KundliSubmitScreen extends StatelessWidget {
  KundliSubmitScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _birthPlaceFocusNode = FocusNode();
  final FocusNode _birthDateFocusNode = FocusNode();
  final FocusNode _birthTimeFocusNode = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _birthTimeController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _kundliLatitude = TextEditingController();
  final TextEditingController _kundliLongitude = TextEditingController();
  final TextEditingController _kundliTimezone = TextEditingController();

  final KundliController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    String title = arguments['title'] ?? '';

    if(title == AppStrings.editKundli.tr){
      _nameController.text = controller.updateKundliData.name.toString();
      _birthDateController.text = controller.updateKundliData.dob.toString();
      _birthTimeController.text = controller.updateKundliData.tob.toString();
      _birthPlaceController.text = controller.updateKundliData.place.toString();
      _kundliLatitude.text = controller.updateKundliData.latitude.toString();
      _kundliLongitude.text = controller.updateKundliData.longitude.toString();
      _kundliTimezone.text = controller.updateKundliData.timeZone.toString();
    }

    return SafeArea(
      child:Scaffold(
        appBar: CustomAppBar(title: title),
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
                    CustomFormTextField(
                      controller: _nameController,
                      hintText: AppStrings.enterFullName.tr,
                      prefixIcon: Icons.person,
                      focusNode: _nameFocusNode,
                      onFieldSubmitted: (_) => _birthPlaceFocusNode.requestFocus(),
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
                    CustomFormTextField(
                      controller: _birthDateController,
                      hintText: AppStrings.selectDate.tr,
                      prefixIcon: CupertinoIcons.calendar,
                      enabled: false,
                      focusNode: _birthDateFocusNode,
                      onFieldSubmitted: (_) => _birthTimeFocusNode.requestFocus(),
                      contentPadding: const EdgeInsets.only(left: 8.0),
                      onTap: () async {
                        CommonMethods().showDatePickerDialog(context, _birthDateController);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.formError.tr;
                        }
                        return null;
                      },
                    ),

                    const Gap(Dimensions.gapLarge),
                    CustomText(hintText: AppStrings.timeOfBirth.tr),
                    const SizedBox(height: Dimensions.sizedBoxExtraSmall),
                    CustomFormTextField(
                      controller: _birthTimeController,
                      hintText: AppStrings.selectTime.tr,
                      prefixIcon: CupertinoIcons.clock_fill,
                      enabled: false,
                      focusNode: _birthTimeFocusNode,
                      onFieldSubmitted: (_) => _birthPlaceFocusNode.requestFocus(),
                      contentPadding: const EdgeInsets.only(left: 8.0),
                      onTap: () async {
                        CommonMethods().showTimerPickerDialog(context, _birthTimeController);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.formError.tr;
                        }
                        return null;
                      },
                    ),

                    const Gap(Dimensions.gapLarge),
                    CustomText(hintText: AppStrings.placeOfBirth.tr),
                    const SizedBox(height: Dimensions.sizedBoxExtraSmall),
                    CustomFormTextField(
                      controller: _birthPlaceController,
                      hintText: AppStrings.selectBirthPlace.tr,
                      prefixIcon: CupertinoIcons.building_2_fill,
                      enabled: false,
                      focusNode: _birthPlaceFocusNode,
                      onTap: () async {
                        String? placeApiKey = await SharedPreferencesHelper.getData(AppConstants.placeApiKey);
                        var result = await Get.to(SearchPlaceScreen(placeApiKey.toString()));
                        if (result != null) {
                          _birthPlaceController.text = result['name'].toString();
                          _kundliLatitude.text = result['latitude'].toString();
                          _kundliLongitude.text = result['longitude'].toString();
                          _kundliTimezone.text = result['offset'].toString();
                          print(result['offset'].toString());
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.formError.tr;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const Gap(Dimensions.gapExtraExtraLarge),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault),
                child: CustomElevatedButton(
                  text: title.contains(AppStrings.createKundli.tr) ? AppStrings.createKundli.tr : AppStrings.editKundli.tr,
                  backgroundColor: ColorResources.colorPrimary,
                  textColor: ColorResources.toolbarText,
                  onPressed: () async {
                    if (title.contains(AppStrings.createKundli.tr)) {
                      print("TimeZone->${_kundliTimezone.text}");
                      print("lat->${_kundliLatitude.text}");
                      print("long->${_kundliLongitude.text}");
                      _formKey.currentState!.validate();
                      if (_formKey.currentState!.validate()) {
                        String? appLanguage = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
                        appLanguage ??= 'en';
                        controller.saveKundli(
                          AppConstants.vedicAstro,
                          AppConstants.kundli,
                          KundliData(
                            _nameController.text.toString(),
                            _birthDateController.text.toString(),
                            _birthTimeController.text.toString(),
                            _kundliTimezone.text.toString(),
                            _kundliLatitude.text.toString(),
                            _kundliLongitude.text.toString(),
                            _birthPlaceController.text.toString(),
                            appLanguage,
                          ),
                        );
                      }
                    } else if (title.contains(AppStrings.editKundli.tr)) {
                      print("TimeZone->${_kundliTimezone.text}");
                      print("lat->${_kundliLatitude.text}");
                      print("long->${_kundliLongitude.text}");
                      _formKey.currentState!.validate();
                      if (_formKey.currentState!.validate()) {
                        String? appLanguage = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
                        appLanguage ??= 'en';
                        controller.updateKundli(
                          controller.updateId.toString(),
                          AppConstants.vedicAstro,
                          AppConstants.kundli,
                          KundliData(
                            _nameController.text.toString(),
                            _birthDateController.text.toString(),
                            _birthTimeController.text.toString(),
                            _kundliTimezone.text.toString(),
                            _kundliLatitude.text.toString(),
                            _kundliLongitude.text.toString(),
                            _birthPlaceController.text.toString(),
                            appLanguage,
                          ),
                        );
                      }
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

