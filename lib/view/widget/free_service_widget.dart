import 'package:flutter/material.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/utill/dimensions.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';

import '../../model/home_menu_model.dart';

class FreeServiceWidget extends StatelessWidget {
  final HomeMenuModel item;
  const FreeServiceWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 3,
          fit: FlexFit.loose,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              item.image,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Flexible(
          flex: 2,
          fit: FlexFit.loose,
          child: Padding(
            padding: const EdgeInsets.only(left: 6.0, right: 6.0, top: 5),
            child: CustomTextMedium(
              item.title,
              textAlign: TextAlign.center,
              color: ColorResources.colorPrimary,
              fontSize: Dimensions.fontSizeSmall,
              maxLines: 2,
            ),
          ),
        ),
      ],
    );
  }
}
