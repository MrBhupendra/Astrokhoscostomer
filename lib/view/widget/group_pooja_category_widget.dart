import 'package:astro_brahmand/view/widget/custom_box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:astro_brahmand/view/widget/custom_round_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';

import '../../model/group_puja_category_model.dart';
import '../../utill/dimensions.dart';

class GroupPoojaCategoryWidget extends StatelessWidget {
  final GroupPoojaCategoryData groupPoojaCategoryData;
  final Function? onPressed;
  const GroupPoojaCategoryWidget(this.groupPoojaCategoryData, {super.key, this.onPressed});

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
              // height: 120,
              // width: 120,
              // decoration: BoxDecoration(
              //   border: Border.all(color: ColorResources.colorPrimary),
              //   borderRadius: BorderRadius.circular(12),
              // ),
              padding: const EdgeInsets.all(15.0),
              decoration: CustomBoxDecoration.getDecoration(),
              child: CustomRoundNetworkImage(
                imageUrl: groupPoojaCategoryData.image.toString(),
                height: 75,
                width: 75
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 95,
              ),
              child: CustomTextRegular(
                groupPoojaCategoryData.title.toString(),
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
