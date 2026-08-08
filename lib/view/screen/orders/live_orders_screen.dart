import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../utill/app_constants.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_round_network_image.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import '../../widget/simmer_widget/simmer_list_view.dart';
import '../splash/controller/config_controller.dart';
import 'controller/order_controller.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class LiveOrdersScreen extends GetView<OrderController> {
  final String type;
  const LiveOrdersScreen(this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();
    if(type == AppConstants.consultingOrder){
      controller.getCallHistory(AppConstants.live,0);
    }else if(type == AppConstants.giftOrder){
      controller.getLiveOrderHistory(AppConstants.live, 0);
    }

    return Obx(
          () {
        if(type == AppConstants.consultingOrder){
          if (controller.isCallLoading.isTrue) {
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
            return controller.isCallSuccess.isTrue
                ?  Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeExtraOverSmall,
                    vertical: Dimensions.paddingSizeExtraExtraSmall
                ),
                child: ListView.builder(

                  itemCount: controller.orderHistoryModel.data?.length,
                  itemBuilder: (context, index) => Card(
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
                              vertical: Dimensions.paddingSizeExtraOverSmall
                          ),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    insetPadding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeOverSmall),
                                    child: FractionallySizedBox(
                                      widthFactor: 1,
                                      child: Container(
                                        decoration:
                                        BoxDecoration(
                                          color: ColorResources.white,
                                          borderRadius: BorderRadius.circular( Dimensions.borderRadiusDefault), // Adjust the value for the desired border radius
                                        ),
                                        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault,),
                                        // color: ColorResources.white,
                                        child: Column(
                                          mainAxisSize:MainAxisSize.min,
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical:14.0),
                                              child: Row(
                                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: CustomTextMedium('Order Detail',maxLines:1),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(6.0),
                                                      child: Image.asset(
                                                        'assets/images/close.png',
                                                        height: 12,
                                                        color: ColorResources.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Divider(color:ColorResources.black7,height: 1),
                                            const Gap(5),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical : 4),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: CustomTextRegular(
                                                      "Status",color: ColorResources.black1,maxLines: 1,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: Dimensions.paddingSizeMediumSmall),
                                                      child: CustomTextRegular(
                                                        controller.orderHistoryModel.data![index].status.toString(),color: ColorResources.black1,textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical : 4),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: CustomTextRegular(
                                                      "ID",color: ColorResources.black1,maxLines: 1,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: Dimensions.paddingSizeMediumSmall),
                                                      child: CustomTextRegular(
                                                        controller.orderHistoryModel.data![index].referenceId.toString(),color: ColorResources.black1,textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical : 4),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: CustomTextRegular(
                                                      "Total Charge",color: ColorResources.black1,maxLines: 1,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: Dimensions.paddingSizeMediumSmall),
                                                      child: CustomTextRegular(
                                                        '${configController.currencySymbol} ${controller.orderHistoryModel.data![index].amount}',color: ColorResources.black1,textAlign: TextAlign.end,
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
                                  );
                                },
                              );
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: AspectRatio(
                                aspectRatio: 1,
                                child: CustomRoundNetworkImage(
                                    imageUrl: controller.orderHistoryModel.data![index].astroImg.toString(),
                                    height: 50,
                                    width: 50
                                ),

                                // CustomRoundNetworkImage(
                                //     imageUrl: controller
                                //         .paymentModel
                                //         .data![index]
                                //         .customerImg
                                //         .toString(),
                                //     height: 50,
                                //     width: 50)
                              ),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                      children: [
                                        CustomTextMedium(
                                          controller.orderHistoryModel.data![index].displayName.toString(),
                                          maxLines: 2,
                                        ),
                                        const SizedBox(height: 3),
                                        CustomTextRegular(
                                          CommonMethods().formatDateTimeOutput(controller.orderHistoryModel.data![index].createdAt.toString()),
                                          fontSize: Dimensions.fontSizeSmall,
                                          color:ColorResources.black1,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        CustomTextMedium("${configController.currencySymbol}${controller.orderHistoryModel.data![index].amount}",color: ColorResources.green,maxLines: 1),
                                        const Gap(3),
                                        CustomTextRegular("(${CommonMethods().formatDuration(controller.orderHistoryModel.data![index].duration ?? "0")})",color: ColorResources.black1,maxLines: 1,fontSize: Dimensions.fontSizeSmall,),
                                        const Gap(3),
                                        CustomTextRegular("(${controller.orderHistoryModel.data![index].callType})",color: ColorResources.green,maxLines: 1,fontSize: Dimensions.fontSizeExtraSmall),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            )
                : const EmptyScreen();
          }
        }

        if(type == AppConstants.giftOrder){
          if (controller.isLiveHistoryLoading.isTrue) {
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
            AppLogger.d("SS->${controller.liveOrderHistoryModel.data?.length}");
            return controller.isLiveHistorySuccess.isTrue
                ? Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeExtraSmall,
                  vertical: Dimensions.paddingSizeExtraSmall
              ),
              child: ListView.builder(
                itemCount: controller.liveOrderHistoryModel.data?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorResources.white,
                          borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
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
                              vertical: Dimensions.paddingSizeDefault
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  // Image.asset(Images.pngProfile,height: 50,width: 50),
                                  CustomRoundNetworkImage(
                                      imageUrl: controller.liveOrderHistoryModel.data![index].astrologer!.astroImg.toString(),
                                      height: 50,
                                      width: 50
                                  ),
                                  const Gap(10),
                                  Expanded(
                                    child: CustomTextMedium(controller.liveOrderHistoryModel.data![index].astrologer!.displayName.toString()),
                                  )
                                ],
                              ),
                              const Divider(color: ColorResources.black7),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8),
                                child: Row(
                                  children: [
                                    // Image.asset(Images.test1,height: 35,width: 35),
                                    CustomRoundNetworkImage(
                                        imageUrl: controller.liveOrderHistoryModel.data![index].gift!.giftImage.toString(),
                                        height: 35,
                                        width: 35
                                    ),
                                    const Gap(10),
                                    Expanded(
                                      child: CustomTextRegular(
                                        controller.liveOrderHistoryModel.data![index].gift!.giftName.toString(),color: ColorResources.black1,fontSize: Dimensions.fontSizeSmall,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(color: ColorResources.black7),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 3),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextRegular(
                                        "Time",color: ColorResources.black1,maxLines: 1,
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomTextRegular(
                                        CommonMethods().formatDateTimeOutput(controller.liveOrderHistoryModel.data![index].createdAt.toString()),color: ColorResources.black1,textAlign: TextAlign.end,fontSize: Dimensions.fontSizeSmall,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 3),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextMedium(
                                        "Gift Amount",color: ColorResources.colorPrimary,maxLines: 1,
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomTextMedium(
                                          '${configController.currencySymbol} ${controller.liveOrderHistoryModel.data![index].gift?.giftPrice.toString()}',color: ColorResources.colorPrimary,textAlign: TextAlign.end
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                  );
                },
              ),
            )
                : const EmptyScreen();
          }
        }

        else{
          return const EmptyScreen();
        }


      },
    );
  }
}
