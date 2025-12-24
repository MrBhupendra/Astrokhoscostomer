
import 'package:astro_brahmand/model/astrologer_detail_model.dart';
import 'package:astro_brahmand/view/screen/chat/controller/chat_intake_form_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:astro_brahmand/model/check_call_detail_model.dart';
import 'package:astro_brahmand/model/review_model.dart';
import 'package:astro_brahmand/model/success_model.dart';
import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';


import '../../../../controller/all_astrologer_controller.dart';
import '../../../../model/astrologer_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_default_indicator.dart';
import '../../../widget/custom_elevated_button.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_round_network_image.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../agora/live_stream/model/live_gift_list_model.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../splash/controller/config_controller.dart';

class AstrologerProfileController extends FullLifeCycleController
    with FullLifeCycleMixin{


  final Dio _dio = Dio();
  final isLoading = false.obs;
  final isSuccess = false.obs;
  final isReviewLoading = false.obs;
  final isReviewSuccess = false.obs;
  final isCallLoading = false.obs;
  final isCallSuccess = false.obs;

  CheckCallDetailModel checkCallDetailModel = CheckCallDetailModel();
  SuccessModel startVoiceCallModel = SuccessModel();
  DashboardController bashboardController = Get.put(DashboardController());

  var isFollowLoading = false.obs;
  RxBool isFollow = false.obs;
  SuccessModel astrologerFollowModel = SuccessModel();

  //Astrologer
  var astrologerController;
  final isAstrologerLoading = false.obs;
  final isAstrologerSuccess = false.obs;
  AstrologerDetailModel astrologerModel = AstrologerDetailModel();
  var astrologerData = AstrologerData().obs;

  //Data
  String? astrologerUniId;
  //Gift List
  final isGiftLoading = false.obs;
  final isGiftSuccess = false.obs;
  LiveGiftListModel liveGiftListModel = LiveGiftListModel();
  RxInt selectedGiftIndex = 0.obs;
  RxString walletBalance = '***'.obs;
  final String giftsChild = "gifts";
  final String giftsListChild = "giftList";
  var isLogin = false.obs;

  SuccessModel giftSendSuccessModel = SuccessModel();

  //NextOnline
  RxString nextCallController = 'N/A'.obs;
  RxString nextChatController = 'N/A'.obs;
  RxString nextVideoController = 'N/A'.obs;

  //Reviews
  ReviewModel reviewModel = ReviewModel();
  List<ReviewsData> reviewsListData = [];
  bool isNoMoreData = false;
  ScrollController scrollController = ScrollController();
  num offsetCount = 0;

  late String astrologerSlugDeepLink;
  late String astrologerNameDeepLink;

  final ConfigController configController = Get.find();

  @override
  void onInit() {
    super.onInit();
    astrologerController = Get.put<AllAstrologerController>(AllAstrologerController());
    astrologerData.value = astrologerController.selectedAstrologerData.value;
    isFollow.value = astrologerController.selectedAstrologerData.value.isFollow as bool;
    getAstrologerDetail(astrologerController.selectedAstrologerData.value.astrologerUniId.toString());
    astrologerNameDeepLink = astrologerController.selectedAstrologerData.value.displayName.toString();
    astrologerSlugDeepLink = astrologerController.selectedAstrologerData.value.slug.toString();
    isLoginValue();
  }

  @override
  void onResumed() {
    getAstrologerDetail(astrologerController.selectedAstrologerData.value.astrologerUniId.toString());
  }

  Future<void> isLoginValue() async {
    isLogin.value = await SharedPreferencesHelper.getIsLogin();
  }

  Future<void> getAstrologerDetail(String astrologerUniId) async {
    isAstrologerLoading(true);
    try {
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.getAstrologerDetail,data: {
        "user_uni_id": uniId,
        "astrologer_uni_id": astrologerUniId
      });
      if (response.statusCode == 200) {
        astrologerModel = AstrologerDetailModel.fromJson(response.data);
        if(astrologerModel.status == AppConstants.success){
          isAstrologerSuccess(true);
          astrologerData.value = astrologerModel.data!;
          isFollow.value = astrologerModel.data!.isFollow as bool;
        }
        else{
          isAstrologerSuccess(false);
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      isAstrologerSuccess(false);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isAstrologerLoading(false);
    }
  }

  Future<void> getAllReviews(num offset, String astrologerUniId) async {
    if (offset == 0) {
      isReviewSuccess(false);
      isNoMoreData = false;
      reviewsListData.clear();
      offsetCount = 0;
    }

    isReviewLoading(true);
    try {
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getReviews,data: {
        'offset': offset,
        "astrologer_uni_id": astrologerUniId,
        "user_uni_id": uniId
      });
      if (response.statusCode == 200) {
        reviewModel = ReviewModel.fromJson(response.data);
        if(reviewModel.status == AppConstants.success){
          offsetCount = reviewModel.offset!;
          isReviewSuccess(true);

          for (var element in (reviewModel.reviews ?? [])) {
            reviewsListData.add(element);
          }
        }
        else{
          if (offset == 0) {
            isReviewSuccess(false);
          }
          isNoMoreData = true;
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      isReviewSuccess(false);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isReviewLoading(false);
    }
  }

  Future<void> checkCallDetail(String callType, String astrologerUniId,AstrologerData astrologer) async {
    CustomProgressDialog.showDialog();
    isCallLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.checkCallDetail,data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "astrologer_uni_id": astrologerUniId,
        "call_type": callType,
      });
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        checkCallDetailModel = CheckCallDetailModel.fromJson(response.data);
        if(checkCallDetailModel.status == AppConstants.success){
          isCallSuccess(true);
          _showCallBottomSheet(astrologerUniId,callType, astrologer);
        }
        else{
          isCallSuccess(false);
        }
      } else {
        CustomProgressDialog.dismissDialog();
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      isCallSuccess(false);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isCallLoading(false);
    }
  }

  Future<void> astrologerFollow(String status, String astrologerUniId) async {
    isFollowLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.astrologerFollow, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        'astrologer_uni_id': astrologerUniId,
        'status' : status
      });
      if (response.statusCode == 200) {
        astrologerFollowModel = SuccessModel.fromJson(response.data);
        if(astrologerFollowModel.status == AppConstants.success){
          if(status == "1"){
            isFollow(true);
          }else{
            isFollow(false);
          }
        }

      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isFollowLoading(false);
    }
  }

  // // Gift
  // Future<void> getGifts() async {
  //
  //   isGiftLoading(true);
  //   try {
  //     String? apiKey =
  //     await SharedPreferencesHelper.getData(AppConstants.userApiKey);
  //     String? uniId =
  //     await SharedPreferencesHelper.getData(AppConstants.userUniId);
  //     final response = await _dio.post(AppConstants.getLiveGifts,
  //         data: {'api_key': apiKey, "user_uni_id": uniId});
  //     if (response.statusCode == 200) {
  //       liveGiftListModel = LiveGiftListModel.fromJson(response.data);
  //       if (liveGiftListModel.status == AppConstants.success) {
  //         walletBalance.value = liveGiftListModel.walletBalance.toString();
  //         isGiftSuccess(true);
  //       } else {
  //         isGiftSuccess(false);
  //       }
  //     } else {
  //       if (kDebugMode) {
  //         print('OnApiError');
  //       }
  //     }
  //   } catch (e) {
  //     isGiftSuccess(false);
  //     if (kDebugMode) {
  //       print('OnException==> ${e.toString()}');
  //     }
  //   } finally {
  //     isGiftLoading(false);
  //   }
  // }
  //
  // Future<void> sendGiftApi(String status, String astrologerId, String giftId) async {
  //   CustomProgressDialog.showDialog();
  //   try {
  //     String? apiKey =
  //     await SharedPreferencesHelper.getData(AppConstants.userApiKey);
  //     String? uniId =
  //     await SharedPreferencesHelper.getData(AppConstants.userUniId);
  //     final response = await _dio.post(AppConstants.sendLiveGift, data: {
  //       'api_key': apiKey,
  //       "user_uni_id": uniId,
  //       "astrologer_uni_id": astrologerId,
  //       "gift_id": giftId
  //     });
  //
  //     if (response.statusCode == 200) {
  //       CustomProgressDialog.dismissDialog();
  //       giftSendSuccessModel = SuccessModel.fromJson(response.data);
  //       if (giftSendSuccessModel.status == AppConstants.success) {
  //         if (status == "1") {
  //           CustomSnackBar.showTop("Gift '${liveGiftListModel.data![selectedGiftIndex.value.toInt()].giftName}' sent successfully.");
  //           Get.offAllNamed('/dashboard');
  //           bashboardController.getWalletBalance();
  //         } else {
  //           CustomSnackBar.showTop("Gift '${liveGiftListModel.data![selectedGiftIndex.value.toInt()].giftName}' sent successfully to ${astrologerData.value.displayName}.");
  //           bashboardController.getWalletBalance();
  //         }
  //       } else {
  //         CustomSnackBar.showBottom(giftSendSuccessModel.msg.toString());
  //       }
  //     } else {
  //       CustomProgressDialog.dismissDialog();
  //       if (kDebugMode) {
  //         print('OnApiError');
  //       }
  //     }
  //   } catch (e) {
  //     CustomProgressDialog.dismissDialog();
  //     if (kDebugMode) {
  //       print('OnException==> ${e.toString()}');
  //     }
  //   }
  // }

  void shareProfile() {
    String slugUrl = "${AppConstants.baseUrl}/astrologers/$astrologerSlugDeepLink";
    String message = """🌟Meet ${astrologerNameDeepLink} on ${AppConstants.appName}🌙✨. Follow by clicking the link to get a guide you through life's journey with personalized astrological insights. ${slugUrl}
    """;
    Share.share(message);
  }

  void _showCallBottomSheet(String astrologerUniId, String type, AstrologerData astrologer) {
    Get.bottomSheet(
        Container(
          color: ColorResources.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        CustomRoundNetworkImage(
                            imageUrl: astrologer.astroImg.toString(),
                            height: 40,
                            width: 40
                        ),
                        Expanded(
                          child: CustomTextMedium(
                            astrologer.displayName.toString(),
                            fontSize: Dimensions.fontSizeDefault,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            color: ColorResources.black1,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 1.5),
                  Obx(
                        () {
                      if (isCallSuccess.isTrue) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 6.0),
                                child: CustomTextMedium("ASTROLOGER DETAIL",
                                    fontSize: Dimensions.fontSizeDefault),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextRegular(
                                      "${type == AppConstants.call ? "Call" : type == AppConstants.chat ? "Chat" : type == AppConstants.video ? "Video" : type == AppConstants.emergencyCall ? "Emergency Call" : type == AppConstants.emergencyChat ? "Emergency Chat" : type == AppConstants.emergencyVideoCall ? "Emergency Video" : "Unknown"} rate: ${configController.currencySymbol}${checkCallDetailModel.data?.price} /min",
                                      // "$type rate: ${configController.currencySymbol}${checkCallDetailModel.data?.price} /min",
                                      color: ColorResources.black1,
                                      fontSize: Dimensions.fontSizeSmall,
                                    ),
                                  ),
                                  const Gap(Dimensions.gapExtraOverLarge),
                                  if(checkCallDetailModel.data?.isSubscriptionApplied == 1)
                                  Container(
                                      decoration: BoxDecoration(
                                        color: ColorResources.white,
                                        borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.3),
                                              blurRadius: 3.0,
                                              spreadRadius: 1,
                                              offset: const Offset(0, 2),
                                            ),
                                          ]
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CustomTextMedium("Subscription Applied",color: ColorResources.colorPrimary,),
                                      )
                                  )
                                ],
                              ),
                              const Gap(Dimensions.gapExtraSmall),
                              const Divider(),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 6.0),
                                child: CustomTextMedium("YOUR DETAIL",
                                    fontSize: Dimensions.fontSizeDefault),
                              ),
                              CustomTextRegular(
                                "Balance: ${configController.currencySymbol} ${checkCallDetailModel.data?.userWalletAmt}",
                                color: ColorResources.black1,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                              const Gap(Dimensions.gapExtraSmall),
                              CustomTextRegular(
                                "Max Duration: ${checkCallDetailModel.data?.minutes} Mins",
                                color: ColorResources.black1,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                              const Gap(Dimensions.gapExtraSmall),
                              const Divider(),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 6.0),
                                child: CustomTextMedium("HOW IT WORKS ?",
                                    fontSize: Dimensions.fontSizeDefault),
                              ),
                              CustomTextRegular(
                                "Simply click 'Start' button to initiate session.",
                                color: ColorResources.black1,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                              const Gap(Dimensions.gapExtraSmall),
                              const Divider(),
                              CustomElevatedButton(
                                onPressed: () {
                                  Get.back(); //Close dialog
                                  ChatIntakeFormController chatIntakeFormController = Get.put(ChatIntakeFormController());
                                  if (type == AppConstants.call) {
                                    chatIntakeFormController.setAstrologerData(astrologer.displayName.toString(), astrologer.astroImg.toString(), astrologer.astrologerUniId.toString(), AppConstants.call,astrologer.isVirtualAstrologer ?? 0);
                                    Get.toNamed("/chat_intake_form");
                                  } else if (type == AppConstants.chat) {
                                    chatIntakeFormController.setAstrologerData(astrologer.displayName.toString(), astrologer.astroImg.toString(), astrologer.astrologerUniId.toString(),AppConstants.chat,astrologer.isVirtualAstrologer ?? 0);
                                    Get.toNamed("/chat_intake_form");
                                  } else if (type == AppConstants.video) {
                                    chatIntakeFormController.setAstrologerData(astrologer.displayName.toString(), astrologer.astroImg.toString(), astrologer.astrologerUniId.toString(),AppConstants.video,astrologer.isVirtualAstrologer ?? 0);
                                    Get.toNamed("/chat_intake_form");
                                  }else if (type == AppConstants.emergencyCall) {
                                    chatIntakeFormController.setAstrologerData(astrologer.displayName.toString(), astrologer.astroImg.toString(), astrologer.astrologerUniId.toString(), AppConstants.emergencyCall,astrologer.isVirtualAstrologer ?? 0);
                                    Get.toNamed("/chat_intake_form");
                                  }else if (type == AppConstants.emergencyChat) {
                                    chatIntakeFormController.setAstrologerData(astrologer.displayName.toString(), astrologer.astroImg.toString(), astrologer.astrologerUniId.toString(),AppConstants.emergencyChat,astrologer.isVirtualAstrologer ?? 0);
                                    Get.toNamed("/chat_intake_form");
                                  }else if (type == AppConstants.emergencyVideoCall) {
                                    chatIntakeFormController.setAstrologerData(astrologer.displayName.toString(), astrologer.astroImg.toString(), astrologer.astrologerUniId.toString(),AppConstants.emergencyVideoCall,astrologer.isVirtualAstrologer ?? 0);
                                    Get.toNamed("/chat_intake_form");
                                  }
                                },
                                text: "START",
                                backgroundColor: ColorResources.colorPrimary,
                                textColor: ColorResources.toolbarText,
                              ),
                              const Gap(10),
                              GestureDetector(
                                onTap: (){
                                  Get.toNamed("/wallet");
                                },
                                child: Center(
                                  child: CustomTextRegular(
                                    "Recharge",
                                    color: ColorResources.colorPrimaryDark,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      } else if (isCallLoading.isTrue) {
                        return const CustomDefaultProgressIndicator();
                      } else {
                        return const EmptyScreen();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  String formatDateTimeOutput(String dateTimeString) {
    if(dateTimeString.isEmpty || dateTimeString == ""){
      return "N/A";
    }else{
      try{
        DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTimeString);
        String formattedDateTime = DateFormat('dd/MM/yyyy hh:mm:a').format(dateTime);
        return formattedDateTime;
      }catch(e){
        return dateTimeString;
      }

    }
  }

}