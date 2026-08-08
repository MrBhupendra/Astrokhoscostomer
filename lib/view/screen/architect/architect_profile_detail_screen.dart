import 'package:astro_brahmand/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/model/astrologer_model.dart';
import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:astro_brahmand/utill/dimensions.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/view/widget/custom_rating_icons.dart';
import 'package:astro_brahmand/view/widget/custom_round_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/images.dart';
import '../../../utill/shared_preference.dart';
import '../../widget/custom_default_dialog.dart';
import '../../widget/custom_network_image.dart';
import '../../widget/custom_snack_bar.dart';
import '../../widget/gallery_image_slider_widget.dart';
import 'controller/architect_profile_controller.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class ArchitectProfileScreen extends GetView<ArchitectProfileController> {
  ArchitectProfileScreen({super.key});
  // final AstrologerData astrologer = Get.arguments;

  final AstrologerData astrologer = Get.arguments['data'];
  final type = Get.arguments['type'];

  final _formKey = GlobalKey<FormState>();
  final _blockReasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String homeCompletePrice = '**',
        officeCompletePrice = '**',
        industryCompletePrice = '**',
        homeLayoutPrice = '**',
        officeLayoutPrice = '**',
        industryLayoutPrice = '**';
    String homeOld = '**', officeOld = '**', industryOld = '**';

    astrologer.prices?.forEach((priceItem) {
      String type = priceItem.type.toString();
      switch (type) {
        case AppConstants.homeComplete:
          homeCompletePrice = priceItem.price.toString();
          break;
        case AppConstants.officeComplete:
          officeCompletePrice = priceItem.price.toString();
          break;
        case AppConstants.industryComplete:
          industryCompletePrice = priceItem.price.toString();
          break;
        case AppConstants.homeLayout:
          homeLayoutPrice = priceItem.price.toString();
          break;
        case AppConstants.officeLayout:
          officeLayoutPrice = priceItem.price.toString();
          break;
        case AppConstants.industryLayout:
          industryLayoutPrice = priceItem.price.toString();
          break;

        case AppConstants.homeOld:
          homeOld = priceItem.price.toString();
          break;
        case AppConstants.officeOld:
          officeOld = priceItem.price.toString();
          break;
        case AppConstants.industryOld:
          industryOld = priceItem.price.toString();
          break;
      }
    });

    if (type == "old") {
      homeLayoutPrice = homeOld;
      officeLayoutPrice = officeOld;
      industryLayoutPrice = industryOld;
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorResources.colorPrimary,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded,
                    size: Dimensions.iconSizeOverSmall,
                    color: ColorResources.toolbarText),
                onPressed: () {
                  Get.back();
                },
              ),
              Expanded(
                child: Text(
                  astrologer.displayName.toString(),
                  style: const TextStyle(
                      fontSize: Dimensions.fontSizeLarge,
                      color: ColorResources.toolbarText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: ColorResources.white),
                onSelected: (value) {
                  if (value == 'block') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        _blockReasonController.text = '';
                        return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          content: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 6),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                // const Gap(10),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0, top: 10),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Image.asset(
                                        Images.close,
                                        height: 14,
                                        color: ColorResources.black,
                                      ),
                                    ),
                                  ),
                                ),
                                CustomTextMedium("Report & Block"),
                                // const Gap(10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: CustomRoundNetworkImage(
                                      imageUrl: astrologer.astroImg.toString(),
                                      height: Dimensions.profileImageHeight,
                                      width: Dimensions.profileImageHeight),
                                ),
                                // const Gap(10),
                                CustomTextMedium(
                                    astrologer.displayName.toString()),
                                const Gap(10),
                                Row(
                                  children: [
                                    CustomTextMedium("Reason for blocking*",
                                        fontSize: Dimensions.fontSizeSmall),
                                  ],
                                ),
                                const Gap(8),
                                Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    controller: _blockReasonController,
                                    decoration: const InputDecoration(
                                      hintText: 'Write your reason...',
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                              ColorResources.colorPrimary)),
                                      alignLabelWithHint: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: Dimensions.paddingSizeSmall,
                                          horizontal: Dimensions
                                              .paddingSizeMediumSmall),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppStrings.blockError.tr;
                                      }
                                      return null;
                                    },
                                    minLines: 3,
                                    maxLines: 3,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        Get.back();

                                        CustomDefaultDialog.showOkDialog(
                                            AppStrings.success.tr,
                                            AppStrings.successBlockMsg.tr, () {
                                          Get.back();
                                        });
                                      } // add block function
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 20.0),
                                        decoration: BoxDecoration(
                                          color:
                                          ColorResources.colorPrimaryDark,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.borderRadiusDefault),
                                        ),
                                        child: CustomTextRegular("Submit",
                                            fontSize: Dimensions.fontSizeSmall,
                                            color: ColorResources.toolbarText)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  // else if (value == 'edit') {
                  //
                  // }
                },
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem<String>(
                    value: 'block',
                    child: Center(child: CustomTextRegular("Report & Block")),
                  ),
                  // const PopupMenuItem<String>(
                  //   value: 'edit',
                  //   child: Text('Edit'),
                  // ),
                ],
              ),
            ],
          ),
          titleSpacing: 0,
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              AppLogger.d(astrologer.astrologerUniId.toString());
              // controller.getAstrologerDetail(controller.astrologer.astrologerUniId.toString());
              controller.getAstrologerDetail(astrologer.astrologerUniId.toString());
            },
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Container(
                                // color: ColorResources.colorPrimaryLight,
                                decoration: const BoxDecoration(
                                  color: ColorResources.colorPrimaryLight,
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.borderRadiusLarge),bottomRight: Radius.circular(Dimensions.borderRadiusLarge)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical: Dimensions.paddingSizeOver),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Gap(10),
                                            Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                CustomRoundNetworkImage(
                                                    imageUrl: astrologer.astroImg.toString(),
                                                    height: Dimensions.imageHeightLarge,
                                                    width: Dimensions.imageHeightLarge),
                                                Positioned(
                                                  right: 0,
                                                  bottom: 0,
                                                  child: Container(
                                                    padding: const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      color: astrologer.onlineStatus == 1 &&
                                                          astrologer.busyStatus == 1
                                                          ? Colors.orange
                                                          : astrologer.onlineStatus == 1
                                                          ? Colors.green
                                                          : Colors.red,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: Colors.white,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      ' ',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          color: ColorResources.red),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Gap(10),
                                            CustomTextMedium(
                                                astrologer.displayName.toString(),
                                                maxLines: 1,
                                                fontSize: Dimensions.fontSizeExtraLarge
                                            ),
                                            CustomTextRegular(
                                              astrologer.categoryNames.toString(),
                                              maxLines: 2,
                                              color: ColorResources.black1,
                                              fontSize: Dimensions.fontSizeLarge,
                                            ),
                                            const Gap(10),
                                            Obx(() => GestureDetector(
                                              onTap: () {
                                                if (controller.isFollow.isTrue) {
                                                  showUnfollowDialog();
                                                }else{
                                                  controller.astrologerFollow("1", controller.astrologer.astrologerUniId.toString());
                                                  CustomSnackBar.showTop(AppStrings.astroFollowMsg);
                                                }
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 5.0,
                                                    horizontal: 16.0),
                                                decoration: BoxDecoration(
                                                  color: controller.isFollow.isFalse
                                                      ? ColorResources.colorPrimary
                                                      : ColorResources.white,
                                                  borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                                                ),
                                                child: CustomTextRegular(
                                                  controller.isFollow.isFalse
                                                      ? "Follow"
                                                      : "Following",
                                                  color: controller
                                                      .isFollow.isFalse
                                                      ? ColorResources.white
                                                      : ColorResources.colorPrimaryDark,
                                                  // fontSize: Dimensions.fontSizeSmall,
                                                ),
                                              ),
                                            )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 0),
                                child: Container(
                                  color: ColorResources.white,
                                  // decoration: BoxDecoration(
                                  //   color: ColorResources.white,
                                  //   borderRadius: BorderRadius.circular(
                                  //       Dimensions.borderRadiusDefault),
                                  // ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions.paddingSizeServices,
                                        vertical: Dimensions.paddingSizeExtraLarge),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: CustomTextRegular(
                                                  "Language",
                                                  maxLines: 1,
                                                  fontSize: Dimensions.fontSizeLarge,
                                                )
                                            ),
                                            Expanded(
                                                child: CustomTextRegular(
                                                  astrologer.languageName.toString(),
                                                  maxLines: 1,
                                                  textAlign: TextAlign.end,
                                                )
                                            ),
                                          ],
                                        ),
                                        const Gap(15),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: CustomTextRegular(
                                                  "Rating",
                                                  maxLines: 1,
                                                  fontSize: Dimensions.fontSizeLarge,
                                                )
                                            ),
                                            CustomRatingIcons(
                                              rating: double.parse(astrologer.user!.avgRating.toString()),
                                              iconSize: Dimensions.iconSizeMediumSmall,
                                            ),
                                          ],
                                        ),
                                        const Gap(15),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: CustomTextRegular(
                                                  "Followers",
                                                  maxLines: 1,
                                                  fontSize: Dimensions.fontSizeLarge,
                                                )
                                            ),
                                            Expanded(
                                                child: CustomTextRegular(
                                                  astrologer.followerCount.toString(),
                                                  maxLines: 1,
                                                  textAlign: TextAlign.end,
                                                )
                                            ),
                                          ],
                                        ),
                                        const Gap(15),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: CustomTextRegular(
                                                  "Experience",
                                                  maxLines: 1,
                                                  fontSize: Dimensions.fontSizeLarge,
                                                )
                                            ),
                                            Expanded(
                                                child: CustomTextRegular(
                                                  "${astrologer.experience.toString()} years",
                                                  maxLines: 1,
                                                  textAlign: TextAlign.end,
                                                )
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(color: ColorResources.black8),
                              // const Gap(Dimensions.gapDefault),
                              // Gallery images
                              Obx((){
                                if(controller.astrologerData.value.galleryImageList!.isNotEmpty){
                                  return Container(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    height: 150.0,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller.astrologerData.value.galleryImageList?.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => GalleryImageSliderWidget(
                                                imageUrls: controller.astrologerData.value.galleryImageList!,
                                                initialIndex: index,
                                              ),
                                            );
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(right: 8.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: CustomNetworkImage(
                                                  imageUrl: controller.astrologerData.value.galleryImageList![index],
                                                  height: 150,
                                                  width: 150
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }
                                else{
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                    child: Container(),
                                  );
                                }
                              }),
                              //What is layout
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextMedium(AppStrings.whatIsFloorPlan.tr,
                                        fontSize: Dimensions.fontSizeExtraLarge),
                                    const Gap(Dimensions.gapSmall),
                                    CustomTextRegular(
                                      AppStrings.whatIsFloorPlanAns.tr,
                                      color: ColorResources.black1,
                                      fontSize: Dimensions.fontSizeDefault,
                                    ),
                                    const Gap(Dimensions.gapDefault),
                                    const Divider(
                                      color: ColorResources.colorPrimaryVariant,
                                    ),

                                    //What is complete
                                    Visibility(
                                      visible: type == "new",
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomTextMedium(
                                              "What Is Layout With Complete Elevation?",
                                              fontSize: Dimensions.fontSizeExtraLarge),
                                          const Gap(Dimensions.gapSmall),
                                          CustomTextRegular(
                                            "A layout with complete elevation provides a comprehensive architectural plan, detailing both the interior and exterior aspects of a building. Architect also guides the placement of furniture, fixtures, and essential items like sofas, inverters,dustbins etc.",
                                            color: ColorResources.black1,
                                            fontSize: Dimensions.fontSizeDefault,
                                          ),
                                          const Gap(Dimensions.gapDefault),
                                          const Divider(
                                            color: ColorResources.colorPrimaryVariant,
                                          ),
                                          const Gap(Dimensions.gapDefault),
                                        ],
                                      ),
                                    ),

                                    const Gap(Dimensions.gapDefault),
                                    CustomTextMedium("Languages",
                                        fontSize: Dimensions.fontSizeExtraLarge),
                                    const Gap(Dimensions.gapSmall),
                                    CustomTextRegular(
                                      astrologer.languageName.toString(),
                                      color: ColorResources.black1,
                                      // fontSize: Dimensions.fontSizeSmall,
                                    ),
                                    const Gap(Dimensions.gapDefault),
                                    const Divider(
                                      color: ColorResources.colorPrimaryVariant,
                                    ),
                                    const Gap(Dimensions.gapDefault),
                                    CustomTextMedium("Profile Summary",
                                        fontSize: Dimensions.fontSizeExtraLarge),
                                    const Gap(Dimensions.gapSmall),

                                    HtmlWidget(
                                      astrologer.longBiography.toString(),
                                      textStyle: const TextStyle(
                                        color: ColorResources.black4,
                                        // fontSize: Dimensions.fontSizeSmall
                                      ),
                                    ),

                                    const Gap(Dimensions.gapDefault),
                                    const Divider(color: ColorResources.colorPrimaryVariant),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                child: Row(
                                  children: [
                                    CustomTextMedium("Reviews:",
                                        fontSize: Dimensions.fontSizeExtraLarge),
                                    const Gap(Dimensions.gapExtraSmall),
                                    Expanded(
                                      child: CustomTextMedium(
                                        astrologer.reviewCount.toString(),
                                        fontSize: Dimensions.fontSizeLarge,
                                        color: ColorResources.colorPrimary,
                                      ),
                                    ),
                                    CustomButton("View all", onPressed: (){
                                      _showReviewBottomSheet(context, controller.astrologer.astrologerUniId.toString());
                                    },
                                        minimumSize: const Size(15,24),color: ColorResources.white,fontSize: Dimensions.fontSizeSmall),
                                    // const Gap(Dimensions.gapExtraLarge),
                                  ],
                                ),
                              ),
                              const Gap(10),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //         color: ColorResources.white,
                              //         borderRadius: BorderRadius.circular(
                              //             Dimensions.borderRadiusDefault),
                              //         border: Border.all(color: ColorResources.black6)),
                              //     child: Padding(
                              //         padding: const EdgeInsets.symmetric(
                              //             vertical: 14.0, horizontal: 10),
                              //         child: CustomReviewWidget(astrologer.reviews)),
                              //   ),
                              // ),
                              const Gap(10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: ColorResources.white,
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeMediumSmall),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (astrologer.onlineStatus == 1)
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: ElevatedButton(
                                  onPressed: () async {

                                    bool isLogin = await SharedPreferencesHelper.getIsLogin();

                                    if (isLogin) {
                                      controller.showTypeBottomSheet(
                                          type,
                                          AppConstants.home,
                                          type == "new"
                                              ? AppConstants.homeLayout
                                              : AppConstants.homeOld,
                                          type == "new"
                                              ? AppConstants.homeComplete
                                              : "",
                                          homeCompletePrice,
                                          homeLayoutPrice,
                                          astrologer);
                                    } else {
                                      Get.toNamed('/login');
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorResources.colorPrimary,
                                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Home Consultancy',
                                    style: TextStyle(
                                      color: ColorResources.toolbarText,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                // CustomElevatedButton(
                                //   onPressed: () async {
                                //     bool isLogin = await SharedPreferencesHelper.getIsLogin();
                                //     if (isLogin) {
                                //       controller.showTypeBottomSheet(
                                //           controller.type,
                                //           AppConstants.home,
                                //           controller.type == "new"
                                //               ? AppConstants.homeLayout
                                //               : AppConstants.homeOld,
                                //           controller.type == "new"
                                //               ? AppConstants.homeComplete
                                //               : "",
                                //           homeCompletePrice,
                                //           homeLayoutPrice,
                                //           astrologer);
                                //     } else {
                                //       Get.toNamed('/login');
                                //     }
                                //   },
                                //   text: 'Home Consultancy',
                                //   backgroundColor: ColorResources.colorPrimaryVariant,
                                //   textColor: ColorResources.toolbarText,
                                // ),

                              ),
                            ),
                          if (astrologer.onlineStatus == 1)
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    bool isLogin = await SharedPreferencesHelper.getIsLogin();
                                    if (isLogin) {
                                      controller.showTypeBottomSheet(
                                          type,
                                          AppConstants.office,
                                          type == "new"
                                              ? AppConstants.officeLayout
                                              : AppConstants.officeOld,
                                          type == "new"
                                              ? AppConstants.officeComplete
                                              : "",
                                          officeCompletePrice,
                                          officeLayoutPrice,
                                          astrologer);
                                    } else {
                                      Get.toNamed('/login');
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorResources.colorPrimary,
                                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Office Consultancy',
                                    style: TextStyle(
                                      color: ColorResources.toolbarText,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                // CustomElevatedButton(
                                //   onPressed: () async {
                                //     bool isLogin = await SharedPreferencesHelper.getIsLogin();
                                //     if (isLogin) {
                                //       controller.showTypeBottomSheet(
                                //           controller.type,
                                //           AppConstants.office,
                                //           controller.type == "new"
                                //               ? AppConstants.officeLayout
                                //               : AppConstants.officeOld,
                                //           controller.type == "new"
                                //               ? AppConstants.officeComplete
                                //               : "",
                                //           officeCompletePrice,
                                //           officeLayoutPrice,
                                //           astrologer);
                                //     } else {
                                //       Get.toNamed('/login');
                                //     }
                                //   },
                                //   text: 'Office Consultancy',
                                //   backgroundColor: ColorResources.colorPrimaryVariant,
                                //   textColor: ColorResources.toolbarText,
                                // ),
                              ),
                            ),
                          if (astrologer.onlineStatus == 1)
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    bool isLogin =
                                    await SharedPreferencesHelper.getIsLogin();
                                    if (isLogin) {
                                      controller.showTypeBottomSheet(
                                          type,
                                          AppConstants.industry,
                                          type == "new"
                                              ? AppConstants.industryLayout
                                              : AppConstants.industryOld,
                                          type == "new"
                                              ? AppConstants.industryComplete
                                              : "",
                                          industryCompletePrice,
                                          industryLayoutPrice,
                                          astrologer);
                                    } else {
                                      Get.toNamed('/login');
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorResources.colorPrimary,
                                    padding: const EdgeInsets.only(top: 2, bottom: 2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Industry Consultancy',
                                    style: TextStyle(
                                      color: ColorResources.toolbarText,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                // CustomElevatedButton(
                                //   onPressed: () async {
                                //     bool isLogin =
                                //         await SharedPreferencesHelper.getIsLogin();
                                //     if (isLogin) {
                                //       controller.showTypeBottomSheet(
                                //           controller.type,
                                //           AppConstants.industry,
                                //           controller.type == "new"
                                //               ? AppConstants.industryLayout
                                //               : AppConstants.industryOld,
                                //           controller.type == "new"
                                //               ? AppConstants.industryComplete
                                //               : "",
                                //           industryCompletePrice,
                                //           industryLayoutPrice,
                                //           astrologer);
                                //     } else {
                                //       Get.toNamed('/login');
                                //     }
                                //   },
                                //   text: 'Industry Consultancy',
                                //   backgroundColor:
                                //       ColorResources.colorPrimaryVariant,
                                //   textColor: ColorResources.toolbarText,
                                // ),
                              ),
                            ),
                          if (astrologer.onlineStatus == 0)
                            CustomTextRegular(
                              "Offline (Available Soon)",
                              fontSize: Dimensions.fontSizeLarge,
                              color: ColorResources.black1,
                            ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
        ),
      ),
    );
    // return SafeArea(
    //   child: Scaffold(
    //     appBar: AppBar(
    //       backgroundColor: ColorResources.colorPrimary,
    //       automaticallyImplyLeading: false,
    //       title: Row(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           IconButton(
    //             icon: const Icon(Icons.arrow_back_ios_rounded,
    //                 size: Dimensions.iconSizeOverSmall,
    //                 color: ColorResources.toolbarText),
    //             onPressed: () {
    //               Get.back();
    //             },
    //           ),
    //           Expanded(
    //             child: Text(
    //               astrologer.displayName.toString(),
    //               style: const TextStyle(
    //                   fontSize: Dimensions.fontSizeLarge,
    //                   color: ColorResources.toolbarText),
    //               maxLines: 1,
    //               overflow: TextOverflow.ellipsis,
    //             ),
    //           ),
    //           PopupMenuButton<String>(
    //             icon: const Icon(Icons.more_vert, color: ColorResources.white),
    //             onSelected: (value) {
    //               if (value == 'block') {
    //                 showDialog(
    //                   context: context,
    //                   builder: (BuildContext context) {
    //                     _blockReasonController.text = '';
    //                     return AlertDialog(
    //                       contentPadding: EdgeInsets.zero,
    //                       shape: RoundedRectangleBorder(
    //                           borderRadius: BorderRadius.circular(10.0)),
    //                       content: Padding(
    //                         padding: const EdgeInsets.symmetric(
    //                             vertical: 10.0, horizontal: 6),
    //                         child: Column(
    //                           mainAxisSize: MainAxisSize.min,
    //                           children: <Widget>[
    //                             // const Gap(10),
    //                             Padding(
    //                               padding: const EdgeInsets.only(
    //                                   right: 10.0, top: 10),
    //                               child: Align(
    //                                 alignment: Alignment.centerRight,
    //                                 child: GestureDetector(
    //                                   onTap: () {
    //                                     Get.back();
    //                                   },
    //                                   child: Image.asset(
    //                                     'assets/images/close.png',
    //                                     height: 14,
    //                                     color: ColorResources.black,
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                             CustomTextMedium("Report & Block"),
    //                             // const Gap(10),
    //                             Padding(
    //                               padding: const EdgeInsets.symmetric(
    //                                   vertical: 10.0),
    //                               child: CustomRoundNetworkImage(
    //                                   imageUrl: astrologer.astroImg.toString(),
    //                                   height: Dimensions.profileImageHeight,
    //                                   width: Dimensions.profileImageHeight),
    //                             ),
    //                             // const Gap(10),
    //                             CustomTextMedium(
    //                                 astrologer.displayName.toString()),
    //                             const Gap(10),
    //                             Row(
    //                               children: [
    //                                 CustomTextMedium("Reason for blocking*",
    //                                     fontSize: Dimensions.fontSizeSmall),
    //                               ],
    //                             ),
    //                             const Gap(8),
    //                             Form(
    //                               key: _formKey,
    //                               child: TextFormField(
    //                                 controller: _blockReasonController,
    //                                 decoration: const InputDecoration(
    //                                   hintText: 'Write your reason...',
    //                                   border: OutlineInputBorder(
    //                                       borderSide: BorderSide(
    //                                           color:
    //                                               ColorResources.colorPrimary)),
    //                                   alignLabelWithHint: true,
    //                                   contentPadding: EdgeInsets.symmetric(
    //                                       vertical: Dimensions.paddingSizeSmall,
    //                                       horizontal: Dimensions
    //                                           .paddingSizeMediumSmall),
    //                                 ),
    //                                 validator: (value) {
    //                                   if (value == null || value.isEmpty) {
    //                                     return AppStrings.formError.tr;
    //                                   }
    //                                   return null;
    //                                 },
    //                                 minLines: 3,
    //                                 maxLines: 3,
    //                               ),
    //                             ),
    //                             Padding(
    //                               padding: const EdgeInsets.symmetric(
    //                                   vertical: 10.0, horizontal: 8.0),
    //                               child: GestureDetector(
    //                                 onTap: () {
    //                                   if (_formKey.currentState!.validate()) {
    //                                     Get.back();
    //
    //                                     CustomDialog.showOkDialog(
    //                                         AppStrings.success.tr,
    //                                         AppStrings.successBlockMsg.tr, () {
    //                                       Get.back();
    //                                     });
    //                                   } // add block function
    //                                 },
    //                                 child: Container(
    //                                     padding: const EdgeInsets.symmetric(
    //                                         vertical: 8.0, horizontal: 20.0),
    //                                     decoration: BoxDecoration(
    //                                       color:
    //                                           ColorResources.colorPrimaryDark,
    //                                       borderRadius: BorderRadius.circular(
    //                                           Dimensions.borderRadiusDefault),
    //                                     ),
    //                                     child: CustomTextRegular("Submit",
    //                                         fontSize: Dimensions.fontSizeSmall,
    //                                         color: ColorResources.toolbarText)),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     );
    //                   },
    //                 );
    //               }
    //               // else if (value == 'edit') {
    //               //
    //               // }
    //             },
    //             shape: const RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.all(Radius.circular(10.0))),
    //             itemBuilder: (BuildContext context) => [
    //               PopupMenuItem<String>(
    //                 value: 'block',
    //                 child: Center(child: CustomTextRegular("Report & Block")),
    //               ),
    //               // const PopupMenuItem<String>(
    //               //   value: 'edit',
    //               //   child: Text('Edit'),
    //               // ),
    //             ],
    //           ),
    //         ],
    //       ),
    //       titleSpacing: 0,
    //     ),
    //     body: Column(
    //       children: [
    //         Expanded(
    //           child: RefreshIndicator(
    //             onRefresh: () async {
    //               controller.getAstrologerDetail(astrologer.astrologerUniId.toString());
    //             },
    //             child: SingleChildScrollView(
    //               child: Column(
    //                 // crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Container(
    //                     // color: ColorResources.colorPrimaryLight,
    //                     decoration: const BoxDecoration(
    //                         color: ColorResources.colorPrimaryLight,
    //                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.borderRadiusLarge),bottomRight: Radius.circular(Dimensions.borderRadiusLarge)),
    //                     ),
    //                     child: Padding(
    //                       padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall,vertical: Dimensions.paddingSizeOver),
    //                       child: Row(
    //                         children: [
    //                           Expanded(
    //                             child: Column(
    //                               crossAxisAlignment: CrossAxisAlignment.center,
    //                               children: [
    //                                 const Gap(10),
    //                                 Stack(
    //                                   clipBehavior: Clip.none,
    //                                   children: [
    //                                     CustomRoundNetworkImage(
    //                                         imageUrl: astrologer.astroImg.toString(),
    //                                         height: Dimensions.imageHeightLarge,
    //                                         width: Dimensions.imageHeightLarge),
    //                                     Positioned(
    //                                       right: 0,
    //                                       bottom: 0,
    //                                       child: Container(
    //                                         padding: const EdgeInsets.all(4),
    //                                         decoration: BoxDecoration(
    //                                           color: astrologer.onlineStatus == 1 &&
    //                                               astrologer.busyStatus == 1
    //                                               ? Colors.orange
    //                                               : astrologer.onlineStatus == 1
    //                                               ? Colors.green
    //                                               : Colors.red,
    //                                           shape: BoxShape.circle,
    //                                           border: Border.all(
    //                                             color: Colors.white,
    //                                             width: 2,
    //                                           ),
    //                                         ),
    //                                         child: const Text(
    //                                           ' ',
    //                                           style: TextStyle(
    //                                               fontSize: 10,
    //                                               color: ColorResources.red),
    //                                         ),
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 const Gap(10),
    //                                 CustomTextMedium(
    //                                     astrologer.displayName.toString(),
    //                                     maxLines: 1,
    //                                     fontSize: Dimensions.fontSizeExtraLarge
    //                                 ),
    //                                 CustomTextRegular(
    //                                   astrologer.categoryNames.toString(),
    //                                   maxLines: 2,
    //                                   color: ColorResources.black1,
    //                                   fontSize: Dimensions.fontSizeLarge,
    //                                 ),
    //                                 const Gap(10),
    //                                 Obx(() => GestureDetector(
    //                                   onTap: () {
    //                                     if (controller.isFollow.isTrue) {
    //                                       showUnfollowDialog();
    //                                     }else{
    //                                       controller.astrologerFollow("1", controller.astrologer.astrologerUniId.toString());
    //                                       CustomSnackBar.showTop(AppStrings.astroFollowMsg);
    //                                     }
    //                                   },
    //                                   child: Container(
    //                                     padding: const EdgeInsets.symmetric(
    //                                         vertical: 5.0,
    //                                         horizontal: 16.0),
    //                                     decoration: BoxDecoration(
    //                                       color: controller.isFollow.isFalse
    //                                           ? ColorResources.colorPrimary
    //                                           : ColorResources.white,
    //                                       borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
    //                                     ),
    //                                     child: CustomTextRegular(
    //                                       controller.isFollow.isFalse
    //                                           ? "Follow"
    //                                           : "Following",
    //                                       color: controller
    //                                           .isFollow.isFalse
    //                                           ? ColorResources.white
    //                                           : ColorResources.colorPrimaryDark,
    //                                       // fontSize: Dimensions.fontSizeSmall,
    //                                     ),
    //                                   ),
    //                                 )),
    //                               ],
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: 0),
    //                     child: Container(
    //                       color: ColorResources.white,
    //                       // decoration: BoxDecoration(
    //                       //   color: ColorResources.white,
    //                       //   borderRadius: BorderRadius.circular(
    //                       //       Dimensions.borderRadiusDefault),
    //                       // ),
    //                       child: Padding(
    //                         padding: const EdgeInsets.symmetric(
    //                             horizontal: Dimensions.paddingSizeServices,
    //                             vertical: Dimensions.paddingSizeExtraLarge),
    //                         child: Column(
    //                           children: [
    //                             Row(
    //                               children: [
    //                                 Expanded(
    //                                     child: CustomTextRegular(
    //                                       "Language",
    //                                       maxLines: 1,
    //                                       fontSize: Dimensions.fontSizeLarge,
    //                                     )
    //                                 ),
    //                                 Expanded(
    //                                     child: CustomTextRegular(
    //                                       astrologer.languageName.toString(),
    //                                       maxLines: 1,
    //                                       textAlign: TextAlign.end,
    //                                     )
    //                                 ),
    //                               ],
    //                             ),
    //                             const Gap(15),
    //                             Row(
    //                               children: [
    //                                 Expanded(
    //                                     child: CustomTextRegular(
    //                                       "Rating",
    //                                       maxLines: 1,
    //                                       fontSize: Dimensions.fontSizeLarge,
    //                                     )
    //                                 ),
    //                                 CustomRatingIcons(
    //                                   rating: double.parse(astrologer.user!.avgRating.toString()),
    //                                   iconSize: Dimensions.iconSizeMediumSmall,
    //                                 ),
    //                               ],
    //                             ),
    //                             const Gap(15),
    //                             Row(
    //                               children: [
    //                                 Expanded(
    //                                     child: CustomTextRegular(
    //                                       "Followers",
    //                                       maxLines: 1,
    //                                       fontSize: Dimensions.fontSizeLarge,
    //                                     )
    //                                 ),
    //                                 Expanded(
    //                                     child: CustomTextRegular(
    //                                       astrologer.followerCount.toString(),
    //                                       maxLines: 1,
    //                                       textAlign: TextAlign.end,
    //                                     )
    //                                 ),
    //                               ],
    //                             ),
    //                             const Gap(15),
    //                             Row(
    //                               children: [
    //                                 Expanded(
    //                                     child: CustomTextRegular(
    //                                       "Experience",
    //                                       maxLines: 1,
    //                                       fontSize: Dimensions.fontSizeLarge,
    //                                     )
    //                                 ),
    //                                 Expanded(
    //                                     child: CustomTextRegular(
    //                                       "${astrologer.experience.toString()} years",
    //                                       maxLines: 1,
    //                                       textAlign: TextAlign.end,
    //                                     )
    //                                 ),
    //                               ],
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   const Divider(color: ColorResources.black8),
    //                   const Gap(Dimensions.gapDefault),
    //
    //                   //What is layout
    //                   Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         CustomTextMedium(AppStrings.whatIsFloorPlan.tr,
    //                             fontSize: Dimensions.fontSizeExtraLarge),
    //                         const Gap(Dimensions.gapSmall),
    //                         CustomTextRegular(
    //                           AppStrings.whatIsFloorPlanAns.tr,
    //                           color: ColorResources.black1,
    //                           fontSize: Dimensions.fontSizeDefault,
    //                         ),
    //                         const Gap(Dimensions.gapDefault),
    //                         const Divider(
    //                           color: ColorResources.colorPrimaryVariant,
    //                         ),
    //
    //                         //What is complete
    //                         Visibility(
    //                           visible: type == "new",
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               CustomTextMedium(
    //                                   "What Is Layout With Complete Elevation?",
    //                                   fontSize: Dimensions.fontSizeExtraLarge),
    //                               const Gap(Dimensions.gapSmall),
    //                               CustomTextRegular(
    //                                 "A layout with complete elevation provides a comprehensive architectural plan, detailing both the interior and exterior aspects of a building. Architect also guides the placement of furniture, fixtures, and essential items like sofas, inverters,dustbins etc.",
    //                                 color: ColorResources.black1,
    //                                 fontSize: Dimensions.fontSizeDefault,
    //                               ),
    //                               const Gap(Dimensions.gapDefault),
    //                               const Divider(
    //                                 color: ColorResources.colorPrimaryVariant,
    //                               ),
    //                               const Gap(Dimensions.gapDefault),
    //                             ],
    //                           ),
    //                         ),
    //
    //                         const Gap(Dimensions.gapDefault),
    //                         CustomTextMedium("Languages",
    //                             fontSize: Dimensions.fontSizeExtraLarge),
    //                         const Gap(Dimensions.gapSmall),
    //                         CustomTextRegular(
    //                           astrologer.languageName.toString(),
    //                           color: ColorResources.black1,
    //                           // fontSize: Dimensions.fontSizeSmall,
    //                         ),
    //                         const Gap(Dimensions.gapDefault),
    //                         const Divider(
    //                           color: ColorResources.colorPrimaryVariant,
    //                         ),
    //                         const Gap(Dimensions.gapDefault),
    //                         CustomTextMedium("Profile Summary",
    //                             fontSize: Dimensions.fontSizeExtraLarge),
    //                         const Gap(Dimensions.gapSmall),
    //
    //                         HtmlWidget(
    //                           astrologer.longBiography.toString(),
    //                           textStyle: const TextStyle(
    //                               color: ColorResources.black4,
    //                               // fontSize: Dimensions.fontSizeSmall
    //                           ),
    //                         ),
    //
    //                         const Gap(Dimensions.gapDefault),
    //                         const Divider(color: ColorResources.colorPrimaryVariant),
    //                       ],
    //                     ),
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
    //                     child: Row(
    //                       children: [
    //                         CustomTextMedium("Reviews:",
    //                             fontSize: Dimensions.fontSizeExtraLarge),
    //                         const Gap(Dimensions.gapExtraSmall),
    //                         Expanded(
    //                           child: CustomTextMedium(
    //                             astrologer.reviewCount.toString(),
    //                             fontSize: Dimensions.fontSizeLarge,
    //                             color: ColorResources.colorPrimary,
    //                           ),
    //                         ),
    //                         CustomButton("View all", onPressed: (){},minimumSize: const Size(15,24),color: ColorResources.white,fontSize: Dimensions.fontSizeSmall),
    //                         // const Gap(Dimensions.gapExtraLarge),
    //                       ],
    //                     ),
    //                   ),
    //                   const Gap(10),
    //                   Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
    //                     child: Container(
    //                       decoration: BoxDecoration(
    //                           color: ColorResources.white,
    //                           borderRadius: BorderRadius.circular(
    //                               Dimensions.borderRadiusDefault),
    //                           border: Border.all(color: ColorResources.black6)),
    //                       child: Padding(
    //                           padding: const EdgeInsets.symmetric(
    //                               vertical: 14.0, horizontal: 10),
    //                           child: CustomReviewWidget(astrologer.reviews)),
    //                     ),
    //                   ),
    //                   const Gap(10),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //         Align(
    //           alignment: Alignment.bottomCenter,
    //           child: Container(
    //             color: ColorResources.white,
    //             child: Padding(
    //               padding: const EdgeInsets.all(Dimensions.paddingSizeMediumSmall),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: [
    //                   if (astrologer.onlineStatus == 1)
    //                     Expanded(
    //                       child: Padding(
    //                         padding: const EdgeInsets.symmetric(horizontal: 4.0),
    //                         child: ElevatedButton(
    //                           onPressed: () async {
    //
    //                             bool isLogin = await SharedPreferencesHelper.getIsLogin();
    //
    //                             if (isLogin) {
    //                               controller.showTypeBottomSheet(
    //                                   type,
    //                                   AppConstants.home,
    //                                   type == "new"
    //                                       ? AppConstants.homeLayout
    //                                       : AppConstants.homeOld,
    //                                   type == "new"
    //                                       ? AppConstants.homeComplete
    //                                       : "",
    //                                   homeCompletePrice,
    //                                   homeLayoutPrice,
    //                                   astrologer);
    //                             } else {
    //                               Get.toNamed('/login');
    //                             }
    //                           },
    //                           style: ElevatedButton.styleFrom(
    //                             backgroundColor: ColorResources.colorPrimary,
    //                             padding: const EdgeInsets.only(top: 2, bottom: 2),
    //                             shape: RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.circular(8),
    //                             ),
    //                           ),
    //                           child: const Text(
    //                             'Home Consultancy',
    //                             style: TextStyle(
    //                               color: ColorResources.toolbarText,
    //                             ),
    //                             textAlign: TextAlign.center,
    //                           ),
    //                         ),
    //                         // CustomElevatedButton(
    //                         //   onPressed: () async {
    //                         //     bool isLogin = await SharedPreferencesHelper.getIsLogin();
    //                         //     if (isLogin) {
    //                         //       controller.showTypeBottomSheet(
    //                         //           controller.type,
    //                         //           AppConstants.home,
    //                         //           controller.type == "new"
    //                         //               ? AppConstants.homeLayout
    //                         //               : AppConstants.homeOld,
    //                         //           controller.type == "new"
    //                         //               ? AppConstants.homeComplete
    //                         //               : "",
    //                         //           homeCompletePrice,
    //                         //           homeLayoutPrice,
    //                         //           astrologer);
    //                         //     } else {
    //                         //       Get.toNamed('/login');
    //                         //     }
    //                         //   },
    //                         //   text: 'Home Consultancy',
    //                         //   backgroundColor: ColorResources.colorPrimaryVariant,
    //                         //   textColor: ColorResources.toolbarText,
    //                         // ),
    //
    //                       ),
    //                     ),
    //                   if (astrologer.onlineStatus == 1)
    //                     Expanded(
    //                       child: Padding(
    //                         padding:
    //                             const EdgeInsets.symmetric(horizontal: 4.0),
    //                         child: ElevatedButton(
    //                           onPressed: () async {
    //                             bool isLogin = await SharedPreferencesHelper.getIsLogin();
    //                             if (isLogin) {
    //                               controller.showTypeBottomSheet(
    //                                   type,
    //                                   AppConstants.office,
    //                                   type == "new"
    //                                       ? AppConstants.officeLayout
    //                                       : AppConstants.officeOld,
    //                                   type == "new"
    //                                       ? AppConstants.officeComplete
    //                                       : "",
    //                                   officeCompletePrice,
    //                                   officeLayoutPrice,
    //                                   astrologer);
    //                             } else {
    //                               Get.toNamed('/login');
    //                             }
    //                           },
    //                           style: ElevatedButton.styleFrom(
    //                             backgroundColor: ColorResources.colorPrimary,
    //                             padding: const EdgeInsets.only(top: 2, bottom: 2),
    //                             shape: RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.circular(8),
    //                             ),
    //                           ),
    //                           child: const Text(
    //                             'Office Consultancy',
    //                             style: TextStyle(
    //                               color: ColorResources.toolbarText,
    //                             ),
    //                             textAlign: TextAlign.center,
    //                           ),
    //                         ),
    //                         // CustomElevatedButton(
    //                         //   onPressed: () async {
    //                         //     bool isLogin = await SharedPreferencesHelper.getIsLogin();
    //                         //     if (isLogin) {
    //                         //       controller.showTypeBottomSheet(
    //                         //           controller.type,
    //                         //           AppConstants.office,
    //                         //           controller.type == "new"
    //                         //               ? AppConstants.officeLayout
    //                         //               : AppConstants.officeOld,
    //                         //           controller.type == "new"
    //                         //               ? AppConstants.officeComplete
    //                         //               : "",
    //                         //           officeCompletePrice,
    //                         //           officeLayoutPrice,
    //                         //           astrologer);
    //                         //     } else {
    //                         //       Get.toNamed('/login');
    //                         //     }
    //                         //   },
    //                         //   text: 'Office Consultancy',
    //                         //   backgroundColor: ColorResources.colorPrimaryVariant,
    //                         //   textColor: ColorResources.toolbarText,
    //                         // ),
    //                       ),
    //                     ),
    //                   if (astrologer.onlineStatus == 1)
    //                     Expanded(
    //                       child: Padding(
    //                         padding:
    //                             const EdgeInsets.symmetric(horizontal: 4.0),
    //                         child: ElevatedButton(
    //                           onPressed: () async {
    //                             bool isLogin =
    //                             await SharedPreferencesHelper.getIsLogin();
    //                             if (isLogin) {
    //                               controller.showTypeBottomSheet(
    //                                   type,
    //                                   AppConstants.industry,
    //                                   type == "new"
    //                                       ? AppConstants.industryLayout
    //                                       : AppConstants.industryOld,
    //                                   type == "new"
    //                                       ? AppConstants.industryComplete
    //                                       : "",
    //                                   industryCompletePrice,
    //                                   industryLayoutPrice,
    //                                   astrologer);
    //                             } else {
    //                               Get.toNamed('/login');
    //                             }
    //                           },
    //                           style: ElevatedButton.styleFrom(
    //                             backgroundColor: ColorResources.colorPrimary,
    //                             padding: const EdgeInsets.only(top: 2, bottom: 2),
    //                             shape: RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.circular(8),
    //                             ),
    //                           ),
    //                           child: const Text(
    //                             'Industry Consultancy',
    //                             style: TextStyle(
    //                               color: ColorResources.toolbarText,
    //                             ),
    //                             textAlign: TextAlign.center,
    //                           ),
    //                         ),
    //                         // CustomElevatedButton(
    //                         //   onPressed: () async {
    //                         //     bool isLogin =
    //                         //         await SharedPreferencesHelper.getIsLogin();
    //                         //     if (isLogin) {
    //                         //       controller.showTypeBottomSheet(
    //                         //           controller.type,
    //                         //           AppConstants.industry,
    //                         //           controller.type == "new"
    //                         //               ? AppConstants.industryLayout
    //                         //               : AppConstants.industryOld,
    //                         //           controller.type == "new"
    //                         //               ? AppConstants.industryComplete
    //                         //               : "",
    //                         //           industryCompletePrice,
    //                         //           industryLayoutPrice,
    //                         //           astrologer);
    //                         //     } else {
    //                         //       Get.toNamed('/login');
    //                         //     }
    //                         //   },
    //                         //   text: 'Industry Consultancy',
    //                         //   backgroundColor:
    //                         //       ColorResources.colorPrimaryVariant,
    //                         //   textColor: ColorResources.toolbarText,
    //                         // ),
    //                       ),
    //                     ),
    //                   if (astrologer.onlineStatus == 0)
    //                     CustomTextRegular(
    //                       "Offline (Available Soon)",
    //                       fontSize: Dimensions.fontSizeLarge,
    //                       color: ColorResources.black1,
    //                     ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  void _showReviewBottomSheet(BuildContext context, String astrologerUniId) {
    controller.getAllReviews(0, astrologerUniId);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 14),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset(
                          'assets/images/back_arrow.png',
                          height: Dimensions.iconImageHeightSmall,
                          color: ColorResources.black,
                        ),
                      ),
                      const Gap(20),
                      Expanded(
                        child: CustomTextMedium(
                          "Rating and Reviews",
                          fontSize: Dimensions.fontSizeDefault,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                // Obx(
                //   () {
                //     if (controller.isReviewSuccess.isTrue) {
                //       return CustomReviewWidget(controller.reviewModel.reviews);
                //     } else if (controller.isReviewLoading.isTrue) {
                //       return const CustomDefaultProgressIndicator();
                //     } else {
                //       return const EmptyScreen();
                //     }
                //   },
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showUnfollowDialog() async {
    Get.dialog(AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Gap(10),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    Images.close,
                    height: 14,
                    color: ColorResources.black,
                  ),
                ),
              ),
            ),
            CustomRoundNetworkImage(
              imageUrl: controller.astrologer.astroImg.toString(),
              height: Dimensions.profileImageHeight,
              width: Dimensions.profileImageHeight,
            ),
            const Gap(10),
            CustomTextRegular(controller.astrologer.displayName.toString(),
                fontSize: 14),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
              child: Text(
                "Are you sure you want to unfollow?",
                style: TextStyle(fontSize: 12.0, color: ColorResources.black1),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              child: GestureDetector(
                onTap: () async {
                  await controller.astrologerFollow("0", controller.astrologer.astrologerUniId.toString());
                  Get.back();
                  CustomSnackBar.showTop(AppStrings.astroUnfollowMsg);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: ColorResources.colorPrimaryDark,
                    borderRadius:
                    BorderRadius.circular(Dimensions.borderRadiusDefault),
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
            ),
          ],
        ),
      ),
    ));
  }
}
