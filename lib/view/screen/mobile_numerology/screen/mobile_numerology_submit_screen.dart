import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/utill/dimensions.dart';
import 'package:astro_brahmand/utill/images.dart';
import 'package:astro_brahmand/view/widget/custom_elevated_button.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controller/mobile_numerology_controller.dart';

class MobileNumerologySubmitScreen extends StatelessWidget {
  final MobileNumerologyController controller = Get.put(MobileNumerologyController());
  bool isCorrectCountry = true;
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  MobileNumerologySubmitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldState,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Images.mobilePredictionBg), fit: BoxFit.fill),
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      margin: const EdgeInsets.only(top: 20,left: 20),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorResources.colorPrimary,
                      ),
                      padding: const EdgeInsets.all(Dimensions.paddingSizeOverSmall),
                      child: Image.asset(
                        Images.back,
                        color: ColorResources.white,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge,vertical: Dimensions.paddingSizeLarge),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
      
                    Image.asset(Images.logo,width: Get.width*0.7),
                    const Gap(Dimensions.gapOverLarge),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      decoration: BoxDecoration(
                        color: ColorResources.colorPrimaryLight,
                        // Replace with your color
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          CountryCodePicker(
                            onChanged: (CountryCode code) {
                              if (isValidCountry(code.name.toString())) {
                                isCorrectCountry = true;
                                controller.updateCountryCode(code);
                              } else {
                                isCorrectCountry = false;
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "Invalid Country ${code.name.toString()}.Please select a country with 10-digit mobile number.")
                                )
                                );
                              }
                            },
                            initialSelection: 'IN',
                            favorite: const ['IN'],
                            showFlagMain: false,
                          ),
                          Expanded(
                            child: TextFormField(
                                onChanged: (value) {
                                  if (value.length == 10) {
                                    controller.updatePhoneNumber(value);
                                    FocusScope.of(context).unfocus();
                                  }
                                },
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration.collapsed(
                                  hintText: 'Mobile Number',
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    const Gap(Dimensions.gapDefault),
                    CustomElevatedButton(
                        text: "Know Your Fortune",
                      onPressed: () {
                        if (isCorrectCountry) {
                          if (isValidMobileNumber(
                              controller.phoneNumber.value.toString())) {
                            Get.toNamed("/mobile_numerology_detail");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Invalid Mobile Number")));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  "Invalid Country.Please select a country with 10-digit mobile number.")));
                        }
                      },
                      backgroundColor: ColorResources.colorPrimary,
                      textColor: ColorResources.toolbarText,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }

  bool isValidMobileNumber(String number) {
    return RegExp(r'^\d{10}$').hasMatch(number);
  }

  bool isValidCountry(String countryName) {
    // Add the names of countries with a 10-digit mobile number requirement
    Set<String> countriesWith10Digits = {
      "भारत",
      "India",
      "United States",
      "Pakistan",
      "Bangladesh",
      "Russia",
      "Mexico",
      "Japan",
      "Egypt",
      "Iran",
      "Turkey",
      "Germany",
      "Italy",
      "Kenya",
      "Columbia",
      "South Korea",
      "Canada",
      "Nepal",
      "Romania",
      "Kazakhstan",
      "Greece",
      "Austria",
      "Libya"
    };
    return countriesWith10Digits.contains(countryName);
  }
}