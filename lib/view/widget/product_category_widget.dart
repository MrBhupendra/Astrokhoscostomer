import 'package:flutter/material.dart';
import 'package:astro_brahmand/view/widget/custom_round_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';

import '../../model/product_category_model.dart';
import '../../utill/dimensions.dart';
import 'custom_box_decoration.dart';

class ProductCategoryWidget extends StatelessWidget {
  final ProductCategoriesData productCategoriesData;
  final Function? onPressed;

  const ProductCategoryWidget(this.productCategoriesData, {super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed?.call();
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 6.0,left: 4,top: 4,bottom: 0),
        child: Column(
          children: [
            Container(
              // width: 120,
              // height: 120,
              // decoration: BoxDecoration(
              //   border: Border.all(
              //       color: ColorResources.colorPrimary),
              //   borderRadius: BorderRadius.circular(12),
              // ),
              padding: const EdgeInsets.all(15.0),
              decoration: CustomBoxDecoration.getDecoration(),
              child:CustomRoundNetworkImage(
                imageUrl: productCategoriesData.image.toString(),
                height: 75,
                width: 75
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 95,
              ),
              child: CustomTextRegular(
                productCategoriesData.title.toString(),
                fontSize: Dimensions.fontSizeHomeText,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}