import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:astro_brahmand/utill/app_features.dart';
import 'package:astro_brahmand/utill/images.dart';
import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:astro_brahmand/view/screen/dashboard/controller/dashboard_controller.dart';
import 'package:astro_brahmand/view/screen/notification/controller/notification_controller.dart';
import 'package:astro_brahmand/view/widget/custom_default_dialog.dart';
import 'package:astro_brahmand/view/widget/custom_round_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:astro_brahmand/utill/app_strings.dart';
import '../../controller/auth_controller.dart';
import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';
import '../../utill/shared_preference.dart';
import '../screen/webview/webview_screen.dart';
import 'custom_dialog_widget.dart';
import 'custom_drawer_item.dart';
import 'custom_progress_indicator.dart';
import 'custom_text_regular.dart';

class CustomDashboardDrawer extends StatelessWidget {
  CustomDashboardDrawer({super.key});
  final InAppReview _inAppReview = InAppReview.instance;

  // Future<void> requestReview() async {
  //   // Check if the device supports in-app reviews
  //   if (await _inAppReview.isAvailable()) {
  //     // Request an in-app review
  //     await _inAppReview.requestReview();
  //   } else {
  //     // If in-app reviews are not available, you can redirect to the Play Store
  //     await _inAppReview.openStoreListing(
  //       appStoreId: 'YOUR_APP_STORE_ID', // For iOS, add your App Store ID here
  //       microsoftStoreId: 'YOUR_MICROSOFT_STORE_ID', // Optional, if applicable
  //     );
  //   }
  // }
  DateTime? lastReviewRequestTime;

  Future<void> requestReview() async {
    const int reviewCooldownDays = 1;

    final DateTime now = DateTime.now();

    if (lastReviewRequestTime == null || now.difference(lastReviewRequestTime!).inDays >= reviewCooldownDays) {
      if (await _inAppReview.isAvailable()) {
        await _inAppReview.requestReview();
        lastReviewRequestTime = now;
      } else {
        await _inAppReview.openStoreListing(
          appStoreId: 'YOUR_APP_STORE_ID',
          microsoftStoreId: 'YOUR_MICROSOFT_STORE_ID',
        );
      }
    } else {
      await _inAppReview.openStoreListing(
        appStoreId: 'YOUR_APP_STORE_ID',
        microsoftStoreId: 'YOUR_MICROSOFT_STORE_ID',
      );
    }
  }

  final AuthController authController = Get.put<AuthController>(AuthController());
  final DashboardController dashboardController = Get.put<DashboardController>(DashboardController());
  @override
  Widget build(BuildContext context) {
    final double drawerWidth = Get.width * 0.75;
    return Drawer(
      width: drawerWidth,
      child: Container(
        color: ColorResources.white,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  GestureDetector(
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
                    child: SizedBox(
                      height: 110,
                      child: DrawerHeader(
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
                                  return snapshot.data.toString() == "***" ?
                                  Image.asset(Images.placeholder, height: Dimensions.profileImageDrawer)
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
                                onTap: () async {
                                  await Get.toNamed('/notificationScreen');
                                  NotificationController.to.refreshUnreadCount();
                                },
                                child: Obx(() {
                                  final count =
                                      NotificationController.to.unreadCount.value;
                                  final label = count > 99 ? '99+' : '$count';
                                  return Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ColorResources
                                                  .colorPrimaryMedium),
                                          child: const Icon(
                                              Icons.notifications_none_outlined,
                                              color: ColorResources.toolbarText,
                                              size: 20)),
                                      if (count > 0)
                                        Positioned(
                                          top: -4,
                                          right: -4,
                                          child: Container(
                                            constraints: const BoxConstraints(
                                                minWidth: 16, minHeight: 16),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: count > 9 ? 4 : 0,
                                            ),
                                            decoration: BoxDecoration(
                                              color: ColorResources.red,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              label,
                                              style: const TextStyle(
                                                color: ColorResources.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                })),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(Dimensions.gapLarge),

                  CustomDrawerItem(
                    iconPath: Images.myProfile,
                    title: AppStrings.myProfile.tr,
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
                  ),

                  CustomDrawerItem(
                    iconPath: Images.orders,
                    title: AppStrings.orders.tr,
                    onTap: () async {
                      bool isLogin = await SharedPreferencesHelper.getIsLogin();
                      if (isLogin) {
                        Get.toNamed('/orders_tab_screen', arguments: {'index': 0});
                      } else {
                        Get.toNamed('/login');
                      }
                    },
                  ),

                  CustomDrawerItem(
                    iconPath: Images.queueList,
                    title: AppStrings.myQueueList.tr,
                    onTap: () async {
                      bool isLogin = await SharedPreferencesHelper.getIsLogin();
                      if (isLogin) {
                        Get.toNamed("/queue_list");
                      } else {
                        Get.toNamed('/login');
                      }
                    },
                  ),

                  CustomDrawerItem(
                    iconPath: Images.chatHistory,
                    title: AppStrings.chatHistory.tr,
                    onTap: () async {
                      bool isLogin = await SharedPreferencesHelper.getIsLogin();
                      if (isLogin) {
                        Get.toNamed("/chatChannels");
                      } else {
                        Get.toNamed('/login');
                      }
                    },
                  ),

                  CustomDrawerItem(
                    iconPath: Images.chatWithAstro,
                    title: AppStrings.chatwithAstrologer.tr,
                    onTap: () async {
                      Get.toNamed("/search");
                    },
                  ),

                  CustomDrawerItem(
                    iconPath: Images.share,
                    title: AppStrings.shareApp.tr,
                    onTap: () {
                      CommonMethods().shareApp("app");
                    },
                  ),

                  CustomDrawerItem(
                    iconPath: Images.privacy,
                    title: AppStrings.privacyPolicy.tr,
                    onTap: () {
                      Get.to(WebViewScreen(AppStrings.privacyPolicy.tr,
                          AppConstants.privacyPolicyUrl));
                    },
                  ),

                  CustomDrawerItem(
                    iconPath: Images.appRating,
                    title: AppStrings.rateApp.tr,
                    onTap: () {
                      requestReview();
                    },
                  ),

                  CustomDrawerItem(
                    iconPath: Images.contactUs,
                    title: AppStrings.contactus.tr,
                    onTap: () {
                      Get.toNamed("/contact_us");
                    },
                  ),

                  // Setting
                  CustomDrawerItem(
                    iconPath: Images.settings,
                    title: AppStrings.settings.tr,
                    visible: authController.isLogin && AppFeatures.privateSetting,
                    onTap: () {
                      Get.toNamed('/settingScreen');
                    },
                  ),

                  CustomDrawerItem(
                    iconPath: Images.logout,
                    title: AppStrings.logout.tr,
                    visible: authController.isLogin,
                    onTap: () {
                      Get.dialog(
                        CustomDialogWidget(
                          imagePath: Images.logout,
                          title: AppStrings.logout.tr,
                          description: AppStrings.logoutPopUP.tr,
                          onYesPressed: () async {
                            await SharedPreferencesHelper.logoutSession();
                          },
                        ),
                        barrierDismissible: false,
                      );
                    },
                  ),

                  CustomDrawerItem(
                    iconPath: Images.login,
                    title: AppStrings.login.tr,
                    visible: authController.isLogin == false,
                    onTap: () {
                      Get.toNamed('/login');
                    },
                  ),
                ],
              ),
            ),
            // Container(
            //   decoration: const BoxDecoration(
            //     borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(20),
            //         topRight: Radius.circular(20)),
            //     color: ColorResources.colorPrimaryLight,
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Text(AppStrings.joinuson.tr,
            //             style: const TextStyle(
            //                 fontSize: 14,
            //                 color: ColorResources.black1,
            //                 letterSpacing: 1)),
            //         const Gap(Dimensions.gapExtraSmall),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: [
            //             GestureDetector(
            //               onTap: () async {
            //                 String? facebook = await SharedPreferencesHelper.getData(AppConstants.facebookLink);
            //                 if(facebook.toString().isNotEmpty){
            //                   launchUrl(Uri.parse(facebook.toString()));
            //                 }else{
            //                   CustomSnackBar.showBottom("Account not found.");
            //                 }
            //               },
            //               child: const Image(
            //                   image: AssetImage(Images.facebook),
            //                   height: Dimensions.socialIconHeight),
            //             ),
            //             // Gap(Dimensions.gapSmall),
            //             GestureDetector(
            //               onTap: () async {
            //                 String? instagram = await SharedPreferencesHelper.getData(AppConstants.instagramLink);
            //                 if(instagram.toString().isNotEmpty){
            //                   launchUrl(Uri.parse(instagram.toString()));
            //                 }else{
            //                   CustomSnackBar.showBottom("Account not found.");
            //                 }
            //               },
            //               child: const Image(
            //                   image: AssetImage(Images.instagram),
            //                   height: Dimensions.socialIconHeight),
            //             ),
            //             // Gap(Dimensions.gapSmall),
            //             GestureDetector(
            //               onTap: () async {
            //                 String? youtube = await SharedPreferencesHelper.getData(AppConstants.youtubeLink);
            //                 if(youtube.toString().isNotEmpty){
            //                   launchUrl(Uri.parse(youtube.toString()));
            //                 }else{
            //                   CustomSnackBar.showBottom("Account not found.");
            //                 }
            //               },
            //               child: const Image(
            //                   image: AssetImage(Images.youtube),
            //                   height: Dimensions.socialIconHeight),
            //             ),
            //             // Gap(Dimensions.gapSmall),
            //             GestureDetector(
            //               onTap: () async {
            //                 String? twitter = await SharedPreferencesHelper.getData(AppConstants.twitterLink);
            //                 if(twitter.toString().isNotEmpty){
            //                   launchUrl(Uri.parse(twitter.toString()));
            //                 }else{
            //                   CustomSnackBar.showBottom("Account not found.");
            //                 }
            //               },
            //               child: const Image(
            //                   image: AssetImage(Images.twitter),
            //                   height: Dimensions.socialIconHeight),
            //             ),
            //           ],
            //         ),
            //         const Gap(Dimensions.gapExtraSmall),
            //         Text(
            //           "${AppStrings.version}${AppConstants.appVersion}".tr,
            //           style: const TextStyle(
            //               fontSize: Dimensions.fontSizeDefault,
            //               fontWeight: FontWeight.bold,
            //               color: ColorResources.green,
            //               letterSpacing: 1),
            //         ),
            //         const Gap(Dimensions.gapSmall),
            //       ],
            //     ),
            //   ),
            // ),
            // const Gap(Dimensions.gapSmall),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FutureBuilder(
                future: _fetchSocialMediaLinks(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CustomProgressIndicator();
                  }

                  final socialMediaIcons = snapshot.data as List<Widget>;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (socialMediaIcons.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.joinuson.tr,
                              style: const TextStyle(
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: ColorResources.black,
                                  letterSpacing: 1),
                            ),
                          ]
                        ),
                      const Gap(Dimensions.gapExtraSmall),
                      if (socialMediaIcons.isNotEmpty)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: socialMediaIcons,
                        ),
                      const Gap(Dimensions.gapExtraSmall),
                      Text(
                        "${AppStrings.version} ${AppConstants.appVersion}".tr,
                        style: const TextStyle(
                            fontSize: Dimensions.fontSizeDefault,
                            color: Colors.green,
                            letterSpacing: 1,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      const Gap(Dimensions.gapSmall),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
  // Fetch links from SharedPreferences
  Future<List<Widget>> _fetchSocialMediaLinks() async {
    List<Widget> socialMediaIcons = [];

    // Facebook
    String? facebook = await SharedPreferencesHelper.getData(AppConstants.facebookLink);
    if (facebook != null && facebook.isNotEmpty) {
      socialMediaIcons.add(
        GestureDetector(
          onTap: () => launchUrl(Uri.parse(facebook.toString())),
          child: const Image(
            image: AssetImage(Images.facebook),
            height: Dimensions.socialIconHeight,
          ),
        ),
      );
      socialMediaIcons.add(const Gap(10));
    }

    // Instagram
    String? instagram = await SharedPreferencesHelper.getData(AppConstants.instagramLink);
    if (instagram != null && instagram.isNotEmpty) {
      socialMediaIcons.add(
        GestureDetector(
          onTap: () => launchUrl(Uri.parse(instagram.toString())),
          child: const Image(
            image: AssetImage(Images.instagram),
            height: Dimensions.socialIconHeight,
          ),
        ),
      );
      socialMediaIcons.add(const Gap(10));
    }

    // LinkedIn
    String? linkedin = await SharedPreferencesHelper.getData(AppConstants.linkedinLink);
    if (linkedin != null && linkedin.isNotEmpty) {
      socialMediaIcons.add(
        GestureDetector(
          onTap: () => launchUrl(Uri.parse(linkedin.toString())),
          child: const Image(
            image: AssetImage(Images.linkedin),
            height: Dimensions.socialIconHeight,
          ),
        ),
      );
      socialMediaIcons.add(const Gap(10));
    }

    // Share Chat
    String? shareChat = await SharedPreferencesHelper.getData(AppConstants.shareChatLink);
    if (shareChat != null && shareChat.isNotEmpty) {
      socialMediaIcons.add(
        GestureDetector(
          onTap: () => launchUrl(Uri.parse(shareChat.toString())),
          child: const Image(
            image: AssetImage(Images.shareChat),
            height: Dimensions.socialIconHeight,
          ),
        ),
      );
      socialMediaIcons.add(const Gap(Dimensions.gapDefault));
    }

    // Twitter
    String? twitter = await SharedPreferencesHelper.getData(AppConstants.twitterLink);
    if (twitter != null && twitter.isNotEmpty) {
      socialMediaIcons.add(
        GestureDetector(
          onTap: () => launchUrl(Uri.parse(twitter.toString())),
          child: const Image(
            image: AssetImage(Images.twitter),
            height: Dimensions.socialIconHeight,
          ),
        ),
      );
      socialMediaIcons.add(const Gap(Dimensions.gapDefault));
    }

    // YouTube
    String? youtube = await SharedPreferencesHelper.getData(AppConstants.youtubeLink);
    if (youtube != null && youtube.isNotEmpty) {
      socialMediaIcons.add(
        GestureDetector(
          onTap: () => launchUrl(Uri.parse(youtube.toString())),
          child: const Image(
            image: AssetImage(Images.youtube),
            height: Dimensions.socialIconHeight,
          ),
        ),
      );
    }

    return socialMediaIcons;
  }
}
