import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/common_methods.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../../utill/shared_preference.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_dialog_widget.dart';
import '../../widget/custom_elevated_button.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_progress_indicator.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/custom_text_regular.dart';
import '../searchPlace/search_place_screen.dart';
import 'controller/ask_question_profile_controller.dart';

class AskQuestionProfileScreen extends GetView<AskQuestionProfileController> {
  AskQuestionProfileScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _birthPlaceFocusNode = FocusNode();
  final FocusNode _birthDateFocusNode = FocusNode();
  final FocusNode _birthTimeFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    String type = "add";
    String profileId = "";
    if(Get.arguments != null){
      type = Get.arguments["type"];
      profileId = Get.arguments["id"];
    }

    if(type == "edit"){
      controller.getProfile(profileId);
    }else {
      controller.isProfileSuccess.value = true;
    }


    return PopScope(
      onPopInvoked: (bool isPopGesture) {
        if (!isPopGesture) {
          Get.offNamed('/ask_question_screen_new',arguments: {
            "price": controller.perQuestionPrice,
            "uniId": controller.userUniId,
          });
        }
      },
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            title: type == "add" ? "Add New Profile" : "Edit Profile",
            onBackPressed: () {
              Get.offNamed('/ask_question_screen_new',arguments: {
                "price": controller.perQuestionPrice,
                "uniId": controller.userUniId,
              });
            },
          ),
          body: Obx(
            () {
              if (controller.isProfileSuccess.isTrue) {
                return Stack(
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
                                      vertical:
                                          Dimensions.paddingSizeMediumSmall,
                                      horizontal:
                                          Dimensions.paddingSizeExtraOverSmall),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const CustomText(hintText: "Name"),
                                        const SizedBox(
                                            height:
                                                Dimensions.sizedBoxExtraSmall),
                                        CustomTextField(
                                          controller: controller.nameController,
                                          hintText: 'Enter your full name',
                                          keyboardType: TextInputType.name,
                                          focusNode: _nameFocusNode,
                                          onSubmitted: (_) =>
                                              _emailFocusNode.requestFocus(),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return AppStrings.formError.tr;
                                            } else if (!RegExp(
                                                    r'^[a-zA-Z0-9 ]*$')
                                                .hasMatch(value)) {
                                              return AppStrings
                                                  .specialCharacterError.tr;
                                            }
                                            return null;
                                          },
                                        ),
                                        const Gap(Dimensions.gapMedium),
                                        const CustomText(hintText: "Gender"),
                                        const SizedBox(
                                            height:
                                                Dimensions.sizedBoxExtraSmall),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: Dimensions
                                                .paddingSizeMediumSmall,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.borderRadiusDefault),
                                          ),
                                          child: Obx(() => Row(
                                                children: [
                                                  CustomTextRegular("Gender"),
                                                  const Gap(10),
                                                  Expanded(
                                                    child:
                                                        RadioListTile<String>(
                                                      fillColor:
                                                          const WidgetStatePropertyAll(
                                                              ColorResources
                                                                  .colorPrimary),
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      title: CustomTextRegular(
                                                          'Male'),
                                                      value: 'male',
                                                      groupValue: controller
                                                          .selectedGender.value,
                                                      onChanged: (value) {
                                                        controller.setGender(
                                                            value!); // Update gender value
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child:
                                                        RadioListTile<String>(
                                                      fillColor:
                                                          const WidgetStatePropertyAll(
                                                              ColorResources
                                                                  .colorPrimary),
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      title: CustomTextRegular(
                                                          'Female'),
                                                      value: 'female',
                                                      groupValue: controller
                                                          .selectedGender.value,
                                                      onChanged: (value) {
                                                        controller.setGender(
                                                            value!); // Update gender value
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        const Gap(Dimensions.gapMedium),
                                        const CustomText(
                                            hintText: "Date of Birth"),
                                        const SizedBox(
                                            height:
                                                Dimensions.sizedBoxExtraSmall),
                                        GestureDetector(
                                          onTap: () async {
                                            CommonMethods()
                                                .showDatePickerDialog(
                                                    context,
                                                    controller
                                                        .birthDateController);
                                          },
                                          child: CustomTextField(
                                            controller:
                                                controller.birthDateController,
                                            hintText: 'Date of Birth',
                                            enabled: false,
                                            focusNode: _birthDateFocusNode,
                                            onSubmitted: (_) =>
                                                _birthTimeFocusNode
                                                    .requestFocus(),
                                          ),
                                        ),
                                        const Gap(Dimensions.gapMedium),
                                        const CustomText(
                                            hintText: "Time of Birth"),
                                        const SizedBox(
                                            height:
                                                Dimensions.sizedBoxExtraSmall),
                                        GestureDetector(
                                          onTap: () async {
                                            CommonMethods()
                                                .showTimerPickerDialog(
                                                    context,
                                                    controller
                                                        .birthTimeController);
                                          },
                                          child: CustomTextField(
                                            controller:
                                                controller.birthTimeController,
                                            hintText: 'Time of Birth',
                                            enabled: false,
                                            focusNode: _birthTimeFocusNode,
                                            onSubmitted: (_) =>
                                                _birthPlaceFocusNode
                                                    .requestFocus(),
                                          ),
                                        ),
                                        const Gap(Dimensions.gapMedium),
                                        const CustomText(
                                            hintText: "Place of Birth"),
                                        const SizedBox(
                                            height:
                                                Dimensions.sizedBoxExtraSmall),
                                        GestureDetector(
                                          onTap: () async {
                                            String? placeApiKey = await SharedPreferencesHelper.getData(AppConstants.placeApiKey);
                                            var result = await Get.to(SearchPlaceScreen(placeApiKey.toString()));
                                            if (result != null) {
                                              controller.birthPlaceController
                                                      .text =
                                                  result['name'].toString();
                                              controller.latitude.text =
                                                  result['latitude'].toString();
                                              controller.longitude.text =
                                                  result['longitude']
                                                      .toString();
                                            }
                                          },
                                          child: CustomTextField(
                                            controller:
                                                controller.birthPlaceController,
                                            hintText: 'Select Birth Place',
                                            enabled: false,
                                            focusNode: _birthPlaceFocusNode,
                                          ),
                                        ),
                                        const Gap(Dimensions.gapMedium),
                                        const CustomText(
                                            hintText: "Select Language"),
                                        const SizedBox(
                                            height:
                                                Dimensions.sizedBoxExtraSmall),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: Dimensions
                                                .paddingSizeMediumSmall,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.borderRadiusDefault),
                                          ),
                                          child: Obx(() => Row(
                                                children: [
                                                  CustomTextRegular("Language"),
                                                  const Gap(10),
                                                  Expanded(
                                                    child:
                                                        RadioListTile<String>(
                                                      fillColor:
                                                          const WidgetStatePropertyAll(
                                                              ColorResources
                                                                  .colorPrimary),
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      title: CustomTextRegular(
                                                          'English'),
                                                      value: 'English',
                                                      groupValue: controller
                                                          .selectedLanguage
                                                          .value,
                                                      onChanged: (value) {
                                                        controller.setLanguage(value
                                                            .toString()); // Update gender value
                                                      },
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child:
                                                        RadioListTile<String>(
                                                      fillColor:
                                                          const WidgetStatePropertyAll(
                                                              ColorResources
                                                                  .colorPrimary),
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      title: CustomTextRegular(
                                                          'Hindi'),
                                                      value: 'Hindi',
                                                      groupValue: controller
                                                          .selectedLanguage
                                                          .value,
                                                      onChanged: (value) {
                                                        controller.setLanguage(value
                                                            .toString()); // Update gender value
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                        const Gap(Dimensions.gapMedium),
                                        const SizedBox(
                                            height: Dimensions.sizedBoxSmall),
                                        CustomElevatedButton(
                                          text: type == "edit" ? "UPDATE" : "ADD PROFILE",
                                          backgroundColor: ColorResources.colorPrimary,
                                          textColor: ColorResources.toolbarText,
                                          onPressed: () async {
                                            if (_formKey.currentState!.validate()) {
                                              if(type == "edit"){
                                                controller.updateProfile(
                                                  profileId,
                                                  controller.nameController.text
                                                      .toString(),
                                                  CommonMethods()
                                                      .convertDateInput(controller
                                                      .birthDateController
                                                      .text
                                                      .toString()),
                                                  CommonMethods()
                                                      .convertTimeInput(controller
                                                      .birthTimeController
                                                      .text
                                                      .toString()),
                                                  controller
                                                      .birthPlaceController.text
                                                      .toString(),
                                                  controller.latitude.text
                                                      .toString(),
                                                  controller.longitude.text
                                                      .toString(),
                                                  controller.selectedGender.value,
                                                  controller
                                                      .selectedLanguage.value,
                                                );
                                              }else{
                                                controller.addProfile(
                                                  controller.nameController.text
                                                      .toString(),
                                                  CommonMethods()
                                                      .convertDateInput(controller
                                                      .birthDateController
                                                      .text
                                                      .toString()),
                                                  CommonMethods()
                                                      .convertTimeInput(controller
                                                      .birthTimeController
                                                      .text
                                                      .toString()),
                                                  controller
                                                      .birthPlaceController.text
                                                      .toString(),
                                                  controller.latitude.text
                                                      .toString(),
                                                  controller.longitude.text
                                                      .toString(),
                                                  controller.selectedGender.value,
                                                  controller
                                                      .selectedLanguage.value,
                                                );
                                              }

                                            }
                                          },
                                        ),
                                        const Gap(Dimensions.gapDefault),
                                        if(type == "edit")
                                        CustomElevatedButton(
                                          onPressed: (){
                                            Get.dialog(
                                                CustomDialogWidget(
                                                    imagePath: Images.delete,
                                                    title: AppStrings.delete.tr,
                                                    onYesPressed: () {
                                                      controller.deleteProfile(profileId);
                                                    },
                                                    description: "Are you sure, you want to delete this profile?"
                                                ),
                                                barrierDismissible: false
                                            );
                                          },
                                          text: "Delete",
                                          backgroundColor: ColorResources.red,
                                          textColor: ColorResources.toolbarText,
                                        ),
                                        const SizedBox(height: Dimensions.sizedBoxSmall),
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
                      () => controller.isUpdateLoading.value
                          ? const CustomProgressIndicator()
                          : const SizedBox.shrink(),
                    ),
                  ],
                );
              } else if (controller.isProfileLoading.isTrue) {
                return const CustomProgressIndicator();
              } else {
                return const EmptyScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
