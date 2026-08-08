/// Centralized navigation for push / local notification payloads.
///
/// Use [routeFromRemoteMessage] for FCM taps, [handleAwesomeAction] for
/// Awesome Notifications (body tap + action buttons). Deep links use
/// [navigateFromDeepLink]. Duplicate navigations are suppressed via dedupe keys.
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../utill/app_constants.dart';
import '../view/screen/chat/controller/chat_intake_form_controller.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
/// High-level categories sent in FCM / Awesome [payload]['type'].
enum NotificationType {
  unknown,
  alert,
  chat,
  video,
  call,
  serviceVideo,
  architectServiceVideo,
  architectServiceOrder,
  android,
  cancel,
  message,
}

/// Parses backend type strings safely (case-insensitive).
NotificationType notificationTypeFromString(String? raw) {
  if (raw == null || raw.trim().isEmpty) return NotificationType.unknown;
  switch (raw.trim().toLowerCase()) {
    case 'alert':
      return NotificationType.alert;
    case 'chat':
      return NotificationType.chat;
    case 'video':
      return NotificationType.video;
    case 'call':
      return NotificationType.call;
    case 'service_video':
      return NotificationType.serviceVideo;
    case 'architect_service_video':
      return NotificationType.architectServiceVideo;
    case 'architect_service_order':
      return NotificationType.architectServiceOrder;
    case 'android':
      return NotificationType.android;
    case 'cancel':
      return NotificationType.cancel;
    case 'message':
      return NotificationType.message;
    default:
      return NotificationType.unknown;
  }
}

/// Normalized payload for routing (all values optional strings).
class NotificationPayload {
  NotificationPayload({
    required this.type,
    required this.raw,
  });

  final NotificationType type;
  final Map<String, String> raw;

  String? get chatId => _nonEmpty(raw['chat_id']);
  String? get userId => _nonEmpty(raw['user_id']);
  String? get orderId => _nonEmpty(raw['order_id']);
  String? get url => _nonEmpty(raw['url']);
  String? get notificationId => _nonEmpty(raw['notification_id']);

  /// Prefer stable id from payload; fallback for deduplication.
  String dedupeKeyForFcm(RemoteMessage? message) {
    // Backend sometimes reuses notification_id (e.g. "75") for many messages.
    // Include FCM messageId/body so each tap can navigate.
    final mid = (message?.messageId ?? '').trim();
    final body = (raw['body'] ?? '').trim();
    if (notificationId != null) {
      if (mid.isNotEmpty) return 'nid:$notificationId|mid:$mid';
      if (body.isNotEmpty) return 'nid:$notificationId|b:${body.hashCode}';
      return 'nid:$notificationId';
    }
    if (mid.isNotEmpty) return 'mid:$mid';
    return 't:${type.name}:${chatId ?? userId ?? orderId ?? url ?? ""}|b:${body.hashCode}';
  }

  String dedupeKeyForAwesome(ReceivedAction action) {
    // Some backends reuse notification_id, and Awesome may surface it as action.id.
    // Include body hash so each new message can navigate.
    final body = (raw['body'] ?? '').trim();
    if (action.id != null) {
      if (body.isNotEmpty) return 'aid:${action.id}|b:${body.hashCode}';
      return 'aid:${action.id}';
    }
    if (notificationId != null) {
      if (body.isNotEmpty) return 'nid:$notificationId|b:${body.hashCode}';
      return 'nid:$notificationId';
    }
    return 'abtn:${action.buttonKeyPressed}:${action.payload?.toString() ?? ""}';
  }

  Map<String, dynamic> toGetArguments() {
    final m = <String, dynamic>{};
    if (chatId != null) m['chat_id'] = chatId;
    if (userId != null) m['user_id'] = userId;
    if (orderId != null) m['order_id'] = orderId;
    if (url != null) m['url'] = url;
    return m;
  }

  static NotificationPayload fromFcmData(Map<String, dynamic> data) {
    final strings = <String, String>{};
    for (final e in data.entries) {
      strings[e.key] = e.value?.toString() ?? '';
    }
    return NotificationPayload(
      type: notificationTypeFromString(strings['type']),
      raw: strings,
    );
  }

  static NotificationPayload? fromAwesomePayload(
      Map<String, String?>? payload) {
    if (payload == null || payload.isEmpty) return null;
    final strings = <String, String>{};
    for (final e in payload.entries) {
      if (e.value != null && e.value!.isNotEmpty) {
        strings[e.key] = e.value!;
      }
    }
    if (strings.isEmpty) return null;
    return NotificationPayload(
      type: notificationTypeFromString(strings['type']),
      raw: strings,
    );
  }

  static String? _nonEmpty(String? s) {
    if (s == null || s.trim().isEmpty) return null;
    return s.trim();
  }
}

/// Single place for GetX navigation driven by notification payloads.
class NotificationRouter {
  NotificationRouter._();

  static String? _lastDedupeKey;

  static void _log(String message) {
    AppLogger.d('[NotificationRouter] $message');
  }

  /// Clears dedupe state (e.g. tests); not required in production.
  @visibleForTesting
  static void resetDedupeForTests() => _lastDedupeKey = null;

  static bool _shouldNavigate(String dedupeKey) {
    if (_lastDedupeKey == dedupeKey) {
      _log('Deduped navigation (same key): $dedupeKey');
      return false;
    }
    _lastDedupeKey = dedupeKey;
    return true;
  }

  /// After resume from background / killed, [Get] navigator may not be ready
  /// immediately; navigating synchronously can no-op. Retry a few times.
  static void _runAfterNavigatorReady(void Function() action) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Try up to ~2s total.
      for (int i = 0; i < 10; i++) {
        await Future<void>.delayed(const Duration(milliseconds: 200));
        if (Get.key.currentState != null) {
          try {
            action();
          } catch (e, st) {
            _log('nav error: $e\n$st');
          }
          return;
        }
      }
      _log('nav skipped: navigator not ready');
    });
  }

  static RemoteMessage? _pendingRemote;
  static ReceivedAction? _pendingAwesome;
  static bool _coldStartFlushDone = false;

  static bool get hasPendingColdStartNavigation =>
      _pendingRemote != null || _pendingAwesome != null;

  static void queuePendingRemote(RemoteMessage? message) {
    if (message == null) return;
    _pendingRemote = message;
    _log('Queued cold-start RemoteMessage: ${message.data}');
  }

  static void queuePendingAwesome(ReceivedAction? action) {
    if (action == null) return;
    _pendingAwesome = action;
    _log('Queued cold-start Awesome action id=${action.id}');
  }

  /// Call once the app shell is ready (e.g. [HomeController.onInit]).
  static Future<void> flushColdStartQueue() async {
    if (_coldStartFlushDone) return;

    try {
      final remote = _pendingRemote;
      _pendingRemote = null;
      if (remote != null) {
        _log('Flushing cold-start FCM message');
        routeFromRemoteMessage(remote);
      }

      final awesome = _pendingAwesome;
      _pendingAwesome = null;
      if (awesome != null) {
        _log('Flushing cold-start Awesome action');
        await handleAwesomeAction(awesome);
      }
    } catch (e, st) {
      _log('flushColdStartQueue error: $e\n$st');
    } finally {
      _coldStartFlushDone = true;
    }
  }

  /// FCM: user opened app from background/terminated via system UI.
  static void routeFromRemoteMessage(RemoteMessage message) {
    final payload = NotificationPayload.fromFcmData(message.data);
    final key = payload.dedupeKeyForFcm(message);
    if (!_shouldNavigate(key)) return;
    _log('routeFromRemoteMessage type=${payload.type} data=${message.data}');
    _runAfterNavigatorReady(() => _routeByPayload(payload));
  }

  /// Register [FirebaseMessaging.onMessageOpenedApp] and pass messages here.
  static void onMessageOpenedApp(RemoteMessage message) {
    routeFromRemoteMessage(message);
  }

  static Future<void> handleAwesomeAction(ReceivedAction action) async {
    final payload = NotificationPayload.fromAwesomePayload(action.payload);
    final key = payload != null
        ? payload.dedupeKeyForAwesome(action)
        : 'awesome:${action.id}:${action.buttonKeyPressed}';
    if (!_shouldNavigate(key)) return;

    _log(
        'handleAwesomeAction lifecycle=${action.actionLifeCycle} button=${action.buttonKeyPressed} payload=${action.payload}');

    final button = action.buttonKeyPressed;
    if (button.isNotEmpty) {
      _routeByActionButton(button, payload);
      return;
    }

    // Notification body tap (no action button).
    if (payload == null) {
      _runAfterNavigatorReady(() => Get.toNamed('/notificationScreen'));
      return;
    }

    if (action.actionLifeCycle == NotificationLifeCycle.Foreground) {
      if (payload.type == NotificationType.android ||
          payload.type == NotificationType.unknown) {
        _runAfterNavigatorReady(() {
          if (_shouldRouteAndroidToSearch(payload)) {
            Get.toNamed('/search');
          } else {
            Get.toNamed('/notificationScreen');
          }
        });
        return;
      }
      if (payload.type == NotificationType.chat ||
          payload.type == NotificationType.video ||
          payload.type == NotificationType.call) {
        _runAfterNavigatorReady(() =>
            Get.toNamed('/queue_list', arguments: payload.toGetArguments()));
        return;
      }
    }

    _runAfterNavigatorReady(() => _routeByPayload(payload));
  }

  static bool _shouldRouteAndroidToSearch(NotificationPayload payload) {
    // Backend sends "android" type for generic alerts.
    // Special-case: "preferred astrologer is online/available" => go to Search.
    final title = (payload.raw['title'] ?? '').toLowerCase();
    final body = (payload.raw['body'] ?? '').toLowerCase();
    final combined = '$title $body';
    return combined.contains('preferred astrologer') &&
        (combined.contains('online') || combined.contains('available'));
  }

  /// Assistant / live chat message push: `channelName` like `ASSISTANT/CUS-ASTRO` or `CHAT/...`.
  /// Matches navigation args used from [support_channels_screen] / chat intake.
  static bool _tryNavigateFromChatMessagePayload(Map<String, String> raw) {
    final rawChannel = (raw['channelName'] ?? raw['channel_name'] ?? '').trim();
    if (rawChannel.isEmpty) return false;

    final channelSegment = rawChannel.contains('/')
        ? rawChannel.split('/').last.trim()
        : rawChannel;
    if (channelSegment.isEmpty) return false;

    final uniqueId = (raw['uniqueId'] ?? raw['unique_id'] ?? '').trim();

    if (!Get.isRegistered<ChatIntakeFormController>()) {
      Get.put(ChatIntakeFormController());
    }
    final intake = Get.find<ChatIntakeFormController>();
    intake.setAstrologerData(
      (raw['astrologerName'] ?? raw['title'] ?? '').trim(),
      (raw['astrologerImage'] ?? raw['logo'] ?? '').trim(),
      raw['astrologerUniId'] ?? '',
      AppConstants.chat,
      0,
    );

    if (rawChannel.startsWith('ASSISTANT/')) {
      Get.toNamed('/assistantChatScreen', arguments: {
        'channelName': channelSegment,
        'uniqueId': uniqueId,
      });
      _log(
          'navigate assistant chat channel=$channelSegment uniqueId=$uniqueId');
      return true;
    }
    if (rawChannel.startsWith('CHAT/')) {
      // Requested behavior: do not jump into chat directly from a message push.
      // Land on dashboard so user can open from inProgress.
      Get.toNamed('/dashboard');
      _log(
          'navigate message->dashboard channel=$channelSegment uniqueId=$uniqueId');
      return true;
    }
    return false;
  }

  static void _routeByActionButton(
      String buttonKey, NotificationPayload? payload) {
    switch (buttonKey) {
      case 'ACCEPT':
      case 'REJECT':
        Get.toNamed('/queue_list', arguments: payload?.toGetArguments() ?? {});
        break;
      case 'ACCEPT SERVICE':
      case 'REJECT SERVICE':
        Get.toNamed('/orders_tab_screen', arguments: {'index': 2});
        break;
      case 'ACCEPT ARCHITECT':
      case 'REJECT ARCHITECT':
        Get.toNamed('/architect_orders_tab_screen',
            arguments: payload?.toGetArguments() ?? {});
        break;
      default:
        if (payload != null) {
          _runAfterNavigatorReady(() => _routeByPayload(payload));
        } else {
          _runAfterNavigatorReady(() => Get.toNamed('/dashboard'));
        }
        break;
    }
  }

  static void _routeByPayload(NotificationPayload payload) {
    switch (payload.type) {
      case NotificationType.chat:
      case NotificationType.video:
      case NotificationType.call:
        Get.toNamed('/queue_list', arguments: payload.toGetArguments());
        break;
      case NotificationType.serviceVideo:
        Get.toNamed('/orders_tab_screen', arguments: {
          'index': 2,
          ...payload.toGetArguments(),
        });
        break;
      case NotificationType.architectServiceVideo:
      case NotificationType.architectServiceOrder:
        Get.toNamed('/architect_orders_tab_screen',
            arguments: payload.toGetArguments());
        break;
      case NotificationType.message:
        if (_tryNavigateFromChatMessagePayload(payload.raw)) {
          break;
        }
        final u = payload.url;
        if (u != null && u.isNotEmpty) {
          navigateFromDeepLink(u);
        } else {
          Get.toNamed('/dashboard');
        }
        break;
      case NotificationType.alert:
      case NotificationType.unknown:
        final u = payload.url;
        if (u != null && u.isNotEmpty) {
          navigateFromDeepLink(u);
        } else {
          Get.toNamed('/dashboard');
        }
        break;
      case NotificationType.android:
        if (_shouldRouteAndroidToSearch(payload)) {
          Get.toNamed('/search');
        } else {
          Get.toNamed('/notificationScreen');
        }
        break;
      case NotificationType.cancel:
        _log('cancel type — no navigation');
        break;
    }
  }

  /// Deep links embedded in `url` (products / services), same behavior as before.
  static void navigateFromDeepLink(String url) {
    if (url.isEmpty) return;
    _log('navigateFromDeepLink url=$url');
    final uri = Uri.parse(url);
    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'products') {
      if (uri.pathSegments.length == 2) {
        final productSlug = uri.pathSegments[1].toString();
        Get.toNamed('/productDetail/$productSlug');
      } else if (uri.pathSegments.length == 3) {
        final productSlug = uri.pathSegments[1].toString();
        final astrologerId = uri.pathSegments[2].toString();
        Get.toNamed('/productDetail/$productSlug/$astrologerId');
      }
    } else if (uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == 'services') {
      if (uri.pathSegments.length == 2) {
        final serviceSlug = uri.pathSegments[1].toString();
        Get.toNamed('/serviceDetail/$serviceSlug');
      } else if (uri.pathSegments.length == 3) {
        final serviceSlug = uri.pathSegments[1].toString();
        final astrologerId = uri.pathSegments[2].toString();
        Get.toNamed('/serviceDetail/$serviceSlug/$astrologerId');
      }
    } else if (uri.pathSegments.isNotEmpty &&
        uri.pathSegments.first == 'blogs') {
      if (uri.pathSegments.length == 2) {
        final blogSlug = uri.pathSegments[1].toString();
        Get.toNamed('/blogDetail/$blogSlug');
      } else {
        Get.toNamed('/blog');
      }
    }
  }
}
