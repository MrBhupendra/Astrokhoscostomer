class AppConstants {
  static const String appName = 'Astro Brahmand';
  static const String appNameHindi = 'एस्ट्रो ब्रह्माण्ड';
  static const String appNameMarathi = 'एस्ट्रो ब्रह्माण्ड';
  static const String appNameGujarati = 'એસ્ટ્રો બ્રહ્માંડ';
  static const String appNameTelugu = 'ఆస్ట్రో విశ్వం';
  static const String appNameBengali = 'অ্যাস্ট্রো মহাবিশ্ব';
  static const String appNameTamil = 'ஆஸ்ட்ரோ பிரபஞ்சம்';
  static const String appNameKannada = 'ಆಸ್ಟ್ರೋ ವಿಶ್ವ';
  static const String appNameMalayalam = 'ആസ്ട്രോ പ്രപഞ്ചം';
  static const String androidPackageName = 'com.astrobrahmand.customer';
  static const String androidAstrologerPackageName =
      'com.astrobrahmand.astrologer';
  static const String appVersion = '1.0.11';
  static const String defaultCurrencyCode = 'INR';
  static const String defaultCurrencySymbol = '\u20B9';
  static const String defaultPhoneCode = '+91';
  static const String baseUrl = 'https://astrobrahmand.com';
  static const String vedicAstroUrl = 'https://api.vedicastroapi.com/v3-json';
  static const String jyotishamAstroUrl =
      'https://api.jyotishamastroapi.com/api';
  static const String ccAvenueUrl =
      'https://secure.ccavenue.com/transaction.do?command=initiateTransaction';
  static const String ifscUrl = 'https://ifsc.razorpay.com/';
  static const String welcomeUri = '$baseUrl/api/welcome';
  static const String otpSendUri = '$baseUrl/api/otpSend';
  static const String verifyOtpUri = '$baseUrl/api/customerLogin';
  static const String updateProfileUri = '$baseUrl/api/customerEdit';
  static const String getPopupBanner = '$baseUrl/api/getNotice';
  static const String getWalletBalance = '$baseUrl/api/getWalletBalance';
  static const String getDashboard = '$baseUrl/api/customerDashbord';
  static const String getAllAstrologer = '$baseUrl/api/getAllAstrologer';
  static const String getAstrologerDetail = '$baseUrl/api/getAstrologerDetail';
  static const String getReviews = '$baseUrl/api/getReviews';
  static const String astrologerFollow = '$baseUrl/api/astrologerFollow';
  static const String astrologerUnfollow = '$baseUrl/api/astrologerUnfollow';
  static const String checkCallDetail = '$baseUrl/api/checkCallDetail';
  static const String startVoiceCall = '$baseUrl/api/startVoiceCallExotel';
  static const String startInAppVoiceCall = '$baseUrl/api/startVoiceCall';
  static const String startEmergencyVoiceCall =
      '$baseUrl/api/startEmergencyVoiceCallExotel';
  static const String startEmergencyInAppVoiceCall =
      '$baseUrl/api/startEmergencyVoiceCall';
  static const String startVideoCall = '$baseUrl/api/startVideoCall';
  static const String startEmergencyVideoCall =
      '$baseUrl/api/startEmergencyVideoCall';
  static const String saveIntakeData = '$baseUrl/api/saveIntake';
  static const String getRechargeVoucher = '$baseUrl/api/rechargeVoucher';
  static const String proceedRechargeRequest =
      '$baseUrl/api/proceedPaymentRequest';
  static const String updatePaymentRequest = '$baseUrl/api/updateOnlinePayment';
  // Razorpay QR: verify payment status (polling) — QR is created via proceedPaymentRequest (razorpay_qr)
  static const String razorpayQrVerify = '$baseUrl/api/razorpay/qr/verify';
  static const String getQuote = '$baseUrl/api/getQuote';
  static const String getQuoteCategory = '$baseUrl/api/getQuoteCategory';
  static const String getBlog = '$baseUrl/api/getBlog';
  static const String blogLike = '$baseUrl/api/blogLike';
  static const String getVideo = '$baseUrl/api/videoSections';
  static const String userAddressList = '$baseUrl/api/userAddressList';
  static const String addAddress = '$baseUrl/api/addAddress';
  static const String deleteAccount = '$baseUrl/api/deleteAccount';
  static const String getFilters = '$baseUrl/api/getFilters';
  static const String sendSuggestions = '$baseUrl/api/suggestionsRequest';

  // anonymousReview
  static const String customerAnonymousReviewStatusChange =
      '$baseUrl/api/customerAnonymousReviewStatusChange';

  //JyotishamAstro
  static const String jyotishamAstroApiKey = 'jyotishamAstroApiKey';
  static const String saveKundli = '$baseUrl/api/saveKundliData';
  static const String getSavedKundli = '$baseUrl/api/userkundaliRequest';
  static const String updateKundli = '$baseUrl/api/editKundliData';
  static const String deleteKundli = '$baseUrl/api/deleteKundali?';

  //JyotishamAstroKundli
  static const String getJyotishamAstroKundliChart =
      '$jyotishamAstroUrl/chart_image/';
  static const String getJyotishamAstroKundliBasicsDetails =
      '$jyotishamAstroUrl/extended_horoscope/extended_kundali?';
  static const String getJyotishamAstroKundliplanets =
      '$jyotishamAstroUrl/horoscope/planet-details?';
  static const String getJyotishamAstroKundliMahadasha =
      '$jyotishamAstroUrl/dasha/current-mahadasha?';
  static const String getJyotishamAstroKundliSpecificDasha =
      '$jyotishamAstroUrl/dasha/specific-sub-dasha?';
  static const String getJyotishamAstroKundliMahaDashaFull =
      '$jyotishamAstroUrl/dasha/current-mahadasha-full?';
  static const String getJyotishamAstroKundliAshtakvarga =
      '$jyotishamAstroUrl/horoscope/ashtakvarga?';
  static const String getJyotishamAstroKundliAscendant =
      '$jyotishamAstroUrl/horoscope/ascendant-report?';
  static const String getJyotishamAstroKundliMangalDosh =
      '$jyotishamAstroUrl/dosha/mangal_dosh?';
  static const String getJyotishamAstroKundliKaalsarpDosh =
      '$jyotishamAstroUrl/dosha/kaalsarp-dosh?';
  static const String getJyotishamAstroKundliManglikDosh =
      '$jyotishamAstroUrl/dosha/manglik-dosh?';
  static const String getJyotishamAstroKundliPitraDosh =
      '$jyotishamAstroUrl/dosha/pitra-dosh?';
  static const String getJyotishamAstroKundliKp =
      '$jyotishamAstroUrl/extended_horoscope/planets_kp?';
  static const String getJyotishamAstroRudrakshSuggestion =
      '$jyotishamAstroUrl/extended_horoscope/rudraksh_suggestion?';
  static const String getJyotishamAstroGemSuggestion =
      '$jyotishamAstroUrl/extended_horoscope/gem_suggestion?';
  static const String getJyotishamAstroFriendShip =
      '$jyotishamAstroUrl/extended_horoscope/friendship_table?';

  //VedicAstroKundli
  static const String getVedicAstroKundliChart =
      '$vedicAstroUrl/horoscope/chart-image?';
  static const String getVedicAstroKundliBasicsDetails =
      '$vedicAstroUrl/extended-horoscope/extended-kundli-details?';
  static const String getVedicAstroKundliplanets =
      '$vedicAstroUrl/horoscope/planet-details?';
  static const String getVedicAstroKundliMahadasha =
      '$vedicAstroUrl/dashas/current-mahadasha?';
  static const String getVedicAstroKundliSpecificDasha =
      '$vedicAstroUrl/dashas/specific-sub-dasha?';
  static const String getVedicAstroKundliMahadashaFull =
      '$vedicAstroUrl/dashas/current-mahadasha-full?';
  static const String getVedicAstroKundliAshtakvarga =
      '$vedicAstroUrl/horoscope/ashtakvarga?';
  static const String getVedicAstroKundliAscendant =
      '$vedicAstroUrl/horoscope/ascendant-report?';
  static const String getVedicAstroKundliMangalDosh =
      '$vedicAstroUrl/dosha/mangal-dosh?';
  static const String getVedicAstroKundliKaalsarpDosh =
      '$vedicAstroUrl/dosha/kaalsarp-dosh?';
  static const String getVedicAstroKundliManglikDosh =
      '$vedicAstroUrl/dosha/manglik-dosh?';
  static const String getVedicAstroKundliPitraDosh =
      '$vedicAstroUrl/dosha/pitra-dosh?';
  static const String getVedicAstroKundliKp =
      '$vedicAstroUrl/extended-horoscope/kp-planets?';
  static const String getVedicAstroRudrakshSuggestion =
      '$vedicAstroUrl/extended-horoscope/rudraksh-suggestion?';
  static const String getVedicAstroGemSuggestion =
      '$vedicAstroUrl/extended-horoscope/gem-suggestion?';

  //Matching
  static const String matchingSaveDataDelete = '$baseUrl/api/deleteKundali';
  static const String matchingSaveDataUpdate = '$baseUrl/api/editKundliData';

  //JyotishamAstroMatching
  static const String getJyotishamAstroMatchingAshtakoot =
      '$jyotishamAstroUrl/matching/ashtakoot-astro?';
  static const String getJyotishamAstroMatchingDashakoot =
      '$jyotishamAstroUrl/matching/dashakoot-astro?';
  static const String getJyotishamAstroMatchingAggregate =
      '$jyotishamAstroUrl/matching/aggregate-match?';
  static const String getJyotishamAstroMatchingNakshatra =
      '$jyotishamAstroUrl/matching/nakshatra-match?';

  //VedicAstroMatching
  static const String getVedicAstroMatchingAshtakoot =
      '$vedicAstroUrl/matching/ashtakoot-with-astro-details?';
  static const String getVedicAstroMatchingDashakoot =
      '$vedicAstroUrl/matching/dashakoot-with-astro-details?';
  static const String getVedicAstroMatchingAggregate =
      '$vedicAstroUrl/matching/aggregate-match?';
  static const String getVedicAstroMatchingNakshatra =
      '$vedicAstroUrl/matching/nakshatra-match?';

  //JyotishamAstro Love Compatibility
  static const String getJyotishamAstroLoveCompat =
      '$jyotishamAstroUrl/matching/western-match?';

  //VedicAstro Love Compatibility
  static const String getVedicAstroLoveCompat =
      '$vedicAstroUrl/matching/western-match?';

  //JyotishamAstro Numerology
  static const String getJyotishamAstroNumerology =
      '$jyotishamAstroUrl/prediction/numerology?';

  //VedicAstro Numerology
  static const String getVedicAstroNumerology =
      '$vedicAstroUrl/prediction/numerology?';

  //JyotishamAstro ShubhMuhrat
  static const String getJyotishamAstroShubhMuhratHora =
      '$jyotishamAstroUrl/panchang/hora-muhurta?';
  static const String getJyotishamAstroShubhMuhratChoghadiya =
      '$jyotishamAstroUrl/panchang/choghadiya-muhurta?';

  //VedicAstro ShubhMuhrat
  static const String getVedicAstroShubhMuhratHora =
      '$vedicAstroUrl/panchang/hora-muhurta?';
  static const String getVedicAstroShubhMuhratChoghadiya =
      '$vedicAstroUrl/panchang/choghadiya-muhurta?';

  //JyotishamAstro tarot
  static const String getTarot = '$jyotishamAstroUrl/tarot_readings/yes_or_no?';

  //JyotishamAstro Horoscope
  static const String getJyotishamAstroHoroscopeDaily =
      '$jyotishamAstroUrl/prediction/daily?';
  static const String getJyotishamAstroHoroscopeWeekly =
      '$jyotishamAstroUrl/prediction/weekly?';
  static const String getJyotishamAstroHoroscopeMonthly =
      '$jyotishamAstroUrl/prediction/monthly?';
  static const String getJyotishamAstroHoroscopeYearly =
      '$jyotishamAstroUrl/prediction/yearly?';

  //VedicAstroHoroscope
  static const String getVedicAstroHoroscopeDaily =
      '$vedicAstroUrl/prediction/daily-moon?';
  static const String getVedicAstroHoroscopeWeekly =
      '$vedicAstroUrl/prediction/weekly-sun?';
  static const String getVedicAstroHoroscopeYearly =
      '$vedicAstroUrl/prediction/yearly?';

  //jyotishamAstroPanchang
  static const String getJyotishamAstroPanchang =
      '$jyotishamAstroUrl/panchang/panchang?';

  //VedicAstroPanchang
  static const String getVedicAstroPanchang =
      '$vedicAstroUrl/panchang/panchang?';

  //JyotishamAstro timeZone
  // static const String timeZone = '5.5';

  //Chat
  static const String startChat = '$baseUrl/api/startChat';
  static const String startAssistantChat = '$baseUrl/api/startAssistantChat';
  static const String getChatHistory = '$baseUrl/api/getChatChannelHistory';
  static const String saveChat = '$baseUrl/api/saveChat';
  static const String updateChatMessageStatus =
      '$baseUrl/api/updateChatMessageStatus';
  static const String getChatRemainingTime = '$baseUrl/api/remainingChatTime';
  static const String getQueueList = '$baseUrl/api/getCustomerQueueList';
  static const String declineQueueRequest = '$baseUrl/api/declineRequest';
  static const String getChatChannelsList = '$baseUrl/api/getChatChannels';
  static const String submitReview = '$baseUrl/api/addReviews';
  static const String deleteChat = '$baseUrl/api/deleteChat';
  static const String deleteChatChannel = '$baseUrl/api/deleteChatChannel';

  //Emergency Chat
  static const String startEmergencyChat = '$baseUrl/api/startEmergencyChat';
  // Vastu
  // Sanjeevini API
  static const String getSanjeevini = '$baseUrl/api/sanjeeviniList';
  static const String sanjeeviniCalculation =
      '$baseUrl/api/sanjeeviniCalculation';
  static const String sanjeeviniPurchase = '$baseUrl/api/sanjeeviniPurchase';
  static const String sanjeeviniPurchaseList =
      '$baseUrl/api/sanjeeviniPurchaseList';

  //SwitchWord API
  static const String getSwitchWords = '$baseUrl/api/switchwordList';
  static const String switchWordCalculation =
      '$baseUrl/api/switchwordCalculation';
  static const String switchWordPurchase = '$baseUrl/api/switchwordPurchase';
  static const String switchWordPurchaseList =
      '$baseUrl/api/switchwordPurchaseList';

  //BookPDF API
  static const String getBooksCategory = '$baseUrl/api/pdfBookCategory';
  static const String getBooksList = '$baseUrl/api/pdfBookList';
  static const String booksCalculation = '$baseUrl/api/pdfBookCalculation';
  static const String bookPurchase = '$baseUrl/api/pdfBookPurchase';
  static const String bookPurchaseList = '$baseUrl/api/pdfBookPurchaseList';

  //AskQuestion
  static const String getQuestionList = '$baseUrl/api/getPredefinedQuestion';
  static const String getAiProfileList = '$baseUrl/api/openAIProfileList';
  static const String selectAiProfile = '$baseUrl/api/selectOpenAIProfile';
  static const String askQuestionCalculation =
      '$baseUrl/api/openAIPredictionCalculation';
  static const String askQuestionPurchase =
      '$baseUrl/api/openAIPredictionPurchase';
  static const String getQuestionHistoryList =
      '$baseUrl/api/openAIPredictionList';

  static const String getOpenAiProfile = '$baseUrl/api/getOpenAIProfile';
  static const String addOpenAiProfile = '$baseUrl/api/addOpenAIProfile';
  static const String updateOpenAiProfile = '$baseUrl/api/updateOpenAIProfile';
  static const String deleteOpenAiProfile = '$baseUrl/api/deleteOpenAIProfile';

  // Ask Astrologer Question
  static const String askAstroQuestionCalculation =
      '$baseUrl/api/askQuestionCalculation';
  static const String askAstroQuestionPurchase =
      '$baseUrl/api/askQuestionPurchase';
  static const String askQuestionCustomerList =
      '$baseUrl/api/askQuestionCustomerList';

  // Order history
  static const String userCallHistory = '$baseUrl/api/userCallHistory';
  static const String requestRefund = '$baseUrl/api/refundRequest';
  static const String getWalletHistory = '$baseUrl/api/getWalletHistory';
  static const String getShopOrder = '$baseUrl/api/productOrderList';
  static const String getServiceOrder = '$baseUrl/api/customerServiceOrder';
  static const String getLiveGiftHistory = '$baseUrl/api/userGiftHistory';

  //LIVE
  static const String joinLiveStream = '$baseUrl/api/joinLiveStream';
  static const String getLiveGifts = '$baseUrl/api/giftItem';
  static const String sendLiveGift = '$baseUrl/api/sendGiftAstro';
  static const String sendLiveRequest = '$baseUrl/api/joinLiveCall';
  static const String getUpcomingLiveAstrologers =
      '$baseUrl/api/upcomingLiveAstrologer';

  // Product Category
  static const String getProductCategory = '$baseUrl/api/productCategory';
  static const String getProducts = '$baseUrl/api/products';
  static const String getProductDetail = '$baseUrl/api/productDetail';
  static const String manageProduct = '$baseUrl/api/productCalculation';
  static const String purchaseProduct = '$baseUrl/api/productPurchase';
  // Offer code
  static const String getOfferCode = '$baseUrl/api/offerList';

  // Service Category
  static const String getServiceCategory = '$baseUrl/api/serviceCategory';
  static const String getServices = '$baseUrl/api/services';
  static const String getServiceAstrologers =
      '$baseUrl/api/serviceAstrologerList';
  static const String manageService = '$baseUrl/api/serviceCalculation';
  static const String purchaseService = '$baseUrl/api/servicePurchase';
  static const String startServiceVideoCall = '$baseUrl/api/serviceVideoCall';
  static const String getServiceRemainingTime =
      '$baseUrl/api/remainingServiceVideoCallTime';

  //Filters
  static const String getSkills = '$baseUrl/api/skillList';
  static const String getLanguage = '$baseUrl/api/languageList';
  static const String getCategory = '$baseUrl/api/categoryList';

  //Followings
  static const String getFollowing = '$baseUrl/api/getFollowing';

  //Remedies
  static const String getRemedies = '$baseUrl/api/getSuggestionHistory';

  //Notification
  static const String getNotification = '$baseUrl/api/getNotification';
  static const String deleteNotification = '$baseUrl/api/deleteNotification';

  //Report
  static const String reportKundliList = '$baseUrl/api/paidKundliManualList';
  static const String reportOrdersList =
      '$baseUrl/api/paidKundliManualOrderList';
  static const String reportCalculation =
      '$baseUrl/api/paidKundliManualCalculation';
  static const String reportHoroscopePurchase =
      '$baseUrl/api/paidKundliManualPurchase';
  static const String reportHoroscopeOrderList =
      '$baseUrl/api/paidKundliManualOrderList';

  //Architect
  static const String architectServiceCalculation =
      '$baseUrl/api/architectServiceOrderCalculation';
  static const String architectServicePurchase =
      '$baseUrl/api/architectServiceOrderPlace';
  static const String architectInProgressOrdersList =
      '$baseUrl/api/getCustomerArchitectServiceInProgressList';
  static const String architectCompletedOrdersList =
      '$baseUrl/api/getCustomerArchitectServiceCompletedList';
  static const String architectStartChat =
      '$baseUrl/api/startArchitectServiceChat';
  static const String startArchitectCall =
      '$baseUrl/api/startArchitectServiceVoiceCallExotel';

  static const String startArchitectVideoCall =
      '$baseUrl/api/startArchitectServiceVideoCall';
  static const String getArchitectRemainingTime =
      '$baseUrl/api/remainingArchitectServiceTime';

  //SlotBooking
  static const String getAstrologerSlotList =
      '$baseUrl/api/astrologerScheduleList';
  static const String bookAstroSchedule = '$baseUrl/api/bookAstroSchedule';
  static const String getBookedSchedule =
      '$baseUrl/api/getBookedScheduleForCustomer';

  static const String startSlotVideoCall =
      '$baseUrl/api/startScheduleBookingVideoCall';
  static const String getSlotRemainingTime =
      '$baseUrl/api/remainingScheduleBookingTime';

  static const String startSlotVoiceCall =
      '$baseUrl/api/startScheduleBookingVoiceCall';

  //Predefined Messages
  static const String getPredefinedMessageCategory =
      '$baseUrl/api/getPredefinedMessageCategory';
  static const String getPredefinedMessage =
      '$baseUrl/api/getPredefinedMessages';

  //Mandir Darshan
  static const String getLiveMandirDarshanList =
      '$baseUrl/api/liveTempleDarshanAstrologerList';
  static const String joinMandirDarshan = '$baseUrl/api/liveTempleDarshanJoin';
  static const String getMandirDarshanCalculation =
      '$baseUrl/api/liveTempleDarshanCalculation';
  static const String purchaseMandirDarshanPooja =
      '$baseUrl/api/liveTempleDarshanPurchase';
  static const String getCustomerMandirDarshanOrder =
      '$baseUrl/api/customerLiveTempleDarshanOrder';

  // Send File on call
  static const String sendFileOnCall = '$baseUrl/api/sendFileOnCall';
  static const String getFileOnCall = '$baseUrl/api/getFileOnCall';

  //GroupPooja
  static const String scheduleGroupPuja = '$baseUrl/api/scheduleGroupPuja';
  static const String groupPujaStatusChange = '$baseUrl/api/groupPujaStatusChange';
  static const String getGroupPujaAstrologerList =
      '$baseUrl/api/groupPujaAstrologerList';
  static const String getGroupPujaCalculation =
      '$baseUrl/api/groupPujaCalculation';
  static const String getCustomerGroupPujaOrder =
      '$baseUrl/api/customerGroupPujaOrder';
  static const String getGroupPujaCategory = '$baseUrl/api/groupPujaCategory';
  static const String getGroupPujaList = '$baseUrl/api/groupPujaList';
  static const String getGroupPujas = '$baseUrl/api/groupPujas';
  static const String joinGroupPuja = '$baseUrl/api/groupPujaJoin';
  static const String getRemainingGroupPujaTime =
      '$baseUrl/api/remainingGroupPujaTime';
  static const String purchaseGroupPuja = '$baseUrl/api/groupPujaPurchase';
  static const String cancelGroupPujaByCustomerApi =
      '$baseUrl/api/cancelGroupPujaByCustomer';

  //Subscription
  static const String getSubscriptionList = '$baseUrl/api/subscriptionList';
  static const String getSubscriptionCalculation =
      '$baseUrl/api/subscriptionCalculation';
  static const String subscriptionPurchase =
      '$baseUrl/api/subscriptionPurchase';
  static const String subscriptionPurchaseList =
      '$baseUrl/api/subscriptionPurchaseList';

  //AppUrl
  static const String faqUrl = '$baseUrl/page_app/FAQ';
  static const String aboutUsUrl = '$baseUrl/page_app/about-us';
  static const String tncUrl = '$baseUrl/page_app/terms-condition';
  static const String privacyPolicyUrl = '$baseUrl/page_app/privacy-policy';
  static const String shippingPolicyUrl = '$baseUrl/page_app/shipping-policy';
  static const String cancellationPolicyUrl =
      '$baseUrl/page_app/refund-and-cancellation-policy';
  static const String blogShareUrl = '$baseUrl/blogs';
  static const String quoteShareUrl = '$baseUrl/quotes';
  static const String astroProfileUrl = '$baseUrl/astrologers';

  // Social site url
  // static const String facebook = "https://www.facebook.com/";
  // static const String instagram = "https://www.instagram.com/";
  // static const String youtube = "https://www.youtube.com/";
  // static const String twitter = "https://twitter.com/";

  //App Constants
  static const int success = 1;
  static const int unAuthoriseUser = 101;
  static const int insufficientBalance = 102;
  static const String isLogin = 'isLogin';
  static const String userUniId = 'userUniId';
  static const String userUid = 'userUid';
  static const String userApiKey = 'userApiKey';
  static const String profileImage = 'profileImage';
  static const String phoneNumber = 'phoneNumber';
  static const String name = 'name';
  static const String email = 'email';
  static const String phone = 'phone';
  static const String gender = 'gender';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String timeZone = 'timeZone';
  static const String birthPlace = 'birthPlace';
  static const String birthDate = 'birthDate';
  static const String birthTime = 'birthTime';
  static const String appLanguage = 'appLanguage';
  static const String fcmToken = 'fcmToken';

  static const String companyEmail = 'coEmail';
  static const String companyWhatsappNo = 'coWhatsapp';
  static const String companyMobileNo = 'coMobile';
  static const String companyAddress = 'coAddress';

  static const String isPopUp = 'isPopUp';
  static const String isInAppCall = 'isInAppCall';
  static const String placeApiKey = 'placeApiKey';
  static const String agoraAppId = 'agoraAppId';
  static const String razorpayAppId = 'razorpayId';
  static const String paymentGateway = 'paymentGateway';
  static const String architectCategoryId = 'architectCategoryId';
  static const String homeopathyCategoryId = 'homeopathyCategoryId';
  static const String aiPredictionPrice = 'aiPredictionPrice';
  static const String askQuestionPrice = 'askQuestionPrice';
  static const String currencyCode = 'currencyCode';
  static const String currencySymbol = 'currencySymbol';
  static const String phoneCode = 'phoneCode';

  static const String youtubeLink = 'youtubeLink';
  static const String instagramLink = 'instagramLink';
  static const String facebookLink = 'facebookLink';
  static const String shareChatLink = 'shareChatLink';
  static const String twitterLink = 'twitterLink';
  static const String linkedinLink = 'linkedinLink';

  static const String chat = 'chat';
  static const String call = 'call';
  static const String video = 'video';
  static const String live = 'live';
  static const String liveVideoCall = 'videocallwithlive';
  static const String liveAudioCall = 'callwithlive';
  static const String privateLiveVideoCall = 'privatevideocallwithlive';
  static const String privateLiveAudioCall = 'privatecallwithlive';
  static const String slot = 'slot';
  static const String emergencyCall = 'emergency_call';
  static const String emergencyChat = 'emergency_chat';
  static const String emergencyVideoCall = 'emergency_video';

  //Mandir Darshan
  static const String mandirDarshan = 'mandir_darshan';

  static const String refresh = 'refresh';

  // Orders type
  static const String allOrder = "All";
  static const String shopOrder = "Shop";
  static const String serviceOrder = "Service";
  static const String groupPoojaOrder = "Group Pooja";
  static const String subscriptionOrder = "Subscription";
  static const String walletOrder = "Wallet";
  static const String consultingOrder = "Consulting";
  static const String giftOrder = "Gift";
  static const String orderMandirDarshan = "Mandir Darshan";

  // Paid Orders type
  static const String sanjeeviniOrder = "Jeevini";
  static const String switchwordOrder = "Divine Code";
  static const String pdfBookOrder = "E-Book";
  static const String reportOrder = "Report";

  static const String single = 'Single';
  static const String married = 'Married';

  static const int vedicSuccess = 200;
  static const int aggregatescore = 100;
  static const int ashtakootescore = 36;
  static const int dashakootscore = 10;

  static const String staticTimezone = '5.5';
  static const String kundliMatching = 'kundli_matching';
  static const String kundli = 'kundli';
  static const String vedicAstro = 'Vedicastro';
  static const String jyotisham = 'jyotisham';
  static const String vedicastro = 'vedicastro';
  static const String vedicApiKey = 'vedicApiKey';
  static const String jyotishamApiKey = 'jyotishamApiKey';

  //Payment Types
  static const String payRazorpay = 'razorpay';
  static const String payRazorpayQr = 'razorpay_qr';
  static const String payCCAvenue = 'CCAvenue';
  static const String payPhonePe = 'PhonePe';
  static const String payPayPal = 'Paypal';
  static const String payCashfree = 'Cashfree';
  static const String payPayu = 'Payu';
  static const String phonePeId = 'phonePeId';

  //Chat
  static const String text = "Text";
  static const String image = "Image";
  static const String pdf = "Pdf";
  static const String voiceNote = "Voice";
  static const String product = "Product";
  static const String service = "Service";

  static const String questionTypeSvg = "svg";
  static const String questionTypeText = "text";

  //Service Payment
  static const String pdfBook = "pdfBook";
  static const String jeevini = "jeevini";
  static const String divineCode = "divineCode";
  static const String wallet = "wallet";
  static const String report = "report";
  static const String askQuestion = "askQuestion";
  static const String shop = "shop";
  static const String architect = "architect";
  static const String slotBooking = "slotBooking";

  //Mobile Numerology File
  static const String mobileNumerologyPrediction =
      "assets/prediction/numerologyPrediction.json";

  //Horoscope
  static const String reportHoroscope = "horoscope";
  static const String reportMatching = "matching";
  static const String reportMarried = "Married";
  static const String reportSingle = "Single";

  //Architect
  static const String home = 'Home';
  static const String office = 'Office';
  static const String industry = 'Industry';
  //New
  static const String homeComplete = 'home_complete';
  static const String officeComplete = 'office_complete';
  static const String industryComplete = 'industry_complete';

  static const String homeLayout = 'home_layout';
  static const String officeLayout = 'office_layout';
  static const String industryLayout = 'industry_layout';

  static const String homeOld = 'home_old';
  static const String officeOld = 'office_old';
  static const String industryOld = 'industry_old';

  // Predefined Msg Types
  static const String preTypeChat = 'chat';
  static const String preTypeAiChat = 'ai_chat';

  static const String createdByAdmin = 'Admin';
  static const String createdByAstrologer = 'Astrologer';

  static const String lastProcessedNotificationId =
      'lastProcessedNotificationId';
  static const String lastProcessedAlertNotificationId =
      'lastProcessedAlertNotificationId';

  // vedic pdf
  static const String paidKundliCalculation =
      '$baseUrl/api/paidKundliCalculation';
  static const String paidKundliPurchase = '$baseUrl/api/paidKundliPurchase';
  static const String paidKundliOrderList = '$baseUrl/api/paidKundliOrderList';

  static const String horoscopePdf = 'Horoscope Pdf Report';
  static const String matchingPdf = 'Matching Pdf Report';

  static const String horoscopePrice = 'horoscopePrice';
  static const String kundliMatchingPrice = 'kundliMatchingPrice';

  // Gmail login
  static const String defaultWebClientId =
      "464748727346-5rrnnv72262g423i379pon04145nbukp.apps.googleusercontent.com";
  static const String gmailLoginUri = '$baseUrl/api/customerLoginWithGmail';
  static const String isGoogleLogin = 'isGoogleLogin';
}
