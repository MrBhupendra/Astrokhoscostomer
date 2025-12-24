import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:astro_brahmand/utill/images.dart';
import 'package:astro_brahmand/view/screen/astrologer_detail/controller/astrologer_profile_controller.dart';
import 'package:astro_brahmand/view/screen/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/view/widget/custom_rating_icons.dart';
import 'package:astro_brahmand/view/widget/custom_round_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../model/astrologer_model.dart';
import '../../utill/app_constants.dart';
import '../../utill/app_features.dart';
import '../../utill/app_strings.dart';
import '../../utill/dimensions.dart';
import '../../utill/shared_preference.dart';
import '../screen/splash/controller/config_controller.dart';
import '../screen/wallet/controller/wallet_controller.dart';
import '../screen/wallet/wallet_screen.dart';
import 'custom_empty_screen.dart';
import 'custom_progress_indicator.dart';
import 'custom_box_decoration.dart';

class AstrologerWidget extends StatelessWidget {
  final AstrologerData astrologer;
  final Function? onPressed;

  const AstrologerWidget(this.astrologer, {this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();
    // final AstrologerProfileController astrologerProfileController = Get.put(AstrologerProfileController());
    // final DashboardController dashboardController = Get.put(DashboardController());
    AstrologerProfileController astrologerProfileController = AstrologerProfileController();
    DashboardController dashboardController = DashboardController();
    String chatRate = '**', callRate = '**', videoRate = '**';
    astrologer.prices?.forEach((priceItem) {
      String type = priceItem.type.toString();
      String actualPrice = priceItem.actualPrice?.toString() ?? "";
      switch (type) {
        case AppConstants.chat:
          chatRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty
              ? "FREE"
              : actualPrice.isNotEmpty && double.tryParse(actualPrice) != null && double.parse(actualPrice) > 0
              ? "${configController.currencySymbol}$actualPrice/min (${configController.currencySymbol}${priceItem.price.toString()}/min)"
              : "${configController.currencySymbol}${priceItem.price.toString()}/min";
          break;
        case AppConstants.call:
          callRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty
              ? "FREE"
              : actualPrice.isNotEmpty && double.tryParse(actualPrice) != null && double.parse(actualPrice) > 0
              ? "${configController.currencySymbol}$actualPrice/min (${configController.currencySymbol}${priceItem.price.toString()}/min)"
              : "${configController.currencySymbol}${priceItem.price.toString()}/min";
          break;
        case AppConstants.video:
          videoRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty
              ? "FREE"
              : actualPrice.isNotEmpty && double.tryParse(actualPrice) != null && double.parse(actualPrice) > 0
              ? "${configController.currencySymbol}$actualPrice/min (${configController.currencySymbol}${priceItem.price.toString()}/min)"
              : "${configController.currencySymbol}${priceItem.price.toString()}/min";
          break;
      }
    });
   /* astrologer.prices?.forEach((priceItem) {
      String type = priceItem.type.toString();
      switch (type) {
        case AppConstants.chat:
          chatRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty ? "FREE" : "${configController.currencySymbol}${priceItem.price.toString()}/min";
          break;
        case AppConstants.call:
          callRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty ? "FREE" : "${configController.currencySymbol}${priceItem.price.toString()}/min";
          break;
        case AppConstants.video:
          videoRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty ? "FREE" : "${configController.currencySymbol}${priceItem.price.toString()}/min";
          break;
      }
    });*/ //Old code commented out due to Added Parameter Actual Price
    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8),
        child: Stack(
          children: [
            Container(
              // decoration: CustomBoxDecoration.getDecoration(),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                // border: Border.all(color: ColorResources.colorPrimary, width: 0.6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 12,
                    offset: const Offset(2, 10),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (astrologer.tag != null && astrologer.tag != "none") ...[
                          const Gap(15),
                        ],
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: ColorResources.colorPrimary,width: Dimensions.profileBorderWidth),
                          ),
                          child: CustomRoundNetworkImage(
                              imageUrl: astrologer.astroImg.toString(),
                              height: 70,
                              width: 70),
                        ),
                        const Gap(6),
                        CustomTextRegular(
                          astrologer.onlineStatus == 1 &&
                                  astrologer.busyStatus == 1
                              ? "BUSY"
                              : astrologer.chatStatus == 1 ||
                              astrologer.callStatus == 1 ||
                              astrologer.videoStatus == 1
                                  ? "ONLINE"
                                  : "OFFLINE",
                          fontSize: Dimensions.fontSizeDefault,
                          color: astrologer.onlineStatus == 1 &&
                                  astrologer.busyStatus == 1
                              ? ColorResources.orange
                              : astrologer.chatStatus == 1 ||
                              astrologer.callStatus == 1 ||
                              astrologer.videoStatus == 1
                                  ? ColorResources.green
                                  : ColorResources.red,
                        ),
                        const Gap(2),
                        ConstrainedBox(
                            constraints: const BoxConstraints(
                                maxWidth: 90
                            ),
                            child: CustomTextRegular("Orders: ${astrologer.totalOrderCount.toString()}",color: ColorResources.black4,fontSize: 13)),
                        const Gap(2),
                        CustomRatingIcons(
                          rating: double.parse(
                              astrologer.user!.avgRating.toString()),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTextMedium(astrologer.displayName.toString(),
                              maxLines: 1, fontSize: Dimensions.fontSizeLarge),
                          const Gap(2),
                          CustomTextRegular(
                            astrologer.categoryNames.toString(),
                            maxLines: 2,
                            fontSize: Dimensions.fontSizeSmall,
                            color: ColorResources.colorSecondaryDark,
                          ),
                          const Gap(2),
                          CustomTextRegular(
                            astrologer.languageName.toString(),
                            maxLines: 2,
                            fontSize: Dimensions.fontSizeSmall,
                            color: ColorResources.black1,
                          ),
                          const Gap(2),
                          CustomTextRegular(
                              "Exp: ${astrologer.experience.toString()} years",
                              maxLines: 2,
                              fontSize: Dimensions.fontSizeSmall,
                              color: ColorResources.black1),
                          const Gap(8),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // if (astrologer.callStatus == 1)
                                  GestureDetector(
                                    onTap: () async {
                                      bool isLogin = await SharedPreferencesHelper.getIsLogin();
                                      if (isLogin && astrologer.callStatus == 1) {
                                        if(AppFeatures.minimumBalanceRequired){
                                          astrologer.prices?.forEach((priceItem) {
                                            String type = priceItem.type.toString();
                                            switch (type) {
                                              case AppConstants.chat:
                                                chatRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty ? "FREE" : priceItem.price.toString();
                                                break;
                                              case AppConstants.call:
                                                callRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty ? "FREE" : priceItem.price.toString();
                                                break;
                                              case AppConstants.video:
                                                videoRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty ? "FREE" : priceItem.price.toString();
                                                break;
                                            }
                                          });
                            
                                          // Now handle the chatRate logic
                                          if (chatRate == "FREE") {
                                            astrologerProfileController.checkCallDetail(
                                                AppConstants.call,
                                                astrologer.astrologerUniId.toString(),
                                                astrologer
                                            );
                                          } else {
                                            // Convert chatRate from String to double
                                            double callRateValue = double.tryParse(callRate) ?? 0.0;
                                            double minimumBalance = callRateValue * 5;
                            
                                            // Convert wallet balance to double
                                            double walletBalance = double.tryParse(dashboardController.walletBalanceModel.data.toString()) ?? 0.0;
                            
                                            if (walletBalance >= minimumBalance) {
                                              astrologerProfileController.checkCallDetail(
                                                  AppConstants.call,
                                                  astrologer.astrologerUniId.toString(),
                                                  astrologer
                                              );
                                            } else {
                                              CommonMethods().showInsufficientBalanceBottomSheet(AppConstants.call,astrologer.displayName.toString(),minimumBalance.toString());
                                              // CustomSnackBar.showBottom("Minimum balance of 5 minutes is required to start chat");
                                            }
                                          }
                                        }else{
                                          astrologerProfileController.checkCallDetail(
                                              AppConstants.call,
                                              astrologer.astrologerUniId.toString(),
                                              astrologer
                                          );
                                        }
                                      } else if (!isLogin) {
                                        Get.toNamed('/login');
                                      } else if (astrologer.callStatus == 0){
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                            content: Text("Astrologer currently unavailable for call"))
                                        );
                                      }
                                    },
                                    child: Container(
                                      // padding: EdgeInsets.symmetric(horizontal: videoRate == "FREE" ? 16.0 : 8.0, vertical: 2),
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: astrologer.callStatus == 1 && astrologer.busyStatus != 1
                                            ? ColorResources.green
                                            : ColorResources.black7,
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(Images.astroCall,
                                              height: 14,
                                            color: astrologer.callStatus == 1 && astrologer.busyStatus == 1
                                                ? Colors.red
                                                : astrologer.callStatus == 1
                                                ? ColorResources.white
                                                : ColorResources.colorText
                                            // color: astrologer.callStatus == 1
                                            //     ? ColorResources.white
                                            //     : ColorResources.colorText
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              if (callRate.contains("(")) ...[
                                                Text(
                                                  callRate.split(' ')[0],
                                                  style: const TextStyle(
                                                    color: Colors.red,
                                                    decoration: TextDecoration.lineThrough,
                                                    decorationColor: Colors.red,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                                CustomTextRegular(
                                                  callRate.split(' ')[1],
                                                  color: astrologer.callStatus == 1 && astrologer.busyStatus == 1
                                                      ? Colors.red
                                                      : astrologer.callStatus == 1
                                                      ? ColorResources.white
                                                      : ColorResources.colorText,
                                                  fontSize: 11,
                                                ),
                                              ] else
                                                CustomTextRegular(
                                                  callRate,
                                                  color: astrologer.callStatus == 1 && astrologer.busyStatus == 1
                                                      ? Colors.red
                                                      : astrologer.callStatus == 1
                                                      ? ColorResources.white
                                                      : ColorResources.colorText,
                                                    fontSize: 11
                                                ),
                                            ],
                                          ),
                                          /*CustomTextRegular(callRate,
                                              color: astrologer.callStatus == 1 && astrologer.busyStatus == 1
                                                  ? Colors.red
                                                  : astrologer.callStatus == 1
                                                  ? ColorResources.white
                                                  : ColorResources.colorText,
                                              fontSize: 11),*/ //Old code commented out due to Added Parameter Actual Price
                                        ],
                                      ),
                                    ),
                                  ),
                                const Gap(5),
                                // if (astrologer.chatStatus == 1)
                                GestureDetector(
                                  onTap: () async {
                                    bool isLogin = await SharedPreferencesHelper.getIsLogin();
                                    if (isLogin && astrologer.chatStatus == 1) {
                                      if(AppFeatures.minimumBalanceRequired){
                                        astrologer.prices?.forEach((priceItem) {
                                          String type = priceItem.type.toString();
                                          switch (type) {
                                            case AppConstants.chat:
                                              chatRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty ? "FREE" : priceItem.price.toString();
                                              break;
                                            case AppConstants.call:
                                              callRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty ? "FREE" : priceItem.price.toString();
                                              break;
                                            case AppConstants.video:
                                              videoRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty ? "FREE" : priceItem.price.toString();
                                              break;
                                          }
                                        });
                            
                                        // Now handle the chatRate logic
                                        if (chatRate == "FREE") {
                                          astrologerProfileController.checkCallDetail(
                                              AppConstants.chat,
                                              astrologer.astrologerUniId.toString(),
                                              astrologer
                                          );
                                        } else {
                                          // Convert chatRate from String to double
                                          double chatRateValue = double.tryParse(chatRate) ?? 0.0;
                                          double minimumBalance = chatRateValue * 5;
                            
                                          // Convert wallet balance to double
                                          double walletBalance = double.tryParse(dashboardController.walletBalanceModel.data.toString()) ?? 0.0;
                            
                                          if (walletBalance >= minimumBalance) {
                                            astrologerProfileController.checkCallDetail(
                                                AppConstants.chat,
                                                astrologer.astrologerUniId.toString(),
                                                astrologer
                                            );
                                          } else {
                                            CommonMethods().showInsufficientBalanceBottomSheet(AppConstants.chat,astrologer.displayName.toString(),minimumBalance.toString());
                                            // CustomSnackBar.showBottom("Minimum balance of 5 minutes is required to start chat");
                                          }
                                        }
                                      }else{
                                        astrologerProfileController.checkCallDetail(
                                            AppConstants.chat,
                                            astrologer.astrologerUniId.toString(),
                                            astrologer
                                        );
                                      }
                            
                                    } else if (!isLogin) {
                                      Get.toNamed('/login');
                                    } else if (astrologer.chatStatus == 0){
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          content: Text("Astrologer currently unavailable for chat"))
                                      );
                                    }
                                  },
                                  child: Container(
                                    // padding: EdgeInsets.symmetric(horizontal: videoRate == "FREE" ? 16.0 : 8.0, vertical: 2),
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: astrologer.chatStatus == 1 && astrologer.busyStatus != 1
                                          ? ColorResources.green
                                          : ColorResources.black7,
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(Images.astroChat,
                                            height: 14,
                                            color: astrologer.chatStatus == 1 && astrologer.busyStatus == 1
                                                ? Colors.red
                                                : astrologer.chatStatus == 1
                                                ? ColorResources.white
                                                : ColorResources.colorText
                                          // color: astrologer.callStatus == 1
                                          //     ? ColorResources.white
                                          //     : ColorResources.colorText
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (chatRate.contains("(")) ...[
                                              Text(
                                                chatRate.split(' ')[0],
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                  decoration: TextDecoration.lineThrough,
                                                  decorationColor: Colors.red,
                                                  fontSize: 11,
                                                ),
                                              ),
                                              CustomTextRegular(
                                                chatRate.split(' ')[1],
                                                color: astrologer.chatStatus == 1 && astrologer.busyStatus == 1
                                                    ? Colors.red
                                                    : astrologer.chatStatus == 1
                                                    ? ColorResources.white
                                                    : ColorResources.colorText,
                                                  fontSize: 11,
                                              ),
                                            ] else
                                              CustomTextRegular(
                                                chatRate,
                                                  color: astrologer.chatStatus == 1 && astrologer.busyStatus == 1
                                                      ? Colors.red
                                                      : astrologer.chatStatus == 1
                                                      ? ColorResources.white
                                                      : ColorResources.colorText,
                                                  fontSize: 11
                                              ),
                                          ],
                                        ),
                                        /*CustomTextRegular(chatRate,
                                            color: astrologer.chatStatus == 1 && astrologer.busyStatus == 1
                                                ? Colors.red
                                                : astrologer.chatStatus == 1
                                                ? ColorResources.white
                                                : ColorResources.colorText,
                                            fontSize: 11),*/
                                      ],
                                    ),
                                  ),
                                ),
                                const Gap(5),
                                // if (astrologer.videoStatus == 1)
                                GestureDetector(
                                  onTap: () async {
                                    bool isLogin = await SharedPreferencesHelper.getIsLogin();
                                    if (isLogin && astrologer.videoStatus == 1) {
                                      if(AppFeatures.minimumBalanceRequired){
                                        astrologer.prices?.forEach((priceItem) {
                                          String type = priceItem.type.toString();
                                          switch (type) {
                                            case AppConstants.chat:
                                              chatRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty ? "FREE" : priceItem.price.toString();
                                              break;
                                            case AppConstants.call:
                                              callRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty ? "FREE" : priceItem.price.toString();
                                              break;
                                            case AppConstants.video:
                                              videoRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty ? "FREE" : priceItem.price.toString();
                                              break;
                                          }
                                        });
                            
                                        // Now handle the chatRate logic
                                        if (chatRate == "FREE") {
                                          astrologerProfileController.checkCallDetail(
                                              AppConstants.video,
                                              astrologer.astrologerUniId.toString(),
                                              astrologer
                                          );
                                        } else {
                                          // Convert chatRate from String to double
                                          double videoRateValue = double.tryParse(videoRate) ?? 0.0;
                                          double minimumBalance = videoRateValue * 5;
                            
                                          // Convert wallet balance to double
                                          double walletBalance = double.tryParse(dashboardController.walletBalanceModel.data.toString()) ?? 0.0;
                            
                                          if (walletBalance >= minimumBalance) {
                                            astrologerProfileController.checkCallDetail(
                                                AppConstants.video,
                                                astrologer.astrologerUniId.toString(),
                                                astrologer
                                            );
                                          } else {
                                            CommonMethods().showInsufficientBalanceBottomSheet(AppConstants.video,astrologer.displayName.toString(),minimumBalance.toString());
                                            // CustomSnackBar.showBottom("Minimum balance of 5 minutes is required to start chat");
                                          }
                                        }
                                      }else{
                                        astrologerProfileController.checkCallDetail(
                                            AppConstants.video,
                                            astrologer.astrologerUniId.toString(),
                                            astrologer
                                        );
                                      }
                            
                                    } else if (!isLogin) {
                                      Get.toNamed('/login');
                                    } else if (astrologer.videoStatus == 0){
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          content: Text("Astrologer currently unavailable for video call"))
                                      );
                                    }
                                  },
                                  child: Container(
                                    // padding: EdgeInsets.symmetric(horizontal: videoRate == "FREE" ? 16.0 : 8.0, vertical: 2),
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: astrologer.videoStatus == 1 && astrologer.busyStatus != 1
                                          ? ColorResources.green
                                          : ColorResources.black7,
                                    ),
                                    child: Column(
                                      children: [
                                        Image.asset(Images.astroVideoCall,
                                            height: 14,
                                            color: astrologer.videoStatus == 1 && astrologer.busyStatus == 1
                                                ? Colors.red
                                                : astrologer.videoStatus == 1
                                                ? ColorResources.white
                                                : ColorResources.colorText
                                          // color: astrologer.callStatus == 1
                                          //     ? ColorResources.white
                                          //     : ColorResources.colorText
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (videoRate.contains("(")) ...[
                                              Text(
                                                videoRate.split(' ')[0],
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                  decoration: TextDecoration.lineThrough,
                                                  decorationColor: Colors.red,
                                                  fontSize: 11,
                                                ),
                                              ),
                                              CustomTextRegular(
                                                videoRate.split(' ')[1],
                                                color: astrologer.videoStatus == 1 && astrologer.busyStatus == 1
                                                    ? Colors.red
                                                    : astrologer.videoStatus == 1
                                                    ? ColorResources.white
                                                    : ColorResources.colorText,
                                                  fontSize: 11,

                                              ),
                                            ] else
                                              CustomTextRegular(
                                                videoRate,
                                                color: astrologer.videoStatus == 1 && astrologer.busyStatus == 1
                                                    ? Colors.red
                                                    : astrologer.videoStatus == 1
                                                    ? ColorResources.white
                                                    : ColorResources.colorText,
                                                fontSize: 11,
                                              ),
                                          ],
                                        ),
                                        /*CustomTextRegular(videoRate,
                                            color: astrologer.videoStatus == 1 && astrologer.busyStatus == 1
                                                ? Colors.red
                                                : astrologer.videoStatus == 1
                                                ? ColorResources.white
                                                : ColorResources.colorText,
                                            fontSize: 11),*/
                                      ],
                                    ),
                                  ),
                                ),
                                // if (astrologer.callStatus == 0 &&
                                //     astrologer.chatStatus == 0 &&
                                //     astrologer.videoStatus == 0)
                                //   CustomTextRegular(
                                //     "Offline (Available Soon)",
                                //     color: ColorResources.black2,
                                //   ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: CommonMethods().getAstroTag(astrologer.tag.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAstroTag(String tag) {
    if (tag == "vip") {
      return Padding(
        padding: const EdgeInsets.only(top: 2.0, left: 2),
        child: Lottie.asset(
          Images.astroVipTag,
          // width: 35,
          height: 30,
          fit: BoxFit.contain,
        ),
      );
    } else if (tag == "most_choice") {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Image.asset(
          Images.astroMostChoiceTag,
          height: 35,
        ),
      );
    } else if (tag == "top_choice") {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Image.asset(
          Images.astroTopChoiceTag,
          height: 35,
        ),
      );
    } else if (tag == "New") {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Image.asset(
          Images.astroNewTag,
          height: 35,
        ),
      );
    } else if (tag == "rising_star") {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Image.asset(
          Images.astroRisingStarTag,
          height: 35,
        ),
      );
    }else if (tag == "premium") {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Image.asset(
          Images.astroPremiumTag,
          height: 35,
        ),
      );
    }else if (tag == "celebrity") {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Image.asset(
          Images.astroCelebrityTag,
          height: 35,
        ),
      );
    } else {
      // Default image if none of the conditions match
      return const SizedBox();
    }
  }

  // void showInsufficientBalanceBottomSheet(String type, String astrologerName, String minimumAmount) {
  //   final WalletController walletController = Get.put(WalletController());
  //   Get.bottomSheet(
  //     Container(
  //       height: Get.height*0.4,
  //       decoration: const BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(10),
  //           topRight: Radius.circular(10),
  //         ),
  //       ),
  //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 CustomTextMedium(
  //                     "Add money to Wallet",
  //                     fontSize: 18
  //                 ),
  //                 InkWell(
  //                     onTap: () {
  //                       Get.back();
  //                     },
  //                     child: const Icon(
  //                       Icons.cancel,
  //                       color: ColorResources.black2,
  //                     ))
  //               ],
  //             ),
  //           ),
  //           const Divider(
  //             color: ColorResources.black6,
  //             height: 1,
  //           ),
  //
  //           const Gap(8),
  //
  //           // Subtitle
  //           CustomTextRegular(
  //             "Minimum balance of 5 minutes (${configController.currencySymbol}$minimumAmount) is required to start $type with $astrologerName",
  //             color: Colors.red,
  //             // fontSize: 15,
  //           ),
  //
  //           const Gap(8),
  //
  //           CustomTextRegular(
  //             "Tip: 90% Users recharge for 10 minutes or more",
  //             color: ColorResources.black4,
  //           ),
  //
  //           const Gap(20),
  //           Obx(
  //                 () {
  //               if (walletController.isVoucherSuccess.isTrue) {
  //                 // GridView for recharge options
  //                 return Expanded(
  //                   child: GridView.builder(
  //                     shrinkWrap: true,
  //                     itemCount: walletController.walletModel.data?.length,
  //                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //                       crossAxisCount: 3,
  //                       crossAxisSpacing: 10,
  //                       mainAxisSpacing: 10,
  //                       childAspectRatio: 2,
  //                     ),
  //                     itemBuilder: (context, index) {
  //                       return GestureDetector(
  //                         onTap: () {
  //                           walletController.selectVoucher(index);
  //                           Get.to(() => const WalletScreen(), arguments: {
  //                             'voucher': walletController.walletModel.data?[index],
  //                           });
  //                         },
  //                         child: Container(
  //                           decoration: BoxDecoration(
  //                             border: Border.all(color: ColorResources.colorPrimary),
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.center,
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             children: [
  //                               CustomTextRegular(
  //                                 "${configController.currencySymbol}${walletController.walletModel.data?[index].walletAmount}",
  //                                 // fontSize: Dimensions.fontSizeLarge,
  //                               ),
  //                               CustomTextRegular(
  //                                 "${AppStrings.extra.tr} ${configController.currencySymbol}${walletController.walletModel.data?[index].giftAmount}",
  //                                 fontSize: Dimensions.fontSizeSmall,
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 );
  //               } else if (walletController.isVoucherLoading.isTrue) {
  //                 return const CustomProgressIndicator();
  //               } else {
  //                 return const EmptyScreen();
  //               }
  //             },
  //           )
  //
  //         ],
  //       ),
  //     ),
  //     isScrollControlled: true, // Ensures full-screen scrollable bottom sheet
  //   );
  // }
}
