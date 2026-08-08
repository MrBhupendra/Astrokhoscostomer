import 'package:astro_brahmand/view/widget/custom_progress_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../model/category_model.dart';
import '../../../../model/success_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_default_indicator.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../../widget/custom_text_medium.dart';
import '../model/predefined_category_model.dart';
import '../model/predefined_message_model.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class PredefinedMessageController extends GetxController {
  final Dio _dio = Dio();
  final isMessageLoading = false.obs;
  final isMessageSuccess = false.obs;

  bool isNoMoreData = false;
  ScrollController scrollController = ScrollController();
  num offsetCount = 0;

  //MessageCategory
  final isCategoryLoading = false.obs;
  final isCategorySuccess = false.obs;
  PredefinedCategoryModel categoryModel = PredefinedCategoryModel();
  //Filter
  String categorySelected = "";
  RxInt selectedIndex = 0.obs;

  void selectCategory(int index) {
    selectedIndex.value = index;
    offsetCount = 0; // Reset offset when category is changed
    isNoMoreData = false; // Reset no more data flag
  }

  //Messages
  PredefinedMessageModel predefinedMessageModel = PredefinedMessageModel();
  List<PredefinedMessages> predefinedMessageList = [];

  final isRefresh = false.obs;

  Future<void> getCategory() async {
    isCategoryLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getPredefinedMessageCategory, data: {
        "api_key" : apiKey,
        "user_uni_id": uniId,
      });
      if (response.statusCode == 200) {
        categoryModel = PredefinedCategoryModel.fromJson(response.data);
        if (categoryModel.status == AppConstants.success) {
          isCategorySuccess(true);
        } else {
          isCategorySuccess(false);
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      isCategorySuccess(false);
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isCategoryLoading(false);
    }
  }

  Future<void> getPredefinedMessages(messageType, {num? offset = -1, String? createdBy = "",String? categoryId = ""}) async {
    if(offset == 0){
      offsetCount = 0;
      isNoMoreData = false;
      predefinedMessageList.clear();
    }

    isMessageLoading(true);
    try {
      String? apiKey = await SharedPreferencesHelper.getData(AppConstants.userApiKey);
      String? uniId = await SharedPreferencesHelper.getData(AppConstants.userUniId);
      final response = await _dio.post(AppConstants.getPredefinedMessage, data: {
        'api_key': apiKey,
        'user_uni_id': uniId,
        'created_by' : createdBy,
        "offset": offset,
        "message_type": messageType,
        "category_id": categoryId
      });
      isRefresh(false);
      if (response.statusCode == 200) {
        predefinedMessageModel = PredefinedMessageModel.fromJson(response.data);
        if(predefinedMessageModel.status == AppConstants.success){
          offsetCount = predefinedMessageModel.offset!;
          isMessageSuccess(true);

          for (var element in (predefinedMessageModel.predefinedMessages ?? [])) {
            predefinedMessageList.add(element);
          }
          AppLogger.d("Request length ${predefinedMessageList.length}");
        }
        else{
          if(offset == 0){
            isMessageSuccess(false);
          }
          isNoMoreData = true;
        }
      } else {
        AppLogger.d('OnApiError');
      }
    } catch (e) {
      AppLogger.d('OnException==> ${e.toString()}');
    } finally {
      isMessageLoading(false);
    }
  }

  void showPredefinedMessagesBottomSheet(BuildContext context, {required Function(int index) onItemSelected}){
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
                     crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextMedium(
                        AppStrings.suggestions.tr,
                        fontSize: Dimensions.fontSizeExtraLarge,
                      ),
                      const Gap(5),
                      Image.asset(Images.icWrite,height: 25,width: 25),
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  children: [
                    Visibility(
                      visible: isCategorySuccess.isTrue,
                      child: Flexible(
                        child: SizedBox(
                          height: 48,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: (categoryModel.predefinedMessageCategory?.length ?? 0) + 1,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                // Handling "All" option
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        selectCategory(0);
                                        isMessageSuccess.value = false;
                                        getPredefinedMessages(AppConstants.preTypeAiChat,offset: 0,createdBy: AppConstants.createdByAdmin,categoryId: "");// 0 for "All"
                                      },
                                      child: Obx(() => AnimatedContainer(
                                        duration: const Duration(milliseconds: 300),
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: selectedIndex.value == 0
                                              ? Colors.white70
                                              : Colors.white54,
                                          borderRadius: selectedIndex.value == 0
                                              ? BorderRadius.circular(12)
                                              : BorderRadius.circular(10),
                                          border: selectedIndex.value == 0
                                              ? Border.all(
                                              color: ColorResources.colorPrimary,
                                              width: 1.5)
                                              : Border.all(
                                              color: ColorResources.black6,
                                              width: 1.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 16),
                                          child: Text(
                                            AppStrings.all,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: selectedIndex.value == 0
                                                  ? ColorResources.colorPrimaryDark
                                                  : ColorResources.black4,
                                            ),
                                          ),
                                        ),
                                      )),
                                    ),
                                  ],
                                );
                              } else {
                                // Handling other categories
                                // final categoryIndex = index - 1;
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        selectCategory(index);
                                        isMessageSuccess.value = false;
                                        String? selectedCategoryId = categoryModel.predefinedMessageCategory?[index - 1].id.toString();
                                        getPredefinedMessages(AppConstants.preTypeAiChat,offset: 0,createdBy: AppConstants.createdByAdmin,categoryId:selectedCategoryId);
                                      },
                                      child: Obx(() => AnimatedContainer(
                                        duration: const Duration(milliseconds: 300),
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: selectedIndex.value == index
                                              ? Colors.white70
                                              : Colors.white54,
                                          borderRadius: selectedIndex.value == index
                                              ? BorderRadius.circular(12)
                                              : BorderRadius.circular(10),
                                          border: selectedIndex.value ==
                                              index
                                              ? Border.all(
                                              color: ColorResources.colorPrimary,
                                              width: 1.5)
                                              : Border.all(
                                              color: ColorResources.black6,
                                              width: 1.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                                          child: Text(
                                            categoryModel.predefinedMessageCategory![index - 1].title.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: selectedIndex.value == index
                                                  ? ColorResources.colorPrimaryDark
                                                  : ColorResources.black4,
                                            ),
                                          ),
                                        ),
                                      )),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(child: Obx(
                        () {
                      if (isMessageSuccess.isTrue) {
                        return ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: predefinedMessageList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                  onItemSelected.call(index);
                                },
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
                                        predefinedMessageList[index].message.toString(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      else if (isMessageLoading.isTrue) {
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