import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_text_regular.dart';

class CustomArchitectContainer extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;

  const CustomArchitectContainer(this.imagePath, this.title, this.price, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: ColorResources.colorPrimary,width: 0.5),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.2),
        //     spreadRadius: 1,
        //   )
        // ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5),
        child:  Row(
          children: [
            Image.asset(imagePath, height: 24),
            const Gap(6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextRegular(title,color: ColorResources.colorPrimary,fontSize: Dimensions.fontSizeDefault),
                CustomTextRegular(price,fontSize: Dimensions.fontSizeExtraSmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
