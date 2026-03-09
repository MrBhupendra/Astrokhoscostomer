import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:astro_brahmand/utill/images.dart';
import 'package:astro_brahmand/view/screen/astrologer_detail/controller/astrologer_profile_controller.dart';
import 'package:astro_brahmand/view/screen/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/view/widget/custom_round_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:get/get.dart';

import '../../model/astrologer_model.dart';
import '../../utill/app_constants.dart';
import '../../utill/app_features.dart';
import '../../utill/app_strings.dart';
import '../../utill/dimensions.dart';
import '../../utill/shared_preference.dart';
import '../screen/splash/controller/config_controller.dart';
import 'custom_snack_bar.dart';

class CallChatAstrologerWidget extends StatelessWidget {
  final AstrologerData astrologer;
  final Function? onPressed;
  final String type;

  const CallChatAstrologerWidget(this.astrologer,
      {this.onPressed, required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();
    // final AstrologerProfileController astrologerProfileController = Get.put(AstrologerProfileController());
    // final DashboardController dashboardController = Get.put(DashboardController());
    AstrologerProfileController astrologerProfileController = AstrologerProfileController();
    DashboardController dashboardController = DashboardController();
    RxBool isFollow = (astrologer.isFollow ?? false).obs;
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
    /*astrologer.prices?.forEach((priceItem) {
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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey, width: 0.6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    blurRadius: 12,
                    offset: const Offset(2, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 8, left: 8, right: 8),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (astrologer.tag != null && astrologer.tag != "none") ...[
                              const Gap(10),
                            ],
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ColorResources.colorPrimary,
                                  width: 1.5,
                                ),
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
                                  : astrologer.onlineStatus == 1
                                      ? ColorResources.green
                                      : ColorResources.red,
                            ),
                            // const Gap(2),
                            // ConstrainedBox(
                            //     constraints: const BoxConstraints(maxWidth: 90),
                            //     child: CustomTextRegular(
                            //         "Orders: ${astrologer.totalOrderCount.toString()}",
                            //         color: ColorResources.black4,
                            //         fontSize: 13)),
                            // const Gap(2),
                            // CustomRatingIcons(
                            //   rating: double.parse(
                            //       astrologer.user!.avgRating.toString()),
                            // ),
                          ],
                        ),
                        const Gap(14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextMedium(
                                      astrologer.displayName.toString(),
                                      maxLines: 2,
                                      fontSize: Dimensions.fontSizeLarge,
                                    ),
                                  ),

                                  const Gap(6),

                                  Obx(() => GestureDetector(
                                    onTap: () {
                                      if (isFollow.value) {
                                        showUnfollowDialog(astrologerProfileController, astrologer, isFollow);
                                      } else {
                                        astrologerProfileController.astrologerFollow(
                                            "1", astrologer.astrologerUniId.toString());

                                        isFollow.value = true;

                                        CustomSnackBar.showTop(AppStrings.astroFollowMsg);
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: isFollow.value
                                            ? ColorResources.white
                                            : ColorResources.colorPrimary,
                                        border: isFollow.value
                                            ? Border.all(color: ColorResources.colorPrimary)
                                            : null,
                                        borderRadius:
                                        BorderRadius.circular(Dimensions.borderRadiusDefault),
                                      ),
                                      child: CustomTextRegular(
                                        isFollow.value ? "Following" : "Follow",
                                        fontSize: Dimensions.fontSizeSmall,
                                        color: isFollow.value
                                            ? ColorResources.colorPrimary
                                            : ColorResources.toolbarText,
                                      ),
                                    ),
                                  )),
                                ],
                              ),
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
                              const Gap(4),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.star_rounded, color: Colors.orange, size: 16),
                                  const SizedBox(width: 3),
                                  Text("${astrologer.reviewCount} • ${astrologer.totalOrderCount} orders",
                                      style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                                ],
                              ),
                              const Gap(5),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: [
                              //     type == AppConstants.call
                              //         ? Padding(
                              //       padding: const EdgeInsets.all(8.0),
                              //       child: Column(
                              //         mainAxisSize: MainAxisSize.min,
                              //         children: [
                              //           if (callRate.contains("(")) ...[
                              //             Text(
                              //               callRate.split(' ')[0],
                              //               style: const TextStyle(
                              //                 color: Colors.red,
                              //                 decoration: TextDecoration.lineThrough,
                              //                 decorationColor: Colors.red,
                              //                 fontSize: 13,
                              //               ),
                              //             ),
                              //             CustomTextRegular(
                              //               callRate.split(' ')[1],
                              //               color: ColorResources.red,
                              //             ),
                              //           ] else
                              //             CustomTextRegular(
                              //               callRate,
                              //               maxLines: 1,
                              //               fontSize: Dimensions.fontSizeLarge,
                              //               color: ColorResources.red
                              //             ),
                              //         ],
                              //       ),
                              //     )
                              //         : Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Column(
                              //             mainAxisSize: MainAxisSize.min,
                              //             children: [
                              //           if (chatRate.contains("(")) ...[
                              //             Text(
                              //               chatRate.split(' ')[0],
                              //               style: const TextStyle(
                              //                 color: Colors.red,
                              //                 decoration:
                              //                 TextDecoration.lineThrough,
                              //                 decorationColor: Colors.red,
                              //                 fontSize: 13,
                              //               ),
                              //             ),
                              //             CustomTextRegular(
                              //               chatRate.split(' ')[1],
                              //               color: ColorResources.red,
                              //               // fontSize: 11,
                              //             ),
                              //           ] else
                              //             CustomTextRegular(
                              //                 chatRate,
                              //                 maxLines: 1,
                              //                 fontSize: Dimensions.fontSizeLarge,
                              //                 color: ColorResources.red
                              //             ),
                              //                                           ],
                              //                                         ),
                              //         ),
                              //
                              //     /*Expanded(
                              //         child: CustomTextRegular(
                              //             type == AppConstants.call ? callRate : chatRate,
                              //             maxLines: 1,
                              //             fontSize: Dimensions.fontSizeLarge,
                              //             color: ColorResources.red
                              //         ),
                              //       ),*/ //Old code commented out due to Added Parameter Actual Price
                              //     const Spacer(),
                              //     if (type == AppConstants.chat)
                              //       GestureDetector(
                              //         onTap: () async {
                              //           bool isLogin = await SharedPreferencesHelper
                              //               .getIsLogin();
                              //           if (isLogin) {
                              //             if (AppFeatures.minimumBalanceRequired) {
                              //               astrologer.prices?.forEach((priceItem) {
                              //                 String type =
                              //                     priceItem.type.toString();
                              //                 switch (type) {
                              //                   case AppConstants.chat:
                              //                     chatRate = priceItem
                              //                             .firstCallFreeMinutes
                              //                             .toString()
                              //                             .isNotEmpty
                              //                         ? "FREE"
                              //                         : priceItem.price.toString();
                              //                     break;
                              //                   case AppConstants.call:
                              //                     callRate = priceItem
                              //                             .firstCallFreeMinutes
                              //                             .toString()
                              //                             .isNotEmpty
                              //                         ? "FREE"
                              //                         : priceItem.price.toString();
                              //                     break;
                              //                   case AppConstants.video:
                              //                     videoRate = priceItem
                              //                             .firstCallFreeMinutes
                              //                             .toString()
                              //                             .isNotEmpty
                              //                         ? "FREE"
                              //                         : priceItem.price.toString();
                              //                     break;
                              //                 }
                              //               });
                              //
                              //               // Now handle the chatRate logic
                              //               if (chatRate == "FREE") {
                              //                 astrologerProfileController
                              //                     .checkCallDetail(
                              //                         AppConstants.chat,
                              //                         astrologer.astrologerUniId
                              //                             .toString(),
                              //                         astrologer);
                              //               } else {
                              //                 // Convert chatRate from String to double
                              //                 double chatRateValue =
                              //                     double.tryParse(chatRate) ?? 0.0;
                              //                 double minimumBalance =
                              //                     chatRateValue * 5;
                              //
                              //                 // Convert wallet balance to double
                              //                 double walletBalance =
                              //                     double.tryParse(
                              //                             dashboardController
                              //                                 .walletBalanceModel
                              //                                 .data
                              //                                 .toString()) ??
                              //                         0.0;
                              //
                              //                 if (walletBalance >= minimumBalance) {
                              //                   astrologerProfileController
                              //                       .checkCallDetail(
                              //                           AppConstants.chat,
                              //                           astrologer.astrologerUniId
                              //                               .toString(),
                              //                           astrologer);
                              //                 } else {
                              //                   CommonMethods()
                              //                       .showInsufficientBalanceBottomSheet(
                              //                           AppConstants.chat,
                              //                           astrologer.displayName
                              //                               .toString(),
                              //                           minimumBalance.toString());
                              //                   // CustomSnackBar.showBottom("Minimum balance of 5 minutes is required to start chat");
                              //                 }
                              //               }
                              //             } else {
                              //               astrologerProfileController
                              //                   .checkCallDetail(
                              //                       AppConstants.chat,
                              //                       astrologer.astrologerUniId
                              //                           .toString(),
                              //                       astrologer);
                              //             }
                              //           } else {
                              //             Get.toNamed('/login');
                              //           }
                              //         },
                              //         child: Container(
                              //           padding: const EdgeInsets.symmetric(
                              //               vertical: 6, horizontal: 10),
                              //           decoration: BoxDecoration(
                              //             borderRadius: BorderRadius.circular(10.0),
                              //             border: Border.all(
                              //               color: astrologer.chatStatus == 1 &&
                              //                       astrologer.busyStatus == 1
                              //                   ? Colors.red
                              //                   : Colors.green,
                              //             ),
                              //           ),
                              //           child: Row(
                              //             children: [
                              //               SvgPicture.asset(
                              //                 Images.icChat,
                              //                 height: 16,
                              //                 // color: Colors.green
                              //                 colorFilter: ColorFilter.mode(
                              //                   astrologer.chatStatus == 1 &&
                              //                           astrologer.busyStatus == 1
                              //                       ? Colors.red
                              //                       : Colors.green,
                              //                   BlendMode.srcIn,
                              //                 ),
                              //                 // color: astrologer.chatStatus == 1 && astrologer.busyStatus == 1
                              //                 //     ? Colors.red
                              //                 //     : Colors.green,
                              //               ),
                              //               const Gap(6),
                              //               Text("Chat",
                              //                   // color: Colors.green,
                              //                   style: TextStyle(
                              //                       color: astrologer.chatStatus ==
                              //                                   1 &&
                              //                               astrologer.busyStatus ==
                              //                                   1
                              //                           ? Colors.red
                              //                           : Colors.green,
                              //                       fontSize: 14,
                              //                       fontFamily: "Poppins")),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     if (type == AppConstants.call)
                              //       GestureDetector(
                              //         onTap: () async {
                              //           bool isLogin = await SharedPreferencesHelper
                              //               .getIsLogin();
                              //           if (isLogin) {
                              //             if (AppFeatures.minimumBalanceRequired) {
                              //               astrologer.prices?.forEach((priceItem) {
                              //                 String type =
                              //                     priceItem.type.toString();
                              //                 switch (type) {
                              //                   case AppConstants.chat:
                              //                     chatRate = priceItem
                              //                             .firstCallFreeMinutes
                              //                             .toString()
                              //                             .isNotEmpty
                              //                         ? "FREE"
                              //                         : priceItem.price.toString();
                              //                     break;
                              //                   case AppConstants.call:
                              //                     callRate = priceItem
                              //                             .firstCallFreeMinutes
                              //                             .toString()
                              //                             .isNotEmpty
                              //                         ? "FREE"
                              //                         : priceItem.price.toString();
                              //                     break;
                              //                   case AppConstants.video:
                              //                     videoRate = priceItem
                              //                             .firstCallFreeMinutes
                              //                             .toString()
                              //                             .isNotEmpty
                              //                         ? "FREE"
                              //                         : priceItem.price.toString();
                              //                     break;
                              //                 }
                              //               });
                              //
                              //               // Now handle the chatRate logic
                              //               if (chatRate == "FREE") {
                              //                 astrologerProfileController
                              //                     .checkCallDetail(
                              //                         AppConstants.call,
                              //                         astrologer.astrologerUniId
                              //                             .toString(),
                              //                         astrologer);
                              //               } else {
                              //                 // Convert chatRate from String to double
                              //                 double callRateValue =
                              //                     double.tryParse(callRate) ?? 0.0;
                              //                 double minimumBalance =
                              //                     callRateValue * 5;
                              //
                              //                 // Convert wallet balance to double
                              //                 double walletBalance =
                              //                     double.tryParse(
                              //                             dashboardController
                              //                                 .walletBalanceModel
                              //                                 .data
                              //                                 .toString()) ??
                              //                         0.0;
                              //
                              //                 if (walletBalance >= minimumBalance) {
                              //                   astrologerProfileController
                              //                       .checkCallDetail(
                              //                           AppConstants.call,
                              //                           astrologer.astrologerUniId
                              //                               .toString(),
                              //                           astrologer);
                              //                 } else {
                              //                   CommonMethods()
                              //                       .showInsufficientBalanceBottomSheet(
                              //                           AppConstants.call,
                              //                           astrologer.displayName
                              //                               .toString(),
                              //                           minimumBalance.toString());
                              //                   // CustomSnackBar.showBottom("Minimum balance of 5 minutes is required to start chat");
                              //                 }
                              //               }
                              //             } else {
                              //               astrologerProfileController
                              //                   .checkCallDetail(
                              //                       AppConstants.call,
                              //                       astrologer.astrologerUniId
                              //                           .toString(),
                              //                       astrologer);
                              //             }
                              //           } else {
                              //             Get.toNamed('/login');
                              //           }
                              //         },
                              //         child: Container(
                              //           padding: const EdgeInsets.symmetric(
                              //               vertical: 6, horizontal: 10),
                              //           decoration: BoxDecoration(
                              //             borderRadius: BorderRadius.circular(10.0),
                              //             border: Border.all(
                              //               color: astrologer.callStatus == 1 &&
                              //                       astrologer.busyStatus == 1
                              //                   ? Colors.red
                              //                   : Colors.green,
                              //             ),
                              //           ),
                              //           child: Row(
                              //             children: [
                              //               SvgPicture.asset(
                              //                 Images.icCall,
                              //                 height: 16,
                              //                 // color: Colors.green
                              //                 colorFilter: ColorFilter.mode(
                              //                   astrologer.callStatus == 1 &&
                              //                           astrologer.busyStatus == 1
                              //                       ? Colors.red
                              //                       : Colors.green,
                              //                   BlendMode.srcIn,
                              //                 ),
                              //                 // color: astrologer.chatStatus == 1 && astrologer.busyStatus == 1
                              //                 //     ? Colors.red
                              //                 //     : Colors.green,
                              //               ),
                              //               const Gap(6),
                              //               Text("Call",
                              //                   // color: Colors.green,
                              //                   style: TextStyle(
                              //                       color: astrologer.callStatus ==
                              //                                   1 &&
                              //                               astrologer.busyStatus ==
                              //                                   1
                              //                           ? Colors.red
                              //                           : Colors.green,
                              //                       fontSize: 14,
                              //                       fontFamily: "Poppins")),
                              //             ],
                              //           ),
                              //         ),
                              //       ),
                              //     const Gap(5)
                              //   ],
                              // ),
                              // Row(
                              //   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //   children: [
                              //     if (astrologer.callStatus == 1)
                              //       Container(
                              //         // padding: EdgeInsets.symmetric(horizontal: videoRate == "FREE" ? 16.0 : 8.0, vertical: 2),
                              //         padding: const EdgeInsets.symmetric(
                              //             horizontal: 8.0, vertical: 2),
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(8),
                              //           color: ColorResources.green,
                              //         ),
                              //         child: Column(
                              //           children: [
                              //             Image.asset(Images.astroCall,
                              //                 height: 14,
                              //                 color: ColorResources.white),
                              //             CustomTextRegular(callRate,
                              //                 color: ColorResources.white,
                              //                 fontSize: 11),
                              //           ],
                              //         ),
                              //       ),
                              //     const Gap(5),
                              //     if (astrologer.chatStatus == 1)
                              //       Container(
                              //         padding: const EdgeInsets.symmetric(
                              //             horizontal: 8.0, vertical: 2),
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(8),
                              //           color: ColorResources.green,
                              //         ),
                              //         child: Column(
                              //           children: [
                              //             Image.asset(Images.astroChat,
                              //                 height: 14,
                              //                 color: ColorResources.white),
                              //             CustomTextRegular(chatRate,
                              //                 color: ColorResources.white,
                              //                 fontSize: 11),
                              //           ],
                              //         ),
                              //       ),
                              //     const Gap(5),
                              //     if (astrologer.videoStatus == 1)
                              //       Container(
                              //         padding: const EdgeInsets.symmetric(
                              //             horizontal: 8.0, vertical: 2),
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(8),
                              //           color: ColorResources.green,
                              //         ),
                              //         child: Column(
                              //           children: [
                              //             Image.asset(Images.astroVideoCall,
                              //                 height: 14,
                              //                 color: ColorResources.white),
                              //             CustomTextRegular(videoRate,
                              //                 color: ColorResources.white,
                              //                 fontSize: 11),
                              //           ],
                              //         ),
                              //       ),
                              //     if (astrologer.callStatus == 0 &&
                              //         astrologer.chatStatus == 0 &&
                              //         astrologer.videoStatus == 0)
                              //       CustomTextRegular(
                              //         "Offline (Available Soon)",
                              //         color: ColorResources.black2,
                              //       ),
                              //   ],
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),

                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.08),
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        type == AppConstants.call
                            ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (callRate.contains("(")) ...[
                                Text(
                                  callRate.split(' ')[0],
                                  style: const TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red,
                                    fontSize: 13,
                                  ),
                                ),
                                CustomTextRegular(
                                  callRate.split(' ')[1],
                                  color: ColorResources.red,
                                ),
                              ] else
                                CustomTextRegular(
                                    callRate,
                                    maxLines: 1,
                                    fontSize: Dimensions.fontSizeLarge,
                                    color: ColorResources.red
                                ),
                            ],
                          ),
                        )
                            : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (chatRate.contains("(")) ...[
                                Text(
                                  chatRate.split(' ')[0],
                                  style: const TextStyle(
                                    color: Colors.red,
                                    decoration:
                                    TextDecoration.lineThrough,
                                    decorationColor: Colors.red,
                                    fontSize: 13,
                                  ),
                                ),
                                CustomTextRegular(
                                  chatRate.split(' ')[1],
                                  color: ColorResources.red,
                                  // fontSize: 11,
                                ),
                              ] else
                                CustomTextRegular(
                                    chatRate,
                                    maxLines: 1,
                                    fontSize: Dimensions.fontSizeLarge,
                                    color: ColorResources.red
                                ),
                            ],
                          ),
                        ),

                        /*Expanded(
                                      child: CustomTextRegular(
                                          type == AppConstants.call ? callRate : chatRate,
                                          maxLines: 1,
                                          fontSize: Dimensions.fontSizeLarge,
                                          color: ColorResources.red
                                      ),
                                    ),*/ //Old code commented out due to Added Parameter Actual Price
                        // const Spacer(),
                        const Gap(25),
                        if (type == AppConstants.chat)
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                bool isLogin = await SharedPreferencesHelper.getIsLogin();
                                if (isLogin) {
                                  if (AppFeatures.minimumBalanceRequired) {
                                    astrologer.prices?.forEach((priceItem) {
                                      String type =
                                      priceItem.type.toString();
                                      switch (type) {
                                        case AppConstants.chat:
                                          chatRate = priceItem
                                              .firstCallFreeMinutes
                                              .toString()
                                              .isNotEmpty
                                              ? "FREE"
                                              : priceItem.price.toString();
                                          break;
                                        case AppConstants.call:
                                          callRate = priceItem
                                              .firstCallFreeMinutes
                                              .toString()
                                              .isNotEmpty
                                              ? "FREE"
                                              : priceItem.price.toString();
                                          break;
                                        case AppConstants.video:
                                          videoRate = priceItem
                                              .firstCallFreeMinutes
                                              .toString()
                                              .isNotEmpty
                                              ? "FREE"
                                              : priceItem.price.toString();
                                          break;
                                      }
                                    });
                            
                                    // Now handle the chatRate logic
                                    if (chatRate == "FREE") {
                                      astrologerProfileController
                                          .checkCallDetail(
                                          AppConstants.chat,
                                          astrologer.astrologerUniId
                                              .toString(),
                                          astrologer);
                                    } else {
                                      // Convert chatRate from String to double
                                      double chatRateValue =
                                          double.tryParse(chatRate) ?? 0.0;
                                      double minimumBalance =
                                          chatRateValue * 5;
                            
                                      // Convert wallet balance to double
                                      double walletBalance =
                                          double.tryParse(
                                              dashboardController
                                                  .walletBalanceModel
                                                  .data
                                                  .toString()) ??
                                              0.0;
                            
                                      if (walletBalance >= minimumBalance) {
                                        astrologerProfileController
                                            .checkCallDetail(
                                            AppConstants.chat,
                                            astrologer.astrologerUniId
                                                .toString(),
                                            astrologer);
                                      } else {
                                        CommonMethods()
                                            .showInsufficientBalanceBottomSheet(
                                            AppConstants.chat,
                                            astrologer.displayName
                                                .toString(),
                                            minimumBalance.toString());
                                        // CustomSnackBar.showBottom("Minimum balance of 5 minutes is required to start chat");
                                      }
                                    }
                                  } else {
                                    astrologerProfileController
                                        .checkCallDetail(
                                        AppConstants.chat,
                                        astrologer.astrologerUniId
                                            .toString(),
                                        astrologer);
                                  }
                                } else {
                                  Get.toNamed('/login');
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: ColorResources.colorPrimary,
                                  borderRadius: BorderRadius.circular(8.0),
                                  // border: Border.all(
                                  //   color: astrologer.chatStatus == 1 &&
                                  //       astrologer.busyStatus == 1
                                  //       ? Colors.red
                                  //       : Colors.green,
                                  // ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      Images.icChat,
                                      height: 16,
                                      // color: Colors.green
                                      colorFilter: const ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                      // color: astrologer.chatStatus == 1 && astrologer.busyStatus == 1
                                      //     ? Colors.red
                                      //     : Colors.green,
                                    ),
                                    const Gap(10),
                                    const Text("Chat Now",
                                        // color: Colors.green,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: "Poppins")),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        if (type == AppConstants.call)
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                bool isLogin = await SharedPreferencesHelper
                                    .getIsLogin();
                                if (isLogin) {
                                  if (AppFeatures.minimumBalanceRequired) {
                                    astrologer.prices?.forEach((priceItem) {
                                      String type =
                                      priceItem.type.toString();
                                      switch (type) {
                                        case AppConstants.chat:
                                          chatRate = priceItem
                                              .firstCallFreeMinutes
                                              .toString()
                                              .isNotEmpty
                                              ? "FREE"
                                              : priceItem.price.toString();
                                          break;
                                        case AppConstants.call:
                                          callRate = priceItem
                                              .firstCallFreeMinutes
                                              .toString()
                                              .isNotEmpty
                                              ? "FREE"
                                              : priceItem.price.toString();
                                          break;
                                        case AppConstants.video:
                                          videoRate = priceItem
                                              .firstCallFreeMinutes
                                              .toString()
                                              .isNotEmpty
                                              ? "FREE"
                                              : priceItem.price.toString();
                                          break;
                                      }
                                    });
                            
                                    // Now handle the chatRate logic
                                    if (chatRate == "FREE") {
                                      astrologerProfileController
                                          .checkCallDetail(
                                          AppConstants.call,
                                          astrologer.astrologerUniId
                                              .toString(),
                                          astrologer);
                                    } else {
                                      // Convert chatRate from String to double
                                      double callRateValue =
                                          double.tryParse(callRate) ?? 0.0;
                                      double minimumBalance =
                                          callRateValue * 5;
                            
                                      // Convert wallet balance to double
                                      double walletBalance =
                                          double.tryParse(
                                              dashboardController
                                                  .walletBalanceModel
                                                  .data
                                                  .toString()) ??
                                              0.0;
                            
                                      if (walletBalance >= minimumBalance) {
                                        astrologerProfileController
                                            .checkCallDetail(
                                            AppConstants.call,
                                            astrologer.astrologerUniId
                                                .toString(),
                                            astrologer);
                                      } else {
                                        CommonMethods()
                                            .showInsufficientBalanceBottomSheet(
                                            AppConstants.call,
                                            astrologer.displayName
                                                .toString(),
                                            minimumBalance.toString());
                                        // CustomSnackBar.showBottom("Minimum balance of 5 minutes is required to start chat");
                                      }
                                    }
                                  } else {
                                    astrologerProfileController
                                        .checkCallDetail(
                                        AppConstants.call,
                                        astrologer.astrologerUniId
                                            .toString(),
                                        astrologer);
                                  }
                                } else {
                                  Get.toNamed('/login');
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: ColorResources.colorPrimary,
                                  borderRadius: BorderRadius.circular(8.0),
                                  // border: Border.all(
                                  //   color: astrologer.callStatus == 1 &&
                                  //       astrologer.busyStatus == 1
                                  //       ? Colors.red
                                  //       : Colors.green,
                                  // ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      Images.icCall,
                                      height: 16,
                                      // color: Colors.green
                                      colorFilter: const ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                      // color: astrologer.chatStatus == 1 && astrologer.busyStatus == 1
                                      //     ? Colors.red
                                      //     : Colors.green,
                                    ),
                                    const Gap(10),
                                    const Text("Call Now",
                                        // color: Colors.green,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: "Poppins")),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        // const Gap(10)
                      ],
                    ),
                  )
                ],
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

  String capitalizeFirst(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  void showUnfollowDialog(
      AstrologerProfileController controller,
      AstrologerData astrologer,
      RxBool isFollow,
      ) {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              CustomRoundNetworkImage(
                imageUrl: astrologer.astroImg.toString(),
                height: Dimensions.profileImageHeight,
                width: Dimensions.profileImageHeight,
              ),

              const Gap(10),

              CustomTextRegular(
                astrologer.displayName.toString(),
                fontSize: 14,
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                child: Text(
                  "Are you sure you want to unfollow?",
                  style: TextStyle(fontSize: 12),
                ),
              ),

              GestureDetector(
                onTap: () async {
                  await controller.astrologerFollow(
                      "0", astrologer.astrologerUniId.toString());

                  isFollow.value = false;

                  Get.back();

                  CustomSnackBar.showTop(AppStrings.astroUnfollowMsg);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8, horizontal: 20),
                  decoration: BoxDecoration(
                    color: ColorResources.colorPrimary,
                    borderRadius: BorderRadius.circular(
                        Dimensions.borderRadiusDefault),
                  ),
                  child: const Text(
                    "Unfollow",
                    style: TextStyle(
                      fontSize: Dimensions.fontSizeSmall,
                      color: ColorResources.toolbarText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


// Widget getAstroTag(String tag) {
  //   if (tag == "vip") {
  //     return Padding(
  //       padding: const EdgeInsets.only(top: 2.0, left: 2),
  //       child: Lottie.asset(
  //         Images.astroVipTag,
  //         // width: 35,
  //         height: 30,
  //         fit: BoxFit.contain,
  //       ),
  //     );
  //   } else if (tag == "most_choice") {
  //     return Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
  //       child: Image.asset(
  //         Images.astroMostChoiceTag,
  //         height: 35,
  //       ),
  //     );
  //   } else if (tag == "New") {
  //     return Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
  //       child: Image.asset(
  //         Images.astroNewTag,
  //         height: 35,
  //       ),
  //     );
  //   } else {
  //     // Default image if none of the conditions match
  //     return const SizedBox();
  //   }
  // }
}
