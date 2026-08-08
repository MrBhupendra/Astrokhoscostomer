import 'package:astro_brahmand/view/screen/astro_shop/controller/products_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../utill/app_constants.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/shared_preference.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_elevated_button.dart';
import '../../widget/custom_icon_textfield.dart';
import '../searchPlace/search_place_screen.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class AddAddressScreen extends GetView<ProductsController> {
  AddAddressScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final FocusNode _billingNameFocusNode = FocusNode();
  final FocusNode _mobileFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _flatFocusNode = FocusNode();
  final FocusNode _areaFocusNode = FocusNode();
  final FocusNode _landmarkFocusNode = FocusNode();
  final FocusNode _pinCodeFocusNode = FocusNode();

  final TextEditingController _billingNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _flatController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _latitude = TextEditingController();
  final TextEditingController _longitude = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _country = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.newAddress.tr),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeMediumSmall,vertical: Dimensions.paddingSizeDefault,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Gap(Dimensions.gapMedium),

                          CustomIconTextField(
                            controller: _billingNameController,
                            hintText: "Billing Name*",
                            prefixIcon: const Icon(Icons.person),
                            focusNode: _billingNameFocusNode,
                            onSubmitted: (_) => _mobileFocusNode.requestFocus(),
                          ),
                          const Gap(Dimensions.gapMedium),

                          CustomIconTextField(
                            controller: _mobileController,
                            hintText: "Mobile Number*",
                            prefixIcon: const Icon(Icons.phone_android),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            focusNode: _mobileFocusNode,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) => _emailFocusNode.requestFocus(),
                          ),
                          const Gap(Dimensions.gapMedium),

                          CustomIconTextField(
                            controller: _emailController,
                            hintText: 'example@mail.com',
                            prefixIcon: const Icon(Icons.email),
                            keyboardType: TextInputType.emailAddress,
                            focusNode: _emailFocusNode,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) => _flatFocusNode.requestFocus(),
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
                          const Gap(Dimensions.gapMedium),

                          CustomIconTextField(
                            controller: _flatController,
                            hintText: 'Flat.no,Building Name*',
                            prefixIcon: const Icon(Icons.location_pin),
                            focusNode: _flatFocusNode,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) => _areaFocusNode.requestFocus(),
                          ),
                          const Gap(Dimensions.gapMedium),

                          CustomIconTextField(
                            controller: _areaController,
                            hintText: 'Locality.area,Street*',
                            prefixIcon: const Icon(Icons.maps_home_work_rounded),
                            focusNode: _areaFocusNode,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) => _landmarkFocusNode.requestFocus(),
                          ),
                          const Gap(Dimensions.gapMedium),

                          CustomIconTextField(
                            controller: _landmarkController,
                            hintText: 'Landmark*',
                            prefixIcon: const Icon(Icons.location_pin),
                            focusNode: _landmarkFocusNode,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) => _pinCodeFocusNode.requestFocus(),
                          ),
                          const Gap(Dimensions.gapMedium),

                          CustomIconTextField(
                            controller: _pinCodeController,
                            hintText: 'Pin Code*',
                            prefixIcon: const Icon(Icons.lock),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6),
                            ],
                            focusNode: _pinCodeFocusNode,
                          ),
                          const Gap(Dimensions.gapMedium),

                          GestureDetector(
                            onTap: () async {
                              String? placeApiKey = await SharedPreferencesHelper.getData(AppConstants.placeApiKey);
                              var result = await Get.to(SearchPlaceScreen(placeApiKey.toString()));
                              if (result != null) {
                                _addressController.text = result['name'];
                                _latitude.text = result['latitude'];
                                _longitude.text = result['longitude'];
                                _city.text = result['city'];
                                _state.text = result['state'];
                                _country.text = result['country'];
                              }
                            },
                            child: CustomIconTextField(
                              controller: _addressController,
                              hintText: 'City/State/Country',
                              prefixIcon: const Icon(Icons.location_pin),
                              enabled: false,
                            ),
                          ),

                          const Gap(Dimensions.gapMedium),

                          const Gap(8),
                          CustomElevatedButton(
                            text: AppStrings.submit.tr,
                            backgroundColor:
                            ColorResources.colorPrimary,
                            textColor: ColorResources.toolbarText,
                            onPressed: () {
                              AppLogger.d(_pinCodeController.text);
                              if (_formKey.currentState!.validate()) {
                                controller.saveUserAddress(
                                    _billingNameController.text,
                                    _emailController.text,
                                    _mobileController.text,
                                    _flatController.text,
                                    _areaController.text,
                                    _landmarkController.text,
                                    _city.text,
                                    _latitude.text,
                                    _longitude.text,
                                    _pinCodeController.text,
                                    _addressController.text,
                                    _country.text,
                                    _state.text
                                );
                              }

                            },
                          ),

                          const Gap(8),
                        ],
                      ),
                    ),
                    const Gap(8),
                  ],
                ),
              ),
            ),
            // Obx(
            //       () => controller.isLoading.value
            //       ? const CustomProgressIndicator()
            //       : const SizedBox.shrink(),
            // ),
          ],
        ),
      ),
    );
  }
}
