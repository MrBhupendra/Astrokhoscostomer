import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/view/screen/orders/controller/order_controller.dart';
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:astro_brahmand/view/widget/custom_elevated_button.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:astro_brahmand/view/widget/order_tracking_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../widget/custom_network_image.dart';
import '../splash/controller/config_controller.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class ProductOrderDetailScreen extends StatelessWidget {
  ProductOrderDetailScreen({super.key});
  final OrderController orderController = Get.find();
  final ConfigController configController = Get.find();

  @override
  Widget build(BuildContext context) {
    String? status = orderController.productOrderData.status;
    return SafeArea(child: Scaffold(appBar: const CustomAppBar(title: "Order Detail"),
    body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 14),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextMedium("Order ID: ${orderController.productOrderData.orderId}",fontSize: Dimensions.fontSizeLarge,color: ColorResources.colorText),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomTextRegular("${AppStrings.status.tr}: ${orderController.productOrderData.status}".toUpperCase(),
                color: status == "delivered"
                    ? Colors.green
                    : (status == "cancel"
                    ? Colors.red
                    : ColorResources.orange),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorResources.white,
                  borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
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
                              orderController.productOrderData.orderProducts![0].product!.productName.toString(),
                              color: ColorResources.colorPrimaryDark,
                              maxLines: 2,
                            ),
                            const Gap(3),
                            CustomTextRegular(
                              "Qty: ${orderController.productOrderData.orderProducts![0].quality}",
                              fontSize: Dimensions.fontSizeSmall,
                              maxLines: 1,
                            ),
                            const Gap(3),
                            CustomTextRegular(
                              "Price: ${configController.currencySymbol}${orderController.productOrderData.orderProducts![0].product?.price}",
                              fontSize: Dimensions.fontSizeSmall,
                              maxLines: 1,
                            ),

                            if(orderController.productOrderData.subscriptionAssignId! > 0)
                              Row(
                                children: [
                                  CustomTextMedium("Order by "),
                                  CustomTextMedium("Subscription",color: ColorResources.colorPrimary,),
                                ],
                              ),
                          ],
                        ),
                      ),
                      // Image.asset(
                      //   Images.placeholder,
                      //   height: 60,
                      // ),
                      CustomNetworkImage(
                          imageUrl: orderController.productOrderData.orderProducts![0].product!.productImage.toString(),
                          height: 70,
                          width: 70
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4,bottom: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorResources.white,
                  borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
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
                              "Shipping Details",
                              color: ColorResources.colorPrimaryDark,
                              maxLines: 2,
                            ),
                            const Gap(3),
                            CustomTextRegular(
                              "${orderController.productOrderData.address?.name.toString()}",
                              fontSize: Dimensions.fontSizeSmall,
                              maxLines: 1,
                            ),
                            const Gap(3),
                            CustomTextRegular(
                              "${orderController.productOrderData.address?.houseNo.toString()}, ${orderController.productOrderData.address?.streetArea.toString()} , ${orderController.productOrderData.address?.pincode}",
                              fontSize: Dimensions.fontSizeSmall,
                              maxLines: 2,
                            ),
                            const Gap(3),
                            CustomTextRegular(
                              "${orderController.productOrderData.address?.address.toString()}",
                              // orderController.productOrderData.address!.address.toString(),
                              fontSize: Dimensions.fontSizeSmall,
                              maxLines: 1,
                            ),
                            const Gap(3),
                            CustomTextRegular(
                              "${orderController.productOrderData.address?.phone.toString()}",
                              fontSize: Dimensions.fontSizeSmall,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomTextRegular(
              "Price Details",
              fontSize: Dimensions.fontSizeSmall,
              maxLines: 1,
            ),
            const Divider(color: ColorResources.black7),
            Row(
              children: [
                Expanded(
                  child: CustomTextRegular(
                    "Price:",
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  child: CustomTextRegular(
                    "${configController.currencySymbol} ${orderController.productOrderData.orderProducts![0].product?.price}",
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const Gap(2),
            Row(
              children: [
                Expanded(
                  child: CustomTextRegular(
                    "Quantity:",
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  child: CustomTextRegular(
                    "${AppStrings.crossSign} ${orderController.productOrderData.orderProducts![0].quality.toString()}",
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            // const Gap(2),
            // Row(
            //   children: [
            //     Expanded(
            //       child: CustomTextRegular(
            //         "GST(${orderController.productOrderData.gstPercent}%)",
            //         maxLines: 1,
            //       ),
            //     ),
            //     Expanded(
            //       child: CustomTextRegular(
            //         "${configController.currencySymbol} ${orderController.productOrderData.gstAmount}",
            //         maxLines: 1,
            //       ),
            //     ),
            //   ],
            // ),
            const Gap(2),
            const Divider(color: ColorResources.black7),
            Row(
              children: [
                Expanded(
                  child: CustomTextMedium(
                    "Total Amount",
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  child: CustomTextMedium(
                    "${configController.currencySymbol} ${orderController.productOrderData.totalAmount}",
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            const Divider(color: ColorResources.black7),
            const Gap(6),
            CustomTextMedium("Track Your Order Below:",fontSize: Dimensions.fontSizeLarge,color: ColorResources.colorText),
            const Gap(6),
            Container(decoration: BoxDecoration(
              color: ColorResources.white,
              borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                )
              ],
            ),child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeSmall,
                vertical: Dimensions.paddingSizeDefault,
              ),
              child: OrderTrackingWidget(currentStatus: orderController.productOrderData.status!.toUpperCase()),
            )),
            Visibility(visible: orderController.productOrderData.invoiceUrl != null && orderController.productOrderData.invoiceUrl!.isNotEmpty,child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomElevatedButton(text: "Download Invoice", backgroundColor: ColorResources.colorPrimary,textColor: ColorResources.white,onPressed: (){
                AppLogger.d("orderController.productOrderData.invoiceUrl!${orderController.productOrderData.invoiceUrl.toString()}");
                Get.toNamed('/pdf_viewer',arguments: {
                  'title': "Invoice",
                  'url': orderController.productOrderData.invoiceUrl.toString()
                });

              },),
            ))
          ],
        ),
      ),
    ),
    ));
  }
}
