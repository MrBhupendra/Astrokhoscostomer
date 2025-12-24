
import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:astro_brahmand/utill/app_constants.dart';

class SharedPreferencesHelper {

  // Save data to SharedPreferences
  static Future<void> saveData(String id, String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(id, data);
  }

  // Retrieve data from SharedPreferences
  static Future<String?> getData(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(id) ?? '***';
  }

  static Future<void> saveIntData(String id, int data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(id, data);
  }


  static Future<int> getIntData(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(id) ?? 0;
  }

  static Future<void> saveBoolData(String id, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(id, value);
  }

  // Retrieve data from SharedPreferences
  static Future<bool> getBoolData(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(id) ?? false;
  }

  static Future<bool> getIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.isLogin) ?? false;
  }

  // Delete data from SharedPreferences
  static Future<void> deleteData(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(id);
  }

  static Future<void> logoutSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Extract Data from SP
    int isInAppCall = prefs.getInt(AppConstants.isInAppCall) ?? 0;
    String paymentGateway = prefs.getString(AppConstants.paymentGateway) ?? AppConstants.payRazorpay;
    String appLanguage = prefs.getString(AppConstants.appLanguage) ?? 'en';
    String vedicApiKey = prefs.getString(AppConstants.vedicApiKey) ?? '***';
    String jyotishamApiKey = prefs.getString(AppConstants.jyotishamApiKey) ?? '***';
    String agoraAppId = prefs.getString(AppConstants.agoraAppId) ?? '***';
    String placeApiKey = prefs.getString(AppConstants.placeApiKey) ?? '***';
    String architectCategoryId = prefs.getString(AppConstants.architectCategoryId) ?? '***';
    String homeopathyCategoryId = prefs.getString(AppConstants.homeopathyCategoryId) ?? '***';
    String aiPredictionPrice = prefs.getString(AppConstants.aiPredictionPrice) ?? '***';
    String askQuestionPrice = prefs.getString(AppConstants.askQuestionPrice) ?? '***';

    String coEmail = prefs.getString(AppConstants.companyEmail) ?? '***';
    String coWhatsapp = prefs.getString(AppConstants.companyWhatsappNo) ?? '***';
    String coMobile = prefs.getString(AppConstants.companyMobileNo) ?? '***';
    String coAddress = prefs.getString(AppConstants.companyAddress) ?? '***';

    String fb = prefs.getString(AppConstants.facebookLink) ?? '***';
    String instagram = prefs.getString(AppConstants.instagramLink) ?? '***';
    String youtube = prefs.getString(AppConstants.youtubeLink) ?? '***';
    String twitter = prefs.getString(AppConstants.twitterLink) ?? '***';
    String shareChat = prefs.getString(AppConstants.shareChatLink) ?? '***';
    String linkedin = prefs.getString(AppConstants.linkedinLink) ?? '***';
    //Clear all data
    await prefs.clear();

    //Save config data
    CommonMethods().logoutUser(isInAppCall,paymentGateway, appLanguage,vedicApiKey,jyotishamApiKey,agoraAppId,placeApiKey,architectCategoryId,homeopathyCategoryId,aiPredictionPrice,askQuestionPrice,coMobile,coEmail,coWhatsapp,coAddress,fb,instagram,youtube,twitter,shareChat,linkedin);
    try{
      User? user = FirebaseAuth.instance.currentUser;
      if(user != null){
        await FirebaseAuth.instance.signOut();
      }
    }catch(e){
      debugPrint("error firebase logout");
    }
    Get.offAllNamed('/login');
  }

}
