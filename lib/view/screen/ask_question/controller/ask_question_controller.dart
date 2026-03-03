import 'package:astro_brahmand/model/success_model.dart';
import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:astro_brahmand/view/screen/ask_question/controller/typing_controller.dart';
import 'package:astro_brahmand/view/screen/ask_question/model/ai_profile_model.dart';
import 'package:astro_brahmand/view/screen/ask_question/model/question_history_list_model.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utill/app_constants.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_elevated_button.dart';
import '../../../widget/custom_progress_dialog.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../splash/controller/config_controller.dart';
import '../model/question_calculation_model.dart';
import '../model/question_purchase_model.dart';

class AskQuestionController extends FullLifeCycleController
    with FullLifeCycleMixin {
  final DashboardController dashboardController = Get.put<DashboardController>(DashboardController());
  final TextEditingController messageController = TextEditingController();

  //Profile
  final isProfileListLoading = false.obs;
  final isProfileListSuccess = false.obs;
  AiProfileModel aiProfileModel = AiProfileModel();
  RxList<AiProfileListData> aiProfileListData = <AiProfileListData>[].obs;

  //Select Profile
  SuccessModel selectSuccessModel = SuccessModel();

  //Chat history
  final Dio _dio = Dio();
  final isChatHistoryLoading = false.obs;
  final isChatHistorySuccess = false.obs;
  QuestionHistoryListModel questionHistoryListModel = QuestionHistoryListModel();
  RxList<QuestionHistoryData> questionHistoryList = <QuestionHistoryData>[].obs;

  //Calculation
  final isCalculationLoading = false.obs;
  final isCalculationSuccess = false.obs;
  final isWalletSelected = 0.obs;
  RxString isOfferApplied = '0'.obs;


  RxString walletPayableAmount = '0'.obs;
  RxString totalPayableAmount = '0'.obs;
  RxString gstAmount = '0'.obs;
  QuestionCalculationModel questionCalculation = QuestionCalculationModel();

  final isPurchaseLoading = false.obs;
  final isPurchaseSuccess = false.obs;
  QuestionPurchaseModel purchaseModel = QuestionPurchaseModel();

  //Scroll
  ScrollController scrollController = ScrollController();
  num offsetCount = 1;
  bool isNoMoreData = false;

  String? perQuestionPrice;
  String? userUniId;
  RxString askingForName = "".obs;

  final ConfigController configController = Get.find();
  final TypingController typingController = Get.put(TypingController());

  @override
  void onInit() {
    super.onInit();
    perQuestionPrice = Get.arguments["price"];
    userUniId = Get.arguments["uniId"];
    getCalculation("", 1, "Wallet");
    getHistory(offsetCount);
    getProfiles();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (isChatHistoryLoading.isFalse && !isNoMoreData) {
          getHistory(offsetCount);
        }
      }
    });

    if (Get.currentRoute == '/ask_question_screen_new') {
      offsetCount = 1;
      isChatHistorySuccess(false);
    }
  }

  Future<void> getProfiles() async {
    isProfileListLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getAiProfileList,
          data: {'api_key': apiKey, 'user_uni_id': uniId});

      if (response.statusCode == 200) {
        aiProfileModel = AiProfileModel.fromJson(response.data);
        if (aiProfileModel.status == AppConstants.success) {
          aiProfileListData.clear();
          isProfileListSuccess(true);
          if (aiProfileModel.data!.isNotEmpty) {
            for (var element in (aiProfileModel.data ?? [])) {
              aiProfileListData.add(element);

              if(element.isSelected?.value == 1){
                askingForName.value = element.isSelfProfile == 1 ? "Yourself" : element.name.toString();
              }
            }
          } else {
            isNoMoreData = true;
          }
        } else {
          print('getChatHistory API Response else: ${response.data.toString()}');
          isNoMoreData = true;
        }
      } else {
        if (kDebugMode) {
          print('OnApiError getChatHistory');
        }
      }
    } catch (e) {
      isProfileListSuccess(false);
      if (kDebugMode) {
        print('OnException getChatHistory==> ${e.toString()}');
      }
    } finally {
      isProfileListLoading(false);
    }
  }

  Future<void> selectProfiles(String profileId) async {
    CustomProgressDialog.showDialog();
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.selectAiProfile, data: {'api_key': apiKey, 'user_uni_id': uniId,"open_ai_profile_id" : profileId});
      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        selectSuccessModel = SuccessModel.fromJson(response.data);
        if (selectSuccessModel.status == AppConstants.success) {
          questionHistoryList.clear();
          getHistory(1);
        } else {
          CustomSnackBar.showBottom("Unable to change profile.Please Try Again");
        }
      } else {
        CustomProgressDialog.dismissDialog();
        if (kDebugMode) {
          print('OnApiError getChatHistory');
        }
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      if (kDebugMode) {
        print('OnException getChatHistory==> ${e.toString()}');
      }
    }
  }

  Future<void> getHistory(num page) async {
    if (page == 1) {
      offsetCount = 1;
      isNoMoreData = false;
      questionHistoryList.clear();
    }

    isChatHistoryLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getQuestionHistoryList,
          data: {'api_key': apiKey, 'user_uni_id': uniId, 'page': page});

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('API Response getChatHistory: ${response.data.toString()}');
        }
        questionHistoryListModel = QuestionHistoryListModel.fromJson(response.data);
        if (questionHistoryListModel.status == AppConstants.success) {
          offsetCount = questionHistoryListModel.page!;
          isChatHistorySuccess(true);

          if (questionHistoryListModel.data!.isNotEmpty) {
            for (var element in (questionHistoryListModel.data ?? [])) {
              questionHistoryList.add(element);
            }
          } else {
            isNoMoreData = true;
          }

          if(page == 1){
            getProfiles();
          }
        } else {
          print('getChatHistory API Response else: ${response.data.toString()}');
          isNoMoreData = true;
        }
      } else {
        if (kDebugMode) {
          print('OnApiError getChatHistory');
        }
      }
    } catch (e) {
      isChatHistorySuccess(false);
      if (kDebugMode) {
        print('OnException getChatHistory==> ${e.toString()}');
      }
    } finally {
      isChatHistoryLoading(false);
    }
  }

  Future<void> getCalculation(String question, int walletCheck, String action) async {
    isCalculationLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.askQuestionCalculation, data: {'api_key': apiKey, "user_uni_id": uniId});

      if (response.statusCode == 200) {
        questionCalculation = QuestionCalculationModel.fromJson(response.data);
        if (questionCalculation.status == AppConstants.success) {
          isCalculationSuccess(true);

          isWalletSelected.value = walletCheck;

          gstAmount.value = questionCalculation.data!.rechargeGstValue.toString();

          totalPayableAmount.value = questionCalculation.data!.payableAmount.toString();

          if (action == "Open") {
            _showCalculationBottomSheet(question, questionCalculation.data);
          }
        } else {
          isCalculationSuccess(false);
        }
      } else {
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      isCalculationSuccess(false);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isCalculationLoading(false);
    }
  }

  Future<void> questionPurchase(String question) async {
    CustomProgressDialog.showDialog();
    isPurchaseLoading(true);
    try {
      String? apiKey =
      await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId =
      await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.askQuestionPurchase, data: {
        'api_key': apiKey,
        "user_uni_id": uniId,
        "question": question
      });


      if (response.statusCode == 200) {
        CustomProgressDialog.dismissDialog();
        purchaseModel = QuestionPurchaseModel.fromJson(response.data);
        if (purchaseModel.status == AppConstants.success) {
          dashboardController.getWalletBalance();
          isPurchaseSuccess(true);
          isCalculationSuccess(false);
          getCalculation("", 1, "Wallet");
          messageController.clear();

          var question = QuestionHistoryData(
              message: purchaseModel.questionData?.message.toString(),
              messageType: purchaseModel.questionData?.messageType.toString(),
              userUniId: purchaseModel.questionData?.userUniId.toString(),
              userName: purchaseModel.questionData?.userName.toString(),
              userImageUrl: purchaseModel.questionData?.userImageUrl.toString(),
              status: purchaseModel.questionData?.status,
              createdAt: purchaseModel.questionData?.createdAt.toString()
          );

          addMessage(question);
          var answer = QuestionHistoryData(
              message: purchaseModel.answerData?.message.toString(),
              messageType: purchaseModel.answerData?.messageType.toString(),
              userUniId: purchaseModel.answerData?.userUniId.toString(),
              userName: purchaseModel.answerData?.userName.toString(),
              userImageUrl: purchaseModel.answerData?.userImageUrl.toString(),
              status: purchaseModel.answerData?.status,
              createdAt: purchaseModel.answerData?.createdAt.toString()
          );

          addMessage(answer);
          typingController.isTyping(true);
        } else {
          isPurchaseSuccess(false);
          if(purchaseModel.errorCode == AppConstants.insufficientBalance){
            CommonMethods().showInsufficientBalancedDialog();
          }else{
            CustomSnackBar.showBottom(purchaseModel.msg.toString());
          }
        }
      } else {
        CustomProgressDialog.dismissDialog();
        // CustomSnackBar.showBottom(purchaseModel.msg.toString());
        if (kDebugMode) {
          print('OnApiError');
        }
      }
    } catch (e) {
      CustomProgressDialog.dismissDialog();
      isPurchaseSuccess(false);
      if (kDebugMode) {
        print('OnException==> ${e.toString()}');
      }
    } finally {
      isPurchaseLoading(false);
    }
  }

  void addMessage(QuestionHistoryData messageModel) {
    questionHistoryList.insert(0, messageModel);
  }

  void _showCalculationBottomSheet(String question, QuestionCalculationData? calculationData) {
    Get.bottomSheet(
      SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: Row(
                      children: [
                        // const Gap(20),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2),
                            child: Image.asset(
                              Images.back,
                              height: 24,
                              color: ColorResources.black,
                            ),
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                            child: CustomTextMedium(AppStrings.paymentInformation.tr,
                                color: ColorResources.black1,
                                fontSize: Dimensions.fontSizeLarge)),
        
                        // const Gap(10),
                      ],
                    ),
                  ),
                  const Divider(),
                  Container(
                    decoration: BoxDecoration(
                        color: ColorResources.white,
                        borderRadius:
                        BorderRadius.circular(Dimensions.borderRadiusDefault),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          )
                        ]),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: CustomTextMedium(
                              "Payment Detail",
                              color: ColorResources.colorPrimary,
                              fontSize: Dimensions.fontSizeLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextRegular(
                                  "Price",
                                  color: ColorResources.black1,
                                ),
                                CustomTextRegular(
                                  "${configController.currencySymbol} ${calculationData
                                      ?.openAiPredictionPrice}",
                                  color: ColorResources.black1,
                                ),
                              ],
                            ),
                          ),
                          Obx(() =>
                              Visibility(
                                visible: isWalletSelected.value == 1,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomTextRegular(
                                        "Wallet",
                                        color: ColorResources.black1,
                                      ),
                                      Obx(() =>
                                          CustomTextRegular(
                                            "${AppStrings
                                                .rupeeSign} ${walletPayableAmount
                                                .value}",
                                            color: ColorResources.black1,
                                          )),
                                    ],
                                  ),
                                ),
                              )),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextMedium("Total Payable",
                                    color: ColorResources.black),
                                Obx(() =>
                                    CustomTextMedium(
                                        "${AppStrings
                                            .rupeeSign} ${totalPayableAmount
                                            .value}",
                                        color: ColorResources.colorPrimary)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(10),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                    child: Row(
                      children: [
                        Image.asset(
                          Images.walletBalance,
                          height: 26,
                          color: ColorResources.colorPrimary,
                        ),
                        const Gap(15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextRegular("Wallet"),
                              CustomTextRegular(
                                "Available for payment ${AppStrings
                                    .rupeeSign} ${calculationData
                                    ?.myWalletAmount}",
                                color: ColorResources.black1,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const Gap(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: CustomElevatedButton(
                        text: AppStrings.proceedToPay.tr,
                        textColor: ColorResources.toolbarText,
                        backgroundColor: ColorResources.colorPrimary,
                        onPressed: () async {
                          questionPurchase(question);
                        }),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed("/wallet");
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextMedium("Recharge",
                              color: ColorResources.colorPrimary),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  void onDetached() {

  }

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {
    print("AskQuestionController onResumed");
  }

}
