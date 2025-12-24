import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utill/app_constants.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_snack_bar.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import 'controller/report_controller.dart';

class ReportOrderListScreenVedic extends StatelessWidget {
  const ReportOrderListScreenVedic({super.key});

  @override
  Widget build(BuildContext context) {
    final ReportController controller = Get.put(ReportController());
    controller.getReportOrderList();
    return PopScope(
      onPopInvoked: (bool isPopGesture) {
        if (!isPopGesture) {
          if (Get.key.currentState?.canPop() ?? false) {
            Get.back();
          } else {
            Get.offAllNamed('/dashboard');
          }
        }
      },
      canPop: false,
      child: SafeArea(
          child: Scaffold(
            appBar: CustomAppBar(title: "My Pdf Report",onBackPressed:(){
              if (Get.key.currentState?.canPop() ?? false) {
                Get.back();
              } else {
                Get.offAllNamed('/dashboard');
              }
            }),
            body: Obx(
                  () {
                if (controller.isOrderSuccess.isTrue) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      await controller.getReportOrderList();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical:Dimensions.paddingSizeExtraSmall,horizontal: Dimensions.paddingSizeExtraSmall),
                        child: ListView.builder(
                          itemCount: controller.reportOrderListModel.data?.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {

                            String? type = controller.reportOrderListModel.data?[index].orderFor.toString();
                            String? requestBody = controller.reportOrderListModel.data?[index].requestBody.toString();

                            Map<String, dynamic> jsonMap = json.decode(requestBody.toString());
                            String name;
                            if (type == AppConstants.reportMatching) {
                              name = jsonMap['boy_name'];
                            }
                            else {
                              name = jsonMap['name'];
                            }

                            return GestureDetector(
                              onTap: (){
                                if(controller.reportOrderListModel.data?[index].status == 1){
                                  Get.toNamed('/pdf_viewer',arguments: {
                                    'title': name,
                                    // 'url': "https://icseindia.org/document/sample.pdf"
                                    'url': controller.reportOrderListModel.data![index].pdfFile.toString()
                                  });
                                }
                                else{
                                  CustomSnackBar.showBottom(AppStrings.reportStatus.tr);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeMediumSmall),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(color: ColorResources.colorPrimary),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: const Offset(0, 1),
                                        )
                                      ]
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomTextMedium(name,color: ColorResources.colorPrimaryDark,maxLines: 2,fontSize: Dimensions.fontSizeLarge),
                                      const Gap(2),
                                      CustomTextRegular('Order ID: ${controller.reportOrderListModel.data![index].orderId.toString()}',fontSize: Dimensions.fontSizeSmall),
                                      const Gap(2),
                                      CustomTextRegular('Order Type: ${controller.reportOrderListModel.data![index].orderFor.toString().toUpperCase()}',fontSize: Dimensions.fontSizeSmall),
                                      const Gap(2),
                                      CustomTextRegular('Price: ${AppStrings.rupeeSign}${controller.reportOrderListModel.data![index].totalAmount}',color: ColorResources.green,),
                                      const Gap(2),
                                      CustomTextRegular(controller.reportOrderListModel.data![index].createdAt.toString(),fontSize: Dimensions.fontSizeExtraSmall),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }
                else if (controller.isOrderLoading.isTrue) {
                  return ListView.builder(
                    itemCount: 8,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return const SimmerListView();
                    },
                  );
                } else {
                  return const EmptyScreen();
                }
              },
            ),
          )),
    );
  }
}