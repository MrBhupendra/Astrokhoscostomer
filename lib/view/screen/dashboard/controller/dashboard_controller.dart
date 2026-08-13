import 'package:astro_brahmand/utill/app_fonts.dart';
import 'package:app_links/app_links.dart';
import 'package:astro_brahmand/utill/images.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../../controller/all_astrologer_controller.dart';
import '../../../../model/dash_popup_banner_model.dart';
import '../../../../model/wallet_balance_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/common_methods.dart';
import '../../../../utill/shared_preference.dart';
import '../../agora/live_stream/controller/live_stream_init_controller.dart';
import '../../search/model/astrologer_request_model.dart';
import 'live_astrologer_controller.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class DashboardController extends FullLifeCycleController with FullLifeCycleMixin {
  final Dio _dio = Dio();

  RxInt selectedIndex = 0.obs;

  //Wallet
  final isBalanceLoading = false.obs;
  final isBalanceSuccess = false.obs;
  RxDouble walletBalance = 0.0.obs;
  WalletBalanceModel walletBalanceModel = WalletBalanceModel();

  //Banner
  final isPopupLoading = false.obs;
  final isPopupSuccess = false.obs;
  DashPopupBannerModel dashPopupBannerModel = DashPopupBannerModel();

  //Deeplink
  final _appLinks = AppLinks(); // AppLinks is singleton

  @override
  Future<void> onInit() async {
    super.onInit();
    bool isLogin = await SharedPreferencesHelper.getIsLogin();
    bool isShowPopUp = await SharedPreferencesHelper.getBoolData(AppConstants.isPopUp);
    if (isLogin) {
      getWalletBalance();
    }
    if (isShowPopUp) {
      getPopupBanner();
    }

    _appLinks.uriLinkStream.listen((uri) async {
      AppLogger.d('Received deep link: $uri length ${uri.pathSegments.length}');
      if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'astrologers') {
        if(uri.pathSegments.length == 2){
          String type = uri.pathSegments[1].toString();
          if(type == "chat"){
            selectedIndex.value = 1;
          }else if(type == "live"){
            selectedIndex.value = 2;
          }else if(type == "call"){
            selectedIndex.value = 3;
          }else{
            String slug = uri.pathSegments[1].toString();
            AllAstrologerController allAstrologerController = Get.put(AllAstrologerController());
            allAstrologerController.getAllAstrologer(AstrologerRequestModel(
              offset: 0,
              search: '',
              gender: '',
              language: '',
              category: '',
              skill:  '',
              sortBy: '',
              slug: slug,
              isVirtual: '0',
              slotPermission: '0',
              isSlotAvailable: '0',
              type: '',
              astrologerUniId: '',
            )).then((_) {
              if (allAstrologerController.astrologerListData.isNotEmpty) {
                allAstrologerController.selectedAstrologerData.value = allAstrologerController.astrologerListData[0];
                Get.toNamed("/astroProfile");
              } else {
                AppLogger.d('No astrologers found.');
              }
            });
          }
        }else{
          selectedIndex.value = 1;
        }
      } else if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'wallet') {
        Get.toNamed('/wallet');
      }else if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'products') {
        if (uri.pathSegments.length == 2) {
          String productSlug = uri.pathSegments[1].toString();
          Get.toNamed('/productDetail/$productSlug');
        } else if (uri.pathSegments.length == 3) {
          String productSlug = uri.pathSegments[1].toString();
          String astrologerId = uri.pathSegments[2].toString();
          Get.toNamed('/productDetail/$productSlug/$astrologerId');
        }
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'liveAstrologer') {
        String uniqueId = uri.pathSegments[1].toString();
        String astrologerUniId = uri.pathSegments[2].toString();
        String astrologerUID = uri.pathSegments[3].toString();
        String astrologerName =  uri.pathSegments[4].toString();
        String astrologerImage = uri.pathSegments[5].toString();
        String callPrice = uri.pathSegments[6].toString();
        String videoCallPrice = uri.pathSegments[7].toString();
        String callDuration = uri.pathSegments[8].toString();
        String videoCallDuration = uri.pathSegments[9].toString();

        String privateCallPrice = uri.pathSegments[10].toString();
        String privateVideoCallPrice = uri.pathSegments[11].toString();
        String privateCallDuration = uri.pathSegments[12].toString();
        String privateVideoCallDuration = uri.pathSegments[13].toString();

        LiveStreamInitController liveController = Get.put(LiveStreamInitController());
        liveController.setAstrologerData(astrologerName, astrologerImage, callPrice, videoCallPrice, callDuration, videoCallDuration,privateCallPrice, privateVideoCallPrice, privateCallDuration, privateVideoCallDuration,AppConstants.live);

        LiveAstrologerController liveAstrologerController = Get.put<LiveAstrologerController>(LiveAstrologerController());
        liveAstrologerController.joinLiveStream(int.tryParse(astrologerUID) ?? 0, uniqueId, astrologerUniId);
      } else if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'services') {
        if (uri.pathSegments.length == 2) {
          String serviceSlug = uri.pathSegments[1].toString();
          Get.toNamed('/serviceDetail/$serviceSlug');
        } else if (uri.pathSegments.length == 3) {
          String serviceSlug = uri.pathSegments[1].toString();
          String astrologerId = uri.pathSegments[2].toString();
          Get.toNamed('/serviceDetail/$serviceSlug/$astrologerId');
        }
      } else if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'blogs') {
        if (uri.pathSegments.length == 2) {
          String blogSlug = uri.pathSegments[1].toString();
          Get.toNamed('/blogDetail/$blogSlug');
        } else {
          Get.toNamed('/blog');
        }
      }
      else if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'jeevini') {
        Get.toNamed('/sanjeeviniList');
      } else if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'divine-code') {
        Get.toNamed('/switchList');
      } else if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'e-books') {
        Get.toNamed('/booksCategory');
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'electro-homeopathy') {
        Get.toNamed('/homeopathy_screen');
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'vastu-architect') {
        Get.toNamed('/architect_new_old_screen');
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'report') {
        Get.toNamed('/reportListScreen');
      } else if (uri.pathSegments.isNotEmpty &&
          uri.pathSegments.first == 'ask-question') {
        String? predictionPrice = await SharedPreferencesHelper.getData(
            AppConstants.aiPredictionPrice);
        String? uniId =
            await SharedPreferencesHelper.getData(AppConstants.userUniId);
        bool isLogin = await SharedPreferencesHelper.getIsLogin();
        if (isLogin) {
          Get.toNamed('/ask_question_screen_new', arguments: {
            "price": predictionPrice,
            "uniId": uniId,
          });
        }else{
          Get.toNamed('/login');
        }
      }
    });
  }

  @override
  Future<void> onResumed() async {
    AppLogger.d('OnResumed Dashboard');

    bool isLogin = await SharedPreferencesHelper.getIsLogin();
    if (isLogin) {
      getWalletBalance();
    }
  }

  @override
  void onPaused() {
    AppLogger.d('onPaused Dashboard');
  }

  @override
  void onClose() {
    super.onClose();
    AppLogger.d('onClose Dashboard');
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  Future<void> getWalletBalance() async {
    isBalanceLoading(true);
    try {
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);

      final response = await _dio.post(AppConstants.getWalletBalance,
          data: {"api_key": apiKey, "user_uni_id": uniId});

      // print("response => $response");
      AppLogger.d("key-> $uniId $apiKey");
      if (response.statusCode == 200) {
        walletBalanceModel = WalletBalanceModel.fromJson(response.data);
        if (walletBalanceModel.status == AppConstants.success) {
          isBalanceSuccess(true);
          walletBalance.value = double.parse(walletBalanceModel.data.toString());
        } else {
          isBalanceSuccess(false);
          if (walletBalanceModel.errorCode == AppConstants.unAuthoriseUser) {
            CommonMethods().showSessionExpiredDialog();
          }
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isBalanceSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isBalanceLoading(false);
    }
  }

  Future<void> getPopupBanner() async {
    isPopupLoading(true);
    try {
      final response = await _dio.post(AppConstants.getPopupBanner);
      if (response.statusCode == 200) {
        dashPopupBannerModel = DashPopupBannerModel.fromJson(response.data);
        if (dashPopupBannerModel.status == AppConstants.success) {
          isPopupSuccess(true);
          showPopupDialog();
        } else {
          isPopupSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isPopupSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isPopupLoading(false);
    }
  }

  void showPopupDialog() async {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        content: Stack(
          children: <Widget>[
            if (dashPopupBannerModel.data?.type == "image")
              CustomNetworkImage(
                imageUrl: dashPopupBannerModel.data!.noticeImage.toString(),
                height: 512,
                width: 512,
                fit: BoxFit.contain,
              )
            else
              Padding(
                padding: const EdgeInsets.only(
                    right: 30.0, top: 5.0, bottom: 5.0, left: 5.0),
                child: HtmlWidget(
                    dashPopupBannerModel.data!.description.toString(),
                    textStyle: const TextStyle(
                      fontFamily: AppFonts.euclidRegular,
                      fontFamilyFallback: AppFonts.fallback,
                    )),
              ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    Images.crossFill,
                    height: 26,
                    color: ColorResources.colorPrimaryDark,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    await SharedPreferencesHelper.saveBoolData(AppConstants.isPopUp, false);
  }

}
