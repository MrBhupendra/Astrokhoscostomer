import 'dart:convert';

import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/utill/dimensions.dart';
import 'package:astro_brahmand/utill/images.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controller/mobile_numerology_controller.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class MobileNumerologyDetailScreen extends StatefulWidget {
  const MobileNumerologyDetailScreen({super.key});

  @override
  State<MobileNumerologyDetailScreen> createState() => _NumerologyDetailState();
}

class _NumerologyDetailState extends State<MobileNumerologyDetailScreen> {
  final MobileNumerologyController mobileNumerologyController = Get.find();
  List<int> singleNoindexToCheck = [2, 3, 4];
  List<int> numbersWithAtLeast2Frequency = [];

  late Map<String, dynamic> kingObject;
  late Map<String, dynamic> queenObject;
  late Map<String, dynamic> singleObject;
  late Map<String, dynamic> multiNoObject;
  late Map<String, dynamic> combinationObject;

  String kingPrediction = "";
  String queenPrediction = "";
  String combinationPrediction = "";
  String multiNoPrediction = "";
  String singleNoPrediction = "";

  @override
  void initState() {
    super.initState();
    calculateFuture(mobileNumerologyController.phoneNumber.value.toString());
  }

  Future<void> calculateFuture(String mobileNumber) async {
    if (mobileNumber.length == 10 && isDigitsOnly(mobileNumber)) {
      List<String> numberArray = chunkString(mobileNumber, 2);
      List<String> reversedArray = numberArray.reversed.toList();
      List<int> numberResultArray = [];
      List<int> resultArray = [];
      int lastDigit = 0;
      for (String pair in reversedArray) {
        int singleDigit = calculateSingleDigit(int.parse(pair));
        numberResultArray.add(singleDigit);
        if (lastDigit != 0) {
          int newDigit = singleDigit + lastDigit;
          lastDigit = calculateSingleDigit(newDigit);
        } else {
          lastDigit = singleDigit;
        }
        resultArray.add(singleDigit);
      }
      List<int> reversedResultArray = resultArray.reversed.toList();
      //Akash
      List<int> results = reversedResultArray.toList();
      int four = reversedResultArray[3] + reversedResultArray[4];
      if (four > 9) {
        results[3] = calculateSingleDigit(four);
      } else {
        results[3] = four;
      }
      int three = reversedResultArray[2] + results[3];
      if (three > 9) {
        results[2] = calculateSingleDigit(three);
      } else {
        results[2] = three;
      }
      int two = reversedResultArray[1] + results[2];
      if (two > 9) {
        results[1] = calculateSingleDigit(two);
      } else {
        results[1] = two;
      }
      int one = reversedResultArray[0] + results[1];
      if (one > 9) {
        results[0] = calculateSingleDigit(one);
      } else {
        results[0] = one;
      }

      final String jsonString =
      await rootBundle.loadString(AppConstants.mobileNumerologyPrediction);
      setState(() {
        Map<String, dynamic> jsonObject = jsonDecode(jsonString);
        kingObject = jsonObject['KING_NUMBERS'];
        queenObject = jsonObject['QUEEN_NUMBERS'];
        singleObject = jsonObject['SINGLE_NUMBERS'];
        multiNoObject = jsonObject['MULTIPLE_NUMBERS'];
        combinationObject = jsonObject['COMBINATION_NUMBERS'];
        AppLogger.d(kingObject['1']['description'].toString());
      });

      //King Prediction
      for (int i = 1; i <= 9; i++) {
        if (results[1] == i) {
          kingPrediction = kingObject[i.toString()]['description'] ??= "";
          break;
        }
      }
      //Queen Prediction
      for (int i = 1; i <= 9; i++) {
        if (results[0] == i) {
          queenPrediction = queenObject[i.toString()]['description'] ??= "";
          break;
        }
      }
      //Combination Prediction
      int king = results[1];
      int queen = results[0];
      if (king == 3) {
        for (int i = 1; i <= 9; i++) {
          if (queen == i) {
            combinationPrediction =
            combinationObject['K3'][i.toString()]['description'] ??= "";
          }
        }
      } else if (king == 7) {
        for (int i = 1; i <= 9; i++) {
          if (queen == i) {
            combinationPrediction =
            combinationObject['K7'][i.toString()]['description'] ??= "";
          }
        }
      } else if (king == 8) {
        for (int i = 1; i <= 9; i++) {
          if (queen == i) {
            combinationPrediction =
            combinationObject['K8'][i.toString()]['description'] ??= "";
          }
        }
      }
      //Multiple No Prediction
      //Max number of occurrence of no
      Map<int, int> frequencies = {};
      for (var element in results) {
        frequencies[element] = (frequencies[element] ?? 0) + 1;
      }

      frequencies.forEach((key, value) {
        if (value >= 2) {
          numbersWithAtLeast2Frequency.add(key);
        }
      });

      if (numbersWithAtLeast2Frequency.isNotEmpty) {
        if (numbersWithAtLeast2Frequency.length >= 2) {
          multiNoPrediction =
              multiNoObject[numbersWithAtLeast2Frequency[0].toString()]
              ['description'] +
                  '\n\n' +
                  multiNoObject[numbersWithAtLeast2Frequency[1].toString()]
                  ['description'];
        } else {
          multiNoPrediction =
          multiNoObject[numbersWithAtLeast2Frequency[0].toString()]
          ['description'];
        }
      }

      //Single No Prediction
      List<int> numbersWithAtLeast1Frequency = [];
      frequencies.forEach((key, value) {
        if (value == 1) {
          numbersWithAtLeast1Frequency.add(key);
        }
      });
      List<int> numbersWithinIndices = numbersWithAtLeast1Frequency
          .where((number) => singleNoindexToCheck
          .any((index) => results.elementAt(index) == number))
          .toList();
      StringBuffer builder = StringBuffer();
      for (int element in numbersWithinIndices) {
        builder.write(
          singleObject[element.toString()]["description"].toString(),
        );
        if (element != numbersWithinIndices.last) {
          builder.write("\n\n");
        }
      }
      singleNoPrediction = builder.toString();
      AppLogger.d('single no $singleNoPrediction');

      AppLogger.d("Your Result is: ${results.toString()}\nYour King Number is: ${results[1]}\nYour Queen Number is: ${results[0]}\nYour Multiple Number is: $numbersWithAtLeast2Frequency\nYour Single Number is: ${numbersWithinIndices.toString()}");
    } else {
      AppLogger.d("Invalid mobile number. Please enter a 10-digit number.");
    }
  }

  int calculateSingleDigit(int number) {
    int sum = 0;
    int n = number;
    while (n > 0) {
      sum += n % 10;
      n ~/= 10;
    }
    if (sum >= 10) {
      return calculateSingleDigit(sum);
    }
    return sum;
  }

  List<String> chunkString(String s, int chunkSize) {
    List<String> chunks = [];
    for (int i = 0; i < s.length; i += chunkSize) {
      int end = (i + chunkSize < s.length) ? i + chunkSize : s.length;
      chunks.add(s.substring(i, end));
    }
    return chunks;
  }

  bool isDigitsOnly(String s) {
    return int.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.mobilePredictionBg),
                  fit: BoxFit.fill
              )
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      margin: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall,left: Dimensions.paddingSizeExtraSmall),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorResources.colorPrimary,
                      ),
                      padding: const EdgeInsets.all(Dimensions.paddingSizeOverSmall),
                      child: Image.asset(
                        Images.back,
                        color: ColorResources.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                    child: Center(
                      child: CustomTextMedium("What Your Mobile Number Say",
                          color:ColorResources.colorPrimary,
                          fontSize: Dimensions.fontSizeExtraLarge
                      )
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                              child: CustomTextRegular(kingPrediction,color: ColorResources.colorText,textAlign: TextAlign.center,fontSize: Dimensions.fontSizeLarge)
                            ),
                            //King Prediction
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                              child: CustomTextRegular(queenPrediction,
                                  color: ColorResources.colorText,
                                  textAlign: TextAlign.center,
                                  fontSize: Dimensions.fontSizeLarge)
                            ),
                            //Queen Prediction
                            Visibility(
                              visible:
                              combinationPrediction.isNotEmpty ? true : false,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                                child: CustomTextRegular(combinationPrediction,
                                    color: ColorResources.colorText,
                                    textAlign: TextAlign.center,
                                    fontSize: Dimensions.fontSizeLarge)
                              ),
                            ),
                            //Combination Prediction
                            Visibility(
                              visible: numbersWithAtLeast2Frequency.isNotEmpty
                                  ? true
                                  : false,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                                child: CustomTextRegular(multiNoPrediction,
                                    color: ColorResources.colorText,
                                    textAlign: TextAlign.center,
                                    fontSize: Dimensions.fontSizeLarge)
                              ),
                            ),
                            //Multiple Prediction
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                              child: CustomTextRegular(singleNoPrediction,
                                  color: ColorResources.colorText,
                                  textAlign: TextAlign.center,
                                  fontSize: Dimensions.fontSizeLarge)
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}