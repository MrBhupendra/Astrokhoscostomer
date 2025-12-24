import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/utill/images.dart';
import 'package:flutter/material.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:get/get.dart';

import '../../utill/dimensions.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Images.emptyScreen,height: 150,width: 150),
          CustomTextRegular(
            AppStrings.noRecordFound.tr,
            fontSize: Dimensions.fontSizeLarge,
          ),
        ],
      ),
    );
  }
}
