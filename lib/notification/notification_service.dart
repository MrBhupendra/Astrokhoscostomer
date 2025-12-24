import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../firebase_options.dart';
import '../utill/color_resources.dart';
import '../view/screen/splash/controller/config_controller.dart';

class NotificationService{

  @pragma('vm:entry-point')
  Future<void> configureFirebaseMessaging() async {
    FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: true,
        provisional: false,
        sound: true);

    // Handle the received message when the app is in background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle the received message when the app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("main notification (onMessage) Data-> ${message.data.toString()}");

      String? title;
      String? body;
      String type = "alert";
      String image = '';
      String logo = '';
      int notificationId = -1;
      if (message.data.isNotEmpty) {
        //PayloadData
        title = message.data['title'];
        body = message.data['body'];
        type = message.data['type'];
        image = message.data['image'];
        logo = message.data['logo'];
        notificationId = int.parse(message.data['notification_id']);
      } else {
        title = message.notification?.title;
        body = message.notification?.body;
      }

      if (type == "chat") {
        cancelAllNotifications();
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: notificationId,
                channelKey: "chat_channel",
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
                playState: NotificationPlayState.playing),
            actionButtons: [
              NotificationActionButton(
                  key: "ACCEPT",
                  label: "Accept Chat",
                  color: ColorResources.green,
                  autoDismissible: true),
              NotificationActionButton(
                  key: "REJECT",
                  label: "Reject Chat",
                  color: ColorResources.red,
                  autoDismissible: true),
            ]);
        startListeningNotificationEvents();
      }

      else if (type == "video") {
        cancelAllNotifications();
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: notificationId,
                channelKey: "chat_channel",
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
                playState: NotificationPlayState.playing),
            actionButtons: [
              NotificationActionButton(
                  key: "ACCEPT",
                  label: "Accept Video",
                  color: ColorResources.green,
                  autoDismissible: true),
              NotificationActionButton(
                  key: "REJECT",
                  label: "Reject Video",
                  color: ColorResources.red,
                  autoDismissible: true),
            ]);
        startListeningNotificationEvents();
      } else if (type == "call") {
        cancelAllNotifications();
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: notificationId,
                channelKey: "chat_channel",
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
                playState: NotificationPlayState.playing),
            actionButtons: [
              NotificationActionButton(
                  key: "ACCEPT",
                  label: "Accept Call",
                  color: ColorResources.green,
                  autoDismissible: true),
              NotificationActionButton(
                  key: "REJECT",
                  label: "Reject Call",
                  color: ColorResources.red,
                  autoDismissible: true),
            ]);
        startListeningNotificationEvents();
      } else if (type == "service_video") {
        cancelAllNotifications();
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: notificationId,
                channelKey: "chat_channel",
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
                playState: NotificationPlayState.playing),
            actionButtons: [
              NotificationActionButton(
                  key: "ACCEPT SERVICE",
                  label: "Accept Video",
                  color: ColorResources.green,
                  autoDismissible: true),
              NotificationActionButton(
                  key: "REJECT SERVICE",
                  label: "Reject Video",
                  color: ColorResources.red,
                  autoDismissible: true),
            ]);
        startListeningNotificationEvents();
      } else if (type == "architect_service_video") {
        cancelAllNotifications();
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: notificationId,
                channelKey: "chat_channel",
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
                playState: NotificationPlayState.playing),
            actionButtons: [
              NotificationActionButton(
                  key: "ACCEPT ARCHITECT",
                  label: "Accept Video",
                  color: ColorResources.green,
                  autoDismissible: true),
              NotificationActionButton(
                  key: "REJECT ARCHITECT",
                  label: "Reject Video",
                  color: ColorResources.red,
                  autoDismissible: true),
            ]);
        startListeningNotificationEvents();
      } else if (type == "architect_service_order") {
        cancelAllNotifications();
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: notificationId,
                channelKey: "chat_channel",
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
                playState: NotificationPlayState.playing),
            actionButtons: [
              NotificationActionButton(
                  key: "ACCEPT ARCHITECT",
                  label: "JOIN",
                  color: ColorResources.green,
                  autoDismissible: true),
            ]);
        startListeningNotificationEvents();
      } else if (type == "android") {
        if (image.isNotEmpty) {
          AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: notificationId,
                channelKey: "alert_channel",
                icon: 'resource://drawable/ic_notification',
                color: ColorResources.colorPrimary,
                title: title,
                body: body,
                backgroundColor: ColorResources.colorPrimary,
                largeIcon: logo,
                bigPicture: image,
                notificationLayout: NotificationLayout.BigPicture,
              ));
        } else {
          AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: notificationId,
                channelKey: "alert_channel",
                icon: 'resource://drawable/ic_notification',
                color: ColorResources.colorPrimary,
                title: title,
                body: body,
                backgroundColor: ColorResources.colorPrimary,
                largeIcon: logo,
              ));
        }
      } else if (type == "cancel") {
        cancelNotification(notificationId);
      } else {
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: notificationId,
                channelKey: "alert_channel",
                icon: 'resource://drawable/ic_notification',
                color: ColorResources.colorPrimary,
                title: title,
                body: body,
                backgroundColor: ColorResources.colorPrimary));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("main notification (onMessageOpenedApp) Data-> ${message.data.toString()}");
      String type = "alert";
      if (message.data.isNotEmpty) {
        type = message.data['type'];
      }
      if (type == "chat") {
        Get.toNamed('/queue_list');
      } else if (type == "video") {
        Get.toNamed('/queue_list');
      } else if (type == "call") {
        Get.toNamed('/queue_list');
      } else if (type == "service_video") {
        Get.toNamed('/orders_tab_screen', arguments: {'index': 2});
      } else if (type == "architect_service_video") {
        Get.toNamed("/architect_orders_tab_screen");
      } else {
        Get.toNamed('/dashboard');
      }
    });
  }

  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint("main notification (onBackgroundMessage) Data-> ${message.data.toString()}");
    String? title;
    String? body;
    String type = "alert";
    String image = '';
    String logo = '';
    int notificationId = -1;
    if (message.data.isNotEmpty) {
      //PayloadData
      title = message.data['title'];
      body = message.data['body'];
      type = message.data['type'];
      image = message.data['image'];
      logo = message.data['logo'];
      notificationId = int.parse(message.data['notification_id']);
    } else {
      title = message.notification?.title;
      body = message.notification?.body;
    }

    if (type == "chat") {
      cancelAllNotifications();
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: notificationId,
              channelKey: "chat_channel",
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
              playState: NotificationPlayState.playing),
          actionButtons: [
            NotificationActionButton(
                key: "ACCEPT",
                label: "Accept Chat",
                color: ColorResources.green,
                autoDismissible: true),
            NotificationActionButton(
                key: "REJECT",
                label: "Reject Chat",
                color: ColorResources.red,
                autoDismissible: true),
          ]);
      startListeningNotificationEvents();
    } else if (type == "video") {
      cancelAllNotifications();
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: notificationId,
              channelKey: "chat_channel",
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
              playState: NotificationPlayState.playing),
          actionButtons: [
            NotificationActionButton(
                key: "ACCEPT",
                label: "Accept Video",
                color: ColorResources.green,
                autoDismissible: true),
            NotificationActionButton(
                key: "REJECT",
                label: "Reject Video",
                color: ColorResources.red,
                autoDismissible: true),
          ]);
      startListeningNotificationEvents();
    } else if (type == "call") {
      cancelAllNotifications();
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: notificationId,
              channelKey: "chat_channel",
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
              playState: NotificationPlayState.playing),
          actionButtons: [
            NotificationActionButton(
                key: "ACCEPT",
                label: "Accept Call",
                color: ColorResources.green,
                autoDismissible: true),
            NotificationActionButton(
                key: "REJECT",
                label: "Reject Call",
                color: ColorResources.red,
                autoDismissible: true),
          ]);
      startListeningNotificationEvents();
    } else if (type == "service_video") {
      cancelAllNotifications();
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: notificationId,
              channelKey: "chat_channel",
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
              playState: NotificationPlayState.playing),
          actionButtons: [
            NotificationActionButton(
                key: "ACCEPT SERVICE",
                label: "Accept Video",
                color: ColorResources.green,
                autoDismissible: true),
            NotificationActionButton(
                key: "REJECT SERVICE",
                label: "Reject Video",
                color: ColorResources.red,
                autoDismissible: true),
          ]);
      startListeningNotificationEvents();
    } else if (type == "architect_service_video") {
      cancelAllNotifications();
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: notificationId,
              channelKey: "chat_channel",
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
              playState: NotificationPlayState.playing),
          actionButtons: [
            NotificationActionButton(
                key: "ACCEPT ARCHITECT",
                label: "Accept Video",
                color: ColorResources.green,
                autoDismissible: true),
            NotificationActionButton(
                key: "REJECT ARCHITECT",
                label: "Reject Video",
                color: ColorResources.red,
                autoDismissible: true),
          ]);
      startListeningNotificationEvents();
    } else if (type == "architect_service_order") {
      cancelAllNotifications();
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: notificationId,
              channelKey: "chat_channel",
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
              playState: NotificationPlayState.playing),
          actionButtons: [
            NotificationActionButton(
                key: "ACCEPT ARCHITECT",
                label: "JOIN",
                color: ColorResources.green,
                autoDismissible: true),
          ]);
      startListeningNotificationEvents();
    } else if (type == "android") {
      if (image.isNotEmpty) {
        AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: notificationId,
              channelKey: "alert_channel",
              icon: 'resource://drawable/ic_notification',
              color: ColorResources.colorPrimary,
              title: title,
              body: body,
              backgroundColor: ColorResources.colorPrimary,
              largeIcon: logo,
              bigPicture: image,
              notificationLayout: NotificationLayout.BigPicture,
            ));
      } else {
        AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: notificationId,
              channelKey: "alert_channel",
              icon: 'resource://drawable/ic_notification',
              color: ColorResources.colorPrimary,
              title: title,
              body: body,
              backgroundColor: ColorResources.colorPrimary,
              largeIcon: logo,
            ));
      }
    } else if (type == "cancel") {
      cancelNotification(notificationId);
    } else {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: notificationId,
              channelKey: "alert_channel",
              icon: 'resource://drawable/ic_notification',
              color: ColorResources.colorPrimary,
              title: title,
              body: body,
              backgroundColor: ColorResources.colorPrimary));
    }
  }

  Future<void> startListeningNotificationEvents() async {
    debugPrint('main notification (startListeningNotificationEvents)');
    AwesomeNotifications().setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }

  @pragma('vm:entry-point')
  Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    debugPrint('main notification (onActionReceivedMethod) $receivedAction');
    return onActionReceivedImplementationMethod(receivedAction);
  }

  Future<void> onActionReceivedImplementationMethod(ReceivedAction receivedAction) async {
    debugPrint('main notification (onActionReceivedImplementationMethod) $receivedAction');
    if (receivedAction.buttonKeyPressed == "ACCEPT") {
      Get.toNamed('/queue_list');
    } else if (receivedAction.buttonKeyPressed == "REJECT") {
      Get.toNamed('/queue_list');
    } else if (receivedAction.buttonKeyPressed == "ACCEPT SERVICE") {
      Get.toNamed('/orders_tab_screen', arguments: {'index': 2});
    } else if (receivedAction.buttonKeyPressed == "REJECT SERVICE") {
      Get.toNamed('/orders_tab_screen', arguments: {'index': 2});
    } else if (receivedAction.buttonKeyPressed == "ACCEPT ARCHITECT") {
      Get.toNamed("/architect_orders_tab_screen");
    } else if (receivedAction.buttonKeyPressed == "REJECT ARCHITECT") {
      Get.toNamed("/architect_orders_tab_screen");
    } else {
      Get.toNamed('/dashboard');
    }
  }

  void cancelAllNotifications() {
    AwesomeNotifications().cancelAll();
  }

  void cancelNotification(int id) {
    AwesomeNotifications().cancel(id);
  }

  void showMessageNotification(RemoteMessage message){
    ConfigController configController = Get.put(ConfigController());
    if(configController.currentScreen.value != AppConstants.chat){
      String? title;
      String? body;
      String type = "message";
      String image = '';
      String logo = '';
      String url = '';
      int notificationId = -1;
      if (message.data.isNotEmpty) {
        //PayloadData
        title = message.data['title'];
        body = message.data['body'];
        type = message.data['type'];
        image = message.data['image'];
        logo = message.data['logo'];
        url = message.data['url'];
        notificationId = int.parse(message.data['notification_id']);
      } else {
        title = message.notification?.title;
        body = message.notification?.body;
      }

      if (image.isNotEmpty) {
        AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: notificationId,
              channelKey: "alert_channel",
              icon: 'resource://drawable/ic_notification',
              color: ColorResources.colorPrimary,
              title: title,
              body: body,
              backgroundColor: ColorResources.colorPrimary,
              largeIcon: logo,
              bigPicture: image,
              notificationLayout: NotificationLayout.BigPicture,
              payload: {'url': url},
            ));
      } else {
        AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: notificationId,
              channelKey: "alert_channel",
              icon: 'resource://drawable/ic_notification',
              color: ColorResources.colorPrimary,
              title: title,
              body: body,
              backgroundColor: ColorResources.colorPrimary,
              largeIcon: logo,
              payload: {'url': url},
            ));
      }
    }
  }
}