import 'dart:convert';

import 'package:astro_brahmand/model/group_puja_category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_default_dialog.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../feedback/feedback_screen.dart';
import '../../mandir_darshan/model/mandir_assign_list_model.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
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

  static const platform = MethodChannel('Chat notifications');
  static const alertPlatform = MethodChannel('Alert notifications');
  Map<String, dynamic>? notificationData;
  Map<String, dynamic>? notificationDataStored;
  int? lastProcessedNotificationId;
  int? lastProcessedAlertNotificationId;

  var inProgressStatus = 0.obs;
  var callType = ''.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    getDashboard(false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getNotificationData();
    });
    getAlertNotificationData();
    isLoginValue();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      debugPrint("App is in resumed state, fetching notification data...");
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await getNotificationData(isFromResume: true);
      });
    }
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

            inProgressStatus.value =
                dashboardModel.data!.inProgressOrder!.status!.toInt();
            callType.value =
                dashboardModel.data?.inProgressOrder!.callType ?? '';

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
            chatChannels = dashboardModel.data?.chatChannels;

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
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isDashboardSuccess(false);
        if (kDebugMode) {
          print('OnException==> ${e.toString()}');
        }
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

      print("Request-> Id $uniId");

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
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isAstrologerSuccess(false);
        if (kDebugMode) {
          print('OnException==> ${e.toString()}');
        }
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
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isAIAstrologerSuccess(false);
        if (kDebugMode) {
          print('OnException==> ${e.toString()}');
        }
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
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isElectroSuccess(false);
        if (kDebugMode) {
          print('OnException==> ${e.toString()}');
        }
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
          print("Success -> ${response.data.toString()}");
          String? token = response.data["data"]["token"];
          Get.toNamed('/liveStreamScreen', arguments: {
            'uniqueId': uniqueId,
            'agoraAppId': agoraAppId,
            'token': token,
            'astrologerId': astrologerUniId,
            'astrologerUID': astrologerUID
          });
          print(
              "As1 Req $token $uniqueId $agoraAppId $astrologerUniId $astrologerUID");
        } else {
          CustomSnackBar.showBottom(liveJoinModel.msg.toString());
        }
      } else {
        CustomProgressDialog.dismissDialog();
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
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
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isFeedbackLoading(false);
    }
  }

  Future<void> getNotificationData({bool? isFromResume}) async {
    try {
      if (kDebugMode) {
        print("Invoking method channel to get notification data...");
      }

      final Map<dynamic, dynamic>? data =
          await platform.invokeMethod('notificationData');

      if (data != null) {
        if (kDebugMode) {
          print("Received data: $data");
        }

        final String? actionKey = data['key'];

        final notificationJson = data['notificationJson'];

        if (notificationJson != null) {
          final Map<String, dynamic> notificationData =
              jsonDecode(notificationJson);

          if (kDebugMode) {
            print("Parsed notificationData: $notificationData");
            print("Channel Key: ${notificationData['content']?['channelKey']}");
          }

          final Map<String, dynamic> content =
              notificationData['content'] ?? {};

          final Map<String, dynamic> payload = content['payload'] ?? {};

          final String url = payload['url'] ?? '';

          final int notificationId = content['id'] ?? 0;

          final String channelKey = content['channelKey'] ?? '';

          String? rawNotificationId = await SharedPreferencesHelper.getData(
              AppConstants.lastProcessedNotificationId);
          lastProcessedNotificationId =
              int.tryParse(rawNotificationId ?? '') ?? 0;
          if (kDebugMode) {
            print(
                "Raw Notification ID from SharedPreferences: $rawNotificationId");
          }

          if (kDebugMode) {
            print(
                "URL: $url, ID: $notificationId, lastID: $lastProcessedNotificationId");
          }

          if (notificationId != lastProcessedNotificationId) {
            await SharedPreferencesHelper.saveData(
                AppConstants.lastProcessedNotificationId,
                notificationId.toString());

            if (kDebugMode) {
              print("called");
            }

            if (channelKey == 'chat_channel') {
              print("Chat Notification Received: $data");
              if (isFromResume == true) {
                if (kDebugMode) {
                  print("Handling notification on resume...");
                }
                handleNavigation(content, actionKey, notificationData,
                    isFromResume: isFromResume);
              } else {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  handleNavigation(content, actionKey, notificationData);
                });
              }
            } else {
              print("Ignoring non-chat notification");
              // getAlertNotificationData();
            }
          }
        } else {
          if (kDebugMode) {
            print("No notificationJson found");
          }
        }
      } else {
        if (kDebugMode) {
          print("No data received from method channel");
        }
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to get notification data: ${e.message}");
      }
    } on MissingPluginException catch (e) {
      if (kDebugMode) {
        print(
            "MissingPluginException: Method not implemented on native side - ${e.message}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching notification data: $e");
      }
    }
  }

  void handleNavigation(Map<String, dynamic> content, String? actionKey,
      Map<String, dynamic> notificationData,
      {bool? isFromResume}) {
    if (actionKey == null) {
      if (content['payload']['type'] == "chat") {
        Get.toNamed('/queue_list');
      }
    } else {
      if (isFromResume == true) {
        processNotificationAction(notificationData, actionKey);
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          processNotificationAction(notificationData, actionKey);
        });
      }
    }
  }

  Future<void> processNotificationAction(
      Map<String, dynamic> notificationJson, String receivedActionKey) async {
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    try {
      final int? notificationId =
          int.tryParse(notificationJson['content']['id']?.toString() ?? '');
      if (notificationId == null) {
        if (kDebugMode) {
          print("Invalid or null notificationId");
        }
        return;
      }

      if (receivedActionKey == "ACCEPT" || receivedActionKey == "REJECT") {
        Get.toNamed('/queue_list');
      } else if (receivedActionKey == "ACCEPT SERVICE" ||
          receivedActionKey == "REJECT SERVICE") {
        Get.toNamed('/orders_tab_screen', arguments: {'index': 2});
      } else if (receivedActionKey == "ACCEPT ARCHITECT" ||
          receivedActionKey == "REJECT ARCHITECT") {
        Get.toNamed("/architect_orders_tab_screen");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error during navigation: $e");
      }
    }
    // });
  }

  Future<void> getAlertNotificationData() async {
    try {
      if (kDebugMode) {
        print("Invoking method channel to get alertNotificationData...");
      }

      final Map<dynamic, dynamic>? data =
          await alertPlatform.invokeMethod('alertNotificationData');

      if (data != null) {
        if (kDebugMode) {
          print("Received alertNotificationData data: $data");
        }

        final String? channelKey = data['channelKey'];
        if (kDebugMode) {
          print("Parsed channelKey: $channelKey");
        }
        final notificationJson = data['notificationJson'];
        if (notificationJson != null) {
          final Map<String, dynamic> notificationData =
              jsonDecode(notificationJson);

          if (kDebugMode) {
            print("Parsed alertNotificationData: $notificationData");
          }

          final Map<String, dynamic> content =
              notificationData['content'] ?? {};
          final Map<String, dynamic> payload = content['payload'] ?? {};
          final String url = payload['url'] ?? '';
          final int notificationId = content['id'] ?? 0;

          String? rawNotificationId = await SharedPreferencesHelper.getData(
              AppConstants.lastProcessedAlertNotificationId);
          lastProcessedAlertNotificationId =
              int.tryParse(rawNotificationId ?? '') ?? 0;

          if (kDebugMode) {
            print(
                "URL: $url, ID: $notificationId, lastID: $lastProcessedAlertNotificationId");
          }

          // if (channelKey == 'alert_channel') {
          print("Alert Notification Received: $data");
          if (url.isNotEmpty &&
              notificationId != lastProcessedAlertNotificationId) {
            await SharedPreferencesHelper.saveData(
                AppConstants.lastProcessedAlertNotificationId,
                notificationId.toString());
            navigateBasedOnUri(url);
          }
          // } else {
          //   print("Ignoring non-alert notification");
          // }
        } else {
          if (kDebugMode) {
            print("No alertNotificationData notificationJson found");
          }
        }
      } else {
        if (kDebugMode) {
          print("No alertNotificationData data received from method channel");
        }
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to get alertNotificationData: ${e.message}");
      }
    } on MissingPluginException catch (e) {
      // Handle the case where the method isn't implemented on the native side
      if (kDebugMode) {
        print(
            "MissingPluginException: Method not implemented on native side - ${e.message}");
      }
      // Optionally, you can fallback to default data or notify the user here
    } catch (e) {
      // Catch any other exceptions that might occur
      if (kDebugMode) {
        print("Error fetching alertNotificationData: $e");
      }
    }
  }

  void navigateBasedOnUri(String url) {
    Uri uri = Uri.parse(url);
    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'products') {
      if (uri.pathSegments.length == 2) {
        String productSlug = uri.pathSegments[1].toString();
        Get.toNamed('/productDetail/$productSlug');
      } else if (uri.pathSegments.length == 3) {
        String productSlug = uri.pathSegments[1].toString();
        String astrologerId = uri.pathSegments[2].toString();
        Get.toNamed('/productDetail/$productSlug/$astrologerId');
      }
    } else if (uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == 'services') {
      if (uri.pathSegments.length == 2) {
        String serviceSlug = uri.pathSegments[1].toString();
        Get.toNamed('/serviceDetail/$serviceSlug');
      } else if (uri.pathSegments.length == 3) {
        String serviceSlug = uri.pathSegments[1].toString();
        String astrologerId = uri.pathSegments[2].toString();
        Get.toNamed('/serviceDetail/$serviceSlug/$astrologerId');
      }
    }
  }
}
