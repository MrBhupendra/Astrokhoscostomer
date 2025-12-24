import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';

import '../../model/products_model.dart';
import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';
import '../../utill/images.dart';
import '../screen/splash/controller/config_controller.dart';
import 'custom_box_decoration.dart';

class ProductsWidget extends StatelessWidget {
  final ProductsData productsData;
  final Function? onPressed;

  const ProductsWidget(this.productsData, {super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();
    return GestureDetector(
      onTap: () {
        onPressed?.call();
      },
      child: Container(
        // height: Get.height,
        // width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            fit: StackFit.expand,
            children: [
              FadeInImage(
                placeholder: const AssetImage(Images.placeholder), // Path to your placeholder image
                image: NetworkImage(productsData.productImage.toString()),
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(Images.placeholder, fit: BoxFit.cover);
                },
                fadeInDuration: const Duration(milliseconds: 300),
              ),
              Container(
                color: Colors.black.withOpacity(0.4),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, left: 4, right: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextMedium(
                        productsData.productName.toString(),
                        // textAlign: TextAlign.center,
                        color: ColorResources.black8,
                        maxLines: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomTextMedium(
                            "${configController.currencySymbol} ${productsData.price}/-",
                            color: ColorResources.black8,
                            // textAlign: TextAlign.start,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 30,
                            child: TextButton(
                                onPressed: () async {
                                  onPressed?.call();
                                },
                                style: ButtonStyle(
                                  padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
                                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(30.0),
                                  )),
                                ),
                                child: Text(
                                  'Buy',
                                  style: Get.textTheme.titleMedium!.copyWith(color: Colors.white, fontSize: 14),
                                )
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
      // Padding(
      //   padding: const EdgeInsets.only(right: 8.0),
      //   child: Column(
      //     children: [
      //       Container(
      //         // width: 120,
      //         // height: 120,
      //         padding: const EdgeInsets.all(0.0),
      //         // decoration: BoxDecoration(
      //         //   border: Border.all(
      //         //       color: ColorResources.colorPrimary.withOpacity(0.5)),
      //         //   borderRadius: BorderRadius.circular(12),
      //         // ),
      //         decoration: CustomBoxDecoration.getDecoration(),
      //         child:ClipRRect(
      //           borderRadius: BorderRadius.circular(10),
      //           child: CustomNetworkImage(
      //               imageUrl: productsData.productImage.toString(),
      //               height: 140,
      //               width: Get.width * 0.5
      //           ),
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 4.0),
      //         child: CustomTextMedium(
      //           productsData.productName.toString(),
      //           maxLines: 2,
      //           textAlign: TextAlign.center,
      //         ),
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           CustomTextMedium(
      //             "${configController.currencySymbol} ${productsData.price}/-",
      //             fontSize: Dimensions.fontSizeSmall,
      //             maxLines: 1,
      //             color: ColorResources.colorPrimaryDark,
      //           ),
      //           Text("MRP.${productsData.mrp}",style: const TextStyle(
      //             fontSize: Dimensions.fontSizeSmall,
      //             color: ColorResources.black4,
      //             decoration: TextDecoration.lineThrough
      //           ),)
      //         ],
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
