import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/utill/dimensions.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utill/app_strings.dart';
import '../../../../utill/images.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_regular.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import '../../splash/controller/config_controller.dart';
import 'controller/report_horo_controller.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class ReportListScreen extends StatelessWidget {
  const ReportListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();
    final ReportHoroController controller = Get.put(ReportHoroController());
    controller.offsetCount = 0;
    controller.getReportKundliList(controller.offsetCount,"");

    controller.scrollController.addListener(() {
      if (controller.scrollController.position.pixels ==
          controller.scrollController.position.maxScrollExtent) {
        if (controller.isReportLoading.isFalse && !controller.isNoMoreData) {
          controller.getReportKundliList(controller.offsetCount, controller.searchQuery.value);
        }
      }
    });

    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.report.tr,
        icon: Icons.my_library_books_outlined,
        onActionPressed: () {
          Get.toNamed('/paid_orders_tab_screen', arguments: {'index': 3});
        },
      ),
      body: Obx(
        () {
          if (controller.isReportSuccess.isTrue) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: Dimensions.paddingSizeExtraSmall,
                  horizontal: Dimensions.paddingSizeExtraSmall),
              child: Column(
                children: [
                  // Search Box
                  Padding(
                    padding: const EdgeInsets.only(left: 0,right: 0,bottom: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorResources.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 3.0,
                            spreadRadius: 1,
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (value) {
                          AppLogger.d("Search Value-> $value");
                          // Future.delayed(const Duration(seconds: 1), () {
                          //   controller.search(value);
                          // });
                          controller.search(value);
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Search Report',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              Images.search,
                              width: 18,
                              height: 18,
                              color: ColorResources.colorPrimary,
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await controller.getReportKundliList(controller.offsetCount,"");
                      },
                      child: ListView.builder(
                        itemCount: controller.reportListData.length,
                        controller: controller.scrollController,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed("/report_detail_screen",
                                  arguments: controller.reportListData[index]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0,left: 0,right: 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: const [
                                      BoxShadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 3,
                                          color: Colors.grey
                                      ),
                                    ],
                                    border: Border.all(
                                      color: ColorResources.colorPrimary,
                                      // width: 0.5,
                                    )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 0),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                                          child: CustomNetworkImage(
                                              imageUrl: controller.reportListData[index].paidKundliManualImage.toString(),
                                              height: 150,
                                              width: Get.width
                                          )
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.start,
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                // mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CustomTextMedium(
                                                    controller.reportListData[index].title.toString(),maxLines: 2,
                                                  ),
                                                  const Gap(2),
                                                  CustomTextMedium("${configController.currencySymbol} ${controller.reportListData[index].price.toString()}/-",color: ColorResources.colorPrimaryDark,fontSize: Dimensions.fontSizeFifteen,),
                                                ],
                                              ),
                                            ),
                                            const Gap(2),
                                            GestureDetector(
                                              onTap: (){
                                                 Get.toNamed("/report_horo_submit",
                                                     arguments: controller.reportListData[index]);
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: Dimensions.paddingSizeSmall,
                                                    vertical: Dimensions.paddingSizeOverSmall
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                                                  // color: ColorResources.colorPrimary, // Replace with your primary color
                                                  border: Border.all(color: ColorResources.colorPrimary),
                                                ),
                                                child: CustomTextRegular(
                                                  "Book Now",
                                                  textAlign: TextAlign.center,
                                                  color: ColorResources.colorPrimary,
                                                ),
                                              ),
                                            ),
                                            // CustomButton(
                                            //   "Book Now",
                                            //   onPressed: () {
                                            //     Get.toNamed("/report_horo_submit", arguments: controller.reportListData[index]);
                                            //   },
                                            //   fontSize: Dimensions.fontSizeSmall,
                                            //   color: ColorResources.white,
                                            //   minimumSize: const Size(80, 32),
                                            // ),

                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                  // Row(
                                  //   // crossAxisAlignment: CrossAxisAlignment.start,
                                  //   children: [
                                  //     Padding(
                                  //       padding: const EdgeInsets.symmetric(vertical: 0.0),
                                  //       child: ClipRRect(
                                  //           borderRadius: BorderRadius.circular(8),
                                  //           child: CustomNetworkImage(
                                  //               imageUrl: controller.reportListData[index].paidKundliManualImage.toString(),
                                  //               height: Dimensions.imageHeightLarge,
                                  //               width: Dimensions.imageHeightLarge)
                                  //       ),
                                  //     ),
                                  //     const Gap(10),
                                  //     Expanded(
                                  //       child: Column(
                                  //         crossAxisAlignment: CrossAxisAlignment.start,
                                  //         children: [
                                  //           const Gap(4),
                                  //           CustomTextMedium(
                                  //             controller.reportListData[index].title.toString(),
                                  //             color: ColorResources.colorPrimary,
                                  //             maxLines: 2,
                                  //             // fontSize: Dimensions.fontSizeLarge,
                                  //           ),
                                  //
                                  //           Row(
                                  //             // mainAxisAlignment: MainAxisAlignment.end,
                                  //             children: [
                                  //               Expanded(
                                  //                 child: CustomTextMedium(
                                  //                   '${configController.currencySymbol} ${controller.reportListData[index].price.toString()}/-',
                                  //                   fontSize: Dimensions.fontSizeSmall,
                                  //                 ),
                                  //               ),
                                  //               CustomButton(
                                  //                 "Book Now",
                                  //                 onPressed: () {
                                  //                   Get.toNamed("/report_horo_submit",
                                  //                       arguments: controller.reportListData[index]);
                                  //                 },
                                  //                 fontSize: Dimensions.fontSizeSmall,
                                  //                 color: ColorResources.white,
                                  //                 minimumSize: const Size(35, 26),
                                  //               ),
                                  //               const Gap(4),
                                  //             ],
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.isReportLoading.isTrue,
                      child: CustomTextRegular('Loading...'),
                    ),
                  )
                ],
              ),
            );
          } else if (controller.isReportLoading.isTrue) {
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
    ));
  }
}
