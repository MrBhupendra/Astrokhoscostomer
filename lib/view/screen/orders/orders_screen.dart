import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:astro_brahmand/view/screen/agora/live_stream/controller/live_stream_init_controller.dart';
import 'package:astro_brahmand/view/screen/video_section/local_video_play_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../widget/custom_dialog_widget.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_network_image.dart';
import '../../widget/custom_round_network_image.dart';
import '../../widget/custom_snack_bar.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import '../../widget/simmer_widget/simmer_list_view.dart';
import '../agora/live_stream/controller/group_pooja_live_stream_init_controller.dart';
import '../chat/controller/chat_intake_form_controller.dart';
import '../splash/controller/config_controller.dart';
import 'controller/order_controller.dart';

class OrdersScreen extends GetView<OrderController> {
  final String type;

  const OrdersScreen(this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();
    if (type == AppConstants.allOrder) {
      controller.offsetCount = 0;
      controller.isCallSuccess(false);
      controller.getCallHistory("", controller.offsetCount);

      controller.scrollController.addListener(() {
        if (controller.scrollController.position.pixels ==
            controller.scrollController.position.maxScrollExtent) {
          if (controller.isCallLoading.isFalse && !controller.isNoMoreData) {
            controller.getCallHistory("", controller.offsetCount);
          }
        }
      });
    } else if (type == AppConstants.shopOrder) {
      controller.getShopOrder();
    } else if (type == AppConstants.serviceOrder) {
      controller.getServiceOrder();
    } else if (type == AppConstants.groupPoojaOrder) {
      controller.offsetCount = 0;
      controller.isGroupPoojaSuccess(false);
      controller.getGroupPoojaOrder(controller.offsetCount);

      controller.groupPoojaScrollController.addListener(() {
        if (controller.groupPoojaScrollController.position.pixels ==
            controller.groupPoojaScrollController.position.maxScrollExtent) {
          if (controller.isGroupPoojaLoading.isFalse &&
              !controller.isNoMoreGroupPoojaData) {
            controller.getGroupPoojaOrder(controller.offsetCount);
          }
        }
      });
    } else if (type == AppConstants.walletOrder) {
      controller.offsetCount = 0;
      controller.isWalletSuccess(false);
      controller.getWalletHistory(controller.offsetCount);

      controller.scrollController.addListener(() {
        if (controller.scrollController.position.pixels ==
            controller.scrollController.position.maxScrollExtent) {
          if (controller.isWalletLoading.isFalse && !controller.isNoMoreData) {
            controller.getWalletHistory(controller.offsetCount);
          }
        }
      });
    }
    else if (type == AppConstants.orderMandirDarshan) {
      controller.offsetCount = 0;
      controller.isMandirDarshanOrderListSuccess(false);
      controller.getCustomerMandirDarshanOrder(controller.offsetCount);

      controller.scrollController.addListener(() {
        if (controller.scrollController.position.pixels ==
            controller.scrollController.position.maxScrollExtent) {
          if (controller.isMandirDarshanOrderListLoading.isFalse &&
              !controller.isNoMoreMandirDarshanData) {
            controller.getCustomerMandirDarshanOrder(controller.offsetCount);
          }
        }
      });
    }

    return Obx(
          () {
        if (type == AppConstants.allOrder) {
          if (controller.isCallSuccess.isTrue) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeExtraOverSmall,
                          vertical: Dimensions.paddingSizeExtraExtraSmall),
                      child: ListView.builder(
                        itemCount: controller.orderHistoryData.length,
                        controller: controller.scrollController,
                        itemBuilder: (context, index) =>
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                                child: Container(
                                  color: ColorResources.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions.paddingSizeExtraSmall,
                                        vertical: Dimensions.paddingSizeExtraOverSmall),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Padding(
                                              padding: const EdgeInsets.all(Dimensions.paddingSizeOverSmall),
                                              child: Dialog(
                                                insetPadding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeOverSmall),
                                                child: FractionallySizedBox(
                                                  widthFactor: 1,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: ColorResources.white,
                                                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault), // Adjust the value for the desired border radius
                                                    ),
                                                    padding: const EdgeInsets.only(
                                                        left: Dimensions.paddingSizeDefault,
                                                        right: Dimensions.paddingSizeDefault,
                                                        bottom: Dimensions.paddingSizeDefault),
                                                    // color: ColorResources.white,
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: CustomTextMedium(
                                                                    'Order Detail',
                                                                    maxLines: 1),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Get.back();
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .all(6.0),
                                                                  child:
                                                                  Image.asset(
                                                                    Images
                                                                        .close,
                                                                    height: 12,
                                                                    color:
                                                                    ColorResources
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const Divider(
                                                            color: ColorResources
                                                                .black7,
                                                            height: 1),
                                                        const Gap(5),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              vertical: 4),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                CustomTextRegular(
                                                                  "Status:",
                                                                  color:
                                                                  ColorResources
                                                                      .black1,
                                                                  maxLines: 1,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left: Dimensions
                                                                          .paddingSizeMediumSmall),
                                                                  child:
                                                                  CustomTextRegular(
                                                                    controller
                                                                        .orderHistoryData[
                                                                    index]
                                                                        .status
                                                                        .toString()
                                                                        .toUpperCase(),
                                                                    color:
                                                                    ColorResources
                                                                        .black1,
                                                                    textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              vertical: 4),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                CustomTextRegular(
                                                                  "ID:",
                                                                  color:
                                                                  ColorResources
                                                                      .black1,
                                                                  maxLines: 1,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left: Dimensions
                                                                          .paddingSizeMediumSmall),
                                                                  child:
                                                                  CustomTextRegular(
                                                                    controller
                                                                        .orderHistoryData[
                                                                    index]
                                                                        .referenceId
                                                                        .toString(),
                                                                    color:
                                                                    ColorResources
                                                                        .black1,
                                                                    textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              vertical: 4),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                CustomTextRegular(
                                                                  "Total Charge:",
                                                                  color:
                                                                  ColorResources
                                                                      .black1,
                                                                  maxLines: 1,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      left: Dimensions
                                                                          .paddingSizeMediumSmall),
                                                                  child:
                                                                  CustomTextRegular(
                                                                    '${configController
                                                                        .currencySymbol} ${controller
                                                                        .orderHistoryData[index]
                                                                        .amount}',
                                                                    color:
                                                                    ColorResources
                                                                        .black1,
                                                                    textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        // leading: AspectRatio(
                                        //   aspectRatio: 1,
                                        //   child: CustomRoundNetworkImage(
                                        //       imageUrl: controller.orderHistoryData[index].astroImg.toString(),
                                        //       height: 50,
                                        //       width: 50
                                        //   ),
                                        // ),
                                        title: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomRoundNetworkImage(
                                                imageUrl: controller.orderHistoryData[index].astroImg.toString(),
                                                height: 50,
                                                width: 50
                                            ),
                                            const Gap(Dimensions.gapDefault),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: CustomTextMedium(
                                                          controller.orderHistoryData[index].displayName.toString(),
                                                          maxLines: 2,
                                                        ),
                                                      ),
                                                      CustomTextMedium(
                                                          "${configController.currencySymbol}${controller.orderHistoryData[index].amount}",
                                                          color: Colors.green,
                                                          maxLines: 1,
                                                        fontSize: 15,
                                                      ),
                                                    ],
                                                  ),
                                                  const Gap(Dimensions.gapExtraExtraSmall),
                                                  CustomTextRegular(
                                                    CommonMethods().formatDateTimeOutput(controller.orderHistoryData[index].createdAt.toString()),
                                                    fontSize: Dimensions.fontSizeSmall,
                                                    color: ColorResources.black1,
                                                    maxLines: 1,
                                                  ),
                                                  CustomTextRegular(
                                                    "Duration: ${CommonMethods().formatDurationFromSec(controller.orderHistoryData[index].duration ?? "0")}",
                                                    // "Duration: (${CommonMethods().formatDuration(controller.orderHistoryData[index].duration ?? "0")})",
                                                    fontSize: Dimensions.fontSizeSmall,
                                                    color: ColorResources.black1,
                                                    maxLines: 1,
                                                  ),
                                                  CustomTextMedium(
                                                      "Type: ${controller.orderHistoryData[index].callType.toString().toUpperCase()}",
                                                      color: ColorResources.black1,
                                                      maxLines: 1,
                                                      fontSize: Dimensions.fontSizeSmall),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      CustomTextMedium("Status: ",
                                                          fontSize: Dimensions.fontSizeSmall,
                                                          maxLines: 1,
                                                          color: ColorResources.black1),
                                                      Expanded(
                                                        child: CustomTextMedium(
                                                          controller.orderHistoryData[index].status.toString().toUpperCase(),
                                                          fontSize: Dimensions.fontSizeSmall,
                                                          maxLines: 1,
                                                          color: controller.orderHistoryData[index].status.toString() == "completed"
                                                              ? ColorResources.green
                                                              : Colors.orange,
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                  const Gap(5),
                                                  if(controller.orderHistoryData[index].offerType.toString() == "5" && controller.orderHistoryData[index].callType.toString() == "video")
                                                    Row(
                                                      children: [
                                                        CustomTextMedium("Video Call by "),
                                                        CustomTextMedium("Subscription",color: ColorResources.colorPrimary,),
                                                      ],
                                                    ),
                                                  if(controller.orderHistoryData[index].offerType.toString() == "5" && controller.orderHistoryData[index].callType.toString() == "chat")
                                                    Row(
                                                      children: [
                                                        CustomTextMedium("Chat by"),
                                                        CustomTextMedium(" Subscription",color: ColorResources.colorPrimary,),
                                                      ],
                                                    ),
                                                  if(controller.orderHistoryData[index].offerType.toString() == "5" && controller.orderHistoryData[index].callType.toString() == "call")
                                                    Row(
                                                      children: [
                                                        CustomTextMedium("Voice Call by "),
                                                        CustomTextMedium("Subscription",color: ColorResources.colorPrimary,),
                                                      ],
                                                    ),


                                                  // Row(
                                                  //   mainAxisAlignment: MainAxisAlignment.end,
                                                  //   children: [
                                                  //     if(controller.orderHistoryData[index].callHistoryImagesExists == 1)
                                                  //     GestureDetector(
                                                  //       onTap: () async {
                                                  //         ///ToDo
                                                  //         Get.toNamed("/call_image_list_screen",arguments: {
                                                  //           "uniqueId": controller.orderHistoryData[index].uniqeid.toString()
                                                  //         });
                                                  //       },
                                                  //       child: Container(
                                                  //         padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                                                  //         decoration: BoxDecoration(
                                                  //           borderRadius: BorderRadius.circular(5),
                                                  //           border: Border.all(
                                                  //               color: ColorResources.colorPrimary,
                                                  //               width: 1.5
                                                  //           ),
                                                  //         ),
                                                  //         child: CustomTextRegular(
                                                  //           "View Images",
                                                  //           fontSize: Dimensions.fontSizeSmall,
                                                  //           maxLines: 1,
                                                  //           color: ColorResources.colorPrimaryDark,
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //     const Gap(5),
                                                  //     const Icon(
                                                  //         Icons.arrow_forward_ios_rounded,
                                                  //         size: 16,
                                                  //         color: ColorResources.colorPrimaryDark),
                                                  //   ],
                                                  // )

                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      // ==================== PLAY RECORDING ====================
                                                      // Voice calls and video calls both have a recording.
                                                      if (controller.canPlayRecording(
                                                          controller.orderHistoryData[index].callType))
                                                        Obx(() {
                                                          final String uniqueId = controller
                                                              .orderHistoryData[index].uniqeid
                                                              .toString()
                                                              .trim();

                                                          final bool isVideo = controller.isVideoRecording(
                                                              controller.orderHistoryData[index].callType);

                                                          final bool isLoading =
                                                          controller.isRecordingLoadingFor(uniqueId);

                                                          final bool isPlaying =
                                                          controller.isRecordingPlayingFor(uniqueId);

                                                          return GestureDetector(
                                                            onTap: () => controller.toggleRecording(
                                                                uniqueId,
                                                                isVideo: isVideo),
                                                            child: Container(
                                                              padding: const EdgeInsets.symmetric(
                                                                vertical: 5,
                                                                horizontal: 8,
                                                              ),
                                                              decoration: BoxDecoration(
                                                                color: ColorResources.colorPrimary.withOpacity(0.08),
                                                                borderRadius: BorderRadius.circular(6),
                                                                border: Border.all(
                                                                  color: ColorResources.colorPrimary,
                                                                  width: 1.2,
                                                                ),
                                                              ),
                                                              child: Row(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [

                                                                  // ==========================================
                                                                  // ICON
                                                                  // ==========================================
                                                                  if (isLoading)
                                                                    const SizedBox(
                                                                      height: 14,
                                                                      width: 14,
                                                                      child: CircularProgressIndicator(
                                                                        strokeWidth: 1.8,
                                                                      ),
                                                                    )
                                                                  else
                                                                    Icon(
                                                                      isPlaying
                                                                          ? Icons.stop_circle_rounded
                                                                          : isVideo
                                                                              ? Icons.play_circle_outline_rounded
                                                                              : Icons.play_circle_fill_rounded,
                                                                      size: 18,
                                                                      color: ColorResources.colorPrimary,
                                                                    ),

                                                                  const SizedBox(width: 4),

                                                                  // ==========================================
                                                                  // TEXT
                                                                  // ==========================================
                                                                  CustomTextRegular(
                                                                    isLoading
                                                                        ? "Loading..."
                                                                        : isPlaying
                                                                        ? "Stop"
                                                                        : "Recording",
                                                                    fontSize: Dimensions.fontSizeSmall,
                                                                    maxLines: 1,
                                                                    color: ColorResources.colorPrimaryDark,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }),

                                                      // ==================== VIEW IMAGES ====================
                                                      if (controller.orderHistoryData[index].callHistoryImagesExists == 1)
                                                        ...[
                                                          const Gap(5),

                                                          GestureDetector(
                                                            onTap: () async {
                                                              Get.toNamed(
                                                                "/call_image_list_screen",
                                                                arguments: {
                                                                  "uniqueId": controller
                                                                      .orderHistoryData[index]
                                                                      .uniqeid
                                                                      .toString(),
                                                                },
                                                              );
                                                            },
                                                            child: Container(
                                                              padding: const EdgeInsets.symmetric(
                                                                vertical: 2,
                                                                horizontal: 4,
                                                              ),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(5),
                                                                border: Border.all(
                                                                  color: ColorResources.colorPrimary,
                                                                  width: 1.5,
                                                                ),
                                                              ),
                                                              child: CustomTextRegular(
                                                                "View Images",
                                                                fontSize: Dimensions.fontSizeSmall,
                                                                maxLines: 1,
                                                                color: ColorResources.colorPrimaryDark,
                                                              ),
                                                            ),
                                                          ),
                                                        ],

                                                      const Gap(5),

                                                      const Icon(
                                                        Icons.arrow_forward_ios_rounded,
                                                        size: 16,
                                                        color: ColorResources.colorPrimaryDark,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                             // SizedBox(width: 10),
                                            // Expanded(
                                            //   child: Column(
                                            //     children: [
                                            //       CustomTextMedium(
                                            //           "${configController.currencySymbol}${controller.orderHistoryData[index].amount}",
                                            //           color: Colors.green,
                                            //           maxLines: 1),
                                            //       const SizedBox(height: 3),
                                            //       CustomTextRegular(
                                            //         "(${CommonMethods().formatDuration(
                                            //             controller.orderHistoryData[index].duration ?? "0")})",
                                            //         color: ColorResources.black1,
                                            //         maxLines: 1,
                                            //         fontSize: Dimensions.fontSizeSmall,
                                            //       ),
                                            //       const SizedBox(height: 3),
                                            //       CustomTextRegular(
                                            //           "(${controller.orderHistoryData[index].callType})",
                                            //           color: ColorResources.black1,
                                            //           maxLines: 1,
                                            //           fontSize: Dimensions.fontSizeSmall),
                                            //       // CustomElevatedButton(text: 'Refund')
                                            //     ],
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        // trailing: const Icon(
                                        //     Icons.arrow_forward_ios_rounded,
                                        //     size: 18,
                                        //     color: ColorResources.colorPrimaryDark),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      )),
                ),
                Obx(
                      () =>
                      Visibility(
                        visible: controller.isCallLoading.isTrue,
                        child: CustomTextRegular('Loading...'),
                      ),
                )
              ],
            );
          } else if (controller.isCallLoading.isTrue) {
            return ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return const SimmerListView();
              },
            );
          } else {
            return const EmptyScreen();
          }
        }

        if (type == AppConstants.shopOrder) {
          if (controller.isProductLoading.isTrue) {
            return ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return const SimmerListView();
              },
            );
          } else {
            return controller.isProductSuccess.isTrue
                ? Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraSmall,
                  vertical: Dimensions.paddingSizeExtraSmall),
              child: ListView.builder(
                itemCount: controller.productOrderModel.data?.length,
                itemBuilder: (context, index) {
                  var orderDetails =
                  controller.productOrderModel.data![index];
                  return GestureDetector(
                    onTap: () {
                      controller.productOrderData =
                      controller.productOrderModel.data![index];
                      Get.toNamed("/product_order_detail_screen");
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
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 3,
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
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    CustomTextMedium(
                                      orderDetails.orderProducts![0]
                                          .product!.productName
                                          .toString(),
                                      color: ColorResources.colorPrimary,
                                      maxLines: 2,
                                    ),
                                    const Gap(2),
                                    CustomTextRegular(
                                      'Ordered on: ${CommonMethods()
                                          .formatDateTimeOutput(
                                          orderDetails.createdAt.toString())}',
                                      fontSize: Dimensions.fontSizeSmall,
                                      maxLines: 1,
                                    ),
                                    const Gap(2),
                                    CustomTextRegular(
                                      'Status: ${orderDetails.status}',
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
                                  imageUrl: orderDetails.orderProducts![0]
                                      .product!.productImage
                                      .toString(),
                                  height: 70,
                                  width: 70),
                              const Gap(10),
                              const Icon(Icons.arrow_forward_ios_rounded,
                                  size: 18, color: ColorResources.green),
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

        if (type == AppConstants.serviceOrder) {
          if (controller.isServiceLoading.isTrue) {
            return ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return const SimmerListView();
              },
            );
          } else {
            return controller.isServiceSuccess.isTrue
                ? Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraSmall,
                  vertical: Dimensions.paddingSizeExtraSmall),
              child: ListView.builder(
                itemCount: controller.serviceOrderModel.data?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: Dimensions.paddingSizeExtraSmall),
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorResources.white,
                          borderRadius: BorderRadius.circular(
                              Dimensions.borderRadiusDefault),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeMediumSmall,
                            vertical: Dimensions.paddingSizeDefault),
                        child: Column(
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                CustomRoundNetworkImage(
                                    imageUrl: controller
                                        .serviceOrderModel
                                        .data![index]
                                        .serviceAssign!
                                        .service!
                                        .serviceImage
                                        .toString(),
                                    height: 60,
                                    width: 60),
                                const Gap(10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      CustomTextMedium(
                                        controller
                                            .serviceOrderModel
                                            .data![index]
                                            .serviceAssign!
                                            .service!
                                            .serviceName
                                            .toString(),
                                        color:
                                        ColorResources.colorPrimary,
                                        maxLines: 1,
                                      ),
                                      const Gap(2),
                                      CustomTextRegular(
                                          controller
                                              .serviceOrderModel
                                              .data![index]
                                              .astrologer!
                                              .displayName
                                              .toString(),
                                          fontSize:
                                          Dimensions.fontSizeSmall,
                                          maxLines: 1,
                                          color: ColorResources.black1),
                                      const Gap(2),
                                      CustomTextRegular(
                                          'Booked on: ${CommonMethods()
                                              .formatDateTimeOutput(
                                              controller.serviceOrderModel
                                                  .data![index].createdAt
                                                  .toString())}',
                                          fontSize:
                                          Dimensions.fontSizeSmall,
                                          maxLines: 1,
                                          color: ColorResources.black2),
                                      const Divider(
                                          color: ColorResources.black6),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomTextRegular(
                                              "Status",
                                              color:
                                              ColorResources.black1,
                                              maxLines: 1,
                                            ),
                                          ),
                                          Expanded(
                                            child: CustomTextRegular(
                                              controller.serviceOrderModel
                                                  .data![index].status
                                                  .toString(),
                                              color:
                                              ColorResources.black1,
                                              textAlign: TextAlign.end,
                                              fontSize: Dimensions
                                                  .fontSizeSmall,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomTextRegular(
                                              "Ref ID",
                                              color:
                                              ColorResources.black1,
                                              maxLines: 1,
                                            ),
                                          ),
                                          Expanded(
                                            child: CustomTextRegular(
                                              controller.serviceOrderModel
                                                  .data![index].orderId
                                                  .toString(),
                                              color:
                                              ColorResources.black1,
                                              textAlign: TextAlign.end,
                                              fontSize: Dimensions
                                                  .fontSizeSmall,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomTextRegular(
                                              "Service Date",
                                              color:
                                              ColorResources.black1,
                                              maxLines: 1,
                                            ),
                                          ),
                                          Expanded(
                                            child: CustomTextRegular(
                                              controller.serviceOrderModel
                                                  .data![index].date
                                                  .toString(),
                                              color:
                                              ColorResources.black1,
                                              textAlign: TextAlign.end,
                                              fontSize: Dimensions
                                                  .fontSizeSmall,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomTextRegular(
                                              "Service Time",
                                              color:
                                              ColorResources.black1,
                                              maxLines: 1,
                                            ),
                                          ),
                                          Expanded(
                                            child: CustomTextRegular(
                                              controller.serviceOrderModel
                                                  .data![index].time
                                                  .toString(),
                                              color:
                                              ColorResources.black1,
                                              textAlign: TextAlign.end,
                                              fontSize: Dimensions
                                                  .fontSizeSmall,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomTextRegular(
                                              "Service Price",
                                              color:
                                              ColorResources.black1,
                                              maxLines: 1,
                                            ),
                                          ),
                                          Expanded(
                                            child: CustomTextRegular(
                                              '${configController
                                                  .currencySymbol} ${controller
                                                  .serviceOrderModel
                                                  .data![index].price}',
                                              color:
                                              ColorResources.black1,
                                              textAlign: TextAlign.end,
                                              fontSize: Dimensions
                                                  .fontSizeSmall,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Gap(10),
                            Row(children: [
                              Visibility(
                                visible: controller.serviceOrderModel
                                    .data![index].isAvailable ==
                                    1,
                                child: Expanded(
                                  child: ElevatedButton(
                                      onPressed: () {
                                        ChatIntakeFormController chatIntakeFormController = Get
                                            .put(ChatIntakeFormController());
                                        chatIntakeFormController
                                            .setAstrologerData(
                                            controller.serviceOrderModel
                                                .data![index].astrologer!
                                                .displayName.toString(),
                                            controller.serviceOrderModel
                                                .data![index].astrologer!
                                                .astroImg.toString(),
                                            controller.serviceOrderModel
                                                .data![index].astrologer!
                                                .astrologerUniId.toString(),
                                            AppConstants.video,
                                        0);
                                        controller.startServiceVideoCall(
                                            controller.serviceOrderModel
                                                .data![index].orderId
                                                .toString(),
                                            controller.serviceOrderModel
                                                .data![index].astrologerUniId
                                                .toString());
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        ColorResources.colorPrimary,
                                        padding: const EdgeInsets.only(
                                            top: 0, bottom: 0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: CustomTextRegular(
                                        "Join Video Call",
                                        color: Colors.white,
                                      )),
                                ),
                              )
                            ]),
                            Row(
                                children: [
                                  Visibility(
                                    visible: controller.serviceOrderModel
                                        .data![index].status == "completed" &&
                                        controller.serviceOrderModel
                                            .data![index].fileUrl != null,
                                    child: Expanded(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            if (controller.serviceOrderModel
                                                .data![index].fileType ==
                                                "Image") {
                                              showImagePreviewDialog(
                                                  controller.serviceOrderModel
                                                      .data![index].fileUrl
                                                      .toString());
                                            } else
                                            if (controller.serviceOrderModel
                                                .data![index].fileType ==
                                                "Video") {
                                              // Get.to(LocalVideoPlayScreen(
                                              //   videoUrl:controller.serviceOrderModel.data![index].fileUrl.toString(),
                                              //   videoTitle: controller.serviceOrderModel.data![index].serviceAssign!.service!.serviceName.toString(),
                                              // ));
                                              Get.to(() =>
                                                  LocalVideoPlayScreen(
                                                    videoUrl: controller
                                                        .serviceOrderModel
                                                        .data![index].fileUrl
                                                        .toString(),
                                                    videoTitle: controller
                                                        .serviceOrderModel
                                                        .data![index]
                                                        .serviceAssign!
                                                        .service!.serviceName
                                                        .toString(),
                                                  ));
                                            } else {
                                              CustomSnackBar.showBottom(
                                                  "Media Not Found.");
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: ColorResources
                                                .colorPrimary,
                                            padding: const EdgeInsets.only(
                                                top: 0, bottom: 0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(8),
                                            ),
                                          ),
                                          child: CustomTextRegular(
                                            "View Media",
                                            color: Colors.white,
                                          )),
                                    ),
                                  )
                                ]
                            ),
                          ],
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

        if (type == AppConstants.groupPoojaOrder) {
          if (controller.isGroupPoojaSuccess.value == true) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeExtraSmall,
                        vertical: Dimensions.paddingSizeExtraSmall),
                    child: ListView.builder(
                      itemCount: controller.groupPoojaOrderData.length,
                      controller: controller.groupPoojaScrollController,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: Dimensions.paddingSizeExtraSmall),
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorResources.white,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.borderRadiusDefault),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 1),
                                  )
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeMediumSmall,
                                  vertical: Dimensions.paddingSizeDefault),
                              child: Column(
                                children: [
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      CustomRoundNetworkImage(
                                          imageUrl: controller
                                              .groupPoojaOrderData[index]
                                              .groupPujaAssign!
                                              .groupPuja!
                                              .groupPujaImage
                                              .toString(),
                                          height: 60,
                                          width: 60),
                                      const Gap(10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            CustomTextMedium(
                                              controller
                                                  .groupPoojaOrderData[index]
                                                  .groupPujaAssign!
                                                  .groupPuja!
                                                  .groupPujaName
                                                  .toString(),
                                              color:
                                              ColorResources.colorPrimary,
                                              maxLines: 1,
                                            ),
                                            const Gap(2),
                                            CustomTextRegular(
                                                controller
                                                    .groupPoojaOrderData[index]
                                                    .astrologer!
                                                    .displayName
                                                    .toString(),
                                                fontSize:
                                                Dimensions.fontSizeSmall,
                                                maxLines: 1,
                                                color: ColorResources.black1),
                                            const Gap(2),
                                            CustomTextRegular(
                                                'Booked on: ${CommonMethods()
                                                    .formatDateTimeOutput(
                                                    controller
                                                        .groupPoojaOrderData[index].createdAt
                                                        .toString())}',
                                                fontSize:
                                                Dimensions.fontSizeSmall,
                                                maxLines: 1,
                                                color: ColorResources.black2),
                                            const Divider(
                                                color: ColorResources.black6),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: CustomTextRegular(
                                                    "Status",
                                                    color:
                                                    ColorResources.black1,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextRegular(
                                                    controller
                                                        .groupPoojaOrderData[index].status
                                                        .toString(),
                                                    color:
                                                    ColorResources.black1,
                                                    textAlign: TextAlign.end,
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: CustomTextRegular(
                                                    "Ref ID",
                                                    color:
                                                    ColorResources.black1,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextRegular(
                                                    controller
                                                        .groupPoojaOrderData[index].orderId
                                                        .toString(),
                                                    color:
                                                    ColorResources.black1,
                                                    textAlign: TextAlign.end,
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: CustomTextRegular(
                                                    "Group Pooja Date",
                                                    color:
                                                    ColorResources.black1,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextRegular(
                                                    CommonMethods()
                                                        .convertDateOutput(
                                                        controller
                                                            .groupPoojaOrderData[index]
                                                            .groupPujaDate
                                                            .toString()),
                                                    color:
                                                    ColorResources.black1,
                                                    textAlign: TextAlign.end,
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: CustomTextRegular(
                                                    "Group Pooja Time",
                                                    color:
                                                    ColorResources.black1,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextRegular(
                                                    CommonMethods()
                                                        .convertTimeToAmPm(
                                                        controller
                                                            .groupPoojaOrderData[index]
                                                            .groupPujaTime
                                                            .toString()),
                                                    color:
                                                    ColorResources.black1,
                                                    textAlign: TextAlign.end,
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: CustomTextRegular(
                                                    "Group Pooja Price",
                                                    color:
                                                    ColorResources.black1,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextRegular(
                                                    '${configController
                                                        .currencySymbol} ${controller
                                                        .groupPoojaOrderData[index].price}',
                                                    color:
                                                    ColorResources.black1,
                                                    textAlign: TextAlign.end,
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(10),
                                  Row(children: [
                                    Visibility(
                                      visible:
                                      controller.groupPoojaOrderData[index].isAvailable ==
                                          1,
                                      child: Expanded(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              final GroupPoojaLiveStreamInitController liveController = Get
                                                  .put(
                                                  GroupPoojaLiveStreamInitController());
                                              String astrologerName = controller
                                                  .groupPoojaOrderData[index].astrologer!
                                                  .displayName.toString();
                                              String astrologerImage = controller
                                                  .groupPoojaOrderData[index].astrologer!
                                                  .astroImg.toString();
                                              liveController.setAstrologerData(
                                                  astrologerName,
                                                  astrologerImage);

                                              // Join GroupPooja
                                              String uniqueId = controller
                                                  .groupPoojaOrderData[index]
                                                  .groupPujaChannelName
                                                  .toString();
                                              String astrologerUniId = controller
                                                  .groupPoojaOrderData[index].astrologerUniId
                                                  .toString();
                                              String orderId = controller
                                                  .groupPoojaOrderData[index].orderId
                                                  .toString();
                                              String groupPoojaAssignId = controller
                                                  .groupPoojaOrderData[index]
                                                  .groupPujaAssignId.toString();
                                              controller
                                                  .joinGroupPoojaLiveStream(
                                                  orderId, astrologerUniId,
                                                  uniqueId, groupPoojaAssignId);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                              ColorResources.colorPrimary,
                                              padding: const EdgeInsets.only(
                                                  top: 0, bottom: 0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: CustomTextRegular(
                                              "Join Group Pooja",
                                              color: Colors.white,
                                            )),
                                      ),
                                    ),
                                    Visibility(
                                      visible: controller.groupPoojaOrderData[index].status == "approved" &&
                                          controller.groupPoojaOrderData[index].isAvailable ==
                                              0,
                                      child: Expanded(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Get.dialog(
                                                  CustomDialogWidget(
                                                    imagePath: Images.queMarkFill,
                                                    title: "Cancel Group Pooja!",
                                                    onYesPressed: () {
                                                      controller.cancelGroupPoojaOrder(controller.groupPoojaOrderData[index].orderId!);
                                                      Get.back();
                                                    },
                                                    description: "Are you sure you want to cancel the Group Pooja?",
                                                  ),
                                                  barrierDismissible: false
                                              );
                                              // CustomDefaultDialog.showDialog(
                                              //     "Cancel Group Pooja!",
                                              //     "Are you sure you want to cancel the Group Pooja?",
                                              //         () {
                                              //       controller
                                              //           .cancelGroupPoojaOrder(
                                              //           controller
                                              //               .groupPoojaOrderData[index]
                                              //               .orderId!);
                                              //     }, () {
                                              //   //On no presses DismissDialog
                                              // });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                              ColorResources.red,
                                              padding: const EdgeInsets.only(
                                                  top: 0, bottom: 0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: CustomTextRegular(
                                              "Cancel Group Pooja",
                                              color: Colors.white,
                                            )),
                                      ),
                                    )
                                  ]),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Obx(
                      () =>
                      Visibility(
                        visible: controller.isGroupPoojaLoading.value == true,
                        child: CustomTextRegular('Loading...'),
                      ),
                ),
              ],
            );
          } else if (controller.isGroupPoojaLoading.isTrue) {
            return ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return const SimmerListView();
              },
            );
          } else {
            return const EmptyScreen();
          }
        }

        if (type == AppConstants.walletOrder) {
          if (controller.isWalletSuccess.isTrue) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeExtraSmall,
                      vertical: Dimensions.paddingSizeExtraSmall,
                    ),
                    child: ListView.builder(
                      itemCount: controller.walletHistoryData.length,
                      controller: controller.scrollController,
                      itemBuilder: (context, index) {
                        num? status =
                            controller.walletHistoryData[index].status;
                        String? mainType =
                            controller.walletHistoryData[index].mainType;
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: Dimensions.paddingSizeExtraSmall,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorResources.white,
                              borderRadius: BorderRadius.circular(
                                Dimensions.borderRadiusDefault,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 1),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeMediumSmall,
                                vertical: Dimensions.paddingSizeDefault,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: CustomTextMedium(
                                          controller.walletHistoryData[index]
                                              .walletHistoryDescription
                                              .toString(),
                                          // color: mainType == "cr" ? Colors.green : Colors.red,
                                          color: status == 0
                                              ? ColorResources.orange
                                              : (mainType == "cr"
                                              ? Colors.green
                                              : Colors.red),
                                          maxLines: 2,
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomTextMedium(
                                          '${configController
                                              .currencySymbol}${controller
                                              .walletHistoryData[index]
                                              .amount}',
                                          color: status == 0
                                              ? ColorResources.orange
                                              : (mainType == "cr"
                                              ? Colors.green
                                              : Colors.red),
                                          textAlign: TextAlign.end,
                                        ),
                                      )
                                    ],
                                  ),
                                  const Gap(4),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextRegular(
                                          "ID",
                                          color: ColorResources.black2,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomTextRegular(
                                          controller.walletHistoryData[index]
                                              .referenceId
                                              .toString(),
                                          color: ColorResources.black2,
                                          textAlign: TextAlign.end,
                                          fontSize: Dimensions.fontSizeSmall,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextRegular(
                                          "Time",
                                          color: ColorResources.black2,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomTextRegular(
                                          CommonMethods().formatDateTimeOutput(
                                              controller
                                                  .walletHistoryData[index]
                                                  .createdAt
                                                  .toString()),
                                          color: ColorResources.black2,
                                          textAlign: TextAlign.end,
                                          fontSize: Dimensions.fontSizeSmall,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextRegular(
                                          "Status",
                                          color: ColorResources.black2,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomTextRegular(
                                          status == 0
                                              ? 'PENDING'
                                              : (status == 1
                                              ? 'COMPLETED'
                                              : 'FAILED'),
                                          color: status == 0
                                              ? Colors.orange
                                              : (status == 1
                                              ? Colors.green
                                              : ColorResources.red),
                                          textAlign: TextAlign.end,
                                          fontSize: Dimensions.fontSizeSmall,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextRegular(
                                          "Method",
                                          color: ColorResources.black2,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomTextRegular(
                                          controller.walletHistoryData[index]
                                              .transactionCode
                                              .toString(),
                                          color: ColorResources.black2,
                                          textAlign: TextAlign.end,
                                          fontSize: Dimensions.fontSizeSmall,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextRegular(
                                          "Total",
                                          color: ColorResources.black2,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomTextRegular(
                                          '${configController
                                              .currencySymbol} ${controller
                                              .walletHistoryData[index]
                                              .transactionAmount}',
                                          color: ColorResources.black2,
                                          textAlign: TextAlign.end,
                                          fontSize: Dimensions.fontSizeSmall,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Obx(
                      () =>
                      Visibility(
                        visible: controller.isWalletLoading.isTrue,
                        child: CustomTextRegular('Loading...'),
                      ),
                )
              ],
            );
          } else if (controller.isWalletLoading.isTrue) {
            return ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return const SimmerListView();
              },
            );
          } else {
            return const EmptyScreen();
          }
        }

        if (type == AppConstants.orderMandirDarshan) {
          if (controller.isMandirDarshanOrderListSuccess.value == true) {
            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeExtraSmall,
                        vertical: Dimensions.paddingSizeExtraSmall),
                    child: ListView.builder(
                      itemCount: controller.mandirDarshanOrderData.length,
                      controller: controller.scrollController,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: Dimensions.paddingSizeExtraSmall),
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorResources.white,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.borderRadiusDefault),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 1),
                                  )
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeMediumSmall,
                                  vertical: Dimensions.paddingSizeDefault),
                              child: Column(
                                children: [
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      CustomRoundNetworkImage(
                                          imageUrl: controller
                                              .mandirDarshanOrderData[index]
                                              .liveTempleDarshanAssign!
                                              .liveTempleDarshan!
                                              .liveTempleDarshanImage
                                              .toString(),
                                          height: 60,
                                          width: 60),
                                      const Gap(10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            CustomTextMedium(
                                              controller
                                                  .mandirDarshanOrderData[index]
                                                  .liveTempleDarshanAssign!
                                                  .liveTempleDarshan!
                                                  .liveTempleDarshanName
                                                  .toString(),
                                              color:
                                              ColorResources.colorPrimary,
                                              maxLines: 1,
                                            ),
                                            const Gap(2),
                                            CustomTextRegular(
                                                controller
                                                    .mandirDarshanOrderData[index]
                                                    .astrologer!
                                                    .displayName
                                                    .toString(),
                                                fontSize:
                                                Dimensions.fontSizeSmall,
                                                maxLines: 1,
                                                color: ColorResources.black1),
                                            const Gap(2),
                                            CustomTextRegular(
                                                'Booked on: ${CommonMethods()
                                                    .formatDateTimeOutput(
                                                    controller
                                                        .mandirDarshanOrderData[index].createdAt
                                                        .toString())}',
                                                fontSize:
                                                Dimensions.fontSizeSmall,
                                                maxLines: 1,
                                                color: ColorResources.black2),
                                            const Divider(
                                                color: ColorResources.black6),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: CustomTextRegular(
                                                    "Status",
                                                    color:
                                                    ColorResources.black1,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextRegular(
                                                    controller
                                                        .mandirDarshanOrderData[index].status
                                                        .toString(),
                                                    color:
                                                    ColorResources.black1,
                                                    textAlign: TextAlign.end,
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: CustomTextRegular(
                                                    "Ref ID",
                                                    color:
                                                    ColorResources.black1,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextRegular(
                                                    controller
                                                        .mandirDarshanOrderData[index].orderId
                                                        .toString(),
                                                    color:
                                                    ColorResources.black1,
                                                    textAlign: TextAlign.end,
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                  ),
                                                )
                                              ],
                                            ),
                                            controller
                                                .mandirDarshanOrderData[index]
                                                .liveTempleDarshanDate != null ? Row(
                                              children: [
                                                Expanded(
                                                  child: CustomTextRegular(
                                                    "Mandir Darshan Date",
                                                    color:
                                                    ColorResources.black1,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextRegular(
                                                    CommonMethods()
                                                        .convertDateOutput(
                                                        controller
                                                            .mandirDarshanOrderData[index]
                                                            .liveTempleDarshanDate
                                                            .toString()),
                                                    color:
                                                    ColorResources.black1,
                                                    textAlign: TextAlign.end,
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                  ),
                                                )
                                              ],
                                            ) : const SizedBox.shrink(),
                                            controller
                                                .mandirDarshanOrderData[index]
                                                .liveTempleDarshanTime != null ? Row(
                                              children: [
                                                Expanded(
                                                  child: CustomTextRegular(
                                                    "Mandir Darshan Time",
                                                    color:
                                                    ColorResources.black1,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextRegular(
                                                    CommonMethods()
                                                        .convertTimeToAmPm(
                                                        controller
                                                            .mandirDarshanOrderData[index]
                                                            .liveTempleDarshanTime
                                                            .toString()),
                                                    color:
                                                    ColorResources.black1,
                                                    textAlign: TextAlign.end,
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                  ),
                                                )
                                              ],
                                            ) : const SizedBox.shrink(),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: CustomTextRegular(
                                                    "Mandir Darshan Price",
                                                    color:
                                                    ColorResources.black1,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextRegular(
                                                    '${configController
                                                        .currencySymbol} ${controller
                                                        .mandirDarshanOrderData[index].price}',
                                                    color:
                                                    ColorResources.black1,
                                                    textAlign: TextAlign.end,
                                                    fontSize: Dimensions
                                                        .fontSizeSmall,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(10),
                                  Row(children: [
                                    Visibility(
                                      visible:
                                      controller.mandirDarshanOrderData[index].status != "completed" || controller.mandirDarshanOrderData[index].isAvailable ==
                                          1,
                                      child: Expanded(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              String callRate = '**', callDuration = '**', videoRate = '**', videoDuration = '**',privateCallRate = '**', privateCallDuration = '**', privateVideoRate = '**', privateVideoDuration = '**';
                                              final LiveStreamInitController liveController = Get
                                                  .put(
                                                  LiveStreamInitController());
                                              String astrologerName = controller
                                                  .mandirDarshanOrderData[index].astrologer!
                                                  .displayName.toString();
                                              String astrologerImage = controller
                                                  .mandirDarshanOrderData[index].astrologer!
                                                  .astroImg.toString();
                                              liveController.setAstrologerData(astrologerName, astrologerImage, callRate, videoRate, callDuration, videoDuration,privateCallRate, privateVideoRate, privateCallDuration, privateVideoDuration,AppConstants.mandirDarshan);

                                              // Join GroupPooja
                                              String uniqueId = controller
                                                  .mandirDarshanOrderData[index]
                                                  .liveTempleDarshanChannelName
                                                  .toString();
                                              String astrologerUniId = controller
                                                  .mandirDarshanOrderData[index].astrologerUniId
                                                  .toString();
                                              String orderId = controller
                                                  .mandirDarshanOrderData[index].orderId
                                                  .toString();
                                              String assignId = controller
                                                  .mandirDarshanOrderData[index]
                                                  .liveTempleDarshanAssignId.toString();
                                              controller
                                                  .joinMandirDarshan(astrologerUniId,
                                                  uniqueId, assignId);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                              ColorResources.colorPrimary,
                                              padding: const EdgeInsets.only(
                                                  top: 0, bottom: 0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: CustomTextRegular(
                                              "Start Mandir Darshan",
                                              color: Colors.white,
                                            )),
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Obx(
                      () =>
                      Visibility(
                        visible: controller.isGroupPoojaLoading.value == true,
                        child: CustomTextRegular('Loading...'),
                      ),
                ),
              ],
            );
          } else if (controller.isMandirDarshanOrderListLoading.isTrue) {
            return ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return const SimmerListView();
              },
            );
          } else {
            return const EmptyScreen();
          }
        }

        else {
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

  void showImagePreviewDialog(String imageUrl) async {
    Get.dialog(
      useSafeArea: true,
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        content: Stack(
          children: <Widget>[
            InteractiveViewer(
              panEnabled: true,
              minScale: 1.0,
              maxScale: 2.0,
              child: CustomNetworkImage(
                imageUrl: imageUrl,
                height: Get.height * 0.7,
                width: Get.width,
                fit: BoxFit.contain,
              ),
            ),
            // Close button
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    Images.crossFill,
                    height: 26,
                    color: ColorResources.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
