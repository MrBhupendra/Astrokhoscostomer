import 'dart:convert';

import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import 'controller/report_horo_controller.dart';

class ReportOrderListScreen extends StatelessWidget {
  const ReportOrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ReportHoroController controller = Get.put(ReportHoroController());
    controller.getReportOrderList(0);
    return SafeArea(
        child: Scaffold(
          appBar: const CustomAppBar(title: "My Report"),
          body: SingleChildScrollView(
            child: Obx(
                  () {
                if (controller.isOrderSuccess.isTrue) {
                  return  Padding(
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
                                      border: Border.all(color: ColorResources.colorPrimary),
                                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault)
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
                                                          // fontSize: Dimensions.fontSizeLarge
                                                      )
                                                      ),
                                                      const Icon(Icons.arrow_forward_ios_rounded,size: Dimensions.iconSizeOverSmall,color: ColorResources.colorPrimary),
                                                    ],
                                                  ),
                                                ),
                                                CustomTextRegular(name,color: ColorResources.colorPrimary),
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
          ),
    ));
  }
}
