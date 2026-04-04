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
import '../../../widget/custom_text_medium.dart';
import '../../searchPlace/search_place_screen.dart';
import '../controller/matching_controller.dart';
import '../model/vedic_data.dart';

class MatchingSubmitScreen extends StatelessWidget {

  MatchingSubmitScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  final FocusNode _maleNameFocusNode = FocusNode();
  final FocusNode _maleBirthdateFocusNode = FocusNode();
  final FocusNode _maleBirthTimeFocusNode = FocusNode();
  final FocusNode _maleBirthPlaceFocusNode = FocusNode();

  final FocusNode _femaleNameFocusNode = FocusNode();
  final FocusNode _femaleBirthdateFocusNode = FocusNode();
  final FocusNode _femaleBirthTimeFocusNode = FocusNode();
  final FocusNode _femaleBirthPlaceFocusNode = FocusNode();

  final TextEditingController _maleNameController = TextEditingController();
  final TextEditingController _maleBirthDateController = TextEditingController();
  final TextEditingController _maleBirthTimeController = TextEditingController();
  final TextEditingController _maleBirthPlaceController = TextEditingController();
  final TextEditingController _maleLatitude = TextEditingController();
  final TextEditingController _maleLongitude = TextEditingController();
  final TextEditingController _maleTimezone = TextEditingController();

  final TextEditingController _femaleNameController = TextEditingController();
  final TextEditingController _femaleBirthDateController = TextEditingController();
  final TextEditingController _femaleBirthTimeController = TextEditingController();
  final TextEditingController _femaleBirthPlaceController = TextEditingController();
  final TextEditingController _femalelatitude = TextEditingController();
  final TextEditingController _femalelongitude = TextEditingController();
  final TextEditingController _femaleTimezone = TextEditingController();

  final MatchingController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    String title = arguments['title'] ?? '';

    if(title == AppStrings.editKundliMatching.tr){
      _maleNameController.text = controller.updateMatchingData.boyName.toString();
      _maleBirthDateController.text = controller.updateMatchingData.boyDob.toString();
      _maleBirthTimeController.text = controller.updateMatchingData.boyTob.toString();
      _maleBirthPlaceController.text = controller.updateMatchingData.boyPlace.toString();
      _maleLatitude.text = controller.updateMatchingData.boyLat.toString();
      _maleLongitude.text = controller.updateMatchingData.boyLong.toString();
      _maleTimezone.text = controller.updateMatchingData.boyTz.toString();

      _femaleNameController.text = controller.updateMatchingData.girlName.toString();
      _femaleBirthDateController.text = controller.updateMatchingData.girlDob.toString();
      _femaleBirthTimeController.text = controller.updateMatchingData.girlTob.toString();
      _femaleBirthPlaceController.text = controller.updateMatchingData.girlPlace.toString();
      _femalelatitude.text = controller.updateMatchingData.girlLat.toString();
      _femalelongitude.text = controller.updateMatchingData.girlLong.toString();
      _femaleTimezone.text = controller.updateMatchingData.girlTz.toString();
    }

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: title),
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
                    CustomFormTextField(
                      controller: _maleNameController,
                      hintText: AppStrings.enterFullName.tr,
                      prefixIcon: Icons.person,
                      focusNode: _maleNameFocusNode,
                      onFieldSubmitted: (_) => _maleBirthdateFocusNode.requestFocus(),
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
                      controller: _maleBirthDateController,
                      hintText: AppStrings.selectDate.tr,
                      prefixIcon: CupertinoIcons.calendar,
                      enabled: false,
                      focusNode: _maleBirthdateFocusNode,
                      onFieldSubmitted: (_) => _maleBirthTimeFocusNode.requestFocus(),
                      contentPadding: const EdgeInsets.only(left: 8.0),
                      onTap: () async {
                        CommonMethods().showDatePickerDialog(context, _maleBirthDateController);
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
                      controller: _maleBirthTimeController,
                      hintText: AppStrings.selectTime.tr,
                      prefixIcon: CupertinoIcons.clock_fill,
                      enabled: false,
                      focusNode: _maleBirthTimeFocusNode,
                      onFieldSubmitted: (_) => _maleBirthPlaceFocusNode.requestFocus(),
                      contentPadding: const EdgeInsets.only(left: 8.0),
                      onTap: () async {
                        CommonMethods().showTimerPickerDialog(context, _maleBirthTimeController);
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
                      controller: _maleBirthPlaceController,
                      hintText: AppStrings.selectBirthPlace.tr,
                      prefixIcon: CupertinoIcons.building_2_fill,
                      enabled: false,
                      focusNode: _maleBirthPlaceFocusNode,
                      onTap: () async {
                        String? placeApiKey = await SharedPreferencesHelper.getData(AppConstants.placeApiKey);
                        var result = await Get.to(SearchPlaceScreen(placeApiKey.toString()));
                        if (result != null) {
                          _maleBirthPlaceController.text = result['name'].toString();
                          _maleLatitude.text = result['latitude'].toString();
                          _maleLongitude.text = result['longitude'].toString();
                          _maleTimezone.text = result['offset'].toString();
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
                    CustomFormTextField(
                      controller: _femaleNameController,
                      hintText: AppStrings.enterFullName.tr,
                      prefixIcon: Icons.person,
                      focusNode: _femaleNameFocusNode,
                      onFieldSubmitted: (_) => _femaleBirthdateFocusNode.requestFocus(),
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
                      controller: _femaleBirthDateController,
                      hintText: AppStrings.selectDate.tr,
                      prefixIcon: CupertinoIcons.calendar,
                      enabled: false,
                      focusNode: _femaleBirthdateFocusNode,
                      onFieldSubmitted: (_) => _femaleBirthTimeFocusNode.requestFocus(),
                      contentPadding: const EdgeInsets.only(left: 8.0),
                      onTap: () async {
                        CommonMethods().showDatePickerDialog(context, _femaleBirthDateController);
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
                      controller: _femaleBirthTimeController,
                      hintText: AppStrings.selectTime.tr,
                      prefixIcon: CupertinoIcons.clock_fill,
                      enabled: false,
                      focusNode: _femaleBirthTimeFocusNode,
                      onFieldSubmitted: (_) => _femaleBirthPlaceFocusNode.requestFocus(),
                      contentPadding: const EdgeInsets.only(left: 8.0),
                      onTap: () async {
                        CommonMethods().showTimerPickerDialog(context, _femaleBirthTimeController);
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
                      controller: _femaleBirthPlaceController,
                      hintText: AppStrings.selectBirthPlace.tr,
                      prefixIcon: CupertinoIcons.building_2_fill,
                      enabled: false,
                      focusNode: _femaleBirthPlaceFocusNode,
                      onTap: () async {
                        String? placeApiKey = await SharedPreferencesHelper.getData(AppConstants.placeApiKey);
                        var result = await Get.to(SearchPlaceScreen(placeApiKey.toString()));
                        if (result != null) {
                          _femaleBirthPlaceController.text = result['name'].toString();
                          _femalelatitude.text = result['latitude'].toString();
                          _femalelongitude.text = result['longitude'].toString();
                          _femaleTimezone.text = result['offset'].toString();
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.formError.tr;
                        }
                        return null;
                      },
                    ),
                    const Gap(Dimensions.gapExtraLarge),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault),
                child: CustomElevatedButton(
                  text: title.contains(AppStrings.createKundliMatching.tr) ? AppStrings.createKundliMatching.tr : AppStrings.editKundliMatching.tr,
                  backgroundColor: ColorResources.colorPrimary,
                  textColor: ColorResources.toolbarText,
                  onPressed: () async {
                    if (title.contains(AppStrings.createKundliMatching.tr)) {
                      _formKey.currentState!.validate();
                      if (_formKey.currentState!.validate()) {
                        String? appLanguage = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
                        appLanguage ??= 'en';
                        controller.saveKundliMatching(
                          AppConstants.vedicAstro,
                          AppConstants.kundliMatching,
                          KundliMatchData(
                            _maleNameController.text.toString(),
                            _maleBirthDateController.text.toString(),
                            _maleBirthTimeController.text.toString(),
                            _maleTimezone.text.toString(),
                            _maleLatitude.text.toString(),
                            _maleLongitude.text.toString(),
                            _maleBirthPlaceController.text.toString(),
                              "",
                            _femaleNameController.text.toString(),
                            _femaleBirthDateController.text.toString(),
                            _femaleBirthTimeController.text.toString(),
                            _femaleTimezone.text.toString(),
                            _femalelatitude.text.toString(),
                            _femalelongitude.text.toString(),
                            _femaleBirthPlaceController.text.toString(),
                            appLanguage,
                          ),
                        );
                      }
                    } else if (title.contains(AppStrings.editKundliMatching.tr)) {
                      _formKey.currentState!.validate();
                      if (_formKey.currentState!.validate()) {
                        String? appLanguage = await SharedPreferencesHelper.getData(AppConstants.appLanguage);
                        appLanguage ??= 'en';
                        controller.updateKundliMatching(
                          controller.updateId.toString(),
                          AppConstants.vedicAstro,
                          AppConstants.kundliMatching,
                          KundliMatchData(
                            _maleNameController.text.toString(),
                            _maleBirthDateController.text.toString(),
                            _maleBirthTimeController.text.toString(),
                            _maleTimezone.text.toString(),
                            _maleLatitude.text.toString(),
                            _maleLongitude.text.toString(),
                            _maleBirthPlaceController.text.toString(),
                            "",
                            _femaleNameController.text.toString(),
                            _femaleBirthDateController.text.toString(),
                            _femaleBirthTimeController.text.toString(),
                            _femaleTimezone.text.toString(),
                            _femalelatitude.text.toString(),
                            _femalelongitude.text.toString(),
                            _femaleBirthPlaceController.text.toString(),
                            appLanguage,
                          ),
                        );
                      }
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
