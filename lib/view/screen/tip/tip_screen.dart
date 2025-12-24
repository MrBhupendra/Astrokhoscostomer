import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_network_image.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import '../dashboard/controller/dashboard_controller.dart';
import 'controller/gift_controller.dart';

class TipScreen extends StatelessWidget {

  DashboardController dashboardController = Get.put(DashboardController());
  GiftController giftController = Get.put(GiftController());
  @override
  Widget build(BuildContext context) {
    giftController.getGifts();
    final Map<String, dynamic>? arguments = Get.arguments as Map<String, dynamic>?;
    final String astrologerId = arguments?['astrologerId'] ?? 'Unknown';

    return PopScope(
      onPopInvoked: (bool isPopGesture) {
        if (!isPopGesture) {
          Get.offAllNamed('/dashboard');
        }
      },
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: "Guru Dakshina",
            onBackPressed: () {
              Get.offAllNamed('/dashboard');
            },
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                    Dimensions.borderRadiusDefault),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 16.0, left: 10, top: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            //heading text
                            const Expanded(
                              child: Text(
                                "Show Your Gratitude with a Guru Dakshina",
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color:ColorResources.colorPrimaryVariant)
                              ),
                            ),
                            //wallet balance
                            Obx(() {
                              if (dashboardController.isBalanceLoading.value) {
                                return const SizedBox(
                                    width: 20.0, // Set your desired width
                                    height: 20.0,
                                    child: CircularProgressIndicator(
                                      color: ColorResources.colorSecondary,
                                      strokeWidth: 1.0,
                                    ));
                              } else if (dashboardController.isBalanceSuccess.value) {
                                return CustomTextMedium(
                                    '${AppStrings.rupeeSign}${dashboardController.walletBalanceModel.data.toString()}',
                                    color: ColorResources.black,
                                fontSize: 15,);
                              } else {
                                return const Text('***',
                                    style: TextStyle(fontSize: 14,color: ColorResources.toolbarText));
                              }
                            }),
                          ],
                        ),
                        Gap(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CustomTextMedium(
                                "Thank you for choosing ${AppConstants.appName}. If you found value in your consultation and would like to express your appreciation to astrologer, we welcome you to offer a Guru Dakshina (gift).",
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),

                  //gift list
                  Obx(() {
                    if (giftController.isGiftSuccess.isTrue) {
                      return GridView.builder(
                        itemCount: giftController.liveGiftListModel.data?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 2.0,
                            crossAxisSpacing: 2.0,
                            childAspectRatio: 0.90
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (giftController.selectedGiftIndex.value == index) {
                                // If the selected gift is clicked again, unselect it
                                giftController.selectedGiftIndex.value = -1;
                              } else {
                                // Otherwise, select the clicked gift
                                giftController.selectedGiftIndex.value = index;
                              }
                            },
                            child: Obx(
                                  () => Container(
                                decoration: BoxDecoration(
                                  color: giftController.selectedGiftIndex.value == index
                                      ? Colors.grey[300]
                                      : null,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomNetworkImage(
                                      imageUrl: giftController.liveGiftListModel.data![index].giftImage.toString(),
                                      height: 40,
                                      width: 40,
                                    ),
                                    // const Gap(Dimensions.gapExtraExtraSmall),
                                    CustomTextRegular(
                                      giftController.liveGiftListModel.data![index].giftName.toString(),
                                      fontSize: Dimensions.fontSizeSmall,
                                      maxLines: 1,
                                    ),
                                    CustomTextMedium(
                                      "${AppStrings.rupeeSign} ${giftController.liveGiftListModel.data![index].giftPrice.toString()}",
                                      fontSize: Dimensions.fontSizeExtraSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (giftController.isGiftLoading.isTrue) {
                      return const CircularProgressIndicator();
                    } else {
                      return const EmptyScreen();
                    }
                  }),

                  const Gap(Dimensions.gapDefault),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, left: 8, right: 8, bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            //recharge button
                            Obx(() {
                              if (giftController.selectedGiftIndex.value != -1) {
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed("/wallet");
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: ColorResources.colorPrimaryLight,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: CustomTextMedium(
                                        "Recharge",
                                        color: ColorResources.black,
                                        fontSize: Dimensions.fontSizeSmall,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                            const Gap(Dimensions.gapExtraSmall),
                            //send button
                            Obx(() {
                              if (giftController.selectedGiftIndex.value != -1) {
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (giftController.selectedGiftIndex.value != -1) {
                                        giftController.sendGiftApi(
                                          "1",
                                          astrologerId,
                                          giftController.liveGiftListModel.data![giftController.selectedGiftIndex.value.toInt()].id.toString(),
                                        );
                                      } else {
                                        CustomSnackBar.showTop("Please select a gift.");
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: ColorResources.colorPrimaryMedium,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: CustomTextMedium(
                                        "Send",
                                        color: ColorResources.toolbarText,
                                        fontSize: Dimensions.fontSizeSmall,
                                        textAlign: TextAlign.center,
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
                        Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  CustomTextMedium(
                                    "*",
                                    fontSize: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: CustomTextMedium(
                                      "Your gift is entirely voluntary and deeply appreciated.",
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // const Divider(
                  //   color: ColorResources.colorPrimaryVariant,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
