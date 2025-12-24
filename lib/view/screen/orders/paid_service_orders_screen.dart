import 'dart:convert';

import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:astro_brahmand/view/screen/orders/controller/paid_service_order_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_network_image.dart';
import '../../widget/custom_snack_bar.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import '../../widget/simmer_widget/simmer_list_view.dart';

class PaidServiceOrdersScreen extends GetView<PaidServiceOrderController> {
  final String type;
  const PaidServiceOrdersScreen(this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    if(type == AppConstants.sanjeeviniOrder){
      controller.sanjeeviniPurchaseList();
    }else if(type == AppConstants.switchwordOrder){
      controller.switchWordPurchaseList();
    }else if(type == AppConstants.pdfBookOrder){
      controller.pdfBookPurchaseList();
    }else if(type == AppConstants.reportOrder){
      controller.getReportOrderList(0);
    }

    return Obx(
          () {

            if (type == AppConstants.sanjeeviniOrder) {
              if (controller.isSanjeeviniLoading.isTrue) {
                return ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const SimmerListView();
                  },
                );
              }
              else {
                return controller.isSanjeeviniSuccess.isTrue
                    ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeExtraSmall,
                      vertical: Dimensions.paddingSizeExtraSmall),
                  child: ListView.builder(
                    itemCount: controller.sanjeeviniPurchaseListModel.data?.length,
                    itemBuilder: (context, index) {
                      // var orderDetails = controller.productOrderModel.data![index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('/sanjeeviniDetail', arguments: {
                            'image': controller.sanjeeviniPurchaseListModel.data?[index].sanjeeviniImage.toString(),
                            'title': controller.sanjeeviniPurchaseListModel.data?[index].title.toString()
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: Dimensions.paddingSizeOverSmall),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorResources.white,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.borderRadiusDefault),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeSmall,
                                vertical: Dimensions.paddingSizeDefault,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomTextMedium(
                                          controller.sanjeeviniPurchaseListModel.data![index].title.toString(),
                                          color: ColorResources.colorPrimary,
                                          maxLines: 2,
                                        ),
                                        const Gap(2),
                                        CustomTextRegular(
                                          'Order ID: ${controller.sanjeeviniPurchaseListModel.data?[index].orderId}',
                                          fontSize: Dimensions.fontSizeSmall,
                                          maxLines: 1,
                                        ),
                                        const Gap(2),
                                        CustomTextRegular(
                                          'Ordered on: ${CommonMethods().formatDateTimeOutput(controller.sanjeeviniPurchaseListModel.data![index].createdAt.toString())}',
                                          fontSize: Dimensions.fontSizeSmall,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Image.asset(
                                  //   Images.placeholder,
                                  //   height: 60,
                                  // ),
                                  CustomNetworkImage(
                                      imageUrl: controller.sanjeeviniPurchaseListModel.data![index].sanjeeviniImage.toString(),
                                      height: 70,
                                      width: 70
                                  ),
                                  const Gap(10),
                                  const Icon(Icons.arrow_forward_ios_rounded,color: ColorResources.green,size: 18),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
                    : const EmptyScreen();
              }
            }

            if (type == AppConstants.switchwordOrder) {
              if (controller.isDivineLoading.isTrue) {
                return ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const SimmerListView();
                  },
                );
              }
              else {
                return controller.isDivineSuccess.isTrue
                    ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeExtraSmall,
                      vertical: Dimensions.paddingSizeExtraSmall),
                  child: ListView.builder(
                    itemCount: controller.switchwordPurchaseListModel.data?.length,
                    itemBuilder: (context, index) {
                      // var orderDetails = controller.productOrderModel.data![index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('/switchDetail', arguments: {
                            'image': controller.switchwordPurchaseListModel.data?[index].switchwordImage.toString(),
                            'title' : controller.switchwordPurchaseListModel.data?[index].title.toString()
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: Dimensions.paddingSizeOverSmall),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorResources.white,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.borderRadiusDefault),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeSmall,
                                vertical: Dimensions.paddingSizeDefault,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomTextMedium(
                                          controller.switchwordPurchaseListModel.data![index].title.toString(),
                                          color: ColorResources.colorPrimary,
                                          maxLines: 2,
                                        ),
                                        const Gap(2),
                                        CustomTextRegular(
                                          'Order ID: ${controller.switchwordPurchaseListModel.data?[index].orderId}',
                                          fontSize: Dimensions.fontSizeSmall,
                                          maxLines: 1,
                                        ),
                                        const Gap(2),
                                        CustomTextRegular(
                                          'Ordered on: ${controller.switchwordPurchaseListModel.data?[index].createdAt}',
                                          fontSize: Dimensions.fontSizeSmall,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Image.asset(
                                  //   Images.placeholder,
                                  //   height: 60,
                                  // ),
                                  CustomNetworkImage(
                                      imageUrl: controller.switchwordPurchaseListModel.data![index].switchwordImage.toString(),
                                      height: 70,
                                      width: 70
                                  ),
                                  const Gap(10),
                                  const Icon(Icons.arrow_forward_ios_rounded,color: ColorResources.green,size: 18),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
                    : const EmptyScreen();
              }
            }

            if (type == AppConstants.pdfBookOrder) {
              if (controller.isEbookLoading.isTrue) {
                return ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const SimmerListView();
                  },
                );
              }
              else {
                return controller.isEbookSuccess.isTrue
                    ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeExtraSmall,
                      vertical: Dimensions.paddingSizeExtraSmall),
                  child: ListView.builder(
                    itemCount: controller.pdfBookPurchaseListModel.data?.length,
                    itemBuilder: (context, index) {
                      // var orderDetails = controller.productOrderModel.data![index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('/pdf_viewer',arguments: {
                            'title': controller.pdfBookPurchaseListModel.data![index].title.toString(),
                            'url': controller.pdfBookPurchaseListModel.data![index].mainPdf.toString()
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: Dimensions.paddingSizeOverSmall),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorResources.white,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.borderRadiusDefault),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeSmall,
                                vertical: Dimensions.paddingSizeDefault,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomTextMedium(
                                          controller.pdfBookPurchaseListModel.data![index].title.toString(),
                                          color: ColorResources.colorPrimary,
                                          maxLines: 2,
                                        ),
                                        const Gap(2),
                                        CustomTextRegular(
                                          'Order ID: ${controller.pdfBookPurchaseListModel.data?[index].orderId}',
                                          fontSize: Dimensions.fontSizeSmall,
                                          maxLines: 1,
                                        ),
                                        const Gap(2),
                                        CustomTextRegular(
                                          'Ordered on: ${controller.pdfBookPurchaseListModel.data?[index].createdAt}',
                                          fontSize: Dimensions.fontSizeSmall,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Image.asset(
                                  //   Images.placeholder,
                                  //   height: 60,
                                  // ),
                                  CustomNetworkImage(
                                      imageUrl: controller.pdfBookPurchaseListModel.data![index].pdfImage.toString(),
                                      height: 70,
                                      width: 70
                                  ),
                                  const Gap(10),
                                  const Icon(Icons.arrow_forward_ios_rounded,color: ColorResources.green,size: 18),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
                    : const EmptyScreen();
              }
            }

            if (type == AppConstants.reportOrder) {
              if (controller.isReportLoading.isTrue) {
                return ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const SimmerListView();
                  },
                );
              }
              else {
                return controller.isReportSuccess.isTrue
                    ? Padding(
                  padding: const EdgeInsets.symmetric(vertical:Dimensions.paddingSizeExtraSmall,horizontal: Dimensions.paddingSizeOverSmall),
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: controller.reportOrderListModel.data?.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {

                          String? type = controller.reportOrderListModel.data?[index].orderFor.toString();
                          String? requestBody = controller.reportOrderListModel.data?[index].requestBody.toString();

                          Map<String, dynamic> jsonMap = json.decode(requestBody.toString());
                          String name;
                          if (type == AppConstants.married) {
                            // Extracting values from the JSON
                            name = jsonMap['boy_name'];
                          }
                          else {
                            // Extracting values from the JSON
                            name = jsonMap['name'];
                          }
                          String statusText;
                          Color containerColor;
                          Color textColor;
                          num? status = controller.reportOrderListModel.data?[index].status;
                          if (status == 1) {
                            statusText = "Completed";
                            containerColor = ColorResources.colorPrimary;
                            textColor = ColorResources.white;
                          }
                          else {
                            statusText = "In Progress";
                            containerColor = Colors.yellow;
                            textColor = ColorResources.black2;
                          }

                          return GestureDetector(
                            onTap: (){
                              if(controller.reportOrderListModel.data?[index].status == 1){
                                Get.toNamed('/pdf_viewer',arguments: {
                                  'title': controller.reportOrderListModel.data![index].title.toString(),
                                  'url': controller.reportOrderListModel.data![index].pdfFile.toString()
                                });
                              }
                              else{
                                CustomSnackBar.showBottom(AppStrings.reportStatus.tr);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical:Dimensions.paddingSizeExtraOverSmall),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorResources.white,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.borderRadiusDefault),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 1),
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                                  child: Row(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(Dimensions.borderRadiusExtraSmall),
                                            child: CustomNetworkImage(
                                                imageUrl: controller.reportOrderListModel.data![index].paidKundliManualImage.toString(),
                                                width: Dimensions.imageWidthDefault,
                                                height: Dimensions.imageWidthDefault
                                            )
                                        ),
                                      ),
                                      const Gap(6),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: 4),
                                                child: Row(
                                                  children: [
                                                    Expanded(child: CustomTextMedium(
                                                      controller.reportOrderListModel.data![index].title.toString(),
                                                        color: ColorResources.colorPrimary
                                                    )
                                                    ),
                                                    const Icon(Icons.arrow_forward_ios_rounded,size: Dimensions.iconSizeOverSmall,color: ColorResources.colorPrimary),
                                                  ],
                                                ),
                                              ),
                                              CustomTextRegular(name),
                                              const Gap(2),
                                              CustomTextRegular('Order ID: ${controller.reportOrderListModel.data![index].orderId.toString()}',fontSize: Dimensions.fontSizeExtraSmall),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: CustomTextRegular(CommonMethods().formatDateTimeOutput(controller.reportOrderListModel.data![index].createdAt.toString()),fontSize: Dimensions.fontSizeExtraSmall),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: containerColor,
                                                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusExtraSmall),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(Dimensions.paddingSizeExtraOverSmall),
                                                      child: CustomTextRegular(
                                                        statusText,
                                                        fontSize: Dimensions.fontSizeSmall,
                                                        color: textColor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
                    : const EmptyScreen();
              }
            }


           else{
             return Center(
               child: CustomTextRegular(
                 AppStrings.somethingWentWrong.tr,
                 fontSize: Dimensions.fontSizeLarge,
               ),
             );
           }
      },
    );
  }
}
