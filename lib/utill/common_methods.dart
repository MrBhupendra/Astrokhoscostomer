import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/utill/dimensions.dart';
import 'package:astro_brahmand/utill/images.dart';
import 'package:astro_brahmand/utill/shared_preference.dart';
import 'package:astro_brahmand/view/screen/dashboard/controller/call_astrologer_controller.dart';
import 'package:astro_brahmand/view/widget/custom_okdialog_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/verify_customer_model.dart';
import '../model/welcome_model.dart';
import '../view/screen/splash/controller/config_controller.dart';
import '../view/screen/wallet/controller/wallet_controller.dart';
import '../view/screen/wallet/wallet_screen.dart';
import '../view/widget/custom_empty_screen.dart';
import '../view/widget/custom_progress_indicator.dart';
import '../view/widget/custom_text_medium.dart';
import '../view/widget/custom_text_regular.dart';
import '../view/widget/filter_item_list_widget.dart';
import 'app_constants.dart';

class CommonMethods {

  String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month
        .toString().padLeft(2, '0')}/${dateTime.year}";
    // return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }

  String formatDuration(String durationString) {
    try {
      int totalSecs = int.tryParse(durationString) ?? 0;
      int hours = totalSecs ~/ 3600;
      int minutes = (totalSecs % 3600) ~/ 60;
      int seconds = totalSecs % 60;
      return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(
          2, '0')}:${seconds.toString().padLeft(2, '0')}";
    } catch (e) {
      return "00:00:00";
    }
  }

  String formatDurationFromSec(String durationString) {
    try {
      int totalSecs = int.tryParse(durationString) ?? 0;
      int hours = totalSecs ~/ 3600;
      int minutes = (totalSecs % 3600) ~/ 60;
      int seconds = totalSecs % 60;

      if (hours.toString().padLeft(2, '0') == "00") {
        return '${minutes.toString().padLeft(2, '0')} Min ${seconds.toString().padLeft(2, '0')} Sec';
      } else {
        return '${hours.toString().padLeft(2, '0')} Hr ${minutes.toString().padLeft(2, '0')} Min ${seconds.toString().padLeft(2, '0')} Sec';
      }
    } catch (e) {
      return "00:00:00"; // Default value in case of an exception
    }

  }

  String convertTo12HourFormat(String time24) {
    if (time24.toLowerCase().contains('am') || time24.toLowerCase().contains('pm')) {
      return time24;
    }
    // Split the input string by colon to get hours and minutes
    final parts = time24.split(':');
    int hour = int.parse(parts[0]);
    String minutes = parts[1];

    // Determine AM/PM
    String period = hour >= 12 ? 'PM' : 'AM';

    // Convert hour to 12-hour format
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour; // Handle the case for 12 AM and 12 PM

    // Format the hour and minutes as a 12-hour time
    return '${hour.toString().padLeft(2, '0')}:$minutes $period';
  }

  Future<void> saveConfigSharedPrefData(WelcomeModel welcomeModel,
      String language) async {
    await SharedPreferencesHelper.saveData(AppConstants.appLanguage, language);
    await SharedPreferencesHelper.saveData(AppConstants.vedicApiKey,
        welcomeModel.data!.vedicAstroApiKey.toString());
    await SharedPreferencesHelper.saveData(AppConstants.jyotishamApiKey,
        welcomeModel.data!.jyotishamApiKey.toString());
    await SharedPreferencesHelper.saveData(AppConstants.paymentGateway,
        welcomeModel.data!.paymentGateway.toString());
    await SharedPreferencesHelper.saveData(
        AppConstants.agoraAppId, welcomeModel.data!.agoraApiId.toString());
    await SharedPreferencesHelper.saveData(AppConstants.placeApiKey,
        welcomeModel.data!.googleMapApiKey.toString());
    await SharedPreferencesHelper.saveData(
        AppConstants.agoraAppId, welcomeModel.data!.agoraApiId.toString());
    await SharedPreferencesHelper.saveData(AppConstants.placeApiKey,
        welcomeModel.data!.googleMapApiKey.toString());

    //IsInAppCall
    await SharedPreferencesHelper.saveIntData(AppConstants.isInAppCall,
        int.parse(welcomeModel.data!.inAppVoiceCall.toString()));

    //Architect
    await SharedPreferencesHelper.saveData(AppConstants.architectCategoryId,
        welcomeModel.data!.architectCategoryId.toString());

    //Homeopathy
    await SharedPreferencesHelper.saveData(AppConstants.homeopathyCategoryId,
        welcomeModel.data!.homeopathyCategoryId.toString());
    //aiPrediction
    await SharedPreferencesHelper.saveData(AppConstants.aiPredictionPrice,
        welcomeModel.data!.openAiQuestionPrice.toString());

    //aiPrediction
    await SharedPreferencesHelper.saveData(AppConstants.askQuestionPrice,
        welcomeModel.data!.askQuestionPrice.toString());

    //Company
    await SharedPreferencesHelper.saveData(
        AppConstants.companyEmail, welcomeModel.data!.email.toString());
    await SharedPreferencesHelper.saveData(AppConstants.companyWhatsappNo,
        welcomeModel.data!.whatsappNumber.toString());
    await SharedPreferencesHelper.saveData(
        AppConstants.companyMobileNo, welcomeModel.data!.mobileNo.toString());
    await SharedPreferencesHelper.saveData(
        AppConstants.companyAddress, welcomeModel.data!.address.toString());

    //Social Links
    await SharedPreferencesHelper.saveData(
        AppConstants.facebookLink, welcomeModel.data!.facebookLink.toString());
    await SharedPreferencesHelper.saveData(AppConstants.instagramLink,
        welcomeModel.data!.instagramLink.toString());
    await SharedPreferencesHelper.saveData(
        AppConstants.youtubeLink, welcomeModel.data!.youtubeLink.toString());
    await SharedPreferencesHelper.saveData(AppConstants.shareChatLink,
        welcomeModel.data!.shareChatLink.toString());
    await SharedPreferencesHelper.saveData(
        AppConstants.twitterLink, welcomeModel.data!.twitterLink.toString());
    await SharedPreferencesHelper.saveData(
        AppConstants.linkedinLink, welcomeModel.data!.linkedinLink.toString());
  }

  Future<void> saveLoginSharedPrefData(VerifyCustomerModel verifyCustomerModel,
      String phoneCode, bool isLogin) async {
    await SharedPreferencesHelper.saveData(AppConstants.userApiKey,
        verifyCustomerModel.data!.userApiKey.toString());
    await SharedPreferencesHelper.saveData(AppConstants.userUniId,
        verifyCustomerModel.data!.customerUniId.toString());
    await SharedPreferencesHelper.saveIntData(
        AppConstants.userUid, verifyCustomerModel.data!.uid!.toInt());
    await SharedPreferencesHelper.saveBoolData(AppConstants.isLogin, isLogin);
    await SharedPreferencesHelper.saveData(AppConstants.currencySymbol,
        verifyCustomerModel.data!.currencySymbol.toString());
    await SharedPreferencesHelper.saveData(AppConstants.currencyCode,
        verifyCustomerModel.data!.currencyCode.toString());
    await SharedPreferencesHelper.saveData(AppConstants.phoneCode, phoneCode);

    await SharedPreferencesHelper.saveData(AppConstants.profileImage,
        verifyCustomerModel.data!.customerImg.toString());
    await SharedPreferencesHelper.saveData(
        AppConstants.name, verifyCustomerModel.data!.name.toString());
    await SharedPreferencesHelper.saveData(
        AppConstants.email, verifyCustomerModel.data!.email.toString());
    await SharedPreferencesHelper.saveData(AppConstants.phoneNumber, verifyCustomerModel.data!.phone.toString());
    await SharedPreferencesHelper.saveData(
        AppConstants.gender, verifyCustomerModel.data!.gender.toString());
    await SharedPreferencesHelper.saveData(
        AppConstants.birthDate, verifyCustomerModel.data!.birthDate.toString());
    await SharedPreferencesHelper.saveData(
        AppConstants.birthTime, verifyCustomerModel.data!.birthTime.toString());
    await SharedPreferencesHelper.saveData(AppConstants.birthPlace,
        verifyCustomerModel.data!.birthPlace.toString());
    await SharedPreferencesHelper.saveData(
        AppConstants.latitude, verifyCustomerModel.data!.latitude.toString());
    await SharedPreferencesHelper.saveData(
        AppConstants.longitude, verifyCustomerModel.data!.longitude.toString());
    await SharedPreferencesHelper.saveData(
        AppConstants.timeZone, verifyCustomerModel.data!.timezone.toString());
  }

  Future<void> saveFcmToken(String token) async {
    await SharedPreferencesHelper.saveData(AppConstants.fcmToken, token);
  }

  Future<void> logoutUser(int isInAppCall,
      String paymentGateway,
      String appLanguage,
      String vedicApiKey,
      String jyotishamApiKey,
      String agoraAppId,
      String placeApiKey,
      String architectCategoryId,
      String homeopathyCategoryId,
      String aiPredictionPrice,
      String askQuestionPrice,
      String coMobile,
      String coEmail,
      String coWhatsapp,
      String coAddress,
      String fb,
      String instagram,
      String youtube,
      String twitter,
      String shareChat,
      String linkedin) async {
    await SharedPreferencesHelper.saveIntData(
        AppConstants.isInAppCall, isInAppCall);
    await SharedPreferencesHelper.saveData(
        AppConstants.paymentGateway, paymentGateway);
    await SharedPreferencesHelper.saveData(
        AppConstants.appLanguage, appLanguage);
    await SharedPreferencesHelper.saveData(
        AppConstants.vedicApiKey, vedicApiKey);
    await SharedPreferencesHelper.saveData(
        AppConstants.jyotishamApiKey, jyotishamApiKey);
    await SharedPreferencesHelper.saveData(AppConstants.agoraAppId, agoraAppId);
    await SharedPreferencesHelper.saveData(
        AppConstants.placeApiKey, placeApiKey);
    await SharedPreferencesHelper.saveData(
        AppConstants.architectCategoryId, architectCategoryId);
    await SharedPreferencesHelper.saveData(
        AppConstants.homeopathyCategoryId, homeopathyCategoryId);
    await SharedPreferencesHelper.saveData(
        AppConstants.aiPredictionPrice, aiPredictionPrice);
    await SharedPreferencesHelper.saveData(
        AppConstants.askQuestionPrice, askQuestionPrice);
    await SharedPreferencesHelper.saveData(AppConstants.companyEmail, coEmail);
    await SharedPreferencesHelper.saveData(
        AppConstants.companyMobileNo, coMobile);
    await SharedPreferencesHelper.saveData(
        AppConstants.companyWhatsappNo, coWhatsapp);
    await SharedPreferencesHelper.saveData(
        AppConstants.companyAddress, coAddress);

    //Links
    await SharedPreferencesHelper.saveData(
        AppConstants.instagramLink, instagram);
    await SharedPreferencesHelper.saveData(AppConstants.facebookLink, fb);
    await SharedPreferencesHelper.saveData(AppConstants.youtubeLink, youtube);
    await SharedPreferencesHelper.saveData(AppConstants.twitterLink, twitter);
    await SharedPreferencesHelper.saveData(
        AppConstants.shareChatLink, shareChat);
    await SharedPreferencesHelper.saveData(AppConstants.linkedinLink, linkedin);
  }

  void showSessionExpiredDialog() {
    Get.dialog(
      CustomOkdialogWidget(
          imagePath: Images.sessionExpired,
          title: "Session Expired",
          description: "Session Expired. Please login again.",
          onPressed: () async {
            await SharedPreferencesHelper.logoutSession();
          }
      ),
      barrierDismissible: false,
    );
  }

  Future<void> showDatePickerDialog(BuildContext context,
      TextEditingController textController) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      textController.text = formattedDate;
    }
  }

  Future<void> showFutureDatePickerDialog(BuildContext context,
      TextEditingController textController) async {
    DateTime now = DateTime.now();
    DateTime tomorrow = now.add(const Duration(days: 1));
    DateTime threeMonthsFromNow = DateTime(now.year, now.month + 3, now.day);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: tomorrow,
      firstDate: tomorrow, // Disable past dates
      lastDate:
      threeMonthsFromNow, // Set a far future date as the last selectable date
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      textController.text = formattedDate;
    }
  }

  Future<void> showTimerPickerDialog(BuildContext context,
      TextEditingController textController) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final format = DateFormat('hh:mm a');
      String formattedTime = format
          .format(DateTime(2022, 1, 1, pickedTime.hour, pickedTime.minute));
      textController.text = formattedTime;
    }
  }

  String convertDateInput(String date) {
    List<String> dateParts = date.split('/');

    // Parse the date parts into a DateTime object
    DateTime parsedDate = DateTime(
        int.parse(dateParts[2]), // year
        int.parse(dateParts[1]), // month
        int.parse(dateParts[0])); // day

    String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);
    return formattedDate;
  }

  String convertTimeInput(String time) {
    final dt = _tryParseTimeOfDay(time);
    if (dt == null) return time;
    return DateFormat("HH:mm:ss").format(dt);
  }

  String convertTimeInputVedic(String time) {
    final dt = _tryParseTimeOfDay(time);
    if (dt == null) return time;
    return DateFormat("HH:mm").format(dt);
  }

  DateTime? _tryParseTimeOfDay(String input) {
    final raw = input.trim();
    if (raw.isEmpty) return null;

    // Try common 12h formats first (the app uses `showTimePicker` → `hh:mm a`).
    final formats = <DateFormat>[
      DateFormat('hh:mm a'),
      DateFormat('h:mm a'),
      // Also accept 24h inputs if backend/UI ever sends them.
      DateFormat('HH:mm:ss'),
      DateFormat('H:mm:ss'),
      DateFormat('HH:mm'),
      DateFormat('H:mm'),
    ];

    for (final f in formats) {
      try {
        // `parseLoose` handles minor variations like extra spaces/case.
        return f.parseLoose(raw);
      } catch (_) {
        // try next format
      }
    }
    return null;
  }

  String convertTimeInputVedicEdit(String time) {
    try {
      // Attempt to parse the time string in "hh:mm a" format
      DateFormat inputFormat = DateFormat("hh:mm a");
      DateTime dateTime = inputFormat.parse(time);

      // Format the DateTime object to "HH:mm" format
      String formattedTime = DateFormat("HH:mm").format(dateTime);
      return formattedTime;
    } on FormatException {
      // If parsing fails, log the error or return the input time as-is
      print("Error: Could not parse time string: $time");
      return time; // or handle the error appropriately
    }
  }

  String getFormattedTimeFromMin(int min) {
    int hours = min ~/ 60;
    int minutes = min % 60;
    int seconds =
    0; // Since the input is in minutes, seconds will always be zero

    if (hours.toString().padLeft(2, '0') == "00") {
      return '${minutes.toString().padLeft(2, '0')} Min';
    } else {
      return '${hours.toString().padLeft(2, '0')} Hr ${minutes.toString()
          .padLeft(2, '0')} Min';
    }
  }

  String getFormattedTimeFromSecLive(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds ~/ 60) % 60;
    num remainingSeconds = seconds % 60;

    if (hours.toString().padLeft(2, '0') == "00") {
      return '${minutes.toString().padLeft(2, '0')} Min';
    } else {
      return '${hours.toString().padLeft(2, '0')} Hr ${minutes.toString()
          .padLeft(2, '0')} Min';
    }
  }

  Future<String> getFCMToken() async {
    String fcmToken = '';
    await FirebaseMessaging.instance.getToken().then((token) async {
      fcmToken = token ?? 'errorGetToken';
      await saveFcmToken(fcmToken);
    }).catchError((e) {
      fcmToken = 'catchGetToken$e';
      debugPrint("Error getting FCM token: $e");
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((token) async {
      fcmToken = token ?? 'errorOnTokenRefresh';
      await saveFcmToken(fcmToken);
    }).onError((e) {
      fcmToken = 'catchOnTokenRefresh$e';
      debugPrint("Error getting FCM token: $e");
      debugPrint("Error getting FCM token: $e");
    });

    return fcmToken;
  }

  Future<void> shareApp(String type,
      {String astroSlugUrl = "",
        String quoteSlug = "",
        String blogUrl = "",
        String imageUrl = "",
        String userUniId = ""}) async {
    if (type == "app") {
      Share.share('Hey! I am using ${AppConstants.appName} to get predictions related to marriage/career etc.I would recommend you to download\nhttp://play.google.com/store/apps/details?id=${AppConstants.androidPackageName}');
    } else if (type == "astrologerApp") {
      const url = 'http://play.google.com/store/apps/details?id=${AppConstants
          .androidAstrologerPackageName}';
      await launchUrl(Uri.parse(url));
      // await launch(url);
    } else if (type == "astrologerProfile") {
      String title = "Hey! I am using ${AppConstants
          .appName} to get predictions related to marriage/career etc.I would recommend you to connect with best Astrologer.";
      Share.share(
          "$title\nhttp://play.google.com/store/apps/details?id=${AppConstants
              .androidPackageName}");
    } else if (type == "dailyQuote") {
      Share.share(
          "$astroSlugUrl\nhttp://play.google.com/store/apps/details?id=${AppConstants
              .androidPackageName}");
    } else if (type == "blog") {
      Share.share("$quoteSlug\n$blogUrl");
    } else if (type == "architect") {
      _shareImage(astroSlugUrl);
    }else if (type == "refer") {
      Share.share('Hey! I am using ${AppConstants.appName} to get predictions related to marriage/career etc.I would recommend you to download\nhttps://play.google.com/store/apps/details?id=${AppConstants.androidPackageName}&referrer=$userUniId');
    }
  }


  void _shareImage(String astroSlugUrl) {
    //Share.shareFiles([astroSlugUrl]);
  }

  void showInsufficientBalancedDialog() {
    Get.dialog(
        Dialog(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            width: Get.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10, top: 14, bottom: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Images.insufficientBalance, // Image
                        height: 80,
                        width: 80,
                        color: ColorResources
                            .yellow, // Replace with your primary color
                      ),
                    ],
                  ),
                  const Gap(15),
                  CustomTextMedium(
                    "Insufficient Balance",
                    fontSize: Dimensions.fontSizeOverLarge,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(8),
                  CustomTextRegular(
                    "Insufficient Wallet Balance. Kindly Recharge.",
                    textAlign: TextAlign.center,
                    color: ColorResources.black4,
                  ),
                  const Gap(8),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              Get.back();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeSmall,
                                  vertical: Dimensions.paddingSizeExtraSmall
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.borderRadiusDefault),
                                border: Border.all(color: ColorResources
                                    .colorPrimary), // Replace with your primary color
                              ),
                              child: CustomTextRegular(
                                  "Cancel",
                                  textAlign: TextAlign.center,
                                  color: ColorResources
                                      .colorPrimary // Replace with your primary color
                              ),
                            ),
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              Get.back();
                              Get.toNamed('/wallet');
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeSmall,
                                  vertical: Dimensions.paddingSizeExtraSmall
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.borderRadiusDefault),
                                color: ColorResources.colorPrimary,
                                // Replace with your primary color
                                border: Border.all(
                                    color: ColorResources.colorPrimary),
                              ),
                              child: CustomTextRegular(
                                "Proceed",
                                textAlign: TextAlign.center,
                                // fontSize: Dimensions.fontSizeSmall,
                                color: ColorResources.toolbarText,
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
          ),
        ),
        barrierDismissible: false
    );
    // Get.defaultDialog(
    //   title: "Insufficient Balance",
    //   barrierDismissible: false,
    //   content: const Text("Insufficient Balance. Kindly Recharge."),
    //   confirm: TextButton(
    //     onPressed: () async {
    //       Get.back();
    //       Get.toNamed('/wallet');
    //     },
    //     child: const Text("Proceed"),
    //   ),
    //   cancel: TextButton(
    //     onPressed: () async {
    //       Get.back();
    //     },
    //     child: const Text("Cancel"),
    //   ),
    // );
  }

  void showReviewDialog() {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // const Gap(10),
              Padding(
                padding: const EdgeInsets.only(right: 10.0, top: 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      Images.close,
                      height: 12,
                      color: ColorResources.black,
                    ),
                  ),
                ),
              ),
              CustomTextMedium("Review Astro Sunil"),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child:
                  // CustomRoundNetworkImage(
                  //     imageUrl: controller.astrologerData.value.astroImg.toString(),
                  //     height: Dimensions.profileImageHeight,
                  //     width: Dimensions.profileImageHeight
                  // ),
                  Image.asset(
                    Images.pngProfile,
                    height: 50,
                  )),
              CustomTextRegular("Please rate this service",
                  color: ColorResources.black4,
                  fontSize: Dimensions.fontSizeSmall),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  glowColor: ColorResources.colorPrimary,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) =>
                  const Icon(
                    Icons.star,
                    color: ColorResources.colorRatingIcon,
                    size: 20,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),
              Form(
                child: TextFormField(
                  // controller: _blockReasonController,
                  decoration: const InputDecoration(
                    hintText: 'Describe your experience (optional)',
                    hintStyle: TextStyle(fontSize: Dimensions.fontSizeSmall),
                    border: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: ColorResources.colorPrimary)),
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeSmall,
                        horizontal: Dimensions.paddingSizeMediumSmall),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.formError;
                    }
                    return null;
                  },
                  minLines: 3,
                  maxLines: 3,
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                child: GestureDetector(
                  onTap: () {
                    // if (_formKey.currentState!.validate()) {
                    //   Get.back();
                    //
                    //   CustomDialog.showOkDialog(
                    //       AppStrings.success,
                    //       AppStrings.successBlockMsg,
                    //           () {
                    //         Get.back();
                    //       });
                    // } // add block function
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: ColorResources.colorPrimaryDark,
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
      ),
    );
  }

  void showInsufficientBalanceBottomSheet(String type, String astrologerName,
      String minimumAmount) {
    final ConfigController configController = Get.find();
    final WalletController walletController = Get.put(WalletController());
    Get.bottomSheet(
      SafeArea(
        child: Container(
          height: Get.height * 0.4,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextMedium(
                        "Add money to Wallet",
                        fontSize: 18
                    ),
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.cancel,
                          color: ColorResources.black2,
                        ))
                  ],
                ),
              ),
              const Divider(
                color: ColorResources.black6,
                height: 1,
              ),
        
              const Gap(8),
        
              // Subtitle
              CustomTextRegular(
                "Minimum balance of 5 minutes (${configController
                    .currencySymbol}$minimumAmount) is required to start $type with $astrologerName",
                color: Colors.red,
                // fontSize: 15,
              ),
        
              const Gap(8),
        
              CustomTextRegular(
                "Tip: 90% Users recharge for 10 minutes or more",
                color: ColorResources.black4,
              ),
        
              const Gap(10),
              Obx(
                    () {
                  if (walletController.isVoucherSuccess.isTrue) {
                    // GridView for recharge options
                    return Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: walletController.walletModel.data?.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 2,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              walletController.selectVoucher(index);
                              Get.to(() => const WalletScreen(), arguments: {
                                'voucher': walletController.walletModel
                                    .data?[index],
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorResources.colorPrimary),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomTextRegular(
                                    "${configController
                                        .currencySymbol}${walletController
                                        .walletModel.data?[index].walletAmount}",
                                    // fontSize: Dimensions.fontSizeLarge,
                                  ),
                                  CustomTextRegular(
                                    "${AppStrings.extra.tr} ${configController
                                        .currencySymbol}${walletController
                                        .walletModel.data?[index].giftAmount}",
                                    fontSize: Dimensions.fontSizeSmall,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (walletController.isVoucherLoading.isTrue) {
                    return const CustomProgressIndicator();
                  } else {
                    return const EmptyScreen();
                  }
                },
              )
            ],
          ),
        ),
      ),
      isScrollControlled: true, // Ensures full-screen scrollable bottom sheet
    );
  }

  Future<String?> getCompanyEmail() async {
    String? email = await SharedPreferencesHelper.getData(
        AppConstants.companyEmail);
    return email;
  }

  Future<String?> getCompanyAddress() async {
    String? address = await SharedPreferencesHelper.getData(
        AppConstants.companyAddress);
    return address;
  }

  Future<String?> getCompanyMobile() async {
    String? mobile = await SharedPreferencesHelper.getData(
        AppConstants.companyMobileNo);
    return mobile;
  }


  Future<String?> getProfileImage() async {
    String? email = '***';
    bool isLogin = await SharedPreferencesHelper.getIsLogin();

    if (isLogin) {
      email = await SharedPreferencesHelper.getData(AppConstants.profileImage);
    }
    return email;
  }

  Future<String?> getProfileName() async {
    String? email = '***';
    bool isLogin = await SharedPreferencesHelper.getIsLogin();
    print("ISLogin $isLogin");
    if (isLogin) {
      email = await SharedPreferencesHelper.getData(AppConstants.name);
    }

    return email;
  }

  Future<String?> getUserUniId() async {
    String? email = '***';
    bool isLogin = await SharedPreferencesHelper.getIsLogin();
    if (isLogin) {
      email = await SharedPreferencesHelper.getData(AppConstants.userUniId);
    }
    return email;
  }

  //Payment Gateways
  // Payment bottom sheet
  void showPaymentMethodBottomSheet(bool isInternational,
      {required Function(int index) onItemSelected}) {
    final ConfigController configController = Get.find();
    final int gatewayCount = isInternational
        ? configController.internationalPaymentGatewayList.length
        : configController.paymentGatewayList.length;
    Get.bottomSheet(
      SafeArea(
        child: Container(
          height: Get.height * (gatewayCount > 4 ? 0.26 : 0.22),
          decoration: const BoxDecoration(
            color: ColorResources.black8,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                child: Row(
                  children: [
                    Expanded(child: CustomTextMedium("Select your payment method",
                      fontSize: Dimensions.fontSizeLarge,)),
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.cancel,
                          color: ColorResources.black4,
                        )
                    )
                  ],
                ),
              ),
              const Divider(
                color: ColorResources.black6,
                height: 1,
              ),
              const Gap(8),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: isInternational ? configController
                      .internationalPaymentGatewayList.length : configController
                      .paymentGatewayList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        onItemSelected.call(index);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2)
                                    )
                                  ]
                              ),
                              child: Image.asset(
                                  isInternational ? configController
                                      .internationalPaymentGatewayList[index]
                                      .image.toString() : configController
                                      .paymentGatewayList[index].image.toString(),
                                  height: 40,
                                  width: 40
                              ),
                            ),
                          ),
                          const Gap(2),
                          CustomTextMedium(
                            isInternational ? configController
                                .internationalPaymentGatewayList[index].title
                                .toString() : configController
                                .paymentGatewayList[index].title.toString(),
                            fontSize: Dimensions.fontSizeSmall,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
        
            ],
          ),
        ),
      ),
      isScrollControlled: true, // Ensures full-screen scrollable bottom sheet
    );
  }

  String convertDateOutput(String date) {
    // Split the input date string by '-' to get year, month, and day
    List<String> dateParts = date.split('-');

    // Parse the date parts into a DateTime object
    DateTime parsedDate = DateTime(
      int.parse(dateParts[0]), // year
      int.parse(dateParts[1]), // month
      int.parse(dateParts[2]), // day
    );

    // Format the DateTime object into the desired format 'dd/MM/yyyy'
    String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);

    return formattedDate;
  }

  String formatDateTimeOutput(String date) {
    if (date.isEmpty) {
      return "N/A";
    } else {
      try {
        String dateTimeString = date.trim();

        DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTimeString);

        String formattedDateTime = DateFormat('dd/MM/yyyy hh:mm a').format(dateTime);

        return formattedDateTime;
      } catch (e) {
        print("Error parsing dateTime: $e");
        return date;
      }
    }
  }

  String formatDateTimeOutputIndividually(String date, String time) {
    if (date.isEmpty || time.isEmpty) {
      return "N/A";
    } else {
      try {
        String dateTimeString = "${date.trim()} ${time.trim()}";

        DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(
            dateTimeString);

        String formattedDateTime = DateFormat('dd/MM/yyyy hh:mm a').format(
            dateTime);

        return formattedDateTime;
      } catch (e) {
        print("Error parsing dateTime: $e");
        return "Invalid Date/Time";
      }
    }
  }

  String convertTimeToAmPm(String time) {
    DateTime parsedTime = DateFormat('HH:mm:ss').parse(time);

    // Format the DateTime object into the desired 'hh:mm a' format
    String formattedTime = DateFormat('hh:mm a').format(parsedTime);

    return formattedTime;
  }

  // Function to mask mobile numbers
  String maskMobileNumber(String message) {
    // Regular expression to detect 10-digit mobile numbers
    final regex = RegExp(r'\b\d{10}\b');

    // Replace detected mobile numbers with 'xxxxxxxxxx'
    return message.replaceAllMapped(regex, (match) {
      return 'xxxxxxxxxx';
    });
  }

  // For Payment Gateway
  String toCapitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
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
    }
    // else if (tag == "most_choice") {
    //   return Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
    //     child: Image.asset(
    //       Images.astroMostChoiceTag,
    //       height: 35,
    //     ),
    //   );
    // }
    else if (tag == "most_choice") {
      return Container(
        height: 20.0,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        decoration: BoxDecoration(
          color: ColorResources.colorPrimary.withOpacity(0.7),borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(20.0),
        ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextMedium(
              "Most Popular",
              fontSize: Dimensions.fontSizeOverSmall,
              color: ColorResources.white,
            ),
          ],
        ),
      );
    }
    else if (tag == "top_choice") {
      return Container(
        height: 20.0,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        decoration: BoxDecoration(
          color: ColorResources.colorPrimary.withOpacity(0.7),borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(20.0),
        ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextMedium(
              "Top Choice",
              fontSize: Dimensions.fontSizeOverSmall,
              color: ColorResources.white,
            ),
          ],
        ),
      );
    } else if (tag == "New" || tag == "new") {
      return Container(
        height: 20.0,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        decoration: BoxDecoration(
          color: ColorResources.colorPrimary.withOpacity(0.7),borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(20.0),
        ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextMedium(
              "New",
              fontSize: Dimensions.fontSizeOverSmall,
              color: ColorResources.white,
            ),
          ],
        ),
      );
    } else if (tag == "rising_star") {
      return Container(
        height: 20.0,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        decoration: BoxDecoration(
          color: ColorResources.colorPrimary.withOpacity(0.7),borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(20.0),
        ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextMedium(
              "Rising Star",
              fontSize: Dimensions.fontSizeOverSmall,
              color: ColorResources.white,
            ),
          ],
        ),
      );
    }else if (tag == "premium") {
      return Container(
        height: 20.0,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        decoration: BoxDecoration(
          color: ColorResources.colorPrimary.withOpacity(0.7),borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(20.0),
        ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextMedium(
              "Premium",
              fontSize: Dimensions.fontSizeOverSmall,
              color: ColorResources.white,
            ),
          ],
        ),
      );
    }
    else if (tag == "celebrity") {
      return Container(
        height: 20.0,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        decoration: BoxDecoration(
          color: ColorResources.colorPrimary.withOpacity(0.7),borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(20.0),
        ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextMedium(
              "Celebrity",
              fontSize: Dimensions.fontSizeOverSmall,
              color: ColorResources.white,
            ),
          ],
        ),
      );
    }
    else if (tag == "special_deal") {
      return Container(
        height: 20.0,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        decoration: BoxDecoration(
          color: ColorResources.colorPrimary.withOpacity(0.7),borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(20.0),
        ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextMedium(
              "Special Deal",
              fontSize: Dimensions.fontSizeOverSmall,
              color: ColorResources.white,
            ),
          ],
        ),
      );
    } else if (tag == "flat_deal") {
      return Container(
        height: 20.0,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        decoration: BoxDecoration(
          color: ColorResources.colorPrimary.withOpacity(0.7),borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(20.0),
        ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextMedium(
              "Flat Deal",
              fontSize: Dimensions.fontSizeOverSmall,
              color: ColorResources.white,
            ),
          ],
        ),
      );
    } else if (tag == "best_deal") {
      return Container(
        height: 20.0,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        decoration: BoxDecoration(
          color: ColorResources.colorPrimary.withOpacity(0.7),borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(20.0),
        ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextMedium(
              "Best Deal",
              fontSize: Dimensions.fontSizeOverSmall,
              color: ColorResources.white,
            ),
          ],
        ),
      );
    } else if (tag == "festival_deal") {
      return Container(
        height: 20.0,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        decoration: BoxDecoration(
          color: ColorResources.colorPrimary.withOpacity(0.7),borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(20.0),
        ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextMedium(
              "Festival Deal",
              fontSize: Dimensions.fontSizeOverSmall,
              color: ColorResources.white,
            ),
          ],
        ),
      );
    }
    else {
      // Default image if none of the conditions match
      return const SizedBox();
    }
  }

  String splitDateFromTime(String dateTimeString) {
    try {
      List<String> parts = dateTimeString.split(' ');
      if (parts.length < 5) return "Invalid Date";
      String formattedDate = "${parts[1]} ${parts[2]} ${parts[3]}";
      return formattedDate;
    } catch (e) {
      return "Invalid Date";
    }
  }
  void showFilterBottomSheet(BuildContext context,dynamic controller) {
    controller.selectedIndexFilter.value = 1;
    void updateStatus(bool? value, String filterType, String filterValue) {
      if (value == true) {
        if (filterType == 'sort') {
          controller.filterSelectedSort.value = filterValue;
        } else if (filterType == 'skill') {
          controller.filterSelectedSkills.add(filterValue);
        } else if (filterType == 'language') {
          controller.filterSelectedLanguages.add(filterValue);
        } else if (filterType == 'gender') {
          controller.filterSelectedGender.value = filterValue;
        }
        // else if (filterType == 'category') {
        //   controller.filterSelectedCategories.add(filterValue);
        // }
      } else {
        if (filterType == 'sort') {
          controller.filterSelectedSort.value = '';
        } else if (filterType == 'skill') {
          controller.filterSelectedSkills.remove(filterValue);
        } else if (filterType == 'language') {
          controller.filterSelectedLanguages.remove(filterValue);
        } else if (filterType == 'gender') {
          controller.filterSelectedGender.value = '';
        }
        // else if (filterType == 'category') {
        //   controller.filterSelectedCategories.remove(filterValue);
        // }
      }
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
          top: Radius.circular(Dimensions.borderRadiusSmall))),
      builder: (BuildContext context) {
        return Obx(() {
          if (controller.isFilterSuccess.value) {
            return SizedBox(
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Dimensions.paddingSizeMediumSmall,
                        right: Dimensions.paddingSizeExtraSmall),
                    child: Row(
                      children: [
                        Expanded(child: CustomTextRegular(
                            AppStrings.sortFilter,
                            fontSize: Dimensions.fontSizeLarge)),
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.close,
                              size: Dimensions.iconSizeMediumSmall),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1.0, color: ColorResources.black6),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              filterItemListWidget(
                                  controller.selectedIndexFilter,
                                  controller.isFilterSelected(1), 1,
                                  AppStrings.sort),
                              filterItemListWidget(
                                  controller.selectedIndexFilter,
                                  controller.isFilterSelected(2), 2,
                                  AppStrings.skills),
                              filterItemListWidget(
                                  controller.selectedIndexFilter,
                                  controller.isFilterSelected(3), 3,
                                  AppStrings.language),
                              filterItemListWidget(
                                  controller.selectedIndexFilter,
                                  controller.isFilterSelected(4), 4,
                                  AppStrings.gender),
                              //filterItemListWidget(controller, 5, AppStrings.category),
                            ],
                          ),
                        ),
                        const VerticalDivider(
                          width: 0.5,
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        Expanded(
                          flex: 3,
                          child: Obx(() {
                            int selectedIndexFilter = controller
                                .selectedIndexFilter.value;
                            if (selectedIndexFilter == 1) {
                              return ListView(
                                shrinkWrap: true,
                                children: [
                                  filterOptionWidget('Price: High to Low',
                                      controller.filterSelectedSort.value ==
                                          'price-desc', (newValue) {
                                        updateStatus(
                                            newValue, 'sort', 'price-desc');
                                      }),
                                  filterOptionWidget('Price: Low to High',
                                      controller.filterSelectedSort.value ==
                                          'price-asc', (newValue) {
                                        updateStatus(
                                            newValue, 'sort', 'price-asc');
                                      }),
                                  filterOptionWidget(
                                      'Experience: High to Low',
                                      controller.filterSelectedSort.value ==
                                          'experience-desc', (newValue) {
                                    updateStatus(
                                        newValue, 'sort', 'experience-desc');
                                  }),
                                  filterOptionWidget(
                                      'Experience: Low to High',
                                      controller.filterSelectedSort.value ==
                                          'experience-asc', (newValue) {
                                    updateStatus(
                                        newValue, 'sort', 'experience-asc');
                                  }),
                                  filterOptionWidget('Rating: High to Low',
                                      controller.filterSelectedSort.value ==
                                          'rating', (newValue) {
                                        updateStatus(
                                            newValue, 'sort', 'rating');
                                      }),
                                  filterOptionWidget('Trending: High to Low',
                                      controller.filterSelectedSort.value ==
                                          'trending', (newValue) {
                                        updateStatus(
                                            newValue, 'sort', 'trending');
                                      }),
                                ],
                              );
                            }
                            else if (selectedIndexFilter == 2) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Flexible(
                                        child: TextButton(
                                          onPressed: () {
                                            // Select all skills
                                            controller.filterSelectedSkills
                                                .value = controller.skillList
                                                .map((skill) =>
                                                (skill.id ?? '').toString())
                                                .toSet()
                                                .toList()
                                                .cast<String>();
                                          },
                                          child: CustomTextRegular(
                                              AppStrings.selectAll,
                                              color: ColorResources
                                                  .colorPrimaryDark),
                                        ),
                                      ),
                                      Flexible(
                                        child: TextButton(
                                          onPressed: () {
                                            // Clear all selected skills
                                            controller.filterSelectedSkills.clear();
                                          },
                                          child: CustomTextRegular(
                                              AppStrings.clear,
                                              color: ColorResources
                                                  .colorPrimaryDark),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: controller.skillList.length,
                                      itemBuilder: (context, index) {
                                        final skill = controller
                                            .skillList[index];
                                        final skillIdString = (skill.id ?? '')
                                            .toString();
                                        return Row(
                                          children: [
                                            Obx(() =>
                                                Checkbox(
                                                  value: controller
                                                      .filterSelectedSkills
                                                      .contains(
                                                      skillIdString),
                                                  onChanged: (bool? value) {
                                                    updateStatus(
                                                        value, 'skill',
                                                        skillIdString);
                                                  },
                                                  activeColor: ColorResources
                                                      .colorPrimary,
                                                  side: WidgetStateBorderSide
                                                      .resolveWith(
                                                        (Set<
                                                        WidgetState> states) {
                                                      if (states.contains(
                                                          WidgetState
                                                              .selected)) {
                                                        return const BorderSide(
                                                            color: ColorResources
                                                                .colorPrimary);
                                                      }
                                                      return const BorderSide(
                                                          color: ColorResources
                                                              .colorPrimary);
                                                    },
                                                  ),
                                                )),
                                            CustomTextRegular(
                                                skill.skillName ?? ''),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }
                            else if (selectedIndexFilter == 3) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Flexible(
                                        child: TextButton(
                                          onPressed: () {
                                            // Select all skills
                                            controller.filterSelectedLanguages.value = controller.languageList
                                                .map((language) => (language.id ?? '').toString())
                                                .toSet()
                                                .toList()
                                                .cast<String>();
                                          },
                                          child: CustomTextRegular(
                                            AppStrings.selectAll,
                                            color: ColorResources
                                                .colorPrimaryDark,),
                                        ),
                                      ),
                                      Flexible(
                                        child: TextButton(
                                          onPressed: () {
                                            // Clear all selected skills
                                            controller.filterSelectedLanguages.clear();
                                          },
                                          child: CustomTextRegular(
                                            AppStrings.clear,
                                            color: ColorResources
                                                .colorPrimaryDark,),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: controller.languageList
                                          .length,
                                      itemBuilder: (context, index) {
                                        final language = controller
                                            .languageList[index];
                                        final languageIdString = (language
                                            .id ?? '').toString();
                                        return Row(
                                          children: [
                                            Obx(() =>
                                                Checkbox(
                                                  value: controller
                                                      .filterSelectedLanguages
                                                      .contains(
                                                      languageIdString),
                                                  onChanged: (bool? value) {
                                                    updateStatus(
                                                        value, 'language',
                                                        languageIdString);
                                                  },
                                                  activeColor: ColorResources
                                                      .colorPrimary,
                                                  side: WidgetStateBorderSide
                                                      .resolveWith(
                                                        (Set<
                                                        WidgetState> states) {
                                                      if (states.contains(
                                                          WidgetState
                                                              .selected)) {
                                                        return const BorderSide(
                                                            color: ColorResources
                                                                .colorPrimary);
                                                      }
                                                      return const BorderSide(
                                                          color: ColorResources
                                                              .colorPrimary);
                                                    },
                                                  ),
                                                )),
                                            CustomTextRegular(
                                                language.languageName ?? ''),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }
                            else if (selectedIndexFilter == 4) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Flexible(
                                        child: TextButton(
                                          onPressed: () {
                                            // Clear all selected skills
                                            controller.filterSelectedGender
                                                .value = '';
                                          },
                                          child: CustomTextRegular(
                                              AppStrings.clear,
                                              color: ColorResources
                                                  .colorPrimaryDark),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ListView(
                                    shrinkWrap: true,
                                    children: [
                                      Row(
                                        children: [
                                          Obx(() =>
                                              Radio<String>(
                                                value: 'male',
                                                groupValue: controller
                                                    .filterSelectedGender
                                                    .value.isEmpty
                                                    ? null
                                                    : controller
                                                    .filterSelectedGender
                                                    .value,
                                                onChanged: (String? value) {
                                                  if (value != null) {
                                                    controller
                                                        .filterSelectedGender
                                                        .value = value;
                                                  }
                                                },
                                                activeColor: ColorResources
                                                    .colorPrimary,
                                              )),
                                          CustomTextRegular(AppStrings.male),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Obx(() =>
                                              Radio<String>(
                                                value: 'female',
                                                groupValue: controller
                                                    .filterSelectedGender
                                                    .value.isEmpty
                                                    ? null
                                                    : controller
                                                    .filterSelectedGender
                                                    .value,
                                                onChanged: (String? value) {
                                                  if (value != null) {
                                                    controller
                                                        .filterSelectedGender
                                                        .value = value;
                                                  }
                                                },
                                                activeColor: ColorResources
                                                    .colorPrimary,
                                              )),
                                          CustomTextRegular(
                                              AppStrings.female),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }
                            // else if (selectedIndexFilter == 5) {
                            //   return Column(
                            //     children: [
                            //       Row(
                            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           Flexible(
                            //             child: TextButton(
                            //               onPressed: () {
                            //                 // Select all categories
                            //                 controller.filterSelectedCategories.value = controller.categoryList
                            //                     .map((category) => (category.id ?? '').toString())
                            //                     .toSet()
                            //                     .toList();
                            //               },
                            //               child: CustomTextRegular(AppStrings.selectAll, color: ColorResources.colorPrimaryDark),
                            //             ),
                            //           ),
                            //           Flexible(
                            //             child: TextButton(
                            //               onPressed: () {
                            //                 // Clear all selected categories
                            //                 controller.filterSelectedCategories.value = [];
                            //               },
                            //               child: CustomTextRegular(AppStrings.clear, color: ColorResources.colorPrimaryDark),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //       Expanded(
                            //         child: ListView.builder(
                            //           shrinkWrap: true,
                            //           itemCount: controller.categoryList.length,
                            //           itemBuilder: (context, index) {
                            //             final category = controller.categoryList[index];
                            //             final categoryIdString = (category.id ?? '').toString();
                            //             return Row(
                            //               children: [
                            //                 Obx(() => Checkbox(
                            //                   value: controller.filterSelectedCategories.contains(categoryIdString),
                            //                   onChanged: (bool? value) {
                            //                     updateStatus(value, 'category', categoryIdString);
                            //                   },
                            //                   activeColor: ColorResources.colorPrimary,
                            //                   side: WidgetStateBorderSide.resolveWith(
                            //                         (Set<WidgetState> states) {
                            //                       if (states.contains(WidgetState.selected)) {
                            //                         return const BorderSide(color: ColorResources.colorPrimary);
                            //                       }
                            //                       return const BorderSide(color: ColorResources.colorPrimary);
                            //                     },
                            //                   ),
                            //                 )),
                            //                 CustomTextRegular(category.categoryTitle ?? ''),
                            //               ],
                            //             );
                            //           },
                            //         ),
                            //       ),
                            //     ],
                            //   );
                            // }
                            else {
                              return Center(child: CustomTextRegular(
                                  AppStrings.dataUnavailable));
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: Dimensions.paddingSizeSmall,
                        top: Dimensions.paddingSizeOverSmall,
                        bottom: Dimensions.paddingSizeOverSmall,
                        left: Dimensions.paddingSizeSmall),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              controller.clearAllFilters();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorResources
                                  .colorPrimaryLight,
                              // Change the color if needed
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.borderRadiusSmall),
                              ),
                              minimumSize: const Size(150, 45),
                            ),
                            child: CustomTextRegular(
                                "Clear All", color: ColorResources.black),
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () async {
                                controller.applyFilters();
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorResources
                                      .colorPrimary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.borderRadiusSmall)),
                                  minimumSize: const Size(150, 45)
                              ),
                              child: CustomTextRegular(AppStrings.apply,
                                  color: ColorResources.toolbarText)
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (controller.isFilterLoading.value) {
            return const CustomProgressIndicator();
          } else {
            return const EmptyScreen();
          }
        });
      },
    );
  }
}
