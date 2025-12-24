import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/common_methods.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_elevated_button.dart';
import '../../../widget/custom_text_field.dart';
import '../controller/numerology_controller.dart';


class NumerologySubmitScreen extends StatelessWidget {
  NumerologySubmitScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _birthDataFocusNode = FocusNode();


  final NumerologyController controller = Get.put(NumerologyController());


  @override
  Widget build(BuildContext context) {
    controller.initData();
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.numerology.tr),
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
                     TextFormField(
                      controller: controller.nameController,
                      focusNode: _nameFocusNode,
                      decoration: InputDecoration(

                        contentPadding: const EdgeInsets.all(0.0),
                        filled: true,
                        fillColor: ColorResources.colorPrimaryLight,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Enter your name here',
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
                      onFieldSubmitted: (_) => _birthDataFocusNode.requestFocus(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),

                    const Gap(Dimensions.gapLarge),
                    CustomText(hintText: AppStrings.dateOfBirth.tr),
                    const SizedBox(height: Dimensions.sizedBoxExtraSmall),
                    GestureDetector(
                      onTap: () async {
                        CommonMethods().showDatePickerDialog(context,controller.dobController);
                      },
                      child: TextFormField(
                          controller: controller.dobController,
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
                          onFieldSubmitted: (_) => _nameFocusNode.requestFocus(),
                          focusNode: _birthDataFocusNode,
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
              const Gap(Dimensions.gapExtraExtraLarge),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeDefault),
                child: CustomElevatedButton(
                  text: AppStrings.submit.tr,
                  backgroundColor: ColorResources.colorPrimary,
                  textColor: ColorResources.toolbarText,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.toNamed('/numerology_detail', arguments: {
                        'name': controller.nameController.text.toString(),
                        'dob': controller.dobController.text.toString()
                      });
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
