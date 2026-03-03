import 'package:astro_brahmand/utill/app_features.dart';
import 'package:astro_brahmand/utill/images.dart';
import 'package:astro_brahmand/view/screen/ask_astrologer_question/controller/ask_astrologer_question_controller.dart';
import 'package:astro_brahmand/view/screen/wallet/controller/wallet_controller.dart';
import 'package:astro_brahmand/view/widget/custom_astrologer_emergency_widget.dart';
import 'package:astro_brahmand/view/widget/custom_html_expanded.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/view/screen/astrologer_detail/controller/astrologer_profile_controller.dart';
import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:astro_brahmand/utill/dimensions.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/view/widget/custom_default_indicator.dart';
import 'package:astro_brahmand/view/widget/custom_empty_screen.dart';
import 'package:astro_brahmand/view/widget/custom_rating_icons.dart';
import 'package:astro_brahmand/view/widget/custom_review_widget.dart';
import 'package:astro_brahmand/view/widget/custom_round_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/common_methods.dart';
import '../../../utill/shared_preference.dart';
import '../../widget/custom_default_dialog.dart';
import '../../widget/custom_okdialog_widget.dart';
import '../../widget/custom_progress_indicator.dart';
import '../../widget/custom_service_button.dart';
import '../../widget/gallery_image_slider_widget.dart';
import '../chat/controller/chat_intake_form_controller.dart';
import '../dashboard/controller/dashboard_controller.dart';
import '../splash/controller/config_controller.dart';
import '../tip/controller/gift_controller.dart';
import '../wallet/wallet_screen.dart';

class AstrologerProfileScreen extends GetView<AstrologerProfileController> {
  AstrologerProfileScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _blockReasonController = TextEditingController();

  final DashboardController dashboardController =
      Get.put(DashboardController());
  final GiftController giftController = Get.put(GiftController());
  final ConfigController configController = Get.find();

  @override
  Widget build(BuildContext context) {
    String chatRate = '**',
        callRate = '**',
        videoRate = '**',
        emergencyChatRate = '**',
        emergencyCallRate = '**',
        emergencyVideoRate = '**';
    controller.astrologerData.value.prices?.forEach((priceItem) {
      String type = priceItem.type.toString();
      switch (type) {
        case AppConstants.chat:
          chatRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty
              ? "FREE"
              : priceItem.price.toString();
          controller.nextChatController.value = controller
              .formatDateTimeOutput(priceItem.nextOnlineTime.toString());
          break;
        case AppConstants.call:
          callRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty
              ? "FREE"
              : priceItem.price.toString();
          controller.nextCallController.value = controller
              .formatDateTimeOutput(priceItem.nextOnlineTime.toString());
          break;
        case AppConstants.video:
          videoRate = priceItem.firstCallFreeMinutes.toString().isNotEmpty
              ? "FREE"
              : priceItem.price.toString();
          controller.nextVideoController.value = controller
              .formatDateTimeOutput(priceItem.nextOnlineTime.toString());
          break;
        case AppConstants.emergencyChat:
          emergencyChatRate = priceItem.price.toString();
          break;
        case AppConstants.emergencyCall:
          emergencyCallRate = priceItem.price.toString();
          break;
        case AppConstants.emergencyVideoCall:
          emergencyVideoRate = priceItem.price.toString();
          break;
      }
    });

    giftController.selectedGiftIndex.value = -1;
    giftController.getGifts();

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
                  controller.astrologerData.value.displayName.toString(),
                  style: const TextStyle(
                      fontSize: Dimensions.fontSizeLarge,
                      color: ColorResources.toolbarText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.share,
                    size: Dimensions.iconSizeMediumSmall,
                    color: ColorResources.toolbarText),
                onPressed: () {
                  controller.shareProfile();
                  // String astroSlugUrl =
                  //     controller.astrologerData.value.slug.toString();
                  // CommonMethods().shareApp("astrologerProfile",
                  //     astroSlugUrl: astroSlugUrl);
                },
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert,
                    color: ColorResources.toolbarText),
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
                                      imageUrl: controller
                                          .astrologerData.value.astroImg
                                          .toString(),
                                      height: Dimensions.profileImageHeight,
                                      width: Dimensions.profileImageHeight),
                                ),
                                // const Gap(10),
                                CustomTextMedium(controller
                                    .astrologerData.value.displayName
                                    .toString()),
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
                                        return AppStrings.formError.tr;
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
                                        Get.dialog(
                                            CustomOkdialogWidget(
                                              imagePath: Images.successCheck,
                                              title: AppStrings.success.tr,
                                              imageColor:
                                                  ColorResources.colorPrimary,
                                              onPressed: () {
                                                Get.back();
                                              },
                                              description:
                                                  AppStrings.successBlockMsg.tr,
                                            ),
                                            barrierDismissible: false);
                                        // CustomDefaultDialog.showOkDialog(
                                        //     AppStrings.success.tr,
                                        //     AppStrings.successBlockMsg.tr, () {
                                        //   Get.back();
                                        // });
                                      } // add block function
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 20.0),
                                        decoration: BoxDecoration(
                                          color: ColorResources.colorPrimary,
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
              controller.getAstrologerDetail(
                  controller.astrologerData.value.astrologerUniId.toString());
              bool isLogin = await SharedPreferencesHelper.getIsLogin();
              if (isLogin) {
                dashboardController.getWalletBalance();
              }
            },
            child: Obx(
              () => Column(
                children: [
                  Expanded(
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeSmall),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(10),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.borderRadiusDefault),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorResources.colorPrimaryVariant
                                        .withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.paddingSizeDefault),
                                child: Column(
                                  children: [
                                    // Online Status Badge (Top Left)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 8,
                                                height: 8,
                                                decoration: BoxDecoration(
                                                  color: controller
                                                                  .astrologerData
                                                                  .value
                                                                  .onlineStatus ==
                                                              1 &&
                                                          controller
                                                                  .astrologerData
                                                                  .value
                                                                  .busyStatus ==
                                                              1
                                                      ? Colors.orange
                                                      : controller
                                                                      .astrologerData
                                                                      .value
                                                                      .chatStatus ==
                                                                  1 ||
                                                              controller
                                                                      .astrologerData
                                                                      .value
                                                                      .callStatus ==
                                                                  1 ||
                                                              controller
                                                                      .astrologerData
                                                                      .value
                                                                      .videoStatus ==
                                                                  1
                                                          ? Colors.green
                                                          : Colors.red,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              const Gap(6),
                                              CustomTextRegular(
                                                controller.astrologerData.value
                                                                .onlineStatus ==
                                                            1 &&
                                                        controller.astrologerData.value
                                                                .busyStatus ==
                                                            1
                                                    ? "BUSY"
                                                    : controller
                                                                    .astrologerData
                                                                    .value
                                                                    .chatStatus ==
                                                                1 ||
                                                            controller
                                                                    .astrologerData
                                                                    .value
                                                                    .callStatus ==
                                                                1 ||
                                                            controller
                                                                    .astrologerData
                                                                    .value
                                                                    .videoStatus ==
                                                                1
                                                        ? "ONLINE"
                                                        : "OFFLINE",
                                                fontSize: Dimensions
                                                    .fontSizeExtraSmall,
                                                color: controller
                                                                .astrologerData
                                                                .value
                                                                .onlineStatus ==
                                                            1 &&
                                                        controller
                                                                .astrologerData
                                                                .value
                                                                .busyStatus ==
                                                            1
                                                    ? Colors.orange.shade700
                                                    : controller.astrologerData
                                                                    .value.chatStatus ==
                                                                1 ||
                                                            controller
                                                                    .astrologerData
                                                                    .value
                                                                    .callStatus ==
                                                                1 ||
                                                            controller
                                                                    .astrologerData
                                                                    .value
                                                                    .videoStatus ==
                                                                1
                                                        ? Colors.green.shade700
                                                        : Colors.red.shade700,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Obx(() => GestureDetector(
                                          onTap: () {
                                            if (controller.isFollow.isTrue) {
                                              showUnfollowDialog();
                                            } else {
                                              controller.astrologerFollow("1", controller.astrologerData.value.astrologerUniId.toString());
                                              CustomSnackBar.showTop(AppStrings.astroFollowMsg);
                                            }
                                          },
                                          child: Container(
                                            padding:
                                            const EdgeInsets.symmetric(
                                                vertical: 4.0,
                                                horizontal: 10.0),
                                            decoration: BoxDecoration(
                                              color: controller
                                                  .isFollow.isFalse
                                                  ? ColorResources
                                                  .colorPrimary
                                                  : ColorResources.white,
                                              border: controller.isFollow.isTrue
                                                  ? Border.all(
                                                color: ColorResources.colorPrimary,
                                                width: 1.0,
                                              )
                                                  : null,
                                              borderRadius: BorderRadius
                                                  .circular(Dimensions
                                                  .borderRadiusDefault),
                                            ),
                                            child: CustomTextRegular(
                                              controller.isFollow.isFalse
                                                  ? "Follow"
                                                  : "Following",
                                              color: controller
                                                  .isFollow.isFalse
                                                  ? ColorResources
                                                  .toolbarText
                                                  : ColorResources.colorPrimary,
                                              fontSize:
                                              Dimensions.fontSizeSmall,
                                            ),
                                          ),
                                        )),
                                      ],
                                    ),
                                    const Gap(Dimensions.gapExtraExtraSmall),

                                    // Profile Picture (Centered)
                                    Center(
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Get.dialog(
                                                Dialog(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Container(
                                                      color: Colors.transparent,
                                                      width: Get.width * 0.8,
                                                      height: Get.height * 0.5,
                                                      child: CustomNetworkImage(
                                                          imageUrl: controller
                                                              .astrologerData
                                                              .value
                                                              .astroImg
                                                              .toString(),
                                                          height:
                                                              Get.height * 0.5,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: controller
                                                                  .astrologerData
                                                                  .value
                                                                  .onlineStatus ==
                                                              1 &&
                                                          controller
                                                                  .astrologerData
                                                                  .value
                                                                  .busyStatus ==
                                                              1
                                                      ? Colors.orange
                                                      : controller
                                                                      .astrologerData
                                                                      .value
                                                                      .chatStatus ==
                                                                  1 ||
                                                              controller
                                                                      .astrologerData
                                                                      .value
                                                                      .callStatus ==
                                                                  1 ||
                                                              controller
                                                                      .astrologerData
                                                                      .value
                                                                      .videoStatus ==
                                                                  1
                                                          ? Colors.green
                                                          : Colors.red,
                                                  width: 2,
                                                ),
                                              ),
                                              child: CustomRoundNetworkImage(
                                                imageUrl: controller
                                                    .astrologerData
                                                    .value
                                                    .astroImg
                                                    .toString(),
                                                height: 100,
                                                width: 100,
                                              ),
                                            ),
                                          ),
                                          // Verified Badge
                                          if (controller.astrologerData.value
                                                  .isVerified ==
                                              0)
                                            Positioned(
                                              right: 3,
                                              bottom: 3,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: ColorResources
                                                            .black7,
                                                        width: 0.5)),
                                                child: Image.asset(
                                                  Images.verifiedProfile,
                                                  height: 20,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    const Gap(Dimensions.gapDefault),

                                    // Name
                                    CustomTextMedium(
                                      controller
                                          .astrologerData.value.displayName
                                          .toString(),
                                      maxLines: 1,
                                      fontSize: Dimensions.fontSizeExtraLarge,
                                      color: ColorResources.black2,
                                    ),
                                    const Gap(Dimensions.gapSmall),

                                    // Rating and Orders
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: ColorResources.colorRatingIcon,
                                          size: Dimensions.iconSizeOverSmall,
                                        ),
                                        const Gap(4),
                                        CustomTextRegular(
                                          controller.astrologerData.value.user!
                                              .avgRating
                                              .toString(),
                                          fontSize: Dimensions.fontSizeDefault,
                                          color: ColorResources.black2,
                                        ),
                                        const Gap(6),
                                        Container(
                                          width: 4,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade400,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const Gap(6),
                                        CustomTextRegular(
                                          "${controller.astrologerData.value.totalOrderCount ?? 0} orders",
                                          fontSize: Dimensions.fontSizeSmall,
                                          color: Colors.grey.shade600,
                                        ),
                                      ],
                                    ),
                                    const Gap(Dimensions.gapDefault),

                                    // Skills Tags
                                    if (controller.astrologerData.value
                                                .categoryNames !=
                                            null &&
                                        controller.astrologerData.value
                                            .categoryNames!.isNotEmpty)
                                      Wrap(
                                        alignment: WrapAlignment.center,
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: controller
                                            .astrologerData.value.categoryNames!
                                            .split(',')
                                            .take(3)
                                            .map((skill) => Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 12,
                                                    vertical: 6,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade100,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: CustomTextRegular(
                                                    skill.trim(),
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                    color:
                                                        ColorResources.black2,
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    const Gap(Dimensions.gapDefault),

                                    // Dashed Separator
                                    CustomPaint(
                                      painter: DashedLinePainter(),
                                      child: const SizedBox(
                                        width: double.infinity,
                                        height: 1,
                                      ),
                                    ),
                                    const Gap(Dimensions.gapDefault),

                                    // Experience and Languages Row
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        // Experience Section
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.school,
                                                  color:
                                                      ColorResources.colorPrimary,
                                                  size: Dimensions
                                                      .iconSizeOverSmall,
                                                ),
                                              ),
                                              const Gap(8),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomTextRegular(
                                                    "EXP",
                                                    fontSize: Dimensions
                                                        .fontSizeExtraSmall,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                  CustomTextMedium(
                                                    "${controller.astrologerData.value.experience ?? 0}+ Years",
                                                    fontSize: Dimensions
                                                        .fontSizeDefault,
                                                    color:
                                                        ColorResources.black2,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Languages Section
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.language,
                                                  color:
                                                  ColorResources.colorPrimary,
                                                  size: Dimensions
                                                      .iconSizeOverSmall,
                                                ),
                                              ),
                                              const Gap(8),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    CustomTextRegular(
                                                      "LANG",
                                                      fontSize: Dimensions
                                                          .fontSizeExtraSmall,
                                                      color:
                                                          Colors.grey.shade600,
                                                    ),
                                                    CustomTextMedium(
                                                      controller
                                                              .astrologerData
                                                              .value
                                                              .languageName
                                                              ?.toString() ??
                                                          "N/A",
                                                      maxLines: 1,
                                                      fontSize: Dimensions
                                                          .fontSizeDefault,
                                                      color:
                                                          ColorResources.black2,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Gap(Dimensions.gapDefault),

                                    // Divider
                                    Container(
                                      height: 1,
                                      color: Colors.grey.shade300,
                                    ),
                                    const Gap(Dimensions.gapDefault),

                                    // Chat Time and Call Time Row
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        // Chat Time Section
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                Images.astroChat,
                                                height: Dimensions
                                                    .iconImageHeightOver,
                                                color: ColorResources.black1,
                                              ),
                                              const Gap(8),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomTextRegular(
                                                    "${controller.astrologerData.value.totalChatDuration ?? 0} mins",
                                                    fontSize: Dimensions
                                                        .fontSizeDefault,
                                                    color:
                                                        ColorResources.black2,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Vertical Divider
                                        Container(
                                          height: 20,
                                          width: 1,
                                          color: Colors.grey.shade400,
                                        ),

                                        // Call Time Section
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                Images.astroCall,
                                                height: Dimensions
                                                    .iconImageHeightOver,
                                                color: ColorResources.black1,
                                              ),
                                              const Gap(8),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomTextRegular(
                                                    "${controller.astrologerData.value.totalCallDuration ?? 0} mins",
                                                    fontSize: Dimensions
                                                        .fontSizeDefault,
                                                    color:
                                                        ColorResources.black2,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Emergency Chat/Call
                            if (AppFeatures.emergencyChat ||
                                AppFeatures.emergencyCall)
                              Obx(() {
                                if (controller
                                        .astrologerData.value.onlineStatus ==
                                    0) {
                                  return Column(
                                    children: [
                                      const Gap(Dimensions.gapDefault),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.borderRadiusDefault),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: ColorResources
                                                  .colorPrimaryLight,
                                              spreadRadius: 1,
                                              blurRadius: 1,
                                              offset: Offset(0, 0),
                                            ),
                                          ],
                                        ),
                                        child: GestureDetector(
                                          onTap: () async {
                                            if (controller.astrologerData.value
                                                        .emergencyChatStatus ==
                                                    1 ||
                                                controller.astrologerData.value
                                                        .emergencyCallStatus ==
                                                    1) {
                                              Get.dialog(
                                                CustomAstrologerEmergencyWidget(
                                                    controller,
                                                    emergencyCallRate,
                                                    emergencyChatRate,
                                                    emergencyVideoRate),
                                              );
                                            } else {
                                              CustomSnackBar.showBottom(
                                                  "${controller.astrologerData.value.displayName} is offline for emergency.Try after sometime.");
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal:
                                                    Dimensions.paddingSizeSmall,
                                                vertical: Dimensions
                                                    .paddingSizeSmall),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                        Images.emergency,
                                                        height: 22,
                                                        color: ColorResources
                                                            .black2),
                                                    const Gap(8),
                                                    Expanded(
                                                      child: CustomTextRegular(
                                                          AppStrings
                                                              .needEmergencyAssistance
                                                              .tr),
                                                    ),
                                                  ],
                                                ),
                                                const Gap(5),
                                                CustomTextRegular(
                                                  "${controller.astrologerData.value.displayName} considers you a VIP customer. You may connect with them, even when they are offline @ ${configController.currencySymbol} $emergencyCallRate",
                                                  color: ColorResources.black2,
                                                  fontSize:
                                                      Dimensions.fontSizeSmall,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                left: 7,
                                                                right: 7,
                                                                top: 3,
                                                                bottom: 3),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                const BorderRadius.all(
                                                                    Radius.circular(
                                                                        10)),
                                                            border: Border.all(
                                                                width: 1,
                                                                color: controller.astrologerData.value.emergencyChatStatus == 1 || controller.astrologerData.value.emergencyCallStatus == 1
                                                                    ? ColorResources
                                                                        .orange
                                                                    : ColorResources
                                                                        .black4)),
                                                        child: CustomTextMedium(AppStrings.connect.tr,
                                                            color: controller.astrologerData.value.emergencyChatStatus ==
                                                                        1 ||
                                                                    controller.astrologerData.value.emergencyCallStatus == 1
                                                                ? ColorResources.orange
                                                                : ColorResources.black4)),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }),

                            // Gallery images
                            Obx(() {
                              if (controller.astrologerData.value
                                  .galleryImageList!.isNotEmpty) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: Dimensions.gapDefault),
                                  height: 130.0,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.astrologerData.value
                                        .galleryImageList?.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                GalleryImageSliderWidget(
                                              imageUrls: controller
                                                  .astrologerData
                                                  .value
                                                  .galleryImageList!,
                                              initialIndex: index,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CustomNetworkImage(
                                                imageUrl: controller
                                                    .astrologerData
                                                    .value
                                                    .galleryImageList![index],
                                                height: 120,
                                                width: 120),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),

                            const Gap(Dimensions.gapLarge),

                            Obx(() {
                              if (controller
                                      .astrologerData.value.onlineStatus ==
                                  0) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextMedium("Next Online",
                                        fontSize: Dimensions.fontSizeLarge),
                                    const Gap(Dimensions.gapExtraSmall),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          if (controller.nextChatController
                                              .value.isNotEmpty)
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              margin: const EdgeInsets.only(
                                                  left: 5, right: 5),
                                              decoration: BoxDecoration(
                                                color: ColorResources
                                                    .colorPrimaryLight,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    Images.astroChat,
                                                    // Replace with your image path
                                                    width: 18,
                                                    // Adjust image size as needed
                                                    height: 18,
                                                    color: ColorResources
                                                        .colorPrimaryMedium,
                                                  ),
                                                  const Gap(
                                                      Dimensions.gapExtraSmall),
                                                  CustomTextRegular(
                                                    controller
                                                        .nextChatController
                                                        .value,
                                                    color:
                                                        ColorResources.black1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          if (controller.nextCallController
                                              .value.isNotEmpty)
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              margin: const EdgeInsets.only(
                                                  left: 5, right: 5),
                                              decoration: BoxDecoration(
                                                color: ColorResources
                                                    .colorPrimaryLight,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    Images.astroCall,
                                                    // Replace with your image path
                                                    width: 18,
                                                    // Adjust image size as needed
                                                    height: 18,
                                                    color: ColorResources
                                                        .colorPrimaryMedium,
                                                  ),
                                                  const Gap(
                                                      Dimensions.gapExtraSmall),
                                                  CustomTextRegular(
                                                    controller
                                                        .nextCallController
                                                        .value,
                                                    color:
                                                        ColorResources.black1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          if (controller.nextVideoController
                                              .value.isNotEmpty)
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              margin: const EdgeInsets.only(
                                                  left: 5, right: 5),
                                              decoration: BoxDecoration(
                                                color: ColorResources
                                                    .colorPrimaryLight,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                    Images.astroVideoCall,
                                                    // Replace with your image path
                                                    width: 18,
                                                    // Adjust image size as needed
                                                    height: 18,
                                                    color: ColorResources
                                                        .colorPrimaryMedium,
                                                  ),
                                                  const Gap(
                                                      Dimensions.gapExtraSmall),
                                                  CustomTextRegular(
                                                    controller
                                                        .nextVideoController
                                                        .value,
                                                    color:
                                                        ColorResources.black1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    const Gap(Dimensions.gapSmall),
                                    const Divider(
                                      color: ColorResources.colorPrimaryVariant,
                                    ),
                                    const Gap(Dimensions.gapSmall),
                                  ],
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            }),

                            CustomTextMedium("Specialization",
                                fontSize: Dimensions.fontSizeLarge),
                            const Gap(Dimensions.gapExtraSmall),
                            CustomTextRegular(
                              controller.astrologerData.value.skillNames
                                  .toString(),
                              color: ColorResources.black1,
                            ),
                            const Gap(Dimensions.gapSmall),
                            const Divider(
                                color: ColorResources.colorPrimaryVariant),
                            const Gap(Dimensions.gapSmall),

                            CustomTextMedium("Languages",
                                fontSize: Dimensions.fontSizeLarge),
                            const Gap(Dimensions.gapExtraSmall),
                            CustomTextRegular(
                              controller.astrologerData.value.languageName
                                  .toString(),
                              color: ColorResources.black1,
                            ),
                            const Gap(Dimensions.gapSmall),
                            const Divider(
                                color: ColorResources.colorPrimaryVariant),
                            const Gap(Dimensions.gapSmall),

                            CustomTextMedium("Profile Summary",
                                fontSize: Dimensions.fontSizeLarge),
                            CustomHtmlTextExpanded(
                                fullText: controller
                                    .astrologerData.value.longBiography
                                    .toString(),
                                mainAxisAlignment: MainAxisAlignment.end,
                                textColor: ColorResources.colorText,
                                iconColor: ColorResources.colorText),
                            const Gap(Dimensions.gapSmall),
                            const Divider(
                                color: ColorResources.colorPrimaryVariant),
                            const Gap(Dimensions.gapSmall),

                            Row(
                              children: [
                                CustomTextMedium("Reviews:",
                                    fontSize: Dimensions.fontSizeLarge),
                                const Gap(Dimensions.gapExtraSmall),
                                Expanded(
                                  child: CustomTextMedium(
                                    controller.astrologerData.value.reviewCount
                                        .toString(),
                                    fontSize: Dimensions.fontSizeLarge,
                                    color: ColorResources.colorPrimaryDark,
                                  ),
                                ),
                                // const Spacer(),
                                InkWell(
                                    onTap: () {
                                      _showReviewBottomSheet(
                                          context,
                                          controller.astrologerData.value
                                              .astrologerUniId
                                              .toString());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0, horizontal: 6),
                                      child: CustomTextMedium("View all",
                                          fontSize: Dimensions.fontSizeSmall,
                                          color: ColorResources.colorText),
                                    )),
                                const Gap(Dimensions.gapLarge),
                              ],
                            ),
                            const Gap(Dimensions.gapExtraSmall),
                            Container(
                              decoration: BoxDecoration(
                                  color: ColorResources.white,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.borderRadiusDefault),
                                  border:
                                      Border.all(color: ColorResources.black6)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 8.0),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller
                                      .astrologerData.value.reviews?.length,
                                  itemBuilder: (context, index) {
                                    return CustomReviewWidget(controller
                                        .astrologerData.value.reviews![index]);
                                  },
                                ),
                              ),
                            ),

                            // Ask a question
                            if (AppFeatures.askAstroQuestion &&
                                controller.astrologerData.value
                                        .isVirtualAstrologer ==
                                    0)
                              Column(
                                children: [
                                  const Gap(Dimensions.gapSmall),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.borderRadiusDefault),
                                      boxShadow: const [
                                        BoxShadow(
                                          color:
                                              ColorResources.colorPrimaryLight,
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: GestureDetector(
                                      onTap: () async {
                                        final AskAstrologerQuestionController
                                            askAstrologerQuestionController =
                                            Get.put(
                                                AskAstrologerQuestionController());
                                        askAstrologerQuestionController
                                            .messageController.text = "";
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          // shape: const RoundedRectangleBorder(
                                          //   borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                          // ),
                                          builder: (BuildContext context) {
                                            return Container(
                                              decoration: const BoxDecoration(
                                                color: ColorResources.white,
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            15)),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom, // Handle keyboard height
                                                  top: 10,
                                                  left: 14,
                                                  right: 6,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const SizedBox(
                                                            width: 12),
                                                        Flexible(
                                                          child: TextField(
                                                            controller:
                                                                askAstrologerQuestionController
                                                                    .messageController,
                                                            autofocus: true,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            maxLines: 4,
                                                            minLines: 1,
                                                            decoration:
                                                                const InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  'Enter your question...',
                                                            ),
                                                          ),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            if (askAstrologerQuestionController
                                                                .messageController
                                                                .text
                                                                .isNotEmpty) {
                                                              if (FocusManager
                                                                      .instance
                                                                      .primaryFocus !=
                                                                  null) {
                                                                FocusManager
                                                                    .instance
                                                                    .primaryFocus!
                                                                    .unfocus();
                                                              }
                                                              askAstrologerQuestionController.getCalculation(
                                                                  askAstrologerQuestionController
                                                                      .messageController
                                                                      .text
                                                                      .toString(),
                                                                  controller
                                                                      .astrologerData
                                                                      .value
                                                                      .astrologerUniId
                                                                      .toString(),
                                                                  1,
                                                                  "Open");
                                                              Get.back(); // Close the bottom sheet
                                                            }
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            shape:
                                                                const CircleBorder(),
                                                            backgroundColor:
                                                                ColorResources
                                                                    .colorPrimary, // Replace with ColorResources.colorPrimary
                                                          ),
                                                          child: const Icon(
                                                            Icons.send,
                                                            color: ColorResources
                                                                .toolbarText, // Replace with ColorResources.white
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:
                                                Dimensions.paddingSizeSmall,
                                            vertical:
                                                Dimensions.paddingSizeSmall),
                                        child: Row(
                                          children: [
                                            Image.asset(Images.askQuestion,
                                                height: 24,
                                                color: ColorResources.black2),
                                            const Gap(10),
                                            Expanded(
                                              child: CustomTextRegular(
                                                  AppStrings.askQuestion.tr),
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: ColorResources.black2,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            if (AppFeatures.slotBooking &&
                                controller.astrologerData.value
                                        .isVirtualAstrologer ==
                                    0)
                              Column(
                                children: [
                                  const Gap(Dimensions.gapSmall),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.borderRadiusDefault),
                                      boxShadow: const [
                                        BoxShadow(
                                          color:
                                              ColorResources.colorPrimaryLight,
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: GestureDetector(
                                      onTap: () async {
                                        bool isLogin =
                                            await SharedPreferencesHelper
                                                .getIsLogin();
                                        if (isLogin) {
                                          ChatIntakeFormController
                                              chatIntakeFormController =
                                              Get.put(
                                                  ChatIntakeFormController());
                                          chatIntakeFormController
                                              .setAstrologerData(
                                                  controller.astrologerData
                                                      .value.displayName
                                                      .toString(),
                                                  controller.astrologerData
                                                      .value.astroImg
                                                      .toString(),
                                                  controller.astrologerData
                                                      .value.astrologerUniId
                                                      .toString(),
                                                  AppConstants.slot,
                                                  controller
                                                          .astrologerData
                                                          .value
                                                          .isVirtualAstrologer ??
                                                      0);
                                          Get.toNamed("/slotAvailabilityScreen",
                                              arguments: {
                                                'astrologerId': controller
                                                    .astrologerData
                                                    .value
                                                    .astrologerUniId
                                                    .toString()
                                              });
                                        } else {
                                          Get.toNamed('/login');
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:
                                                Dimensions.paddingSizeSmall,
                                            vertical:
                                                Dimensions.paddingSizeSmall),
                                        child: Row(
                                          children: [
                                            Image.asset(Images.chatAssistant,
                                                height: 24,
                                                color: ColorResources.black2),
                                            const Gap(10),
                                            Expanded(
                                              child: CustomTextRegular(
                                                  AppStrings
                                                      .checkSlotAvailability
                                                      .tr),
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: ColorResources.black2,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            const Gap(Dimensions.gapSmall),
                            if (controller
                                    .astrologerData.value.isVirtualAstrologer ==
                                0)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.borderRadiusDefault),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: ColorResources.colorPrimaryLight,
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    bool isLogin = await SharedPreferencesHelper
                                        .getIsLogin();
                                    if (isLogin) {
                                      ChatIntakeFormController
                                          chatIntakeFormController =
                                          Get.put(ChatIntakeFormController());
                                      chatIntakeFormController
                                          .setAstrologerData(
                                              controller.astrologerData.value
                                                  .displayName
                                                  .toString(),
                                              controller
                                                  .astrologerData.value.astroImg
                                                  .toString(),
                                              controller.astrologerData.value
                                                  .astrologerUniId
                                                  .toString(),
                                              AppConstants.chat,
                                              controller.astrologerData.value
                                                      .isVirtualAstrologer ??
                                                  0);
                                      chatIntakeFormController
                                          .startAssistantChat(controller
                                              .astrologerData
                                              .value
                                              .astrologerUniId
                                              .toString());
                                    } else {
                                      Get.toNamed('/login');
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions.paddingSizeSmall,
                                        vertical: Dimensions.paddingSizeSmall),
                                    child: Row(
                                      children: [
                                        Image.asset(Images.chatAssistant,
                                            height: 24,
                                            color: ColorResources.black2),
                                        const Gap(10),
                                        Expanded(
                                          child: CustomTextRegular(
                                              AppStrings.chatWithAss.tr),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: ColorResources.black2,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            const Gap(Dimensions.gapSmall),
                            // Gifts
                            Obx(() {
                              if (controller.isLogin.isTrue) {
                                return Container(
                                  padding: const EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.borderRadiusDefault),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: ColorResources.colorPrimaryLight,
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 16.0, left: 10, top: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: CustomTextMedium(
                                                "Send a Gift",
                                                fontSize:
                                                    Dimensions.fontSizeLarge,
                                              ),
                                            ),
                                            Obx(() {
                                              if (dashboardController
                                                  .isBalanceLoading.value) {
                                                return const SizedBox(
                                                    width:
                                                        20.0, // Set your desired width
                                                    height: 20.0,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: ColorResources
                                                          .colorSecondary,
                                                      strokeWidth: 1.0,
                                                    ));
                                              } else if (dashboardController
                                                  .isBalanceSuccess.value) {
                                                return CustomTextMedium(
                                                    '${configController.currencySymbol}${dashboardController.walletBalanceModel.data.toString()}',
                                                    color:
                                                        ColorResources.black);
                                              } else {
                                                return const Text('***',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: ColorResources
                                                            .toolbarText));
                                              }
                                            }),
                                          ],
                                        ),
                                      ),
                                      const Gap(Dimensions.gapDefault),
                                      Obx(() {
                                        if (giftController
                                            .isGiftSuccess.isTrue) {
                                          return GridView.builder(
                                            itemCount: giftController
                                                .liveGiftListModel.data?.length,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4,
                                                    mainAxisSpacing: 2.0,
                                                    crossAxisSpacing: 2.0,
                                                    childAspectRatio: 0.90),
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  // controller.selectedGiftIndex.value = index;
                                                  if (giftController
                                                          .selectedGiftIndex
                                                          .value ==
                                                      index) {
                                                    // If the selected gift is clicked again, unselect it
                                                    giftController
                                                        .selectedGiftIndex
                                                        .value = -1;
                                                  } else {
                                                    // Otherwise, select the clicked gift
                                                    giftController
                                                        .selectedGiftIndex
                                                        .value = index;
                                                  }
                                                },
                                                child: Obx(
                                                  () => Container(
                                                    decoration: BoxDecoration(
                                                      color: giftController
                                                                  .selectedGiftIndex
                                                                  .value ==
                                                              index
                                                          ? Colors.grey[300]
                                                          : null,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        CustomNetworkImage(
                                                          imageUrl: giftController
                                                              .liveGiftListModel
                                                              .data![index]
                                                              .giftImage
                                                              .toString(),
                                                          height: 40,
                                                          width: 40,
                                                        ),
                                                        // const Gap(Dimensions.gapExtraExtraSmall),
                                                        CustomTextRegular(
                                                          giftController
                                                              .liveGiftListModel
                                                              .data![index]
                                                              .giftName
                                                              .toString(),
                                                          fontSize: Dimensions
                                                              .fontSizeSmall,
                                                          maxLines: 1,
                                                        ),
                                                        CustomTextMedium(
                                                          "${configController.currencySymbol} ${giftController.liveGiftListModel.data![index].giftPrice.toString()}",
                                                          fontSize: Dimensions
                                                              .fontSizeExtraSmall,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        } else if (giftController
                                            .isGiftLoading.isTrue) {
                                          return const CircularProgressIndicator();
                                        } else {
                                          return const EmptyScreen();
                                        }
                                      }),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4.0,
                                            left: 8,
                                            right: 8,
                                            bottom: 10),
                                        child: Row(
                                          children: [
                                            Obx(() {
                                              if (giftController
                                                      .selectedGiftIndex
                                                      .value !=
                                                  -1) {
                                                return Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed("/wallet");
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10,
                                                          horizontal: 15),
                                                      decoration: BoxDecoration(
                                                        color: ColorResources
                                                            .colorPrimaryLight,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: CustomTextMedium(
                                                        "Recharge",
                                                        color: ColorResources
                                                            .black,
                                                        fontSize: Dimensions
                                                            .fontSizeSmall,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Container();
                                              }
                                            }),
                                            const Gap(Dimensions.gapExtraSmall),
                                            Obx(() {
                                              if (giftController
                                                      .selectedGiftIndex
                                                      .value !=
                                                  -1) {
                                                return Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if (giftController
                                                              .selectedGiftIndex
                                                              .value !=
                                                          -1) {
                                                        giftController
                                                            .sendGiftApi(
                                                          "0",
                                                          giftController
                                                              .astrologerData
                                                              .value
                                                              .astrologerUniId
                                                              .toString(),
                                                          giftController
                                                              .liveGiftListModel
                                                              .data![giftController
                                                                  .selectedGiftIndex
                                                                  .value
                                                                  .toInt()]
                                                              .id
                                                              .toString(),
                                                        );
                                                      } else {
                                                        CustomSnackBar.showTop(
                                                            "Please select a gift.");
                                                      }
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10,
                                                          horizontal: 15),
                                                      decoration: BoxDecoration(
                                                        color: ColorResources
                                                            .colorPrimaryMedium,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: CustomTextMedium(
                                                        "Send",
                                                        color: ColorResources
                                                            .toolbarText,
                                                        fontSize: Dimensions
                                                            .fontSizeSmall,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Container();
                                              }
                                            }),
                                          ],
                                        ),
                                      ),
                                      // const Divider(
                                      //   color: ColorResources.colorPrimaryVariant,
                                      // ),
                                    ],
                                  ),
                                );
                              } else {
                                return Container(); // Or any other placeholder
                              }
                            }),
                            // Gifts End
                            const Gap(Dimensions.gapDefault),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (controller.astrologerData.value.emergencyChatStatus != 1 ||
                      controller.astrologerData.value.emergencyCallStatus !=
                          1 ||
                      controller.astrologerData.value.emergencyVideoStatus != 1)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: ColorResources.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeMediumSmall,
                              vertical: Dimensions.paddingSizeOverSmall),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // if (controller.astrologerData.value.callStatus == 1)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: CustomServiceButton(
                                    onTap: () async {
                                      bool isLogin =
                                          await SharedPreferencesHelper
                                              .getIsLogin();
                                      num? isCallRequestToOfflineAstro =
                                          configController.config.data
                                              ?.isCallRequestToOfflineAstro;
                                      if (isLogin &&
                                          controller.astrologerData.value
                                                  .callStatus ==
                                              1) {
                                        if (AppFeatures
                                            .minimumBalanceRequired) {
                                          controller.astrologerData.value.prices
                                              ?.forEach((priceItem) {
                                            String type =
                                                priceItem.type.toString();
                                            switch (type) {
                                              case AppConstants.chat:
                                                chatRate = priceItem
                                                        .firstCallFreeMinutes
                                                        .toString()
                                                        .isNotEmpty
                                                    ? "FREE"
                                                    : priceItem.price
                                                        .toString();
                                                break;
                                              case AppConstants.call:
                                                callRate = priceItem
                                                        .firstCallFreeMinutes
                                                        .toString()
                                                        .isNotEmpty
                                                    ? "FREE"
                                                    : priceItem.price
                                                        .toString();
                                                break;
                                              case AppConstants.video:
                                                videoRate = priceItem
                                                        .firstCallFreeMinutes
                                                        .toString()
                                                        .isNotEmpty
                                                    ? "FREE"
                                                    : priceItem.price
                                                        .toString();
                                                break;
                                            }
                                          });

                                          // Now handle the chatRate logic
                                          if (chatRate == "FREE") {
                                            controller.checkCallDetail(
                                                AppConstants.call,
                                                controller.astrologerData.value
                                                    .astrologerUniId
                                                    .toString(),
                                                controller
                                                    .astrologerData.value);
                                          } else {
                                            // Convert chatRate from String to double
                                            double callRateValue =
                                                double.tryParse(callRate) ??
                                                    0.0;
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

                                            if (walletBalance >=
                                                minimumBalance) {
                                              controller.checkCallDetail(
                                                  AppConstants.call,
                                                  controller.astrologerData
                                                      .value.astrologerUniId
                                                      .toString(),
                                                  controller
                                                      .astrologerData.value);
                                            } else {
                                              CommonMethods()
                                                  .showInsufficientBalanceBottomSheet(
                                                      AppConstants.call,
                                                      controller.astrologerData
                                                          .value.displayName
                                                          .toString(),
                                                      minimumBalance
                                                          .toString());
                                              // CustomSnackBar.showBottom("Minimum balance of 5 minutes is required to start chat");
                                            }
                                          }
                                        } else {
                                          controller.checkCallDetail(
                                              AppConstants.call,
                                              controller.astrologerData.value
                                                  .astrologerUniId
                                                  .toString(),
                                              controller.astrologerData.value);
                                        }
                                      } else if (!isLogin) {
                                        Get.toNamed('/login');
                                      } else if (controller.astrologerData.value
                                                  .callStatus ==
                                              0 &&
                                          isCallRequestToOfflineAstro == 1) {
                                        showWaitListDialog(AppConstants.call);
                                      } else if (controller.astrologerData.value
                                                  .callStatus ==
                                              0 &&
                                          isCallRequestToOfflineAstro == 0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Astrologer currently unavailable for call")));
                                      }
                                    },
                                    service: "Call Now",
                                    servicePrice: callRate,
                                    backgroundColor: controller.astrologerData
                                                .value.callStatus ==
                                            1
                                        ? Colors.green
                                        : ColorResources.black7,
                                    textColor: controller.astrologerData.value
                                                    .callStatus ==
                                                1 &&
                                            controller.astrologerData.value
                                                    .busyStatus ==
                                                1
                                        ? Colors.red
                                        : controller.astrologerData.value
                                                    .callStatus ==
                                                1
                                            ? ColorResources.white
                                            : ColorResources.colorText,
                                  ),
                                ),
                              ),
                              // const Gap(Dimensions.gapDefault),
                              // if (controller.astrologerData.value.chatStatus == 1)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: CustomServiceButton(
                                    // onTap: () async {
                                    //   bool isLogin = await SharedPreferencesHelper.getIsLogin();
                                    //   if (isLogin && controller.astrologerData.value.chatStatus == 1) {
                                    //     controller.checkCallDetail(
                                    //         AppConstants.chat,
                                    //         controller.astrologerData.value.astrologerUniId.toString(),
                                    //         controller.astrologerData.value);
                                    //   } else if (!isLogin) {
                                    //     Get.toNamed('/login');
                                    //   } else if (controller.astrologerData.value.chatStatus == 0){
                                    //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    //         content: Text("Astrologer currently unavailable for chat"))
                                    //     );
                                    //   }
                                    // },
                                    onTap: () async {
                                      bool isLogin =
                                          await SharedPreferencesHelper
                                              .getIsLogin();
                                      num? isCallRequestToOfflineAstro =
                                          configController.config.data
                                              ?.isCallRequestToOfflineAstro;
                                      if (isLogin &&
                                          controller.astrologerData.value
                                                  .chatStatus ==
                                              1) {
                                        if (AppFeatures
                                            .minimumBalanceRequired) {
                                          controller.astrologerData.value.prices
                                              ?.forEach((priceItem) {
                                            String type =
                                                priceItem.type.toString();
                                            switch (type) {
                                              case AppConstants.chat:
                                                chatRate = priceItem
                                                        .firstCallFreeMinutes
                                                        .toString()
                                                        .isNotEmpty
                                                    ? "FREE"
                                                    : priceItem.price
                                                        .toString();
                                                break;
                                              case AppConstants.call:
                                                callRate = priceItem
                                                        .firstCallFreeMinutes
                                                        .toString()
                                                        .isNotEmpty
                                                    ? "FREE"
                                                    : priceItem.price
                                                        .toString();
                                                break;
                                              case AppConstants.video:
                                                videoRate = priceItem
                                                        .firstCallFreeMinutes
                                                        .toString()
                                                        .isNotEmpty
                                                    ? "FREE"
                                                    : priceItem.price
                                                        .toString();
                                                break;
                                            }
                                          });

                                          // Now handle the chatRate logic
                                          if (chatRate == "FREE") {
                                            controller.checkCallDetail(
                                                AppConstants.chat,
                                                controller.astrologerData.value
                                                    .astrologerUniId
                                                    .toString(),
                                                controller
                                                    .astrologerData.value);
                                          } else {
                                            // Convert chatRate from String to double
                                            double chatRateValue =
                                                double.tryParse(chatRate) ??
                                                    0.0;
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

                                            if (walletBalance >=
                                                minimumBalance) {
                                              controller.checkCallDetail(
                                                  AppConstants.chat,
                                                  controller.astrologerData
                                                      .value.astrologerUniId
                                                      .toString(),
                                                  controller
                                                      .astrologerData.value);
                                            } else {
                                              CommonMethods()
                                                  .showInsufficientBalanceBottomSheet(
                                                      AppConstants.chat,
                                                      controller.astrologerData
                                                          .value.displayName
                                                          .toString(),
                                                      minimumBalance
                                                          .toString());
                                              // CustomSnackBar.showBottom("Minimum balance of 5 minutes is required to start chat");
                                            }
                                          }
                                        } else {
                                          controller.checkCallDetail(
                                              AppConstants.chat,
                                              controller.astrologerData.value
                                                  .astrologerUniId
                                                  .toString(),
                                              controller.astrologerData.value);
                                        }
                                      } else if (!isLogin) {
                                        Get.toNamed('/login');
                                      } else if (controller.astrologerData.value
                                                  .chatStatus ==
                                              0 &&
                                          isCallRequestToOfflineAstro == 1) {
                                        showWaitListDialog(AppConstants.chat);
                                      } else if (controller.astrologerData.value
                                                  .chatStatus ==
                                              0 &&
                                          isCallRequestToOfflineAstro == 0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Astrologer currently unavailable for chat")));
                                      }
                                    },
                                    service: "Chat Now",
                                    servicePrice: chatRate,
                                    backgroundColor: controller.astrologerData
                                                .value.chatStatus ==
                                            1
                                        ? Colors.green
                                        : ColorResources.black7,
                                    textColor: controller.astrologerData.value
                                                    .chatStatus ==
                                                1 &&
                                            controller.astrologerData.value
                                                    .busyStatus ==
                                                1
                                        ? Colors.red
                                        : controller.astrologerData.value
                                                    .chatStatus ==
                                                1
                                            ? ColorResources.white
                                            : ColorResources.colorText,
                                  ),
                                ),
                              ),
                              // const Gap(Dimensions.gapDefault),
                              // if (controller.astrologerData.value.videoStatus == 1)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: CustomServiceButton(
                                    onTap: () async {
                                      bool isLogin =
                                          await SharedPreferencesHelper
                                              .getIsLogin();
                                      num? isCallRequestToOfflineAstro =
                                          configController.config.data
                                              ?.isCallRequestToOfflineAstro;
                                      if (isLogin &&
                                          controller.astrologerData.value
                                                  .videoStatus ==
                                              1) {
                                        if (AppFeatures
                                            .minimumBalanceRequired) {
                                          controller.astrologerData.value.prices
                                              ?.forEach((priceItem) {
                                            String type =
                                                priceItem.type.toString();
                                            switch (type) {
                                              case AppConstants.chat:
                                                chatRate = priceItem
                                                        .firstCallFreeMinutes
                                                        .toString()
                                                        .isNotEmpty
                                                    ? "FREE"
                                                    : priceItem.price
                                                        .toString();
                                                break;
                                              case AppConstants.call:
                                                callRate = priceItem
                                                        .firstCallFreeMinutes
                                                        .toString()
                                                        .isNotEmpty
                                                    ? "FREE"
                                                    : priceItem.price
                                                        .toString();
                                                break;
                                              case AppConstants.video:
                                                videoRate = priceItem
                                                        .firstCallFreeMinutes
                                                        .toString()
                                                        .isNotEmpty
                                                    ? "FREE"
                                                    : priceItem.price
                                                        .toString();
                                                break;
                                            }
                                          });

                                          // Now handle the chatRate logic
                                          if (chatRate == "FREE") {
                                            controller.checkCallDetail(
                                                AppConstants.video,
                                                controller.astrologerData.value
                                                    .astrologerUniId
                                                    .toString(),
                                                controller
                                                    .astrologerData.value);
                                          } else {
                                            // Convert chatRate from String to double
                                            double videoRateValue =
                                                double.tryParse(videoRate) ??
                                                    0.0;
                                            double minimumBalance =
                                                videoRateValue * 5;

                                            // Convert wallet balance to double
                                            double walletBalance =
                                                double.tryParse(
                                                        dashboardController
                                                            .walletBalanceModel
                                                            .data
                                                            .toString()) ??
                                                    0.0;

                                            if (walletBalance >=
                                                minimumBalance) {
                                              controller.checkCallDetail(
                                                  AppConstants.video,
                                                  controller.astrologerData
                                                      .value.astrologerUniId
                                                      .toString(),
                                                  controller
                                                      .astrologerData.value);
                                            } else {
                                              CommonMethods()
                                                  .showInsufficientBalanceBottomSheet(
                                                      AppConstants.video,
                                                      controller.astrologerData
                                                          .value.displayName
                                                          .toString(),
                                                      minimumBalance
                                                          .toString());
                                              // CustomSnackBar.showBottom("Minimum balance of 5 minutes is required to start chat");
                                            }
                                          }
                                        } else {
                                          controller.checkCallDetail(
                                              AppConstants.video,
                                              controller.astrologerData.value
                                                  .astrologerUniId
                                                  .toString(),
                                              controller.astrologerData.value);
                                        }
                                      } else if (!isLogin) {
                                        Get.toNamed('/login');
                                      } else if (controller.astrologerData.value
                                                  .videoStatus ==
                                              0 &&
                                          isCallRequestToOfflineAstro == 1) {
                                        showWaitListDialog(AppConstants.video);
                                      } else if (controller.astrologerData.value
                                                  .videoStatus ==
                                              0 &&
                                          isCallRequestToOfflineAstro == 0) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Astrologer currently unavailable for video call")));
                                      }
                                    },
                                    service: "Video Call",
                                    servicePrice: videoRate,
                                    backgroundColor: controller.astrologerData
                                                .value.videoStatus ==
                                            1
                                        ? Colors.green
                                        : ColorResources.black7,
                                    textColor: controller.astrologerData.value
                                                    .videoStatus ==
                                                1 &&
                                            controller.astrologerData.value
                                                    .busyStatus ==
                                                1
                                        ? Colors.red
                                        : controller.astrologerData.value
                                                    .videoStatus ==
                                                1
                                            ? ColorResources.white
                                            : ColorResources.colorText,
                                  ),
                                ),
                              ),
                              // if (controller.astrologerData.value.callStatus == 0 &&
                              //     controller.astrologerData.value.chatStatus ==
                              //         0 &&
                              //     controller.astrologerData.value.videoStatus ==
                              //         0)
                              //   CustomTextRegular(
                              //     "Offline (Available Soon)",
                              //     fontSize: Dimensions.fontSizeLarge,
                              //     color: ColorResources.black1,
                              //   ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (AppFeatures.emergencyChat ||
                      AppFeatures.emergencyCall ||
                      AppFeatures.emergencyVideoCall)
                    Obx(() {
                      if (controller.astrologerData.value.onlineStatus == 0 &&
                              controller.astrologerData.value
                                      .emergencyChatStatus ==
                                  1 ||
                          controller.astrologerData.value.emergencyCallStatus ==
                              1 ||
                          controller
                                  .astrologerData.value.emergencyVideoStatus ==
                              1) {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            color: ColorResources.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeMediumSmall,
                                  vertical: Dimensions.paddingSizeOverSmall),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        if (controller.astrologerData.value.emergencyChatStatus == 1 ||
                                            controller.astrologerData.value
                                                    .emergencyCallStatus ==
                                                1 ||
                                            controller.astrologerData.value
                                                    .emergencyVideoStatus ==
                                                1) {
                                          Get.dialog(
                                            CustomAstrologerEmergencyWidget(
                                                controller,
                                                emergencyCallRate,
                                                emergencyChatRate,
                                                emergencyVideoRate),
                                          );
                                        } else {
                                          CustomSnackBar.showBottom(
                                              "${controller.astrologerData.value.displayName} is offline for emergency.Try after sometime.");
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.borderRadiusDefault),
                                            color: ColorResources.orange),
                                        child: CustomTextRegular(
                                          "Try Emergency Session @ ${configController.currencySymbol} $emergencyCallRate/min",
                                          textAlign: TextAlign.center,
                                          color: ColorResources.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                ],
              ),
            )),
      ),
    );
  }

  void _showReviewBottomSheet(BuildContext context, String astrologerUniId) {
    controller.offsetCount = 0;
    controller.getAllReviews(controller.offsetCount, astrologerUniId);

    final draggableController = DraggableScrollableController();

    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          controller: draggableController,
          initialChildSize: 0.5,
          minChildSize: 0.25,
          maxChildSize: 1.0,
          expand: false,
          builder: (context, scrollController) {
            controller.scrollController = scrollController;
            scrollController.addListener(() {
              if (scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent) {
                if (controller.isReviewLoading.isFalse &&
                    !controller.isNoMoreData) {
                  controller.getAllReviews(
                      controller.offsetCount, astrologerUniId);
                }
              }
            });

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, bottom: 8.0, right: 8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset(
                            Images.back,
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
                  Expanded(
                    child: Obx(() {
                      if (controller.isReviewSuccess.isTrue) {
                        return Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: controller.reviewsListData.length,
                                itemBuilder: (context, index) {
                                  // return CustomReviewWidget(
                                  //     controller.reviewsListData[index]);
                                  var review =
                                      controller.reviewsListData[index];
                                  if (review.status == 1) {
                                    return CustomReviewWidget(review);
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ),
                            Obx(() => Visibility(
                                  visible: controller.isReviewLoading.isTrue,
                                  child: const Text('Loading..'),
                                )),
                          ],
                        );
                      } else if (controller.isReviewLoading.isTrue) {
                        return const CustomDefaultProgressIndicator();
                      } else {
                        return const EmptyScreen();
                      }
                    }),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // void _showReviewBottomSheet(BuildContext context, String astrologerUniId) {
  //   controller.offsetCount = 0;
  //   controller.getAllReviews(controller.offsetCount, astrologerUniId);
  //
  //   controller.scrollController.addListener(() {
  //     if (controller.scrollController.position.pixels ==
  //         controller.scrollController.position.maxScrollExtent) {
  //       if(controller.isReviewLoading.isFalse && !controller.isNoMoreData) {
  //         controller.getAllReviews(controller.offsetCount, astrologerUniId);
  //       }
  //     }
  //   });
  //   final draggableController = DraggableScrollableController();
  //
  //   showModalBottomSheet(
  //     context: context,
  //     useSafeArea: true,
  //     showDragHandle: true,
  //     enableDrag: true,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.white,
  //     builder: (BuildContext context) {
  //       return DraggableScrollableSheet(
  //         controller: draggableController,
  //         initialChildSize: 0.5,
  //         // Half screen initially
  //         minChildSize: 0.25,
  //         // Minimum size
  //         maxChildSize: 1.0,
  //         // Full screen when dragged
  //         expand: false,
  //         builder: (context, scrollController) {
  //           return Padding(
  //             padding: const EdgeInsets.only(right: 14.0, left: 14.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.only(
  //                       top: 0.0, bottom: 8.0, right: 8.0),
  //                   child: Row(
  //                     children: [
  //                       GestureDetector(
  //                         onTap: () {
  //                           Get.back();
  //                         },
  //                         child: Image.asset(
  //                           Images.back,
  //                           height: Dimensions.iconImageHeightSmall,
  //                           color: ColorResources.black,
  //                         ),
  //                       ),
  //                       const Gap(20),
  //                       Expanded(
  //                         child: CustomTextMedium(
  //                           "Rating and Reviews",
  //                           fontSize: Dimensions.fontSizeDefault,
  //                           maxLines: 1,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 const Divider(),
  //                 Expanded(
  //                   child: Obx(
  //                         () {
  //                       if (controller.isReviewSuccess.isTrue) {
  //                         return Column(
  //                           children: [
  //                             Expanded(
  //                               child: ListView.builder(
  //                                 itemCount: controller.reviewsListData.length,
  //                                 controller: controller.scrollController,
  //                                 itemBuilder: (context, index) {
  //                                   return CustomReviewWidget(controller.reviewsListData[index]);
  //                                 },
  //                               ),
  //                             ),
  //                             Obx(() => Visibility(
  //                               visible: controller.isReviewLoading.isTrue,
  //                               child: const Text('Loading..'),
  //                             ),)
  //
  //                           ],
  //                         );
  //                       } else if (controller.isReviewLoading.isTrue) {
  //                         return const CustomDefaultProgressIndicator();
  //                       } else {
  //                         return const EmptyScreen();
  //                       }
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

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
              imageUrl: controller.astrologerData.value.astroImg.toString(),
              height: Dimensions.profileImageHeight,
              width: Dimensions.profileImageHeight,
            ),
            const Gap(10),
            CustomTextRegular(
                controller.astrologerData.value.displayName.toString(),
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
                  await controller.astrologerFollow(
                      "0",
                      controller.astrologerData.value.astrologerUniId
                          .toString());
                  Get.back();
                  CustomSnackBar.showTop(AppStrings.astroUnfollowMsg);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: ColorResources.colorPrimary,
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

  void showWaitListDialog(String type) async {
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
              imageUrl: controller.astrologerData.value.astroImg.toString(),
              height: Dimensions.profileImageHeight,
              width: Dimensions.profileImageHeight,
            ),
            const Gap(10),
            CustomTextRegular(
                controller.astrologerData.value.displayName.toString(),
                fontSize: 14),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
              child: Text(
                "Astrologer will be available soon",
                style: TextStyle(fontSize: 12.0, color: ColorResources.black1),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorResources.grey,
                          borderRadius: BorderRadius.circular(
                              Dimensions.borderRadiusDefault),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: Dimensions.fontSizeSmall,
                            color: ColorResources.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(10), // Space between buttons
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.checkCallDetail(
                            type,
                            controller.astrologerData.value.astrologerUniId
                                .toString(),
                            controller.astrologerData.value);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorResources.colorPrimary,
                          borderRadius: BorderRadius.circular(
                              Dimensions.borderRadiusDefault),
                        ),
                        child: const Text(
                          "WaitList",
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
          ],
        ),
      ),
    ));
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

  Widget _infoItem(IconData icon, String value, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.teal.shade50,
          child: Icon(icon, color: Colors.teal),
        ),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..strokeWidth = 1;

    const double dashWidth = 5;
    const double dashSpace = 3;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
