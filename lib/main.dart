import 'package:astro_brahmand/view/screen/agora/live_stream/group_pooja_live_stream_screen.dart';
import 'package:astro_brahmand/view/screen/agora/live_stream/live_stream_screen.dart';
import 'package:astro_brahmand/view/screen/agora/videocall/service_video_call_screen.dart';
import 'package:astro_brahmand/view/screen/agora/videocall/video_call_screen.dart';
import 'package:astro_brahmand/view/screen/agora/voicecall/voice_call_screen.dart';
import 'package:astro_brahmand/view/screen/architect/architect_chat/architect_chat_screen.dart';
import 'package:astro_brahmand/view/screen/architect/architect_list_screen.dart';
import 'package:astro_brahmand/view/screen/architect/architect_new_old_screen.dart';
import 'package:astro_brahmand/view/screen/architect/architect_orders_tab_screen.dart';
import 'package:astro_brahmand/view/screen/architect/architect_profile_detail_screen.dart';
import 'package:astro_brahmand/view/screen/architect/architect_video/architect_video_call_screen.dart';
import 'package:astro_brahmand/view/screen/architect/binding/architect_orders_binding.dart';
import 'package:astro_brahmand/view/screen/architect/binding/architect_profile_binding.dart';
import 'package:astro_brahmand/view/screen/architect/binding/architect_screen_binding.dart';
import 'package:astro_brahmand/view/screen/ask_astrologer_question/ask_question_customer_list_screen.dart';
import 'package:astro_brahmand/view/screen/ask_astrologer_question/binding/ask_astrologer_question_binding.dart';
import 'package:astro_brahmand/view/screen/ask_question/ask_question_screen_new.dart';
import 'package:astro_brahmand/view/screen/assistant_chat/assistant_chat_screen.dart';
import 'package:astro_brahmand/view/screen/assistant_chat/support_tab_screen.dart';
import 'package:astro_brahmand/view/screen/deeplink/deeplink_service_detail.dart';
import 'package:astro_brahmand/view/screen/deeplink/deeplink_blog_detail.dart';
import 'package:astro_brahmand/view/screen/electro_homeopathy/electro_homeopathy_list.dart';
import 'package:astro_brahmand/view/screen/electro_homeopathy/electro_homeopathy_screen.dart';
import 'package:astro_brahmand/view/screen/group_pooja/binding/group_pooja_binding.dart';
import 'package:astro_brahmand/view/screen/group_pooja/group_pooja_astrologer_list_screen.dart';
import 'package:astro_brahmand/view/screen/group_pooja/group_pooja_category_list_screen.dart';
import 'package:astro_brahmand/view/screen/group_pooja/group_pooja_detail_screen.dart';
import 'package:astro_brahmand/view/screen/group_pooja/group_pooja_list_screen.dart';
import 'package:astro_brahmand/view/screen/language/binding/app_language_binding.dart';
import 'package:astro_brahmand/view/screen/maintenance/maintenance_screen.dart';
import 'package:astro_brahmand/view/screen/notification/notification_screen.dart';
import 'package:astro_brahmand/view/screen/orders/call_image_list_screen.dart';
import 'package:astro_brahmand/view/screen/remedies/remedies_screen.dart';
import 'package:astro_brahmand/view/screen/setting/setting_screen.dart';
import 'package:astro_brahmand/view/screen/slot_booking/slot_availability_screen.dart';
import 'package:astro_brahmand/view/screen/slot_booking/slot_chat/slot_chat_screen.dart';
import 'package:astro_brahmand/view/screen/slot_booking/slot_video/slot_video_call_screen.dart';
import 'package:astro_brahmand/view/screen/subscription/binding/subscription_binding.dart';
import 'package:astro_brahmand/view/screen/subscription/subscription_list_screen.dart';
import 'package:astro_brahmand/view/screen/subscription/subscription_purchase_list_screen.dart';
import 'package:astro_brahmand/view/screen/tip/tip_screen.dart';
import 'package:astro_brahmand/view/screen/update/update_screen.dart';
import 'package:astro_brahmand/view/screen/vastu/report/report_detail_screen.dart';
import 'package:astro_brahmand/view/screen/vastu/report/report_horo_submit_screen.dart';
import 'package:astro_brahmand/view/screen/vastu/report/report_list_screen.dart';
import 'package:astro_brahmand/view/screen/vastu/report/report_order_list_screen.dart';
import 'package:astro_brahmand/view/screen/vastu/vastu_compass/office_vastu_zones_screen.dart';
import 'package:astro_brahmand/view/screen/vastu/zone_compass/zonal_chart_screen.dart';
import 'package:astro_brahmand/view/screen/vastu/zone_compass/zone_32_compass_screen.dart';
import 'package:astro_brahmand/view/screen/vastu/binding/sanjeevini_binding.dart';
import 'package:astro_brahmand/view/screen/vastu/binding/switch_word_binding.dart';
import 'package:astro_brahmand/view/screen/vastu/bookPdf/book_list_screen.dart';
import 'package:astro_brahmand/view/screen/vastu/bookPdf/book_pdf_detail_screen.dart';
import 'package:astro_brahmand/view/screen/vastu/bookPdf/books_category_list_screen.dart';
import 'package:astro_brahmand/view/screen/vastu/sanjeevini/sanjeevini_detail_screen.dart';
import 'package:astro_brahmand/view/screen/vastu/sanjeevini/sanjeevini_list_screen.dart';
import 'package:astro_brahmand/view/screen/vastu/switch_word/switch_detail_screen.dart';
import 'package:astro_brahmand/view/screen/vastu/switch_word/switch_list_screen.dart';
import 'package:astro_brahmand/view/screen/vastu/vastu_compass/home_vastu_screen.dart';
import 'package:astro_brahmand/view/screen/vastu/vastu_compass/home_vastu_zone_detail.dart';
import 'package:astro_brahmand/view/screen/vastu/vastu_compass/home_vastu_zones_screen.dart';
import 'package:astro_brahmand/view/screen/mobile_numerology/screen/mobile_numerology_detail_screen.dart';
import 'package:astro_brahmand/view/screen/mobile_numerology/screen/mobile_numerology_submit_screen.dart';
import 'package:astro_brahmand/view/screen/ask_question/ask_question_profile_screen.dart';
import 'package:astro_brahmand/view/screen/ask_question/ask_question_screen.dart';
import 'package:astro_brahmand/view/screen/ask_question/binding/ask_question_binding.dart';
import 'package:astro_brahmand/view/screen/ask_question/binding/ask_question_profile_binding.dart';
import 'package:astro_brahmand/view/screen/daily_quotes/binding/daily_quote_binding.dart';
import 'package:astro_brahmand/view/screen/daily_quotes/daily_quote_screen.dart';
import 'package:astro_brahmand/view/screen/pdf_viewer/pdf_viewer_screen.dart';
import 'package:astro_brahmand/view/screen/astro_service/binding/services_binding.dart';
import 'package:astro_brahmand/view/screen/astro_service/service_astrologer_list_screen.dart';
import 'package:astro_brahmand/view/screen/astro_service/service_category_list_screen.dart';
import 'package:astro_brahmand/view/screen/astro_service/service_detail_screen.dart';
import 'package:astro_brahmand/view/screen/astro_service/service_list_screen.dart';
import 'package:astro_brahmand/view/screen/astro_shop/binding/products_binding.dart';
import 'package:astro_brahmand/view/screen/chat/binding/chat_history_binding.dart';
import 'package:astro_brahmand/view/screen/chat/chat_channel_list_screen.dart';
import 'package:astro_brahmand/view/screen/chat/chat_history_screen.dart';
import 'package:astro_brahmand/view/screen/contact_us/assistant_screen.dart';
import 'package:astro_brahmand/view/screen/deeplink/deeplink_astrologer_detail.dart';
import 'package:astro_brahmand/view/screen/deeplink/deeplink_product_detail.dart';
import 'package:astro_brahmand/view/screen/feedback/feedback_screen.dart';
import 'package:astro_brahmand/view/screen/followings/binding/following_screen_binding.dart';
import 'package:astro_brahmand/view/screen/followings/following_list_screen.dart';
import 'package:astro_brahmand/view/screen/language/app_language_screen.dart';
import 'package:astro_brahmand/utill/language_translation.dart';
import 'package:astro_brahmand/view/screen/blog/blog_detail_screen.dart';
import 'package:astro_brahmand/view/screen/chat/chat_screen.dart';
import 'package:astro_brahmand/view/screen/orders/binding/paid_service_order_binding.dart';
import 'package:astro_brahmand/view/screen/orders/live_orders_tab_screen.dart';
import 'package:astro_brahmand/view/screen/orders/paid_service_orders_tab_screen.dart';
import 'package:astro_brahmand/view/screen/orders/product_order_detail_screen.dart';
import 'package:astro_brahmand/view/screen/queue_list/binding/queue_binding.dart';
import 'package:astro_brahmand/view/screen/queue_list/queue_list_screen.dart';
import 'package:astro_brahmand/view/screen/search/search_screen.dart';
import 'package:astro_brahmand/view/screen/orders/binding/order_binding.dart';
import 'package:astro_brahmand/view/screen/orders/orders_tab_screen.dart';
import 'package:astro_brahmand/view/screen/vedic_and_jyotisham_astro/daily_tarot/daily_tarot_detail.dart';
import 'package:astro_brahmand/view/screen/vedic_and_jyotisham_astro/daily_tarot/daily_tarot_reading.dart';
import 'package:astro_brahmand/view/screen/vedic_and_jyotisham_astro/horoscope/horoscope_daily_screen.dart';
import 'package:astro_brahmand/view/screen/vedic_and_jyotisham_astro/horoscope/horoscope_monthly_screen.dart';
import 'package:astro_brahmand/view/screen/vedic_and_jyotisham_astro/horoscope/horoscope_tab_screen.dart';
import 'package:astro_brahmand/view/screen/vedic_and_jyotisham_astro/horoscope/horoscope_weekly_screen.dart';
import 'package:astro_brahmand/view/screen/vedic_and_jyotisham_astro/horoscope/horoscope_yearly_sreen.dart';
import 'package:astro_brahmand/view/screen/vedic_and_jyotisham_astro/kundli/kundli_saved_screen.dart';
import 'package:astro_brahmand/view/screen/vedic_and_jyotisham_astro/kundli/kundli_submit_screen.dart';
import 'package:astro_brahmand/view/screen/vedic_and_jyotisham_astro/kundli/kundli_tab_screen.dart';
import 'package:astro_brahmand/view/screen/vedic_and_jyotisham_astro/love_compatibility/love_compatibility_detail_screen.dart';
import 'package:astro_brahmand/view/screen/vedic_and_jyotisham_astro/love_compatibility/love_compatibility_submit_screen.dart';
import 'package:astro_brahmand/view/screen/vedic_and_jyotisham_astro/matching/matching_saved_screen.dart';
import 'package:astro_brahmand/view/screen/vedic_and_jyotisham_astro/matching/matching_submit_screen.dart';
import 'package:astro_brahmand/view/screen/vedic_and_jyotisham_astro/matching/matching_tab_screen.dart';
import 'package:astro_brahmand/view/screen/vedic_and_jyotisham_astro/numerology/numerology_detail_screen.dart';
import 'package:astro_brahmand/view/screen/vedic_and_jyotisham_astro/numerology/numerology_submit_screen.dart';
import 'package:astro_brahmand/view/screen/vedic_and_jyotisham_astro/panchang/panchang_detail_screen.dart';
import 'package:astro_brahmand/view/screen/vedic_and_jyotisham_astro/report/report_order_list_screen.dart';
import 'package:astro_brahmand/view/screen/vedic_and_jyotisham_astro/shubhmuhrat/shubhmuhrat_tab_screen.dart';
import 'package:astro_brahmand/view/screen/video_section/binding/video_binding.dart';
import 'package:astro_brahmand/view/screen/video_section/video_list_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/view/screen/astro_shop/add_address_screen.dart';
import 'package:astro_brahmand/view/screen/astro_shop/payment_summary_screen.dart';
import 'package:astro_brahmand/view/screen/astro_shop/product_detail_screen.dart';
import 'package:astro_brahmand/view/screen/astro_shop/products_category_list_screen.dart';
import 'package:astro_brahmand/view/screen/astro_shop/products_list_screen.dart';
import 'package:astro_brahmand/view/screen/astro_shop/save_address_screen.dart';
import 'package:astro_brahmand/view/screen/astrologer_detail/binding/astrologer_profile_binding.dart';
import 'package:astro_brahmand/view/screen/blog/binding/blog_binding.dart';
import 'package:astro_brahmand/view/screen/blog/blog_screen.dart';
import 'package:astro_brahmand/binding/recharge_voucher_binding.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/view/screen/dashboard/binding/dashboard_binding.dart';
import 'package:astro_brahmand/view/screen/intake_form/chat_intake_form_screen.dart';
import 'package:astro_brahmand/view/screen/login/binding/login_binding.dart';
import 'package:astro_brahmand/view/screen/login/login_screen.dart';
import 'package:astro_brahmand/view/screen/login/verify_otp_screen.dart';
import 'package:astro_brahmand/view/screen/astrologer_detail/astrologer_profile_detail_screen.dart';
import 'package:astro_brahmand/view/screen/dashboard/dashboard_screen.dart';
import 'package:astro_brahmand/view/screen/splash/binding/splash_binding.dart';
import 'package:astro_brahmand/view/screen/splash/splash_screen.dart';
import 'package:astro_brahmand/view/screen/splash/controller/config_controller.dart';
import 'package:astro_brahmand/view/screen/update_profile/binding/update_profile_binding.dart';
import 'package:astro_brahmand/view/screen/update_profile/update_profile_screen.dart';
import 'package:astro_brahmand/view/screen/wallet/wallet_screen.dart';
import 'controller/deeplink_controller.dart';
import 'firebase_options.dart';
import 'notification/notification_router.dart';
import 'notification/notification_service.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:astro_brahmand/utill/app_fonts.dart';
import 'package:astro_brahmand/utill/app_logger.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(DeepLinkController()); // Initialize deeplink controller
  // Needed for notification-driven navigation on cold start (terminated state).
  // SplashController will later populate config data; for now we just need the instance.
  if (!Get.isRegistered<ConfigController>()) {
    Get.put(ConfigController(), permanent: true);
  }

  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'chat_channel',
        channelName: 'Chat notifications',
        channelDescription: 'Chat Alert notification channel',
        channelShowBadge: true,
        importance: NotificationImportance.High,
        playSound: true,
        defaultRingtoneType: DefaultRingtoneType.Ringtone,
        enableVibration: true,
        vibrationPattern: highVibrationPattern,
        enableLights: true,
        ledColor: ColorResources.colorPrimary,
        groupAlertBehavior: GroupAlertBehavior.All,
        icon: 'resource://drawable/ic_notification',
        defaultColor: ColorResources.colorPrimary,
        locked: true,
        defaultPrivacy: NotificationPrivacy.Public,
        criticalAlerts: true,
      ),
      NotificationChannel(
          channelKey: 'alert_channel',
          channelName: 'Alert notifications',
          channelDescription: 'Alert notification channel',
          channelShowBadge: true,
          importance: NotificationImportance.Default,
          playSound: true,
          defaultRingtoneType: DefaultRingtoneType.Notification,
          enableVibration: true,
          vibrationPattern: lowVibrationPattern,
          enableLights: true,
          ledColor: ColorResources.colorPrimary,
          groupAlertBehavior: GroupAlertBehavior.Children,
          icon: 'resource://drawable/ic_notification',
          defaultColor: ColorResources.colorPrimary,
          locked: true,
          defaultPrivacy: NotificationPrivacy.Public,
          criticalAlerts: false),
    ],
  );

  // Cold-start tap on an Awesome notification (terminated state)
  NotificationRouter.queuePendingAwesome(
    await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false),
  );

  //Crashlytics
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // Set status bar style for both Android and iOS
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ColorResources.colorPrimaryDark,
      statusBarIconBrightness:
          Brightness.light, // Light icons (white) for Android
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: ColorResources.colorPrimaryDark,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  } else if (Platform.isIOS) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ColorResources.colorPrimaryDark,
      statusBarBrightness:
          Brightness.dark, // Dark style = light content (white icons) for iOS
    ));
  }
  // Register the platform color-emoji font so custom Euclid/Poppins faces
  // can fall back to real emoji glyphs (😊🙏🔥❤️🎉🌙✨).
  await AppFonts.loadEmojiFont();

  // Start UI immediately (important for first install).
  runApp(const MyApp());

  // Do not block app startup on permission dialogs; request after first frame.
  WidgetsBinding.instance.addPostFrameCallback((_) {
    requestImportantPermissions();
  });

  // Configure messaging asynchronously; navigation is handled by router.
  // Avoid delaying initial render / splash.
  // ignore: discarded_futures
  NotificationService().configureFirebaseMessaging();
  FacebookAppEvents().setAutoLogAppEventsEnabled(true);
}

Future<void> requestImportantPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.phone, // For CALL & FOREGROUND_SERVICE_PHONE_CALL
    Permission.notification, // For POST_NOTIFICATIONS (Android 13+)
    Permission.microphone,
  ].request();

  statuses.forEach((permission, status) {
    AppLogger.d('$permission: $status');
  });

  if (await Permission.phone.isDenied ||
      await Permission.notification.isDenied ||
      await Permission.microphone.isDenied) {
    AppLogger.d('Some permissions were denied. App may not function properly.');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: ColorResources.colorPrimaryDark,
        statusBarIconBrightness:
            Brightness.light, // Android: Light icons (white)
        statusBarBrightness:
            Brightness.dark, // iOS: Dark status bar style (light content)
      ),
      child: GetMaterialApp(
        locale: const Locale('en', 'IN'),
        translations: EnglishToHindiTranslationClass(),
        localeResolutionCallback: (locale, supportedLocales) {
          if (supportedLocales.contains(locale)) {
            return locale;
          } else {
            return const Locale('en', 'IN');
          }
        },
        supportedLocales: const [
          Locale('en', 'IN'),
          Locale('hi', 'IN'),
          Locale('mr', 'IN'),
          Locale('gr', 'IN'),
          Locale('te', 'IN'),
          Locale('ml', 'IN'),
          Locale('be', 'IN'),
          Locale('ta', 'IN'),
          Locale('ka', 'IN'),
        ],
        enableLog: true,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: ColorResources.colorPrimary),
          useMaterial3: true,
          fontFamily: AppFonts.euclidRegular,
          fontFamilyFallback: AppFonts.fallback,
        ),
        initialRoute: '/splash',
        getPages: [
          GetPage(
            name: '/splash',
            page: () => SplashScreen(),
            binding: SplashBinding(),
          ),
          GetPage(
            name: '/login',
            page: () => LoginScreen(),
            binding: LoginBinding(),
          ),
          GetPage(
            name: '/verifyOtp',
            page: () => const VerifyOtpScreen(),
            binding: LoginBinding(),
          ),
          GetPage(
            name: '/updateProfile',
            page: () => UpdateProfileScreen(),
            binding: UpdateProfileBinding(),
          ),
          GetPage(
            name: '/dashboard',
            page: () => DashboardScreen(),
            binding: DashboardBinding(),
          ),
          GetPage(
              name: '/astroProfile',
              page: () => AstrologerProfileScreen(),
              binding: AstrologerProfileBinding()),
          GetPage(
              name: '/wallet',
              page: () => const WalletScreen(),
              binding: RechargeVoucherBinding()),
          GetPage(
              name: '/sanjeeviniList',
              page: () => const SanjeeviniListScreen(),
              binding: SanjeeviniBinding()),
          GetPage(
            name: '/sanjeeviniDetail',
            page: () => const SanjeeviniDetailScreen(),
          ),
          GetPage(
              name: '/switchList',
              page: () => const SwitchListScreen(),
              binding: SwitchWordBinding()),
          GetPage(
            name: '/switchDetail',
            page: () => const SwitchDetailScreen(),
          ),
          GetPage(
            name: '/vastu_zones',
            page: () => const HomeVastuZonesScreen(),
          ),
          GetPage(
            name: '/vastu_zone_detail',
            page: () => HomeVastuZoneDetail("Home Entrance"),
          ),
          GetPage(
            name: '/home_vastu',
            page: () => const HomeVastuScreen(),
          ),
          GetPage(
            name: '/zonal_chart',
            page: () => const ZonalChartScreen(),
          ),
          GetPage(
            name: '/32zone_compass_screen',
            page: () => const Zone32CompassScreen(),
          ),
          GetPage(
            name: '/office_vastu',
            page: () => const OfficeVastuZonesScreen(),
          ),
          GetPage(
              name: '/daily_quote',
              page: () => const DailyQuoteScreen(),
              binding: DailyQuoteBinding()),

          //tarot
          GetPage(
            name: '/dailyTarotReading',
            page: () => dailyTarotReading(),
          ),
          GetPage(
            name: '/dailyTarotDetail',
            page: () => DailyTarotDetail(),
          ),

          GetPage(
            name: '/booksCategory',
            page: () => const BooksCategoryListScreen(),
          ),
          GetPage(
            name: '/booksList',
            page: () => const BooksListScreen(),
          ),
          GetPage(
            name: '/bookDetail',
            page: () => BookPdfDetailScreen(),
          ),
          GetPage(
              name: '/blog',
              page: () => const BlogScreen(),
              binding: BlogBinding()),
          GetPage(
            name: '/blog_detail',
            page: () => BlogDetailScreen(),
          ),
          GetPage(
              name: '/video_list',
              page: () => const VideoListScreen(),
              binding: VideoBinding()),
          GetPage(
              name: '/products_category',
              page: () => const ProductsCategoryListScreen(),
              binding: ProductsBinding()),
          GetPage(
              name: '/products',
              page: () => const ProductsListScreen(),
              binding: ProductsBinding()),
          GetPage(
            name: '/product_detail',
            page: () => const ProductDetailScreen(),
          ),
          GetPage(
            name: '/save_address',
            page: () => const SaveAddressScreen(),
          ),
          GetPage(
            name: '/add_address',
            page: () => AddAddressScreen(),
          ),
          GetPage(
            name: '/payment_summary',
            page: () => PaymentSummaryScreen(),
          ),
          GetPage(
            name: '/numerology_submit',
            page: () => NumerologySubmitScreen(),
          ),
          GetPage(
            name: '/numerology_detail',
            page: () => NumerologyDetailScreen(),
          ),

          // Horoscope
          GetPage(
            name: '/horoscopeTabScreen',
            page: () => HoroscopeTabScreen(),
          ),
          GetPage(
            name: '/horoscopeDailyScreen',
            page: () => const HoroscopeDailyScreen(),
          ),
          GetPage(
            name: '/horoscopeWeeklyScreen',
            page: () => const HoroscopeWeeklyScreen(),
          ),
          GetPage(
            name: '/horoscopeMonthlyScreen',
            page: () => const HoroscopeMonthalyScreen(),
          ),
          GetPage(
            name: '/horoscopeYearlyScreen',
            page: () => const HoroscopeYearlyScreen(),
          ),

          //Matching
          GetPage(
            name: '/matchingSubmitScreen',
            page: () => MatchingSubmitScreen(),
          ),
          GetPage(
            name: '/matchingTabScreen',
            page: () => MatchingTabScreen(),
          ),
          GetPage(
            name: '/saveMatchingKundliScreen',
            page: () => MatchingSavedScreen(),
          ),

          GetPage(
            name: '/panchang_detail',
            page: () => PanchangDetailScreen(),
          ),
          GetPage(
            name: '/shubhmuhrat_details',
            page: () => const ShubhMuhratTabScreen(),
          ),
          GetPage(
            name: '/love_compatibility_submit_screen',
            page: () => LoveCompatibilitySubmitScreen(),
          ),
          GetPage(
            name: '/Love_compatibility',
            page: () => LoveCompatibilityScreen(),
          ),

          //Kundli
          GetPage(
            name: '/savedKundliScreen',
            page: () => KundliSavedScreen(),
          ),
          GetPage(
            name: '/kundliSubmitScreen',
            page: () => KundliSubmitScreen(),
          ),
          GetPage(
            name: '/kundliTabScreen',
            page: () => KundliTabScreen(),
          ),

          //Services
          GetPage(
              name: '/services_category',
              page: () => const ServiceCategoryListScreen(),
              binding: ServiceBinding()),
          GetPage(
              name: '/services',
              page: () => const ServiceListScreen(),
              binding: ServiceBinding()),
          GetPage(
              name: '/service_detail',
              page: () => const ServiceDetailScreen(),
              binding: ServiceBinding()),
          GetPage(
              name: '/service_astrologer_list',
              page: () => const ServiceAstrologerListScreen(),
              binding: ServiceBinding()),
          GetPage(
            name: '/chat_intake_form',
            page: () => ChatIntakeFormScreen(),
          ),
          GetPage(
            name: '/chat_screen',
            page: () => ChatScreen(),
          ),
          GetPage(
              name: '/chatChannels',
              page: () => const ChatChannelListScreen(),
              binding: ChatHistoryBinding()),
          GetPage(
              name: '/chatHistory',
              page: () => ChatHistoryScreen(),
              binding: ChatHistoryBinding()),
          GetPage(
            name: '/remedies',
            page: () => const RemediesScreen(),
          ),
          // Profile topics
          GetPage(
              name: '/orders_tab_screen',
              page: () => OrdersTabScreen(),
              binding: OrderBinding()),
          GetPage(
              name: '/paid_orders_tab_screen',
              page: () => const PaidServiceOrdersTabScreen(),
              binding: PaidServiceOrderBinding()),
          GetPage(
              name: '/live_orders_tab_screen',
              page: () => const LiveOrdersTabScreen(),
              binding: OrderBinding()),
          GetPage(
              name: '/product_order_detail_screen',
              page: () => ProductOrderDetailScreen()),
          GetPage(
            name: '/queue_list',
            page: () => const QueueListScreen(),
            binding: QueueBinding(),
          ),
          GetPage(
            name: '/contact_us',
            page: () => const ContactUsScreen(),
          ),
          GetPage(
            name: '/language_screen',
            page: () => const AppLanguageScreen(),
            binding: AppLanguageBinding(),
          ),
          GetPage(
            name: '/mobile_numerology',
            page: () => MobileNumerologySubmitScreen(),
          ),
          GetPage(
            name: '/mobile_numerology_detail',
            page: () => const MobileNumerologyDetailScreen(),
          ),
          GetPage(
            name: '/reportListScreen',
            page: () => const ReportListScreen(),
          ),
          GetPage(
            name: '/report_horo_submit',
            page: () => ReportHoroSubmitScreen(),
          ),
          GetPage(
            name: '/report_detail_screen',
            page: () => ReportDetailScreen(),
          ),
          GetPage(
            name: '/report_order_list',
            page: () => const ReportOrderListScreen(),
          ),
          GetPage(
            name: '/report_order_list_vedic',
            page: () => const ReportOrderListScreenVedic(),
          ),
          GetPage(
            name: '/pdf_viewer',
            page: () => PdfViewerScreen(),
          ),
          //Architects
          GetPage(
            name: '/architect_new_old_screen',
            page: () => const ArchitectNewOldScreen(),
            binding: ArchitectScreenBinding(),
          ),
          GetPage(
            name: '/architect_list_screen',
            page: () => const ArchitectListScreen(),
            binding: ArchitectScreenBinding(),
          ),
          GetPage(
            name: '/architect_profile_screen',
            page: () => ArchitectProfileScreen(),
            binding: ArchitectProfileBinding(),
          ),
          GetPage(
              name: '/architect_orders_tab_screen',
              page: () => const ArchitectOrdersTabScreen(),
              binding: ArchitectOrderBinding()),
          GetPage(
            name: '/architect_chat_screen',
            page: () => ArchitectChatScreen(),
          ),
          GetPage(
            name: '/architectVideoCallScreen',
            page: () => ArchitectVideoCallScreen(),
          ),
          //Homeopathy
          GetPage(
            name: '/homeopathy_screen',
            page: () => const ElectroHomeopathyScreen(),
          ),
          GetPage(
            name: '/homeopathy_list_screen',
            page: () => const ElectroHomeopathyList(),
          ),
          //AskQuestion
          GetPage(
            name: '/ask_question_screen',
            page: () => AskQuestionScreen(),
            binding: AskQuestionBinding(),
          ),
          GetPage(
            name: '/ask_question_profile_screen',
            page: () => AskQuestionProfileScreen(),
            binding: AskQuestionProfileBinding(),
          ),
          GetPage(
            name: '/ask_question_screen_new',
            page: () => AskQuestionScreenNew(),
            binding: AskQuestionBinding(),
          ),
          //AskAstrologerQuestion
          GetPage(
            name: '/ask_question_order_screen',
            page: () => const AskQuestionCustomerListScreen(),
            binding: AskAstrologerQuestionBinding(),
          ),
          //Following
          GetPage(
            name: '/following_list',
            page: () => FollowingListScreen(),
            binding: FollowingScreenBinding(),
          ),
          //Search Astrologer
          GetPage(
            name: '/search',
            page: () => SearchScreen(),
          ),

          //VideoCall
          GetPage(
            name: '/videoCallScreen',
            page: () => VideoCallScreen(),
          ),

          //VoiceCall
          GetPage(
            name: '/voiceCallScreen',
            page: () => VoiceCallScreen(),
          ),

          //ServiceVideoCall
          GetPage(
            name: '/serviceVideoCallScreen',
            page: () => ServiceVideoCallScreen(),
          ),

          //Feedback
          GetPage(
              name: '/feedbackScreen',
              page: () => FeedbackScreen("", "", "", "")),

          //LiveStream
          GetPage(
            name: '/liveStreamScreen',
            page: () => LiveStreamScreen(),
          ),

          GetPage(
            name: '/notificationScreen',
            page: () => const NotificationScreen(),
          ),
          //ChatAssistant
          GetPage(
            name: '/assistantChatScreen',
            page: () => AssistantChatScreen(),
          ),
          GetPage(
            name: '/supportTabScreen',
            page: () => const SupportTabScreen(),
          ),
          //Slot Availability
          GetPage(
            name: '/slotAvailabilityScreen',
            page: () => SlotAvailabilityScreen(),
          ),
          GetPage(
            name: '/slot_chat_screen',
            page: () => SlotChatScreen(),
          ),
          GetPage(
            name: '/slotVideoCallScreen',
            page: () => SlotVideoCallScreen(),
          ),
          //Deeplink Pages
          //Astrologer
          GetPage(
              name: '/astrologerDetail/:id',
              page: () => const DeeplinkAstrologerDetail()),
          //Product
          GetPage(
              name: '/productDetail/:slug',
              page: () => const DeeplinkProductDetail()),
          GetPage(
              name: '/productDetail/:slug/:id',
              page: () => const DeeplinkProductDetail()),
          //Service
          GetPage(
              name: '/serviceDetail/:slug',
              page: () => const DeeplinkServiceDetail()),
          GetPage(
              name: '/serviceDetail/:slug/:id',
              page: () => const DeeplinkServiceDetail()),
          //Blog
          GetPage(
              name: '/blogDetail/:slug',
              page: () => const DeeplinkBlogDetail()),

          GetPage(
              name: '/tipScreen',
              page: () => TipScreen()),
          //GroupPooja
          GetPage(
              name: '/group_pooja_category',
              page: () => const GroupPoojaCategoryListScreen(),
              binding: GroupPoojaBinding()),
          GetPage(
              name: '/group_pooja_list_screen',
              page: () => const GroupPoojaListScreen(),
              binding: GroupPoojaBinding()),
          GetPage(
              name: '/group_pooja_detail',
              page: () => const GroupPoojaDetailScreen(),
              binding: GroupPoojaBinding()),
          GetPage(
              name: '/group_pooja_astrologer_list',
              page: () => const GroupPoojaAstrologerListScreen(),
              binding: GroupPoojaBinding()),
          GetPage(
            name: '/groupPoojaLiveStreamScreen',
            page: () => GroupPoojaLiveStreamScreen(),
          ),
          GetPage(
            name: '/settingScreen',
            page: () => SettingScreen(),
          ),

          // Call Image List
          GetPage(
              name: '/call_image_list_screen',
              page: () => const CallImageListScreen()),

          // Subscription
          GetPage(
            name: '/subscription_list_screen',
            page: () => const SubscriptionListScreen(),
            binding: SubscriptionBinding(),
          ),
          GetPage(
            name: '/subscription_purchase_list',
            page: () => const SubscriptionPurchaseListScreen(),
            binding: SubscriptionBinding(),
          ),
          //Maintenance
          GetPage(name: '/update_screen', page: () => UpdateScreen()),
          GetPage(name: '/maintenance_screen', page: () => MaintenanceScreen()),
        ],
      ),
    );
  }
}
