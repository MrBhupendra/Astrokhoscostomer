import 'dart:io';

import 'package:astro_brahmand/utill/app_features.dart';
import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/utill/images.dart';
import 'package:astro_brahmand/view/screen/webview/webview_screen.dart';
import 'package:astro_brahmand/view/widget/custom_dialog_widget.dart';
import 'package:astro_brahmand/view/widget/custom_round_network_image.dart';
import 'package:astro_brahmand/view/widget/dash_profile_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';

import '../../../controller/auth_controller.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/common_methods.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/shared_preference.dart';
import '../../widget/custom_text_regular.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController =
        Get.put<AuthController>(AuthController());
    authController.getData();
    return SingleChildScrollView(
      child: Container(
        color: ColorResources.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeMediumSmall,
              vertical: Dimensions.paddingSizeExtraOverSmall),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeOverSmall),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                          return snapshot.data.toString() == "***"
                              ? Image.asset(Images.placeholder,
                                  height: Dimensions.profileImageDrawer)
                              : CustomRoundNetworkImage(
                                  imageUrl: snapshot.data.toString(),
                                  height: Dimensions.profileImageDrawer,
                                  width: Dimensions.profileImageDrawer);
                        }
                      },
                    ),
                    const Gap(Dimensions.gapLarge),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FutureBuilder<String?>(
                            future: CommonMethods().getProfileName(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return CustomTextMedium(
                                  snapshot.data.toString() == "***"
                                      ? "Not logged in"
                                      : snapshot.data.toString(),
                                  fontSize: Dimensions.fontSizeLarge,
                                  color: ColorResources.black,
                                  maxLines: 2,
                                );
                              }
                            },
                          ),
                          FutureBuilder<String?>(
                            future: CommonMethods().getUserUniId(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                return CustomTextRegular(
                                  snapshot.data.toString() == "***"
                                      ? "Login to continue"
                                      : "ID:${snapshot.data.toString()}",
                                  color: ColorResources.black1,
                                  maxLines: 1,
                                  fontSize: Dimensions.fontSizeSmall,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.toNamed('/notificationScreen');
                        },
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorResources.colorPrimaryMedium),
                            child: const Icon(
                              Icons.notifications_none_outlined,
                              color: ColorResources.toolbarText,
                              size: 20,
                            ))),
                  ],
                ),
              ),
              const Divider(color: ColorResources.black7),

              DashProfileListWidget(
                onTap: () async {
                  bool isLogin = await SharedPreferencesHelper.getIsLogin();
                  String? mobile = await SharedPreferencesHelper.getData(
                      AppConstants.phoneNumber);
                  if (isLogin) {
                    Get.toNamed('/updateProfile',
                        arguments: {'mobile': mobile, 'type': "Update"});
                  } else {
                    Get.toNamed('/login');
                  }
                },
                image: Images.myProfile,
                title: AppStrings.myProfile.tr,
              ),
              const Divider(color: ColorResources.black7),

              DashProfileListWidget(
                onTap: () async {
                  bool isLogin = await SharedPreferencesHelper.getIsLogin();
                  if (isLogin) {
                    Get.toNamed('/orders_tab_screen', arguments: {'index': 0});
                  } else {
                    Get.toNamed('/login');
                  }
                },
                image: Images.orders,
                title: AppStrings.orders.tr,
              ),
              const Divider(color: ColorResources.black7),

              if (AppFeatures.downloadJyotishamPDF == true)
                Column(
                  children: [
                    DashProfileListWidget(
                      onTap: () async {
                        bool isLogin =
                            await SharedPreferencesHelper.getIsLogin();
                        if (isLogin) {
                          Get.toNamed('/report_order_list_vedic');
                        } else {
                          Get.toNamed('/login');
                        }
                      },
                      image: Images.pdfReportIcon,
                      title: AppStrings.myPdfReport.tr,
                    ),
                    const Divider(color: ColorResources.black7),
                  ],
                ),

              if(AppFeatures.vastuArchitect)
              DashProfileListWidget(
                onTap: () async {
                  bool isLogin = await SharedPreferencesHelper.getIsLogin();
                  if (isLogin) {
                    Get.toNamed('/paid_orders_tab_screen',
                        arguments: {'index': 0});
                  } else {
                    Get.toNamed('/login');
                  }
                },
                image: Images.paidOrders,
                title: AppStrings.paidServiceOrders.tr,
              ),
              if(AppFeatures.vastuArchitect)
              const Divider(color: ColorResources.black7),

              if(AppFeatures.vastuArchitect)
              DashProfileListWidget(
                onTap: () async {
                  bool isLogin = await SharedPreferencesHelper.getIsLogin();
                  if (isLogin) {
                    Get.toNamed("/architect_orders_tab_screen");
                  } else {
                    Get.toNamed('/login');
                  }
                },
                image: Images.architectOrders,
                title: AppStrings.vastuArchitectOrders.tr,
              ),
              if(AppFeatures.vastuArchitect)
              const Divider(color: ColorResources.black7),

              if (AppFeatures.askAstroQuestion)
                DashProfileListWidget(
                  onTap: () async {
                    bool isLogin = await SharedPreferencesHelper.getIsLogin();
                    if (isLogin) {
                      Get.toNamed('/ask_question_order_screen');
                    } else {
                      Get.toNamed('/login');
                    }
                  },
                  image: Images.askQuestionOrders,
                  title: AppStrings.askQuestionOrders.tr,
                ),
              if (AppFeatures.askAstroQuestion)
                const Divider(color: ColorResources.black7),

              DashProfileListWidget(
                onTap: () async {
                  bool isLogin = await SharedPreferencesHelper.getIsLogin();
                  if (isLogin) {
                    Get.toNamed("/live_orders_tab_screen");
                  } else {
                    Get.toNamed('/login');
                  }
                },
                image: Images.liveOrders,
                title: AppStrings.liveOrders.tr,
              ),
              const Divider(color: ColorResources.black7),
              DashProfileListWidget(
                onTap: () async {
                  bool isLogin = await SharedPreferencesHelper.getIsLogin();
                  if (isLogin) {
                    Get.toNamed("/queue_list");
                  } else {
                    Get.toNamed('/login');
                  }
                },
                image: Images.queueList,
                title: AppStrings.myQueueList.tr,
              ),
              const Divider(color: ColorResources.black7),

              DashProfileListWidget(
                onTap: () async {
                  bool isLogin = await SharedPreferencesHelper.getIsLogin();
                  if (isLogin) {
                    Get.toNamed("/chatChannels");
                  } else {
                    Get.toNamed('/login');
                  }
                },
                image: Images.chatHistory,
                title: AppStrings.chatHistory.tr,
              ),
              const Divider(color: ColorResources.black7),

              DashProfileListWidget(
                onTap: () async {
                  bool isLogin = await SharedPreferencesHelper.getIsLogin();
                  if (isLogin) {
                    Get.toNamed("/remedies");
                  } else {
                    Get.toNamed('/login');
                  }
                },
                image: Images.remedies,
                title: AppStrings.remedies.tr,
              ),
              const Divider(color: ColorResources.black7),

              DashProfileListWidget(
                onTap: () async {
                  bool isLogin = await SharedPreferencesHelper.getIsLogin();
                  if (isLogin) {
                    Get.toNamed("/supportTabScreen");
                  } else {
                    Get.toNamed('/login');
                  }
                },
                image: Images.customerSupport,
                title: AppStrings.customerSupportChat.tr,
              ),
              const Divider(color: ColorResources.black7),

              DashProfileListWidget(
                onTap: () async {
                  bool isLogin = await SharedPreferencesHelper.getIsLogin();
                  if (isLogin) {
                    Get.toNamed("/following_list");
                  } else {
                    Get.toNamed('/login');
                  }
                },
                image: Images.following,
                title: AppStrings.followings.tr,
              ),
              const Divider(color: ColorResources.black7),

              if(AppFeatures.subscription)
              DashProfileListWidget(
                onTap: () async {
                  bool isLogin = await SharedPreferencesHelper.getIsLogin();
                  if (isLogin) {
                    Get.toNamed("/subscription_list_screen");
                  } else {
                    Get.toNamed('/login');
                  }
                },
                image: Images.subscription,
                title: AppStrings.subscription.tr,
              ),
              if(AppFeatures.subscription)
              const Divider(color: ColorResources.black7),




              DashProfileListWidget(
                onTap: () {
                  Get.to(WebViewScreen(AppStrings.faq.tr, AppConstants.faqUrl));
                },
                image: Images.faq,
                title: AppStrings.faq.tr,
              ),
              const Divider(color: ColorResources.black7),

              DashProfileListWidget(
                onTap: () {
                  Get.to(WebViewScreen(
                      "${AppStrings.about.tr} ${AppConstants.appName.tr}".tr,
                      AppConstants.aboutUsUrl));
                },
                image: Images.aboutApp,
                title: "${AppStrings.about.tr} ${AppConstants.appName.tr}",
              ),
              const Divider(color: ColorResources.black7),

              DashProfileListWidget(
                onTap: () {
                  Get.to(WebViewScreen(
                      AppStrings.termAndCondition.tr, AppConstants.tncUrl));
                },
                image: Images.terms,
                title: AppStrings.termAndCondition.tr,
              ),
              const Divider(color: ColorResources.black7),

              DashProfileListWidget(
                onTap: () {
                  Get.to(WebViewScreen(AppStrings.privacyPolicy.tr,
                      AppConstants.privacyPolicyUrl));
                },
                image: Images.privacy,
                title: AppStrings.privacyPolicy.tr,
              ),
              const Divider(color: ColorResources.black7),

              DashProfileListWidget(
                onTap: () {
                  Get.toNamed("/contact_us");
                },
                image: Images.contactUs,
                title: AppStrings.contactus.tr,
              ),
              const Divider(color: ColorResources.black7),

              //ReferAndEarn
              Visibility(
                visible: AppFeatures.referAndEarn && Platform.isAndroid,
                child: Column(
                  children: [
                    DashProfileListWidget(
                      onTap: () async {
                        bool isLogin = await SharedPreferencesHelper.getIsLogin();
                        if(isLogin){
                          String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
                          CommonMethods().shareApp("refer",userUniId: uniId.toString());
                        }else{
                          Get.toNamed('/login');
                        }
                      },
                      image: Images.referEarn,
                      title: AppStrings.referAndEarn.tr,
                    ),
                    const Divider(color: ColorResources.black7),
                  ],
                ),
              ),
              // Login
              Visibility(
                visible: authController.isLogin == false,
                child: DashProfileListWidget(
                  onTap: () {
                    Get.toNamed('/login');
                  },
                  image: Images.login,
                  title: AppStrings.login.tr,
                ),
              ),
              //Logout
              Visibility(
                visible: authController.isLogin,
                child: DashProfileListWidget(
                  onTap: () {
                    Get.dialog(
                        CustomDialogWidget(
                            imagePath: Images.logout,
                            title: AppStrings.logout.tr,
                            onYesPressed: () async {
                              await SharedPreferencesHelper.logoutSession();
                            },
                            description: AppStrings.logoutPopUP.tr),
                        barrierDismissible: false);
                  },
                  image: Images.logout,
                  title: AppStrings.logout.tr,
                ),
              ),
              //Delete
              Visibility(
                  visible: authController.isLogin,
                  child: const Divider(color: ColorResources.black7)),
              Visibility(
                visible: authController.isLogin,
                child: InkWell(
                  onTap: () {
                    Get.dialog(
                        CustomDialogWidget(
                            imagePath: Images.deleteAcc,
                            title: AppStrings.delete.tr,
                            onYesPressed: () {
                              authController.deleteAccount();
                            },
                            imageColor: ColorResources.colorFontRed,
                            description: AppStrings.deletePopUP.tr),
                        barrierDismissible: false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeExtraOverSmall),
                    child: Row(
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                              color:
                                  ColorResources.colorFontRed.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                            Images.deleteAcc,
                            // height: Dimensions.profileIconSize,
                            color: ColorResources.colorFontRed,
                          ),
                        ),
                        const Gap(Dimensions.gapMedium),
                        Expanded(
                            child: CustomTextRegular(
                                AppStrings.deleteMyAccount.tr,
                                color: ColorResources.colorFontRed)),
                        const Icon(Icons.arrow_forward_ios_rounded,
                            size: 18, color: ColorResources.colorFontRed)
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(5),
            ],
          ),
        ),
      ),
    );
  }
}
