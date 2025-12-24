import 'dart:io';

import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/common_methods.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../../utill/shared_preference.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_elevated_button.dart';
import '../../widget/custom_text_regular.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  CustomAppBar(title:AppStrings.contactus.tr),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: Dimensions.sizedBoxExtraExtraLarge),
              SizedBox(
                // width: 150,
                height: 120,
                child: Image.asset(
                  Images.support,
          
                ),
              ),
              const SizedBox(height: Dimensions.sizedBoxExtraExtraLarge),
              Text(AppStrings.customerSupport.tr,
                style: const TextStyle(
                    fontSize: Dimensions.fontSizeOverLarge,
                    color: ColorResources.colorPrimaryDark,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1
                ),
              ),
              const SizedBox(height: Dimensions.sizedBoxExtraSmall),
              CustomTextRegular(AppStrings.forAnyQuery.tr,color: ColorResources.black1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault,vertical: Dimensions.paddingSizeLarge),
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorResources.grey,
                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall,horizontal: Dimensions.paddingSizeDefault),
                      child: Row(
                        children: [
                          const Icon(Icons.mail,color: ColorResources.colorPrimaryDark,size: 35),
                          const Gap(10),
                          Expanded(
                            child:FutureBuilder<String?>(
                              future: CommonMethods().getCompanyEmail(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return Text(snapshot.data.toString(),
                                    style: const TextStyle(
                                      fontSize: Dimensions.fontSizeLarge,
                                      fontWeight: FontWeight.w500,
                                      color: ColorResources.black3,
                                      letterSpacing: 1,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  );
                                }
                              },
                            ),
                          )
                        ],
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: CustomElevatedButton(
                  text: AppStrings.proceed.tr,
                  onPressed: () async {
                    String? email = await SharedPreferencesHelper.getData(AppConstants.companyEmail);
                    _sendEmail(email.toString(), "Regarding ${AppConstants.appName} App", "Dear ${AppConstants.appName} Support Team,\n");
                  },
                  backgroundColor: ColorResources.colorPrimary,
                  textColor: ColorResources.toolbarText,
                ),
              ),
              const SizedBox(height: Dimensions.sizedBoxExtraExtraLarge),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(
                  children: [
                    const Flexible(
                      child: Divider(
                        color: ColorResources.black6,
                      ),
                    ),
                    const SizedBox(width: Dimensions.sizedBoxSmall),
                    Text(AppStrings.or.tr,style: const TextStyle(
                        color: ColorResources.black4
                    ),),
                    const SizedBox(width: Dimensions.sizedBoxSmall),
                    const Flexible(
                      child: Divider(
                        color: ColorResources.black6,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomTextRegular(AppStrings.connectUsOn.tr,fontSize: Dimensions.fontSizeSmall,color: ColorResources.black2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        String? mobile = await SharedPreferencesHelper.getData(AppConstants.companyMobileNo);
                        _launchDialer(mobile.toString());
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 20,
                        child: Image.asset(
                          'assets/images/iconcall.png',
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () async {
                        String? whatsappNo = await SharedPreferencesHelper.getData(AppConstants.companyWhatsappNo);
                        whatsapp(whatsappNo.toString());
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 20,
                        child: Image.asset(
                          'assets/images/iconwhatsapp.png',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Gap(Dimensions.gapExtraLarge),

              FutureBuilder<String?>(
                future: CommonMethods().getCompanyAddress(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return CustomTextRegular("Address: ${snapshot.data.toString()}",color: ColorResources.black2,textAlign: TextAlign.center,);
                  }
                },
              ),
              FutureBuilder<String?>(
                future: CommonMethods().getCompanyMobile(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return CustomTextRegular("Mobile: ${snapshot.data.toString()}",color: ColorResources.black2,textAlign: TextAlign.center,);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to launch the dialer with a specific number
  _launchDialer(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      CustomSnackBar.showBottom("Something went wrong");
    }
  }

  whatsapp(String whatsappNumber) async{
    var androidUrl = "whatsapp://send?phone=$whatsappNumber&text=Hi\n${AppConstants.appName} Support Team,\nI need some help\n";
    var iosUrl = "https://wa.me/$whatsappNumber?text=${Uri.parse('Hi\n${AppConstants.appName} Support Team,\nI need some help\n')}";

    try{
      if(Platform.isIOS){
        await launchUrl(Uri.parse(iosUrl));
      }
      else{
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception{
      CustomSnackBar.showBottom("Whatsapp not installed");
    }
  }

  void _sendEmail(String toEmail, String subject, String body) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: toEmail,
      query: 'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
    );

    if (await canLaunchUrl(params)) {
      await launchUrl(params);
    } else {
      CustomSnackBar.showBottom("Something went wrong");
    }
  }
}

