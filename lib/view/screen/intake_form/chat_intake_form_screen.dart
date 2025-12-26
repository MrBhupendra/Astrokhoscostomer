import 'package:astro_brahmand/view/screen/chat/controller/chat_intake_form_controller.dart';
import 'package:astro_brahmand/view/widget/custom_checkbox.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/common_methods.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/shared_preference.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_elevated_button.dart';
import '../../widget/custom_text_field.dart';
import '../../widget/custom_text_regular.dart';
import '../searchPlace/search_place_screen.dart';
import '../splash/controller/config_controller.dart';

class ChatIntakeFormScreen extends StatelessWidget {
  ChatIntakeFormScreen({super.key});

  final ChatIntakeFormController chatIntakeFormController = Get.find();
  final ConfigController configController = Get.find();

  final _formKey = GlobalKey<FormState>();
  final _partnerFormKey = GlobalKey<FormState>();

  final List<String> maritalStatusItems = [
    'Single',
    'Married',
    'Divorced',
    'Separated',
    'Widowed'
  ];
  final selectedMaritalStatus = ''.obs;

  final List<String> concernTopicItems = [
    'Career and Business',
    'Marriage',
    'Love and Relationship',
    'Wealth and Property',
    'Education',
    'Other'
  ];
  final selectedConcernTopic = ''.obs;

  final isOtherSelected = 0.obs;

  //Partner Detail
  final isPartnerSelected = 0.obs;

  @override
  Widget build(BuildContext context) {
    chatIntakeFormController.initData();
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(
          title: chatIntakeFormController.callType == AppConstants.call
              ? "Call Intake Form"
              : chatIntakeFormController.callType == AppConstants.chat
                  ? "Chat Intake Form"
                  : chatIntakeFormController.callType == AppConstants.video
                      ? "Video Call Intake Form"
                      : chatIntakeFormController.callType ==
                              AppConstants.emergencyChat
                          ? "Emergency Chat Intake Form"
                          : chatIntakeFormController.callType ==
                                  AppConstants.emergencyCall
                              ? "Emergency Call Intake Form"
                              : chatIntakeFormController.callType ==
                                      AppConstants.emergencyVideoCall
                                  ? "Emergency Video Call Intake Form"
                                  : "Slot Booking Form"),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeSmall,
                  vertical: Dimensions.paddingSizeSmall,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextRegular("Enter Name*"),
                          const Gap(Dimensions.gapExtraSmall),
                          CustomFormTextField(
                            controller: chatIntakeFormController.nameController,
                            hintText: 'Enter your name here',
                            prefixIcon: Icons.person,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.formError.tr;
                              }
                              return null;
                            },
                          ),
                          const Gap(Dimensions.gapMedium),
                          CustomTextRegular("Gender*"),
                          const Gap(Dimensions.gapExtraSmall),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeMediumSmall,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Obx(() => Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile<String>(
                                        fillColor: const WidgetStatePropertyAll(
                                            ColorResources.colorPrimaryDark),
                                        contentPadding: EdgeInsets.zero,
                                        visualDensity: const VisualDensity(
                                            horizontal: -4, vertical: -4),
                                        title: CustomTextRegular('Male'),
                                        value: 'male',
                                        groupValue: chatIntakeFormController
                                            .selectedGender.value,
                                        onChanged: (value) {
                                          chatIntakeFormController.updateGender(
                                              value!); // Update gender value
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile<String>(
                                        fillColor: const WidgetStatePropertyAll(
                                            ColorResources.colorPrimaryDark),
                                        contentPadding: EdgeInsets.zero,
                                        visualDensity: const VisualDensity(
                                            horizontal: -4, vertical: -4),
                                        title: CustomTextRegular('Female'),
                                        value: 'female',
                                        groupValue: chatIntakeFormController
                                            .selectedGender.value,
                                        onChanged: (value) {
                                          chatIntakeFormController.updateGender(
                                              value!); // Update gender value
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          const Gap(Dimensions.gapMedium),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextRegular("Birth Date*"),
                                    const Gap(Dimensions.gapExtraSmall),
                                    CustomFormTextField(
                                      controller: chatIntakeFormController
                                          .birthDateController,
                                      hintText: 'Select date',
                                      prefixIcon: CupertinoIcons.calendar,
                                      enabled: false,
                                      contentPadding:
                                          const EdgeInsets.only(left: 8.0),
                                      onTap: () async {
                                        CommonMethods().showDatePickerDialog(
                                            context,
                                            chatIntakeFormController
                                                .birthDateController);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextRegular("Time*"),
                                    const Gap(Dimensions.gapExtraSmall),
                                    CustomFormTextField(
                                      controller: chatIntakeFormController
                                          .birthTimeController,
                                      hintText: 'Select time',
                                      prefixIcon: CupertinoIcons.clock_fill,
                                      enabled: false,
                                      contentPadding:
                                          const EdgeInsets.only(left: 8.0),
                                      onTap: () async {
                                        CommonMethods().showTimerPickerDialog(
                                            context,
                                            chatIntakeFormController
                                                .birthTimeController);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Gap(Dimensions.gapMedium),
                          CustomTextRegular("Birth Place*"),
                          const Gap(Dimensions.gapExtraSmall),
                          CustomFormTextField(
                            controller:
                                chatIntakeFormController.birthPlaceController,
                            hintText: 'Select birth place',
                            prefixIcon: CupertinoIcons.building_2_fill,
                            enabled: false,
                            onTap: () async {
                              String? placeApiKey =
                                  await SharedPreferencesHelper.getData(
                                      AppConstants.placeApiKey);
                              var result = await Get.to(
                                  SearchPlaceScreen(placeApiKey.toString()));
                              if (result != null) {
                                chatIntakeFormController.birthPlaceController
                                    .text = result['name'].toString();
                                chatIntakeFormController.latitudeController
                                    .text = result['latitude'].toString();
                                chatIntakeFormController.longitudeController
                                    .text = result['longitude'].toString();
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppStrings.formError.tr;
                              }
                              return null;
                            },
                          ),
                          const Gap(Dimensions.gapMedium),
                          CustomTextRegular("Marital Status"),
                          const Gap(Dimensions.gapExtraSmall),
                          CustomFormTextField(
                            controller: chatIntakeFormController
                                .maritalStatusController,
                            hintText: 'Select Marital Status',
                            prefixIcon: Icons.people,
                            enabled: false,
                            onTap: () {
                              showMenu(
                                context: context,
                                position: RelativeRect.fromLTRB(
                                    Get.width / 2,
                                    Get.height / 2,
                                    Get.height / 2,
                                    Get.height / 2),
                                items: maritalStatusItems.map((String item) {
                                  return PopupMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                              ).then((value) {
                                if (value != null) {
                                  selectedMaritalStatus.value = value;
                                  chatIntakeFormController
                                      .maritalStatusController.text = value;
                                }
                              });
                            },
                          ),
                          const Gap(Dimensions.gapMedium),
                          CustomTextRegular("Occupation"),
                          const Gap(Dimensions.gapExtraSmall),
                          CustomFormTextField(
                            controller:
                                chatIntakeFormController.occupationController,
                            hintText: 'Occupation',
                            prefixIcon: Icons.work,
                          ),
                          const Gap(Dimensions.gapMedium),
                          CustomTextRegular("Topic of Concern"),
                          const Gap(Dimensions.gapExtraSmall),
                          CustomFormTextField(
                            controller:
                                chatIntakeFormController.concernController,
                            hintText: 'Select your topic',
                            prefixIcon: Icons.account_box_sharp,
                            enabled: false,
                            onTap: () {
                              showMenu(
                                context: context,
                                position: RelativeRect.fromLTRB(
                                    Get.width / 2,
                                    Get.height / 2,
                                    Get.width / 2,
                                    Get.height / 2),
                                items: concernTopicItems.map((String item) {
                                  return PopupMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                              ).then((value) {
                                if (value != null) {
                                  if (value == 'Other') {
                                    isOtherSelected.value = 1;
                                  } else {
                                    isOtherSelected.value = 0;
                                  }
                                  selectedConcernTopic.value = value;
                                  chatIntakeFormController
                                      .concernController.text = value;
                                }
                              });
                            },
                          ),
                          const Gap(Dimensions.gapMedium),
                          Obx(
                            () => Visibility(
                              visible: isOtherSelected.value == 1,
                              child: CustomFormTextField(
                                controller: chatIntakeFormController
                                    .concernOtherController,
                                hintText: 'Enter topic of concern',
                                prefixIcon: Icons.account_box_sharp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Partner Detail
                    Row(
                      children: [
                        CustomCheckbox(
                          onChanged: (isChecked) {
                            if (isChecked) {
                              isPartnerSelected.value = 1;
                            } else {
                              isPartnerSelected.value = 0;
                            }
                          },
                        ),
                        CustomTextRegular("Add Partner Details"),
                      ],
                    ),
                    Obx(
                      () => Visibility(
                        visible: isPartnerSelected.value == 1,
                        child: Form(
                            key: _partnerFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextRegular("Enter Partner Name*"),
                                const Gap(Dimensions.gapExtraSmall),
                                CustomFormTextField(
                                  controller: chatIntakeFormController
                                      .partnerNameController,
                                  hintText: 'Enter partner name here',
                                  prefixIcon: Icons.person,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return AppStrings.formError.tr;
                                    }
                                    return null;
                                  },
                                ),
                                const Gap(Dimensions.gapMedium),
                                CustomTextRegular("Partner Gender*"),
                                const Gap(Dimensions.gapExtraSmall),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        Dimensions.paddingSizeMediumSmall,
                                    vertical: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Obx(() => Row(
                                        children: [
                                          Expanded(
                                            child: RadioListTile<String>(
                                              fillColor:
                                                  const WidgetStatePropertyAll(
                                                      ColorResources
                                                          .colorPrimaryDark),
                                              contentPadding: EdgeInsets.zero,
                                              visualDensity:
                                                  const VisualDensity(
                                                      horizontal: -4,
                                                      vertical: -4),
                                              title: CustomTextRegular('Male'),
                                              value: 'male',
                                              groupValue:
                                                  chatIntakeFormController
                                                      .partnerSelectedGender
                                                      .value,
                                              onChanged: (value) {
                                                chatIntakeFormController
                                                    .updatePartnerGender(
                                                        value!); // Update gender value
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: RadioListTile<String>(
                                              fillColor:
                                                  const WidgetStatePropertyAll(
                                                      ColorResources
                                                          .colorPrimaryDark),
                                              contentPadding: EdgeInsets.zero,
                                              visualDensity:
                                                  const VisualDensity(
                                                      horizontal: -4,
                                                      vertical: -4),
                                              title:
                                                  CustomTextRegular('Female'),
                                              value: 'female',
                                              groupValue:
                                                  chatIntakeFormController
                                                      .partnerSelectedGender
                                                      .value,
                                              onChanged: (value) {
                                                chatIntakeFormController
                                                    .updatePartnerGender(
                                                        value!); // Update gender value
                                              },
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                const Gap(Dimensions.gapMedium),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomTextRegular(
                                              "Partner Birth Date*"),
                                          const Gap(Dimensions.gapExtraSmall),
                                          CustomFormTextField(
                                            controller: chatIntakeFormController
                                                .partnerBirthDateController,
                                            hintText: 'Select date',
                                            prefixIcon: CupertinoIcons.calendar,
                                            enabled: false,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 8.0),
                                            onTap: () async {
                                              CommonMethods().showDatePickerDialog(
                                                  context,
                                                  chatIntakeFormController
                                                      .partnerBirthDateController);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Gap(8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomTextRegular(
                                              "Partner Birth Time*"),
                                          const Gap(Dimensions.gapExtraSmall),
                                          CustomFormTextField(
                                            controller: chatIntakeFormController
                                                .partnerBirthTimeController,
                                            hintText: 'Select time',
                                            prefixIcon:
                                                CupertinoIcons.clock_fill,
                                            enabled: false,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 8.0),
                                            onTap: () async {
                                              CommonMethods().showTimerPickerDialog(
                                                  context,
                                                  chatIntakeFormController
                                                      .partnerBirthTimeController);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(Dimensions.gapMedium),
                                CustomTextRegular("Partner Birth Place*"),
                                const Gap(Dimensions.gapExtraSmall),
                                CustomFormTextField(
                                  controller: chatIntakeFormController
                                      .partnerBirthPlaceController,
                                  hintText: 'Select birth place',
                                  prefixIcon: CupertinoIcons.building_2_fill,
                                  enabled: false,
                                  onTap: () async {
                                    String? placeApiKey =
                                        await SharedPreferencesHelper.getData(
                                            AppConstants.placeApiKey);
                                    var result = await Get.to(SearchPlaceScreen(
                                        placeApiKey.toString()));
                                    if (result != null) {
                                      chatIntakeFormController
                                          .partnerBirthPlaceController
                                          .text = result['name'].toString();
                                      chatIntakeFormController
                                          .partnerLatitudeController
                                          .text = result['latitude'].toString();
                                      chatIntakeFormController
                                              .partnerLongitudeController.text =
                                          result['longitude'].toString();
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
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: ColorResources.white,
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeMediumSmall),
              child: CustomElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  if (chatIntakeFormController.selectedGender.value.isEmpty) {
                    return CustomSnackBar.showBottom(
                        AppStrings.selectYourGender.tr);
                  }
                  if (chatIntakeFormController
                      .birthDateController.text.isEmpty) {
                    return CustomSnackBar.showBottom(
                        AppStrings.selectDateOfBirth.tr);
                  }
                  if (chatIntakeFormController
                      .birthTimeController.text.isEmpty) {
                    return CustomSnackBar.showBottom(
                        AppStrings.selectTimeOfBirth.tr);
                  }

                  if (isPartnerSelected.value == 1) {
                    if (!_partnerFormKey.currentState!.validate()) return;

                    if (chatIntakeFormController
                        .partnerSelectedGender.value.isEmpty) {
                      return CustomSnackBar.showBottom(
                          AppStrings.selectPartnerGender.tr);
                    }
                    if (chatIntakeFormController
                        .partnerBirthDateController.text.isEmpty) {
                      return CustomSnackBar.showBottom(
                          AppStrings.selectPartnerDateOfBirth.tr);
                    }
                    if (chatIntakeFormController
                        .partnerBirthTimeController.text.isEmpty) {
                      return CustomSnackBar.showBottom(
                          AppStrings.selectPartnerTimeOfBirth.tr);
                    }
                  }

                  chatIntakeFormController.setIntakeData(
                      chatIntakeFormController.nameController.text.toString(),
                      chatIntakeFormController.selectedGender.value.toString(),
                      chatIntakeFormController.birthDateController.text
                          .toString(),
                      chatIntakeFormController.birthTimeController.text
                          .toString(),
                      chatIntakeFormController.birthPlaceController.text
                          .toString(),
                      chatIntakeFormController.latitudeController.text
                          .toString(),
                      chatIntakeFormController.longitudeController.text
                          .toString(),
                      chatIntakeFormController.maritalStatusController.text
                          .toString(),
                      chatIntakeFormController.occupationController.text
                          .toString(),
                      chatIntakeFormController.concernController.text,
                      chatIntakeFormController.concernOtherController.text
                          .toString(),
                      partnerName_: chatIntakeFormController
                          .partnerNameController.text
                          .toString(),
                      partnerGender_: chatIntakeFormController
                          .partnerSelectedGender.value
                          .toString(),
                      partnerDob_: chatIntakeFormController
                          .partnerBirthDateController.text
                          .toString(),
                      partnerTob_: chatIntakeFormController
                          .partnerBirthTimeController.text
                          .toString(),
                      partnerBirthPlace_: chatIntakeFormController
                          .partnerBirthPlaceController.text
                          .toString(),
                      partnerLatitude_:
                          chatIntakeFormController.partnerLatitudeController.text.toString(),
                      partnerLongitude_: chatIntakeFormController.partnerLongitudeController.text.toString());

                  String? astrologerUniId =
                      chatIntakeFormController.astrologerUniId;
                  if (chatIntakeFormController.callType == AppConstants.chat) {
                    chatIntakeFormController.startChat(astrologerUniId);
                  } else if (chatIntakeFormController.callType ==
                      AppConstants.video) {
                    chatIntakeFormController.startVideoCall(astrologerUniId);
                  } else if (chatIntakeFormController.callType ==
                      AppConstants.call) {
                    int? inAppCall =
                        configController.config.data?.inAppVoiceCall?.toInt() ??
                            0;
                    String phoneCode = configController.phoneCode.toString();
                    if (inAppCall == 1 ||
                        phoneCode != AppConstants.defaultPhoneCode) {
                      chatIntakeFormController
                          .startInAppVoiceCall(astrologerUniId);
                    } else {
                      chatIntakeFormController.startVoiceCall(astrologerUniId);
                    }
                  } else if (chatIntakeFormController.callType ==
                      AppConstants.emergencyChat) {
                    chatIntakeFormController
                        .startEmergencyChat(astrologerUniId);
                  } else if (chatIntakeFormController.callType ==
                      AppConstants.emergencyCall) {
                    int? inAppCall =
                        configController.config.data?.inAppVoiceCall?.toInt() ??
                            0;
                    String phoneCode = configController.phoneCode.toString();
                    if (inAppCall == 1 ||
                        phoneCode != AppConstants.defaultPhoneCode) {
                      chatIntakeFormController
                          .startEmergencyInAppVoiceCall(astrologerUniId);
                    } else {
                      chatIntakeFormController
                          .startEmergencyVoiceCall(astrologerUniId);
                    }
                  } else if (chatIntakeFormController.callType ==
                      AppConstants.emergencyVideoCall) {
                    chatIntakeFormController
                        .startEmergencyVideoCall(astrologerUniId);
                  } else if (chatIntakeFormController.callType ==
                      AppConstants.slot) {
                    // SlotBookingController slotController = Get.find();
                    // slotController.bookSchedule(astrologerUniId.toString(), slotController.selectedSlot.slotStart.toString(), slotController.selectedSlot.slotEnd.toString(), slotController.selectedSlot.serialNo.toString(), slotController.selectedScheduleId.toString());
                  } else {
                    CustomSnackBar.showBottom("Undefined Service Type");
                  }
                },
                text: chatIntakeFormController.callType == AppConstants.call ||
                        chatIntakeFormController.callType ==
                            AppConstants.emergencyCall
                    ? "START CALL"
                    : chatIntakeFormController.callType == AppConstants.chat ||
                            chatIntakeFormController.callType ==
                                AppConstants.emergencyChat
                        ? "START CHAT"
                        : chatIntakeFormController.callType ==
                                    AppConstants.video ||
                                chatIntakeFormController.callType ==
                                    AppConstants.emergencyVideoCall
                            ? "START VIDEO CALL"
                            : "BOOK SLOT",
                backgroundColor: ColorResources.colorPrimary,
                textColor: ColorResources.toolbarText,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
