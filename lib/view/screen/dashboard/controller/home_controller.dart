import 'dart:async';

import 'package:astro_brahmand/model/group_puja_category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:astro_brahmand/model/astrologer_model.dart';
import 'package:astro_brahmand/model/dashboard_model.dart';
import 'package:astro_brahmand/model/product_category_model.dart';

import '../../../../model/banner_model.dart';
import '../../../../model/blog_model.dart';
import '../../../../model/service_category_model.dart';
import '../../../../model/success_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_strings.dart';
import '../../../../notification/notification_router.dart';
import '../../../../utill/session_end_tracker.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_default_dialog.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../feedback/feedback_screen.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class HomeController extends GetxController {
  final Dio _dio = Dio();

  // Dashboard
  final isDashboardLoading = false.obs;
  final isDashboardSuccess = false.obs;
  final isDashboardRefreshing = false.obs;
  DashboardModel dashboardModel = DashboardModel();
  List<ServiceCategoryData>? serviceCategoryList;
  List<GroupPoojaCategoryData>? groupPoojaCategoryList;
  List<ProductCategoriesData>? productCategoryList;
  List<BlogsData>? blogList;
  List<BannersData>? bannerList;
  List<Videosection>? videoList;
  List<ChatChannels>? chatChannels;
  RxList<AstrologerData> liveAstrologerListData = <AstrologerData>[].obs;

  SuccessModel liveJoinModel = SuccessModel();

  // isLogin
  var isLogin = false.obs;

  // Feedback Suggestions
  final isFeedbackLoading = false.obs;
  final isFeedbackSuccess = false.obs;
  SuccessModel feedbackModel = SuccessModel();

  // Rates
  RxString chatRate = '***'.obs;
  RxString callRate = '***'.obs;
  RxString videoRate = '**'.obs;

  List<String> prices = [];

  // Astrologer
  final isAstrologerLoading = false.obs;
  final isAstrologerSuccess = false.obs;
  AstrologerModel astrologerModel = AstrologerModel();
  List<AstrologerData> astrologerListData = [];

  //AI Astrologer
  final isAIAstrologerLoading = false.obs;
  final isAIAstrologerSuccess = false.obs;
  AstrologerModel aiAstrologerModel = AstrologerModel();
  List<AstrologerData> aiAstrologerListData = [];

  //Homeopathy
  final isElectroLoading = false.obs;
  final isElectroSuccess = false.obs;
  AstrologerModel electroModel = AstrologerModel();
  List<AstrologerData> electroListData = [];

  var inProgressStatus = 0.obs;
  var callType = ''.obs;

  /// Re-fetch schedule used while the backend still reports a session we
  /// already ended locally (see [SessionEndTracker]).
  Timer? _inProgressRecheckTimer;
  int _inProgressRecheckAttempt = 0;
  static const int _maxInProgressRechecks = 5;

  @override
  void onInit() {
    super.onInit();
    getDashboard(false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // FCM / Awesome cold-start navigation (after GetMaterialApp + shell ready)
      await NotificationRouter.flushColdStartQueue();
    });
    isLoginValue();
  }

  Future<void> isLoginValue() async {
    isLogin.value = await SharedPreferencesHelper.getIsLogin();
  }

  Future<void> getDashboard(bool isRefresh) async {
    if (isRefresh) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isDashboardRefreshing(true);
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isDashboardLoading(true);
    });

    try {
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio
          .post(AppConstants.getDashboard, data: {"user_uni_id": uniId});
      if (response.statusCode == 200) {
        dashboardModel = DashboardModel.fromJson(response.data);
        if (dashboardModel.status == AppConstants.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            isDashboardSuccess(true);

            _applyInProgressOrder(dashboardModel.data?.inProgressOrder);

            bannerList = dashboardModel.data?.banners;
            //Live
            List<AstrologerData> astrologers =
                dashboardModel.data?.liveAstrologers ?? [];
            liveAstrologerListData.assignAll(astrologers);

            serviceCategoryList = dashboardModel.data?.services;
            groupPoojaCategoryList = dashboardModel.data?.groupPoojaCategories;
            productCategoryList = dashboardModel.data?.productCategories;
            blogList = dashboardModel.data?.blogs;
            videoList = dashboardModel.data?.videosection;
            //Only chat channels (skip ASSISTANT/ and CALL/)
            chatChannels = dashboardModel.data?.chatChannels
                ?.where((channel) =>
                    channel.channelName.toString().startsWith('CHAT/'))
                .toList();

            if (dashboardModel.data?.inReview?.isReview == 1) {
              Get.off(FeedbackScreen(
                  dashboardModel.data!.inReview!.idForReview.toString(),
                  dashboardModel.data!.inReview!.displayNameForReview
                      .toString(),
                  dashboardModel.data!.inReview!.astroImg.toString(),
                  dashboardModel.data!.inReview!.uniqeid.toString()));
            }
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            isDashboardSuccess(false);
          });
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isDashboardSuccess(false);
        AppLogger.d('OnException==> ${e.toString()}');
      });
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isDashboardLoading(false);
        if (isRefresh) {
          isDashboardRefreshing(false);
        }
      });
    }
  }

  /// Applies the dashboard's in-progress order to the home screen state.
  ///
  /// A session ended on this device can still come back as `status == 1`
  /// because the backend closes the order asynchronously. Keeping the card
  /// visible would leave the user "stuck" on a consultation that is already
  /// over, so the stale order is ignored and the dashboard is re-fetched until
  /// the backend agrees.
  void _applyInProgressOrder(InProgressOrder? order) {
    final status = order?.status?.toInt() ?? 0;

    if (status == 1 && SessionEndTracker.isEnded(order?.uniqeid)) {
      AppLogger.d(
          'Ignoring stale in-progress order ${order?.uniqeid}; session already ended locally');
      inProgressStatus.value = 0;
      callType.value = '';
      _scheduleInProgressRecheck();
      return;
    }

    _cancelInProgressRecheck();
    SessionEndTracker.clear(order?.uniqeid);
    inProgressStatus.value = status;
    callType.value = order?.callType ?? '';
  }

  void _scheduleInProgressRecheck() {
    if (_inProgressRecheckAttempt >= _maxInProgressRechecks) return;
    _inProgressRecheckAttempt++;
    _inProgressRecheckTimer?.cancel();
    _inProgressRecheckTimer = Timer(
      Duration(seconds: 3 * _inProgressRecheckAttempt),
      () => getDashboard(false),
    );
  }

  void _cancelInProgressRecheck() {
    _inProgressRecheckTimer?.cancel();
    _inProgressRecheckTimer = null;
    _inProgressRecheckAttempt = 0;
  }

  /// Drops the "in progress" card as soon as a chat/call/video session ends and
  /// re-syncs the dashboard.
  ///
  /// Safe to call from anywhere: it records the ended session even when the
  /// dashboard has not been built yet, so a freshly created [HomeController]
  /// will not resurrect the card either.
  static void notifySessionEnded(String? uniqeid) {
    SessionEndTracker.markEnded(uniqeid);
    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().onSessionEnded(uniqeid);
    }
  }

  void onSessionEnded(String? uniqeid) {
    SessionEndTracker.markEnded(uniqeid);
    _cancelInProgressRecheck();
    inProgressStatus.value = 0;
    callType.value = '';
    getDashboard(false);
  }

  @override
  void onClose() {
    _inProgressRecheckTimer?.cancel();
    super.onClose();
  }

  Future<void> getAllAstrologer() async {
    astrologerListData.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isAstrologerSuccess(false);
      isAstrologerLoading(true);
    });

    try {
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.getAllAstrologer,
          data: {"user_uni_id": uniId, "offset": 0});

      AppLogger.d("Request-> Id $uniId");

      if (response.statusCode == 200) {
        astrologerModel = AstrologerModel.fromJson(response.data);
        if (astrologerModel.status == AppConstants.success) {
          for (var element in (astrologerModel.data ?? [])) {
            astrologerListData.add(element);
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            isAstrologerSuccess(true);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            isAstrologerSuccess(false);
          });
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isAstrologerSuccess(false);
        AppLogger.d('OnException==> ${e.toString()}');
      });
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isAstrologerLoading(false);
      });
    }
  }

  Future<void> getAllAIAstrologer() async {
    aiAstrologerListData.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isAIAstrologerSuccess(false);
      isAIAstrologerLoading(true);
    });

    try {
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.getAllAstrologer,
          data: {"user_uni_id": uniId, "offset": 0, "is_virtual": 1});

      if (response.statusCode == 200) {
        aiAstrologerModel = AstrologerModel.fromJson(response.data);
        if (aiAstrologerModel.status == AppConstants.success) {
          for (var element in (aiAstrologerModel.data ?? [])) {
            aiAstrologerListData.add(element);
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            isAIAstrologerSuccess(true);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            isAIAstrologerSuccess(false);
          });
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isAIAstrologerSuccess(false);
        AppLogger.d('OnException==> ${e.toString()}');
      });
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isAIAstrologerLoading(false);
      });
    }
  }

  Future<void> getAllElectro() async {
    electroListData.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isElectroSuccess(false);
      isElectroLoading(true);
    });

    try {
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? categoryId = await SharedPreferencesHelper.getData(
          AppConstants.homeopathyCategoryId);

      final response = await _dio.post(AppConstants.getAllAstrologer,
          data: {"user_uni_id": uniId, "offset": 0, "category": categoryId});

      if (response.statusCode == 200) {
        electroModel = AstrologerModel.fromJson(response.data);
        if (electroModel.status == AppConstants.success) {
          for (var element in (electroModel.data ?? [])) {
            electroListData.add(element);
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            isElectroSuccess(true);
          });
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            isElectroSuccess(false);
          });
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isElectroSuccess(false);
        AppLogger.d('OnException==> ${e.toString()}');
      });
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isElectroLoading(false);
      });
    }
  }

  Future<void> joinLiveStream(
      int astrologerUID, String uniqueId, String astrologerUniId) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);
      String? agoraAppId =
          await SharedPreferencesHelper.getData(AppConstants.agoraAppId);
      final response = await _dio.post(AppConstants.joinLiveStream,
          data: {'api_key': apiKey, 'user_uni_id': uniId, 'uniqeid': uniqueId});
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        liveJoinModel = SuccessModel.fromJson(response.data);
        if (liveJoinModel.status == AppConstants.success) {
          AppLogger.d("Success -> ${response.data.toString()}");
          String? token = response.data["data"]["token"];
          Get.toNamed('/liveStreamScreen', arguments: {
            'uniqueId': uniqueId,
            'agoraAppId': agoraAppId,
            'token': token,
            'astrologerId': astrologerUniId,
            'astrologerUID': astrologerUID
          });
          AppLogger.d("As1 Req $token $uniqueId $agoraAppId $astrologerUniId $astrologerUID");
        } else {
          CustomSnackBar.showBottom(liveJoinModel.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    }
  }

  void showSessionExpiredDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.defaultDialog(
        title: "Session Expired",
        barrierDismissible: false,
        content: const Text("Session Expired. Please login again."),
        confirm: TextButton(
          onPressed: () async {
            await SharedPreferencesHelper.logoutSession();
          },
          child: const Text("Ok"),
        ),
      );
    });
  }

  Future<void> sendSuggestions(String feedback) async {
    CustomProgressDialog.showDialog();
    isFeedbackLoading(true);
    try {
      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.sendSuggestions, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'feedback': feedback
      });
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        feedbackModel = SuccessModel.fromJson(response.data);
        if (feedbackModel.status == AppConstants.success) {
          isFeedbackSuccess(true);
          // CustomSnackBar.showTop(feedbackModel.msg.toString());
          CustomDefaultDialog.showOkDialog(
              AppStrings.success.tr, AppStrings.successFeedbackMsg.tr, () {
            Get.back();
          });
        } else {
          isFeedbackSuccess(false);
          CustomSnackBar.showBottom(feedbackModel.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isFeedbackLoading(false);
    }
  }
}
