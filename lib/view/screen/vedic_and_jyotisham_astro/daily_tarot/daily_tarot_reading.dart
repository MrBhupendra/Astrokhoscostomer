import 'dart:math';
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart'; // Import the audioplayers package
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../controller/daily_tarot_controller.dart';

class dailyTarotReading extends StatelessWidget {
  dailyTarotReading({super.key});

  final DailyTarotController controller = Get.put(DailyTarotController());

  final ValueNotifier<double> angle = ValueNotifier<double>(0); // Use ValueNotifier to track angle
  final ValueNotifier<bool> showButton = ValueNotifier<bool>(false); // Track if the button should be shown
  final ValueNotifier<int?> randomNumber = ValueNotifier<int?>(null); // Track the random number
  bool isBack = true;
  bool hasFlipped = false; // Track if the card has flipped

  // Create an instance of the AudioPlayer
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Method to generate a random number between 1 and 22
  int getRandomNumber() {
    final random = Random();
    return random.nextInt(22) + 1; // Generate a random number between 1 and 22 (inclusive)
  }

  // Function to flip the card and play sound
  void _flip() async {
    // Only flip if it hasn't already flipped
    if (!hasFlipped) {
      angle.value = (angle.value + pi) % (2 * pi); // Rotate by pi (180 degrees)
      hasFlipped = true; // Mark as flipped to prevent further flips

      // Play the flip sound
      await _audioPlayer.play(AssetSource(Images.flipSound));

      // Delay showing the button by 1.5 seconds
      Future.delayed(const Duration(milliseconds: 1500), () {
        showButton.value = true; // Show the button
      });
    }
  }

  // Map tarot card images and names based on the random number
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  CustomAppBar(title: AppStrings.dashTarot.tr),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppStrings.getYourReading.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _flip, // Trigger the flip when tapped
                  child: ValueListenableBuilder<double>(
                    valueListenable: angle,
                    builder: (BuildContext context, double val, __) {
                      // Swap the image after a 90-degree (pi / 2) flip
                      if (val >= (pi / 2)) {
                        isBack = false;
                        randomNumber.value ??= getRandomNumber();
                      } else {
                        isBack = true;
                      }

                      return TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: val),
                        duration: const Duration(milliseconds: 1000), // Set the duration to 1 second
                        builder: (BuildContext context, double tweenVal, __) {
                          return Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001) // Perspective effect
                              ..rotateY(tweenVal), // Rotate the card
                            child: SizedBox(
                              width: 170,
                              height: 370,
                              child: (tweenVal <= pi / 2)
                                  ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: const DecorationImage(
                                    image: AssetImage("assets/images/tarot_closed_image.png"), // Front side image
                                  ),
                                ),
                              )
                                  : Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()..rotateY(pi), // Flip horizontally after 90°
                                child: randomNumber.value != null
                                    ? Image.asset(tarotCards[randomNumber.value]!['image']!)
                                    : Container(), // Show corresponding tarot card image
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                const Gap(Dimensions.gapExtraExtraLarge),
                ValueListenableBuilder<bool>(
                  valueListenable: showButton,
                  builder: (context, showBtn, __) {
                    return showBtn
                        ? Column(
                      children: [
                        CustomTextMedium(tarotCards[randomNumber.value]!['name']!),
                        const Gap(Dimensions.gapExtraExtraLarge),
                          ValueListenableBuilder<int?>(
                            valueListenable: randomNumber,
                            builder: (context, tarotNum, __) {
                            return tarotNum != null
                                ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorResources.colorPrimary,
                                ),
                                onPressed: () {
                                  Get.toNamed("/dailyTarotDetail",arguments: tarotNum);
                                  controller.getDailyTarot(tarotNum);
                                },
                                child: CustomTextMedium(
                                  AppStrings.showMyReading.tr,
                                  color: ColorResources.toolbarText,
                                ),
                              )
                              : const SizedBox.shrink();
                            },
                          ),
                      ],
                    )
                        : Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppStrings.thinkOfYour.tr,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}







