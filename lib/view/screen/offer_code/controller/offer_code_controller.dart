import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../../../model/offer_code_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_default_indicator.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class OfferCodeController extends GetxController {
  final Dio _dio = Dio();

  // Offer Code
  RxString offerStatus = ''.obs;
  // Update offerStatus dynamically
  void updateOfferStatus(String status) {
    offerStatus.value = status;
  }
  final isOfferCodeLoading = false.obs;
  final isOfferCodeSuccess = false.obs;
  OfferCodeModel offerCodeModel = OfferCodeModel();

  // Offer Code
  Future<void> getOfferCode(String offerType) async {
    isOfferCodeLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getOfferCode, data: {
        "api_key": apiKey,
        "user_uni_id": uniId,
        "offer_type": offerType
      });
      if (response.statusCode == 200) {
        offerCodeModel = OfferCodeModel.fromJson(response.data);
        if (offerCodeModel.status == AppConstants.success) {
          isOfferCodeSuccess(true);
        } else {
          isOfferCodeSuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isOfferCodeSuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isOfferCodeLoading(false);
    }
  }

  void offerCodeBottomSheet(BuildContext context, TextEditingController offerCodeController, {required Function() applyOffer}) {
    getOfferCode("");
    final draggableController = DraggableScrollableController();

    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      showDragHandle: true,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: ColorResources.black8,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          controller: draggableController,
          initialChildSize: 0.5,
          minChildSize: 0.25,
          maxChildSize: 1.0,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,right: 12),
                  child: Row(
                    children: [
                      Image.asset(Images.discountCoupon,height: 24,width: 20,color: ColorResources.colorPrimaryDark),
                      const Gap(6),
                      Expanded(
                        child: CustomTextMedium(
                          AppStrings.allOfferForYou.tr,
                          fontSize: Dimensions.fontSizeExtraLarge,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.cancel,
                            color: ColorResources.black4,
                          )
                      )
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: Obx(
                        () {
                      if (isOfferCodeSuccess.isTrue) {
                        return ListView.builder(
                          controller: scrollController,
                          itemCount: offerCodeModel.data?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: ColorResources.white,
                                  borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 1),
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextMedium(
                                      offerCodeModel.data![index].offerName.toString(),
                                    ),
                                    const Gap(5),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomTextRegular(
                                            "Offer Valid: ${offerCodeModel.data![index].offerValidityTo.toString()}",
                                            fontSize: Dimensions.fontSizeSmall,
                                            color: ColorResources.black2,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // Clipboard.setData(
                                            //   ClipboardData(
                                            //     text: offerCodeModel.data![index].offerCode.toString(),
                                            //   ),
                                            // );
                                            // Set the selected offer code in the TextField
                                            offerCodeController.text = offerCodeModel.data![index].offerCode.toString();

                                            // Close the bottom sheet
                                            Get.back();
                                            // Automatically apply the offer
                                            applyOffer.call();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                                              border: Border.all(color: ColorResources.colorPrimaryDark),
                                            ),
                                            child: CustomTextMedium(
                                              offerCodeModel.data![index].offerCode.toString(),
                                              fontSize: Dimensions.fontSizeSmall,
                                              color: ColorResources.colorPrimaryDark,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (isOfferCodeLoading.isTrue) {
                        return const CustomDefaultProgressIndicator();
                      } else {
                        return const EmptyScreen();
                      }
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}