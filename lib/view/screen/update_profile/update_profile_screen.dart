import 'dart:io';
import 'dart:ui';

import 'package:astro_brahmand/view/screen/splash/controller/config_controller.dart';
import 'package:astro_brahmand/view/widget/custom_round_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/view/screen/update_profile/controller/update_profile_controller.dart';
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:astro_brahmand/view/widget/custom_image_picker.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/common_methods.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../../utill/shared_preference.dart';
import '../../widget/custom_elevated_button.dart';
import '../../widget/custom_network_image.dart';
import '../../widget/custom_progress_indicator.dart';
import '../../widget/custom_text_field.dart';
import '../searchPlace/search_place_screen.dart';

class UpdateProfileScreen extends GetView<UpdateProfileController> {
  UpdateProfileScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _birthPlaceFocusNode = FocusNode();
  final FocusNode _birthDateFocusNode = FocusNode();
  final FocusNode _birthTimeFocusNode = FocusNode();
  File? _customerImg;

  @override
  Widget build(BuildContext context) {

    dynamic arguments = Get.arguments;
    String type = '';
    String email = '';
    String mobile = '';
    String name = '';
    String regionCode = '';

    if (arguments != null && arguments is Map<String, dynamic>) {
      type = arguments['type'] ?? '';
      email = arguments['email'] ?? '';
      mobile = arguments['mobile'] ?? '';
      name = arguments['name'] ?? '';
      regionCode = arguments['regionCode'] ?? '';
    }


    controller.mobileController.text = mobile;
    controller.emailController.text = email;
    controller.nameController.text = name;
    controller.countryCode.value = regionCode;

    if (type.isNotEmpty && type == "Update") {
      controller.initData();
    }

    return PopScope(
      onPopInvoked: (bool isPopGesture) {
        if (!isPopGesture) {
          if (Get.key.currentState?.canPop() ?? false) {
            Get.back();
          } else {
            Get.offAllNamed('/login');
          }
        }
      },
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: type == "Register" ? AppStrings.registration.tr : AppStrings.profile.tr ,onBackPressed: (){
            if (Get.key.currentState?.canPop() ?? false) {
              Get.back();
            } else {
              Get.offAllNamed('/login');
            }
          },),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeExtraSmall,
                        ),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeMediumSmall,
                                horizontal: Dimensions.paddingSizeExtraOverSmall),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: type == "Update"
                                        ? Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        FutureBuilder<String?>(
                                          future: CommonMethods().getProfileImage(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const CircularProgressIndicator();
                                            } else if (snapshot.hasError) {
                                              return Text('Error: ${snapshot.error}');
                                            } else {
                                              return snapshot.data.toString() == "***" ?
                                              Image.asset(Images.updateProfile, height: 100,width: 100,)
                                                  : GestureDetector(
                                                onTap: () {
                                                  openProfileDialog(snapshot.data.toString());
                                                },

                                                child: CustomRoundNetworkImage(
                                                    imageUrl: snapshot.data.toString(),
                                                    height:  100,
                                                    width: 100),
                                              );
                                            }
                                          },
                                        ),
                                        Positioned(
                                          right: -25,
                                          bottom: 0,
                                          child: CustomImagePicker(
                                            uniqueKey: "customerImg",
                                            defaultImagePath: Images.addCamera,
                                            width: 30,
                                            height: 30,
                                            onImageChanged: (imageFile) {
                                              if (imageFile != null) {
                                                _customerImg = imageFile;
                                              } else {
                                                _customerImg = null;
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                        : CustomImagePicker(
                                      uniqueKey: "customerImg",
                                      defaultImagePath: Images.addCamera,
                                      width: 100,
                                      height: 100,
                                      onImageChanged: (imageFile) {
                                        if (imageFile != null) {
                                          _customerImg = imageFile;
                                        } else {
                                          _customerImg = null;
                                        }
                                      },
                                    ),
                                  ),
                                  const Gap(5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomTextRegular("Profile picture",
                                          fontSize: Dimensions.fontSizeSmall,
                                          color: ColorResources.black4),
                                    ],
                                  ),
                                  if (mobile.isNotEmpty || email.isNotEmpty || type == "Update")
                                    ...[
                                      if (mobile.isNotEmpty)
                                        TextFormField(
                                          controller: controller.mobileController,
                                          style: const TextStyle(
                                            color: ColorResources.black,
                                            fontSize: Dimensions.fontSizeDefault,
                                          ),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            isDense: true,
                                          ),
                                          enabled: false,
                                          textAlign: TextAlign.center,
                                        ),

                                      if (email.isNotEmpty)
                                        TextFormField(
                                          controller: controller.emailController,
                                          style: const TextStyle(
                                            color: ColorResources.black,
                                            fontSize: Dimensions.fontSizeDefault,
                                          ),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            isDense: true,
                                          ),
                                          enabled: false,
                                          textAlign: TextAlign.center,
                                        ),

                                      if (type == "Update")
                                        TextFormField(
                                          controller: controller.emailController,
                                          style: const TextStyle(
                                            color: ColorResources.black,
                                            fontSize: Dimensions.fontSizeDefault,
                                          ),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            isDense: true,
                                          ),
                                          enabled: false,
                                          textAlign: TextAlign.center,
                                        ),

                                      // const Gap(Dimensions.gapMedium),
                                    ],
                                  /*TextFormField(
                                    controller: controller.mobileController,
                                    style: const TextStyle(
                                        color: ColorResources.black,
                                        fontSize: Dimensions.fontSizeDefault),
                                    decoration: const InputDecoration(
                                      hintText: 'Mobile',
                                      border: InputBorder.none,
                                      // contentPadding: EdgeInsets.zero,
                                      isDense: true,
                                    ),
                                    enabled: false,
                                    textAlign: TextAlign.center,
                                  ),*/
                                  const Gap(Dimensions.gapMedium),
                                  CustomText(hintText: AppStrings.name.tr),
                                  const SizedBox(
                                      height: Dimensions.sizedBoxExtraSmall),
                                  CustomTextField(
                                    controller: controller.nameController,
                                    hintText: AppStrings.enterFullName.tr,
                                    keyboardType: TextInputType.name,
                                    focusNode: _nameFocusNode,
                                    onSubmitted: (_) =>
                                        _emailFocusNode.requestFocus(),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppStrings.formError.tr;
                                      } else if (!RegExp(r'^[a-zA-Z0-9 ]*$')
                                          .hasMatch(value)) {
                                        return AppStrings.specialCharacterError.tr;
                                      }
                                      return null;
                                    },
                                  ),

                                  if(type == "Register" && email.isNotEmpty)
                                    const Gap(10),
                                  if(type == "Register" && email.isNotEmpty)
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Gap(Dimensions.gapMedium),
                                        const CustomText(hintText: "Phone Number"),
                                        const SizedBox(height: Dimensions.sizedBoxSmall),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                                          ),
                                          clipBehavior: Clip.antiAlias,
                                          child: Row(
                                            children: [
                                              CountryCodePicker(
                                                onChanged: (CountryCode code) {
                                                  controller.updateCountryCode(code);
                                                },
                                                initialSelection: regionCode,
                                                favorite: const ['IN', 'US'],
                                                enabled: false,
                                              ),
                                              const Gap(5),
                                              Expanded(
                                                child: TextFormField(
                                                  controller: controller.mobileController,
                                                  onChanged: (value) {
                                                    if(controller.countryCode.value == "+91"){
                                                      if (value.length == 10) {
                                                        FocusManager.instance.primaryFocus?.unfocus();
                                                      }
                                                    }
                                                  },
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return AppStrings.phoneError.tr;
                                                    } else if (controller.countryCode.value == "+91" && controller.mobileController.text.length != 10) {
                                                      return AppStrings.validPhoneError.tr;
                                                    }
                                                    return null;
                                                  },
                                                  keyboardType: TextInputType.phone,
                                                  decoration: const InputDecoration(
                                                    hintText: "Enter your phone number",
                                                    hintStyle: TextStyle(
                                                        fontSize: Dimensions.fontSizeDefault,
                                                        fontWeight: FontWeight.w400,
                                                        letterSpacing: 0.5,
                                                        color: ColorResources.black1),
                                                    border: InputBorder.none,
                                                    contentPadding: EdgeInsets.zero,
                                                    isDense: true,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                  if(type == "Register" && mobile.isNotEmpty)
                                    const Gap(Dimensions.gapMedium),
                                  if(type == "Register" && mobile.isNotEmpty)
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomText(hintText: AppStrings.email.tr),
                                        const SizedBox(
                                            height: Dimensions.sizedBoxExtraSmall),
                                        SizedBox(
                                          child: CustomTextField(
                                            controller: controller.emailController,
                                            hintText: 'example@mail.com',
                                            keyboardType: TextInputType.emailAddress,
                                            focusNode: _emailFocusNode,
                                            onSubmitted: (_) => _birthDateFocusNode.requestFocus(),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return AppStrings.formError.tr;
                                              } else if (!RegExp(
                                                  r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
                                                  .hasMatch(value)) {
                                                return AppStrings.formEmailError.tr;
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),

                                  /*const Gap(Dimensions.gapMedium),
                                  CustomText(hintText: AppStrings.email.tr),
                                  const SizedBox(
                                      height: Dimensions.sizedBoxExtraSmall),
                                  SizedBox(
                                    child: CustomTextField(
                                      controller: controller.emailController,
                                      hintText: 'example@mail.com',
                                      keyboardType: TextInputType.emailAddress,
                                      focusNode: _emailFocusNode,
                                      onSubmitted: (_) => _birthDateFocusNode.requestFocus(),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return AppStrings.formError.tr;
                                        } else if (!RegExp(
                                                r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
                                            .hasMatch(value)) {
                                          return AppStrings.formEmailError.tr;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),*/
                                  // const SizedBox(height: Dimensions.sizedBoxSmall),
                                  const Gap(Dimensions.gapMedium),
                                  CustomText(hintText: AppStrings.gender.tr),
                                  const SizedBox(height: Dimensions.sizedBoxExtraSmall),

                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.paddingSizeMediumSmall,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                                    ),
                                    child: Obx(() =>  Row(
                                      children: [
                                        CustomTextRegular(AppStrings.gender.tr),
                                        const Gap(10),
                                        Expanded(
                                          child: RadioListTile<String>(
                                            fillColor: const WidgetStatePropertyAll(ColorResources.colorPrimaryDark),
                                            contentPadding: EdgeInsets.zero,
                                            title: CustomTextRegular(AppStrings.male.tr),
                                            value: 'male',
                                            groupValue: controller.selectedGender.value,
                                            onChanged: (value) {
                                              controller.setGender(value!); // Update gender value
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: RadioListTile<String>(
                                            fillColor: const WidgetStatePropertyAll(ColorResources.colorPrimaryDark),
                                            contentPadding: EdgeInsets.zero,
                                            title: CustomTextRegular(AppStrings.female.tr),
                                            value: 'female',
                                            groupValue: controller.selectedGender.value,
                                            onChanged: (value) {
                                              controller.setGender(value!); // Update gender value
                                            },
                                          ),
                                        ),

                                      ],
                                    )),
                                  ),

                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //     border: Border.all(),
                                  //     borderRadius: BorderRadius.circular(
                                  //         Dimensions.borderRadiusDefault),
                                  //   ),
                                  //   child: CustomGenderWidget(
                                  //     onGenderChanged: (value) {
                                  //       controller.setGender(value!);
                                  //     },
                                  //     selectedGender: controller.genderValue,
                                  //   ),
                                  // ),
                                  // Obx(() => Text('Selected Gender: ${controller.selectedGender.value}')),

                                  const Gap(Dimensions.gapMedium),
                                  CustomText(hintText: AppStrings.dateOfBirth.tr),
                                  const SizedBox(height: Dimensions.sizedBoxExtraSmall),

                                  GestureDetector(
                                    onTap: () async {
                                      CommonMethods().showDatePickerDialog(
                                          context,
                                          controller.birthDateController);
                                    },
                                    child: CustomTextField(
                                      controller: controller.birthDateController,
                                      hintText: AppStrings.dateOfBirth.tr,
                                      enabled: false,
                                      focusNode: _birthDateFocusNode,
                                      onSubmitted: (_) =>
                                          _birthTimeFocusNode.requestFocus(),
                                    ),
                                  ),

                                  const Gap(Dimensions.gapMedium),

                                  CustomText(hintText: AppStrings.timeOfBirth.tr),
                                  const SizedBox(
                                      height: Dimensions.sizedBoxExtraSmall),
                                  GestureDetector(
                                    onTap: () async {
                                      CommonMethods().showTimerPickerDialog(
                                          context,
                                          controller.birthTimeController);
                                    },
                                    child: CustomTextField(
                                      controller: controller.birthTimeController,
                                      hintText: AppStrings.timeOfBirth.tr,
                                      enabled: false,
                                      focusNode: _birthTimeFocusNode,
                                      onSubmitted: (_) =>
                                          _birthPlaceFocusNode.requestFocus(),
                                    ),
                                  ),

                                  const Gap(Dimensions.gapMedium),

                                  CustomText(hintText: AppStrings.placeOfBirth.tr),
                                  const SizedBox(
                                      height: Dimensions.sizedBoxExtraSmall),

                                  GestureDetector(
                                    onTap: () async {
                                      String? placeApiKey = await SharedPreferencesHelper.getData(AppConstants.placeApiKey);
                                      var result = await Get.to(SearchPlaceScreen(placeApiKey.toString()));
                                      if (result != null) {
                                        controller.birthPlaceController.text = result['name'].toString();
                                        controller.latitude.text = result['latitude'].toString();
                                        controller.longitude.text = result['longitude'].toString();
                                        controller.timezone.text = result['offset'].toString();
                                      }
                                    },
                                    child: CustomTextField(
                                      controller: controller.birthPlaceController,
                                      hintText: AppStrings.selectBirthPlace.tr,
                                      enabled: false,
                                      focusNode: _birthPlaceFocusNode,
                                    ),
                                  ),

                                  const Gap(Dimensions.gapMedium),

                                  const SizedBox(height: Dimensions.sizedBoxSmall),
                                  CustomElevatedButton(
                                    text: AppStrings.submit.tr.toUpperCase(),
                                    backgroundColor: ColorResources.colorPrimary,
                                    textColor: ColorResources.toolbarText,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        String phoneNumber = (type == "Register" && mobile.isEmpty)
                                            ? controller.countryCode.value + controller.mobileController.text.toString()
                                            : controller.mobileController.text.toString();
                                        controller.updateProfile(
                                            _customerImg,
                                            controller.nameController.text.toString(),
                                            controller.emailController.text.toString(),
                                            phoneNumber,
                                            // controller.mobileController.text.toString(),
                                            CommonMethods().convertDateInput(controller.birthDateController.text.toString()),
                                            CommonMethods().convertTimeInput(controller.birthTimeController.text.toString()),
                                            controller.birthPlaceController.text.toString(),
                                            controller.latitude.text.toString(),
                                            controller.longitude.text.toString(),
                                            controller.timezone.text.toString(),
                                            controller.selectedGender.value,
                                            type
                                        );
                                      }
                                    },
                                  ),

                                  const SizedBox(
                                      height: Dimensions.sizedBoxSmall),
                                ],
                              ),
                            )),
                      ),
                      const SizedBox(height: Dimensions.sizedBoxSmall),
                    ],
                  ),
                ),
              ),
              Obx(
                    () => controller.isLoading.value
                    ? const CustomProgressIndicator()
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void openProfileDialog(String imageUrl) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            // Blurred background
            Center(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0)),
                  ),
                )
            ),
            Center(
              child: ClipOval(
                // borderRadius: BorderRadius.circular(50.0),
                child: Container(
                  color: Colors.transparent,
                  width: Get.width * 0.8,
                  height: Get.width * 0.75,
                  child: CustomNetworkImage(imageUrl: imageUrl, height: Get.height * 0.5,fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
