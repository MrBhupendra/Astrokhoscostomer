import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_regular.dart';
import '../controller/daily_tarot_controller.dart';
import 'daily_tarot_loader.dart';

class DailyTarotDetail extends StatelessWidget {
  DailyTarotDetail({super.key});

  final DailyTarotController controller = Get.put(DailyTarotController());

  @override
  Widget build(BuildContext context) {
    var tarotNum = Get.arguments;
    ValueNotifier<int?> randomNumber = ValueNotifier<int?>(tarotNum);

    Map<int, Map<String, String>> tarotCards = {
      1: {'image':  Images.tarotMagician, 'name': 'The Magician'},
      2: {'image':  Images.tarotHierophant, 'name': 'The Hierophant'},
      3: {'image':  Images.tarotEmperor, 'name': 'The Emperor'},
      4: {'image':  Images.tarotDeath, 'name': 'Death'},
      5: {'image':  Images.tarotHermit, 'name': 'The Hermit'},
      6: {'image':  Images.tarotDevil, 'name': 'The Devil'},
      7: {'image':  Images.tarotTemperance, 'name': 'Temperance'},
      8: {'image':  Images.tarotFool, 'name': 'The Fool'},
      9: {'image':  Images.tarotChariot, 'name': 'The Chariot'},
      10: {'image': Images.tarotJustice, 'name': 'Justice'},
      11: {'image': Images.tarotJudgement, 'name': 'The Judgment'},
      12: {'image': Images.tarotStrength, 'name': 'Strength'},
      13: {'image': Images.tarotEmpress, 'name': 'The Empress'},
      14: {'image': Images.tarotFortune, 'name': 'The Wheel of Fortune'},
      15: {'image': Images.tarotStar, 'name': 'The Star'},
      16: {'image': Images.tarotMoon, 'name': 'The Moon'},
      17: {'image': Images.tarotLovers, 'name': 'The Lovers'},
      18: {'image': Images.tarotSun, 'name': 'The Sun'},
      19: {'image': Images.tarotHangedMan, 'name': 'The Hanged Man'},
      20: {'image': Images.tarotTower, 'name': 'The Tower'},
      21: {'image': Images.tarotWorld, 'name': 'The World'},
      22: {'image': Images.tarotPriest, 'name': 'The High Priestess'},
    };

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorResources.colorPrimary,
          automaticallyImplyLeading: false,
          title: CustomTextRegular(
            AppStrings.tarotDetail.tr,
            fontSize: 16,
            color: ColorResources.toolbarText,
            maxLines: 1,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 18,
              color: ColorResources.toolbarText,
            ),
            onPressed: () {
              Get.toNamed("/dashboard");
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Obx(() {
            if (controller.isTarotLoading.value) {
              return DailyTarotLoader();
            } else if (controller.isTarotSuccess.value && controller.tarotModel.response != null) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const Gap(Dimensions.gapExtraLarge),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextMedium(
                          controller.tarotModel.response?.name ?? 'No Name',
                          fontSize: Dimensions.fontSizeExtraLarge,
                          color: ColorResources.black,
                        ),
                      ],
                    ),
                    if (randomNumber.value != null &&
                        tarotCards.containsKey(randomNumber.value))
                      Image.asset(
                        tarotCards[randomNumber.value]!['image']!,
                        width: 120,
                        height: 220,
                      )
                    else
                      const Text("Tarot card not found"),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          color: ColorResources.white,
                          borderRadius:
                          BorderRadius.circular(Dimensions.borderRadiusDefault),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorResources.colorPrimaryLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: Get.width * 0.5,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(15),
                                        topLeft: Radius.circular(10),
                                      ),
                                      color: ColorResources.colorPrimary,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      child: CustomTextMedium(
                                        "${controller.tarotModel.response?.value ?? 'No Value'}",
                                        fontSize: Dimensions.fontSizeLarge,
                                        color: ColorResources.toolbarText,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(Dimensions.gapDefault),
                              Padding(
                                padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                                child: CustomTextRegular(
                                  "${controller.tarotModel.response?.description ?? 'No Description'}",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const EmptyScreen();
            }
          }),
        ),
      ),
    );
  }
}




