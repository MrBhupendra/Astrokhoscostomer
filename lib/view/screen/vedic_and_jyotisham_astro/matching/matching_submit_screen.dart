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

    if(title == "Edit Match Matching"){
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
                    TextFormField(
                      controller: _maleNameController,
                      focusNode: _maleNameFocusNode,
                      decoration: InputDecoration(

                        contentPadding: const EdgeInsets.all(0.0),
                        filled: true,
                        fillColor: ColorResources.colorPrimaryLight,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Enter your full name',
                        hintStyle: const TextStyle(
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                          color: ColorResources.black1,
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: ColorResources.colorPrimaryDark,
                          size: 20,
                        ),
                      ),
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

                    GestureDetector(
                      onTap: () async {
                        CommonMethods().showDatePickerDialog(context,_maleBirthDateController);
                      },
                      child:TextFormField(
                          controller: _maleBirthDateController,
                          style: const TextStyle(
                              color: ColorResources.black1,
                              fontSize: Dimensions.fontSizeDefault),
                          decoration: InputDecoration(
                            contentPadding:
                            const EdgeInsets.only(left: 8.0),
                            filled: true,
                            fillColor:
                            ColorResources.colorPrimaryLight,
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Select date',
                            hintStyle: const TextStyle(
                                fontSize:
                                Dimensions.fontSizeDefault,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                                color: ColorResources.black1),
                            enabled: false,
                            prefixIcon: const Icon(
                              CupertinoIcons.calendar,
                              color:
                              ColorResources.colorPrimaryDark,
                              size: 20,
                            ),
                          ),
                        onFieldSubmitted: (_) => _maleBirthTimeFocusNode.requestFocus(),
                          focusNode: _maleBirthdateFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.formError.tr;
                            }
                            return null;
                          },
                        )

                    ),

                    const Gap(Dimensions.gapLarge),
                    CustomText(hintText: AppStrings.timeOfBirth.tr),
                    const SizedBox(height: Dimensions.sizedBoxExtraSmall),

                    GestureDetector(
                      onTap: () async {
                        CommonMethods().showTimerPickerDialog(context,_maleBirthTimeController);
                      },
                      child: TextFormField(
                          controller: _maleBirthTimeController,
                          style: const TextStyle(
                              color: ColorResources.black1,
                              fontSize: Dimensions.fontSizeDefault),
                          decoration: InputDecoration(
                            contentPadding:
                            const EdgeInsets.only(left: 8.0),
                            filled: true,
                            fillColor:
                            ColorResources.colorPrimaryLight,
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Select time',
                            hintStyle: const TextStyle(
                                fontSize:
                                Dimensions.fontSizeDefault,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                                color: ColorResources.black1),
                            enabled: false,
                            prefixIcon: const Icon(
                              CupertinoIcons.clock_fill,
                              color:
                              ColorResources.colorPrimaryDark,
                              size: 20,
                            ),
                          ),
                          onFieldSubmitted: (_) => _maleBirthPlaceFocusNode.requestFocus(),
                          focusNode: _maleBirthTimeFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.formError.tr;
                            }
                            return null;
                          },

                        )

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
                          _maleTimezone.text = result['offset'].toString();
                        }
                      },
                      child: TextFormField(
                          controller: _maleBirthPlaceController,
                          style: const TextStyle(
                              color: ColorResources.black1,
                              fontSize: Dimensions.fontSizeDefault),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(0.0),
                              filled: true,
                              fillColor: ColorResources.colorPrimaryLight,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Select birth place',
                              hintStyle: const TextStyle(
                                  fontSize: Dimensions.fontSizeDefault,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5,
                                  color: ColorResources.black1),
                              prefixIcon: const Icon(
                                CupertinoIcons.building_2_fill,
                                color: ColorResources.colorPrimaryDark,
                                size: 20,
                              ),
                              enabled: false),
                          focusNode: _maleBirthPlaceFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.formError.tr;
                            }
                            return null;
                          },
                        )


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
                    TextFormField(
                      controller: _femaleNameController,
                      focusNode: _femaleNameFocusNode,
                      decoration: InputDecoration(

                        contentPadding: const EdgeInsets.all(0.0),
                        filled: true,
                        fillColor: ColorResources.colorPrimaryLight,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Enter your full name',
                        hintStyle: const TextStyle(
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                          color: ColorResources.black1,
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: ColorResources.colorPrimaryDark,
                          size: 20,
                        ),
                      ),
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
                    CustomText(hintText:AppStrings.dateOfBirth.tr),
                    const SizedBox(height: Dimensions.sizedBoxExtraSmall),
                    GestureDetector(
                      onTap: () async {
                        CommonMethods().showDatePickerDialog(context,_femaleBirthDateController);
                      },
                      child: TextFormField(
                          controller: _femaleBirthDateController,
                          style: const TextStyle(
                              color: ColorResources.black1,
                              fontSize: Dimensions.fontSizeDefault),
                          decoration: InputDecoration(
                            contentPadding:
                            const EdgeInsets.only(left: 8.0),
                            filled: true,
                            fillColor:
                            ColorResources.colorPrimaryLight,
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Select date',
                            hintStyle: const TextStyle(
                                fontSize:
                                Dimensions.fontSizeDefault,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                                color: ColorResources.black1),
                            enabled: false,
                            prefixIcon: const Icon(
                              CupertinoIcons.calendar,
                              color:
                              ColorResources.colorPrimaryDark,
                              size: 20,
                            ),
                          ),
                          onFieldSubmitted: (_) =>_femaleBirthTimeFocusNode.requestFocus(),
                          focusNode: _femaleBirthdateFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.formError.tr;
                            }
                            return null;
                          },
                        )



                    ),
                    const Gap(Dimensions.gapLarge),
                    CustomText(hintText: AppStrings.timeOfBirth.tr),
                    const SizedBox(height: Dimensions.sizedBoxExtraSmall),
                    GestureDetector(
                      onTap: () async {
                        CommonMethods().showTimerPickerDialog(context,_femaleBirthTimeController);
                      },
                      child: TextFormField(
                          controller: _femaleBirthTimeController,
                          style: const TextStyle(
                              color: ColorResources.black1,
                              fontSize: Dimensions.fontSizeDefault),
                          decoration: InputDecoration(
                            contentPadding:
                            const EdgeInsets.only(left: 8.0),
                            filled: true,
                            fillColor:
                            ColorResources.colorPrimaryLight,
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Select time',
                            hintStyle: const TextStyle(
                                fontSize:
                                Dimensions.fontSizeDefault,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                                color: ColorResources.black1),
                            enabled: false,
                            prefixIcon: const Icon(
                              CupertinoIcons.clock_fill,
                              color:
                              ColorResources.colorPrimaryDark,
                              size: 20,
                            ),
                          ),
                          onFieldSubmitted: (_) => _femaleBirthPlaceFocusNode.requestFocus(),
                          focusNode: _femaleBirthTimeFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.formError.tr;
                            }
                            return null;
                          },

                        )

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
                          _femaleTimezone.text = result['offset'].toString();
                        }
                      },
                      child: TextFormField(
                          controller: _femaleBirthPlaceController,
                          style: const TextStyle(
                              color: ColorResources.black1,
                              fontSize: Dimensions.fontSizeDefault),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(0.0),
                              filled: true,
                              fillColor: ColorResources.colorPrimaryLight,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Select birth place',
                              hintStyle: const TextStyle(
                                  fontSize: Dimensions.fontSizeDefault,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5,
                                  color: ColorResources.black1),
                              prefixIcon: const Icon(
                                CupertinoIcons.building_2_fill,
                                color: ColorResources.colorPrimaryDark,
                                size: 20,
                              ),
                              enabled: false),
                          focusNode: _femaleBirthPlaceFocusNode,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.formError.tr;
                            }
                            return null;
                          },
                        )

                    ),
                    const Gap(Dimensions.gapExtraLarge),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault),
                child: CustomElevatedButton(
                  text: title.contains('Create Kundli Matching') ? 'Create Kundli Matching' : 'Edit Match Matching',
                  backgroundColor: ColorResources.colorPrimary,
                  textColor: ColorResources.toolbarText,
                  onPressed: () async {
                    if (title.contains('Create Kundli Matching')) {
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
                    } else if (title.contains('Edit Match Matching')) {
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
