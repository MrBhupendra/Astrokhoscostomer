class WelcomeModel {
  WelcomeModel({
    this.status,
    this.data,
  });

  WelcomeModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  num? status;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.companyName,
    this.email,
    this.postalCode,
    this.city,
    this.state,
    this.country,
    this.address,
    this.mobileNo,
    this.firbaseApiToken,
    this.googleMapApiKey,
    this.zegoApiId,
    this.zegoSecretKey,
    this.razorpayId,
    this.razorpayKey,
    this.agoraApiId,
    this.agoraApiCertificate,
    this.sendBirdApplicationId,
    this.sendBirdApiToken,
    this.clientIdProkerala,
    this.clientSecretProkerala,
    this.vedicAstroApiKey,
    this.jyotishamApiKey,
    this.websiteFavicon,
    this.backWebsiteLogo,
    this.logo,
    this.youtubeLink,
    this.linkedinLink,
    this.instagramLink,
    this.googleLink,
    this.twitterLink,
    this.facebookLink,
    this.whatsappNumber,
    this.telephone,
    this.serviceRefundDuration,
    this.shareChatLink,
    this.paymentGateway,
    this.payment,
    this.paymentForOtherCountry,
    this.phonepeMerchantId,
    this.architectCategoryId,
    this.homeopathyCategoryId,
    this.openAiQuestionPrice,
    this.askQuestionPrice,
    this.inAppVoiceCall,
    this.defaultCurrencyCode,
    this.defaultCurrencySymbol,
    this.activeOffer,
    this.activeKundliApi,
    this.isCallRequestToOfflineAstro,
  });

  Data.fromJson(dynamic json) {
    companyName = json['company_name'];
    email = json['email'];
    postalCode = json['postal_code'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    address = json['address'];
    mobileNo = json['mobile_no'];
    firbaseApiToken = json['firbase_api_token'];
    googleMapApiKey = json['google_map_api_key'];
    zegoApiId = json['zego_api_id'];
    zegoSecretKey = json['zego_secret_key'];
    razorpayId = json['razorpay_id'];
    razorpayKey = json['razorpay_key'];
    agoraApiId = json['agora_api_id'];
    agoraApiCertificate = json['agora_api_certificate'];
    sendBirdApplicationId = json['send_bird_application_id'];
    sendBirdApiToken = json['send_bird_api_token'];
    clientIdProkerala = json['client_id_prokerala'];
    clientSecretProkerala = json['client_secret_prokerala'];
    vedicAstroApiKey = json['vedic_astro_api_key'];
    jyotishamApiKey = json['jyotisham_api_key'];
    websiteFavicon = json['website_favicon'];
    backWebsiteLogo = json['back_website_logo'];
    logo = json['logo'];
    youtubeLink = json['youtube_link'];
    linkedinLink = json['linkedin_link'];
    instagramLink = json['instagram_link'];
    googleLink = json['google_link'];
    twitterLink = json['twitter_link'];
    facebookLink = json['facebook_link'];
    whatsappNumber = json['whatsapp_number'];
    telephone = json['telephone'];
    serviceRefundDuration = json['service_refund_duration'];
    shareChatLink = json['share_chat_link'];
    paymentGateway = json['payment_gateway'];
    payment = json['payment'] != null ? Payment.fromJson(json['payment']) : null;
    paymentForOtherCountry = json['payment_for_other_country'] != null ? PaymentForOtherCountry.fromJson(json['payment_for_other_country']) : null;
    phonepeMerchantId = json['phonepe_merchant_id'];
    architectCategoryId = json['architect_category_id'];
    homeopathyCategoryId = json['electro_homoeopathy_category_id'];
    openAiQuestionPrice = json['open_ai_prediction_price'];
    askQuestionPrice = json['ask_question_price'];
    inAppVoiceCall = json['in_app_voice_call'];
    defaultCurrencyCode = json['default_currency_code'];
    defaultCurrencySymbol = json['default_currency_symbol'];
    activeOffer = json['active_offer'];
    activeKundliApi = json['active_kundli_api'];
    isCallRequestToOfflineAstro = json['is_call_request_to_offline_astro'];
  }

  String? companyName;
  String? email;
  String? postalCode;
  String? city;
  String? state;
  String? country;
  String? address;
  String? mobileNo;
  String? firbaseApiToken;
  String? googleMapApiKey;
  String? zegoApiId;
  String? zegoSecretKey;
  String? razorpayId;
  String? razorpayKey;
  String? agoraApiId;
  String? agoraApiCertificate;
  String? sendBirdApplicationId;
  String? sendBirdApiToken;
  String? clientIdProkerala;
  String? clientSecretProkerala;
  String? vedicAstroApiKey;
  String? jyotishamApiKey;
  String? websiteFavicon;
  String? backWebsiteLogo;
  String? logo;
  String? youtubeLink;
  String? linkedinLink;
  String? instagramLink;
  String? googleLink;
  String? twitterLink;
  String? facebookLink;
  String? whatsappNumber;
  String? telephone;
  String? serviceRefundDuration;
  String? shareChatLink;
  String? paymentGateway;
  Payment? payment;
  PaymentForOtherCountry? paymentForOtherCountry;
  String? phonepeMerchantId;
  String? architectCategoryId;
  String? homeopathyCategoryId;
  String? openAiQuestionPrice;
  String? askQuestionPrice;
  num? inAppVoiceCall;
  String? defaultCurrencyCode;
  String? defaultCurrencySymbol;
  String? activeOffer;
  String? activeKundliApi;
  num? isCallRequestToOfflineAstro;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['company_name'] = companyName;
    map['email'] = email;
    map['postal_code'] = postalCode;
    map['city'] = city;
    map['state'] = state;
    map['country'] = country;
    map['address'] = address;
    map['mobile_no'] = mobileNo;
    map['firbase_api_token'] = firbaseApiToken;
    map['google_map_api_key'] = googleMapApiKey;
    map['zego_api_id'] = zegoApiId;
    map['zego_secret_key'] = zegoSecretKey;
    map['razorpay_id'] = razorpayId;
    map['razorpay_key'] = razorpayKey;
    map['agora_api_id'] = agoraApiId;
    map['agora_api_certificate'] = agoraApiCertificate;
    map['send_bird_application_id'] = sendBirdApplicationId;
    map['send_bird_api_token'] = sendBirdApiToken;
    map['client_id_prokerala'] = clientIdProkerala;
    map['client_secret_prokerala'] = clientSecretProkerala;
    map['vedic_astro_api_key'] = vedicAstroApiKey;
    map['jyotisham_api_key'] = jyotishamApiKey;
    map['website_favicon'] = websiteFavicon;
    map['back_website_logo'] = backWebsiteLogo;
    map['logo'] = logo;
    map['youtube_link'] = youtubeLink;
    map['linkedin_link'] = linkedinLink;
    map['instagram_link'] = instagramLink;
    map['google_link'] = googleLink;
    map['twitter_link'] = twitterLink;
    map['facebook_link'] = facebookLink;
    map['whatsapp_number'] = whatsappNumber;
    map['telephone'] = telephone;
    map['service_refund_duration'] = serviceRefundDuration;
    map['share_chat_link'] = shareChatLink;
    map['payment_gateway'] = paymentGateway;
    if (payment != null) {
      map['payment'] = payment?.toJson();
    }
    if (paymentForOtherCountry != null) {
      map['payment_for_other_country'] = paymentForOtherCountry?.toJson();
    }
    map['phonepe_merchant_id'] = phonepeMerchantId;
    map['architect_category_id'] = architectCategoryId;
    map['electro_homoeopathy_category_id'] = homeopathyCategoryId;
    map['open_ai_prediction_price'] = openAiQuestionPrice;
    map['ask_question_price'] = askQuestionPrice;
    map['in_app_voice_call'] = inAppVoiceCall;
    map['default_currency_code'] = defaultCurrencyCode;
    map['default_currency_symbol'] = defaultCurrencySymbol;
    map['active_offer'] = activeOffer;
    map['active_kundli_api'] = activeKundliApi;
    map['is_call_request_to_offline_astro'] = isCallRequestToOfflineAstro;
    return map;
  }
}

class Payment {
  Payment({
    this.defaultPaymentGateway,
    this.razorpay,
    this.phonepe,
    this.ccavenue,
    this.cashfree,
    this.paypal,
    this.payu,
  });

  Payment.fromJson(dynamic json) {
    defaultPaymentGateway = json['default_payment_gateway'];
    razorpay = json['razorpay'];
    phonepe = json['phonepe'];
    ccavenue = json['ccavenue'];
    cashfree = json['cashfree'];
    paypal = json['paypal'];
    payu = json['payu'];
  }
  String? defaultPaymentGateway;
  bool? razorpay;
  bool? phonepe;
  bool? ccavenue;
  bool? cashfree;
  bool? paypal;
  bool? payu;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['default_payment_gateway'] = defaultPaymentGateway;
    map['razorpay'] = razorpay;
    map['phonepe'] = phonepe;
    map['ccavenue'] = ccavenue;
    map['cashfree'] = cashfree;
    map['paypal'] = paypal;
    map['payu'] = payu;
    return map;
  }

}

class PaymentForOtherCountry {
  PaymentForOtherCountry({
    this.defaultPaymentGateway,
    this.razorpay,
    this.phonepe,
    this.ccavenue,
    this.cashfree,
    this.paypal,
    this.payu,
  });

  PaymentForOtherCountry.fromJson(dynamic json) {
    defaultPaymentGateway = json['default_payment_gateway'];
    razorpay = json['razorpay'];
    phonepe = json['phonepe'];
    ccavenue = json['ccavenue'];
    cashfree = json['cashfree'];
    paypal = json['paypal'];
    payu = json['payu'];
  }
  String? defaultPaymentGateway;
  bool? razorpay;
  bool? phonepe;
  bool? ccavenue;
  bool? cashfree;
  bool? paypal;
  bool? payu;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['default_payment_gateway'] = defaultPaymentGateway;
    map['razorpay'] = razorpay;
    map['phonepe'] = phonepe;
    map['ccavenue'] = ccavenue;
    map['cashfree'] = cashfree;
    map['paypal'] = paypal;
    map['payu'] = payu;
    return map;
  }

}
