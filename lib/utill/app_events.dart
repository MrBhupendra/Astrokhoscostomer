import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AppEvents {
  //Events
  static final facebookAppEvents = FacebookAppEvents();

  Future<void> sendSignInEvent(
      String method, String userUniId, String mobileNumber) async {
    //Firebase Analytics
    await FirebaseAnalytics.instance.logLogin(
      loginMethod: method,
      parameters: {"userUniId": userUniId, "mobile": mobileNumber},
    );

    //facebook
    facebookAppEvents.logEvent(
      name: "login",
      parameters: {"userUniId": userUniId, "mobile": mobileNumber},
    );
  }

  Future<void> sendSignupEvent(
      String method, String userUniId, String mobileNumber) async {
    //Firebase Analytics
    await FirebaseAnalytics.instance.logSignUp(
      signUpMethod: method,
      parameters: {"userUniId": userUniId, "mobile": mobileNumber},
    );

    //facebook
    facebookAppEvents.logCompletedRegistration(registrationMethod: method);
  }

  Future<void> sendInitCheckoutEvent(String amount, String orderId, String userUniId, String type) async {
    //Firebase Analytics
    await FirebaseAnalytics.instance.logBeginCheckout(
      value: double.parse(amount.toString()),
      currency: "INR",
      parameters: {"userUniId": userUniId, "type": type, "order_id": orderId},
    );

    //facebook
    facebookAppEvents.logInitiatedCheckout(
        totalPrice: double.parse(amount.toString()),
        currency: "INR",
        contentId: orderId,
        contentType: type);
  }

  Future<void> sendPaymentSuccessEvent(String amount, String orderId, String userUniId, String type) async {
    //Firebase Analytics
    await FirebaseAnalytics.instance.logPurchase(
      value: double.parse(amount.toString()),
      currency: "INR",
      transactionId: orderId,
      parameters: {
        "userUniId": userUniId,
        "type": type,
        "order_id": orderId
      },
    );

    //facebook
    facebookAppEvents.logPurchase(
      amount: double.parse(amount.toString()),
      currency: "INR",
      parameters: {
        "userUniId": userUniId,
        "type": type,
        "order_id": orderId
      },
    );
  }
}
