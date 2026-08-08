/// Firebase Messaging + Awesome Notifications: display only.
///
/// All [Get.toNamed] calls live in [NotificationRouter]. This service registers
/// FCM streams, the background isolate entrypoint, and Awesome [setListeners].
import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../firebase_options.dart';
import '../utill/color_resources.dart';
import '../view/screen/splash/controller/config_controller.dart';
import '../view/screen/assistant_chat/assistant_chat_delivery_helper.dart';
import 'notification_router.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
// --- Firebase background isolate (must be top-level) -------------------------

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AppLogger.d('[NotificationService] background isolate message: ${message.data}');
  await NotificationService.showNotification(message);
}

// --- Awesome foreground action (must be top-level for plugin) ---------------

@pragma('vm:entry-point')
Future<void> awesomeNotificationsActionHandler(
    ReceivedAction receivedAction) async {
  AppLogger.d('[NotificationService] onActionReceived: ${receivedAction.payload} btn=${receivedAction.buttonKeyPressed}');
  await NotificationRouter.handleAwesomeAction(receivedAction);
}

/// Receives FCM, displays local notifications via Awesome Notifications,
/// and registers listeners. Navigation is delegated to [NotificationRouter].
class NotificationService {
  factory NotificationService() => _instance;
  NotificationService._internal();
  static final NotificationService _instance = NotificationService._internal();

  static bool _awesomeListenersRegistered = false;
  static bool _firebaseConfigured = false;

  /// Maps FCM data values to string payload for Awesome (required for taps).
  static Map<String, String> fcmDataToPayloadMap(Map<String, dynamic> data) {
    final out = <String, String>{};
    for (final e in data.entries) {
      out[e.key] = e.value?.toString() ?? '';
    }
    return out;
  }

  /// Single entry: show/update local notification from FCM (foreground + background).
  static Future<void> showNotification(RemoteMessage message) async {
    final data = message.data;
    final payloadMap = fcmDataToPayloadMap(data);
    final type = notificationTypeFromString(payloadMap['type']);

    AppLogger.d('[NotificationService] showNotification type=$type id=${message.messageId} data=$data');

    switch (type) {
      case NotificationType.cancel:
        final id = int.tryParse(payloadMap['notification_id'] ?? '') ?? -1;
        _instance.cancelNotification(id);
        return;
      case NotificationType.message:
        await AssistantChatDeliveryHelper.markDeliveredFromFcmData(data);
        await _instance._showMessageNotification(message, payloadMap);
        return;
      case NotificationType.chat:
      case NotificationType.video:
      case NotificationType.call:
      case NotificationType.serviceVideo:
      case NotificationType.architectServiceVideo:
      case NotificationType.architectServiceOrder:
        final nid =
            int.tryParse(payloadMap['notification_id'] ?? '') ?? -1;
        final t = (payloadMap['title'] ?? '').isNotEmpty
            ? payloadMap['title']
            : message.notification?.title;
        final b = (payloadMap['body'] ?? '').isNotEmpty
            ? payloadMap['body']
            : message.notification?.body;
        await _instance._showIncomingStyle(
          notificationId: nid,
          title: t,
          body: b,
          type: type,
          payloadMap: payloadMap,
        );
        return;
      case NotificationType.android:
        final nid =
            int.tryParse(payloadMap['notification_id'] ?? '') ?? -1;
        final t = (payloadMap['title'] ?? '').isNotEmpty
            ? payloadMap['title']
            : message.notification?.title;
        final b = (payloadMap['body'] ?? '').isNotEmpty
            ? payloadMap['body']
            : message.notification?.body;
        await _instance._showAndroidStyle(
          notificationId: nid,
          title: t,
          body: b,
          image: payloadMap['image'] ?? '',
          logo: payloadMap['logo'] ?? '',
          payloadMap: payloadMap,
        );
        return;
      case NotificationType.alert:
      case NotificationType.unknown:
        final nid =
            int.tryParse(payloadMap['notification_id'] ?? '') ?? -1;
        final t = (payloadMap['title'] ?? '').isNotEmpty
            ? payloadMap['title']
            : message.notification?.title;
        final b = (payloadMap['body'] ?? '').isNotEmpty
            ? payloadMap['body']
            : message.notification?.body;
        await _instance._showDefaultAlert(
          notificationId: nid,
          title: t,
          body: b,
          payloadMap: payloadMap,
        );
        return;
    }
  }

  /// One-time FCM + Awesome wiring (call from [main] after Firebase init).
  Future<void> configureFirebaseMessaging() async {
    if (_firebaseConfigured) {
      AppLogger.d('[NotificationService] configureFirebaseMessaging: skipped');
      return;
    }
    _firebaseConfigured = true;

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    _ensureAwesomeListenersRegistered();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      AppLogger.d('[NotificationService] onMessage: ${message.data}');
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      AppLogger.d('[NotificationService] onMessageOpenedApp: ${message.data}');
      NotificationRouter.onMessageOpenedApp(message);
    });

    final initial = await FirebaseMessaging.instance.getInitialMessage();
    if (initial != null) {
      NotificationRouter.queuePendingRemote(initial);
    }
  }

  static void _ensureAwesomeListenersRegistered() {
    if (_awesomeListenersRegistered) return;
    _awesomeListenersRegistered = true;
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: awesomeNotificationsActionHandler,
    );
    AppLogger.d('[NotificationService] Awesome setListeners registered');
  }

  Future<void> _showMessageNotification(
    RemoteMessage message,
    Map<String, String> payloadMap,
  ) async {
    if (Get.isRegistered<ConfigController>()) {
      final configController = Get.find<ConfigController>();
      if (configController.currentScreen.value == AppConstants.chat) {
        AppLogger.d('[NotificationService] skip message notif — on chat');
        return;
      }
    }

    final title = (payloadMap['title'] ?? '').isNotEmpty
        ? payloadMap['title']
        : message.notification?.title;
    final body = (payloadMap['body'] ?? '').isNotEmpty
        ? payloadMap['body']
        : message.notification?.body;
    final image = payloadMap['image'] ?? '';
    final logo = payloadMap['logo'] ?? '';
    final url = payloadMap['url'] ?? '';
    var notificationId =
        int.tryParse(payloadMap['notification_id'] ?? '') ?? -1;
    if (AssistantChatDeliveryHelper.isAssistantFcmPayload(
        Map<String, dynamic>.from(payloadMap))) {
      notificationId = AssistantChatDeliveryHelper.awesomeDisplayIdForMessage(
        Map<String, dynamic>.from(payloadMap),
        fcmMessageId: message.messageId,
      );
      AppLogger.d('[NotificationService] assistant_chat displayId=$notificationId '
          'backend_nid=${payloadMap['notification_id']}',);
    }

    final payload = <String, String>{...payloadMap, 'url': url};

    if (image.isNotEmpty) {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: notificationId,
          channelKey: 'alert_channel',
          icon: 'resource://drawable/ic_notification',
          color: ColorResources.colorPrimary,
          title: title,
          body: body,
          backgroundColor: ColorResources.colorPrimary,
          largeIcon: logo,
          bigPicture: image,
          notificationLayout: NotificationLayout.BigPicture,
          payload: payload,
        ),
      );
    } else {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: notificationId,
          channelKey: 'alert_channel',
          icon: 'resource://drawable/ic_notification',
          color: ColorResources.colorPrimary,
          title: title,
          body: body,
          backgroundColor: ColorResources.colorPrimary,
          largeIcon: logo,
          payload: payload,
        ),
      );
    }
    _ensureAwesomeListenersRegistered();
  }

  Future<void> _showIncomingStyle({
    required int notificationId,
    required String? title,
    required String? body,
    required NotificationType type,
    required Map<String, String> payloadMap,
  }) async {
    cancelAllNotifications();
    final buttons = _incomingActionButtons(type);
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId,
        channelKey: 'chat_channel',
        title: title,
        body: body,
        icon: 'resource://drawable/ic_notification',
        showWhen: true,
        wakeUpScreen: true,
        fullScreenIntent: true,
        criticalAlert: true,
        autoDismissible: true,
        color: ColorResources.colorPrimary,
        chronometer: Duration.zero,
        timeoutAfter: const Duration(seconds: 180),
        backgroundColor: ColorResources.colorPrimary,
        notificationLayout: NotificationLayout.Default,
        category: NotificationCategory.Call,
        locked: true,
        displayOnBackground: true,
        displayOnForeground: true,
        playState: NotificationPlayState.playing,
        payload: payloadMap,
      ),
      actionButtons: buttons,
    );
    _ensureAwesomeListenersRegistered();
  }

  List<NotificationActionButton> _incomingActionButtons(NotificationType type) {
    switch (type) {
      case NotificationType.chat:
        return [
          NotificationActionButton(
            key: 'ACCEPT',
            label: 'Accept Chat',
            color: ColorResources.green,
            autoDismissible: true,
          ),
          NotificationActionButton(
            key: 'REJECT',
            label: 'Reject Chat',
            color: ColorResources.red,
            autoDismissible: true,
          ),
        ];
      case NotificationType.video:
        return [
          NotificationActionButton(
            key: 'ACCEPT',
            label: 'Accept Video',
            color: ColorResources.green,
            autoDismissible: true,
          ),
          NotificationActionButton(
            key: 'REJECT',
            label: 'Reject Video',
            color: ColorResources.red,
            autoDismissible: true,
          ),
        ];
      case NotificationType.call:
        return [
          NotificationActionButton(
            key: 'ACCEPT',
            label: 'Accept Call',
            color: ColorResources.green,
            autoDismissible: true,
          ),
          NotificationActionButton(
            key: 'REJECT',
            label: 'Reject Call',
            color: ColorResources.red,
            autoDismissible: true,
          ),
        ];
      case NotificationType.serviceVideo:
        return [
          NotificationActionButton(
            key: 'ACCEPT SERVICE',
            label: 'Accept Video',
            color: ColorResources.green,
            autoDismissible: true,
          ),
          NotificationActionButton(
            key: 'REJECT SERVICE',
            label: 'Reject Video',
            color: ColorResources.red,
            autoDismissible: true,
          ),
        ];
      case NotificationType.architectServiceVideo:
        return [
          NotificationActionButton(
            key: 'ACCEPT ARCHITECT',
            label: 'Accept Video',
            color: ColorResources.green,
            autoDismissible: true,
          ),
          NotificationActionButton(
            key: 'REJECT ARCHITECT',
            label: 'Reject Video',
            color: ColorResources.red,
            autoDismissible: true,
          ),
        ];
      case NotificationType.architectServiceOrder:
        return [
          NotificationActionButton(
            key: 'ACCEPT ARCHITECT',
            label: 'JOIN',
            color: ColorResources.green,
            autoDismissible: true,
          ),
        ];
      default:
        return [];
    }
  }

  Future<void> _showAndroidStyle({
    required int notificationId,
    required String? title,
    required String? body,
    required String image,
    required String logo,
    required Map<String, String> payloadMap,
  }) async {
    if (image.isNotEmpty) {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: notificationId,
          channelKey: 'alert_channel',
          icon: 'resource://drawable/ic_notification',
          color: ColorResources.colorPrimary,
          title: title,
          body: body,
          backgroundColor: ColorResources.colorPrimary,
          largeIcon: logo,
          bigPicture: image,
          notificationLayout: NotificationLayout.BigPicture,
          payload: payloadMap,
        ),
      );
    } else {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: notificationId,
          channelKey: 'alert_channel',
          icon: 'resource://drawable/ic_notification',
          color: ColorResources.colorPrimary,
          title: title,
          body: body,
          backgroundColor: ColorResources.colorPrimary,
          largeIcon: logo,
          payload: payloadMap,
        ),
      );
    }
    _ensureAwesomeListenersRegistered();
  }

  Future<void> _showDefaultAlert({
    required int notificationId,
    required String? title,
    required String? body,
    required Map<String, String> payloadMap,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId,
        channelKey: 'alert_channel',
        icon: 'resource://drawable/ic_notification',
        color: ColorResources.colorPrimary,
        title: title,
        body: body,
        backgroundColor: ColorResources.colorPrimary,
        payload: payloadMap,
      ),
    );
    _ensureAwesomeListenersRegistered();
  }

  void cancelAllNotifications() {
    AwesomeNotifications().cancelAll();
  }

  void cancelNotification(int id) {
    AwesomeNotifications().cancel(id);
  }
}
