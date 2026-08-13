import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../model/success_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_logger.dart';
import '../../../../utill/shared_preference.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  final Dio _dio = Dio();

  final isLoading = false.obs;
  final isSuccess = false.obs;
  bool isNoMoreData = false;
  NotificationModel notificationModel = NotificationModel();
  ScrollController scrollController = ScrollController();
  num offsetCount = 0;
  final notificationListData = <NotificationData>[].obs;

  final RxBool shouldRefreshScreen = false.obs;
  SuccessModel deleteModel = SuccessModel();
  final isDeleteSuccess = false.obs;

  /// Total unread notifications for the drawer badge.
  final RxInt unreadCount = 0.obs;

  Timer? _autoRefreshTimer;
  bool _isScreenOpen = false;

  static NotificationController get to {
    if (Get.isRegistered<NotificationController>()) {
      return Get.find<NotificationController>();
    }
    return Get.put(NotificationController(), permanent: true);
  }

  void refreshScreen() {
    shouldRefreshScreen.toggle();
  }

  @override
  void onInit() {
    super.onInit();
    getNotifications(offsetCount);
    refreshUnreadCount();
    _autoRefreshTimer?.cancel();
    _autoRefreshTimer = Timer.periodic(const Duration(seconds: 45), (_) {
      refreshUnreadCount();
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (isLoading.isFalse && !isNoMoreData) {
          getNotifications(offsetCount);
        }
      }
    });
  }

  @override
  void onClose() {
    _autoRefreshTimer?.cancel();
    scrollController.dispose();
    super.onClose();
  }

  /// Called when the notification list screen is shown: load + mark read.
  Future<void> onNotificationScreenOpened() async {
    _isScreenOpen = true;
    await getNotifications(0);
    await markAllAsRead();
  }

  void onNotificationScreenClosed() {
    _isScreenOpen = false;
  }

  Future<void> getNotifications(num offset) async {
    if (offset == 0) {
      offsetCount = 0;
      isNoMoreData = false;
      notificationListData.clear();
    }

    isLoading(true);
    try {
      final isLogin = await SharedPreferencesHelper.getIsLogin();
      if (!isLogin) {
        unreadCount.value = 0;
        isSuccess(false);
        return;
      }

      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getNotification, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        "offset": offset
      });

      if (response.statusCode == 200) {
        notificationModel = NotificationModel.fromJson(response.data);
        if (notificationModel.status == AppConstants.success) {
          offsetCount = notificationModel.offset!;

          for (var element in (notificationModel.data ?? [])) {
            notificationListData.add(element);
          }
          if (notificationListData.isNotEmpty) {
            isSuccess(true);
          }
          await _applyLocalReadOverlay();
          await _recalculateUnreadFrom(notificationListData);
          if (_isScreenOpen) {
            await markAllAsRead();
          }
        } else {
          if (offset == 0) {
            isSuccess(false);
            unreadCount.value = 0;
          }
          isNoMoreData = true;
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isSuccess(false);
      AppLogger.d('OnExceptionAll==> ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  /// Lightweight badge refresh (does not wipe the open list).
  Future<void> refreshUnreadCount() async {
    try {
      final isLogin = await SharedPreferencesHelper.getIsLogin();
      if (!isLogin) {
        unreadCount.value = 0;
        return;
      }

      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);
      if (apiKey == null ||
          apiKey == '***' ||
          uniId == null ||
          uniId == '***') {
        unreadCount.value = 0;
        return;
      }

      final response = await _dio.post(AppConstants.getNotification, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'offset': 0,
      });

      if (response.statusCode == 200) {
        final model = NotificationModel.fromJson(response.data);
        if (model.status == AppConstants.success) {
          final list = model.data ?? <NotificationData>[];
          await _recalculateUnreadFrom(list);
        } else {
          unreadCount.value = 0;
        }
      }
    } catch (e) {
      AppLogger.d('refreshUnreadCount ==> ${e.toString()}');
    }
  }

  Future<void> markAllAsRead() async {
    num maxId = 0;
    for (final n in notificationListData) {
      n.isRead = true;
      final id = n.id ?? 0;
      if (id > maxId) maxId = id;
    }
    if (maxId > 0) {
      await SharedPreferencesHelper.saveData(
        AppConstants.lastReadNotificationId,
        maxId.toString(),
      );
    } else {
      // Still advance watermark from a fresh fetch if list empty after deletes.
      final last = await _getLastReadId();
      if (last <= 0) {
        // no-op
      }
    }
    unreadCount.value = 0;
    notificationListData.refresh();
    refreshScreen();
  }

  Future<void> deleteAllNotifications(
      int isAllDelete, String? notificationId, int? index) async {
    try {
      String? apiKey =
          await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
          await SharedPreferencesHelper.getData(AppConstants.userUniId);

      final response = await _dio.post(AppConstants.deleteNotification, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'notification_id': notificationId,
        'is_all_delete': isAllDelete,
      });
      if (response.statusCode == 200) {
        deleteModel = SuccessModel.fromJson(response.data);
        if (deleteModel.status == AppConstants.success) {
          isDeleteSuccess(true);
          if (isAllDelete == 1) {
            Get.back();
            notificationListData.clear();
            unreadCount.value = 0;
            refreshScreen();
          } else {
            if (index != null) {
              notificationListData.removeAt(index);
              await _recalculateUnreadFrom(notificationListData);
              refreshScreen();
            }
          }
        } else {
          isDeleteSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<num> _getLastReadId() async {
    final raw = await SharedPreferencesHelper.getData(
        AppConstants.lastReadNotificationId);
    if (raw == null || raw == '***' || raw.isEmpty) return 0;
    return num.tryParse(raw) ?? 0;
  }

  Future<void> _applyLocalReadOverlay() async {
    final lastRead = await _getLastReadId();
    if (lastRead <= 0) return;
    for (final n in notificationListData) {
      final id = n.id ?? 0;
      if (id > 0 && id <= lastRead) {
        n.isRead = true;
      }
    }
    notificationListData.refresh();
  }

  Future<void> _recalculateUnreadFrom(List<NotificationData> list) async {
    final lastRead = await _getLastReadId();
    int count = 0;
    for (final n in list) {
      final id = n.id ?? 0;
      final readByApi = n.isRead == true;
      final readByLocal = lastRead > 0 && id > 0 && id <= lastRead;
      if (!readByApi && !readByLocal) {
        count++;
      }
    }
    unreadCount.value = count;
  }
}
