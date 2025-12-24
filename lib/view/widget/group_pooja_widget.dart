import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/model/services_model.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';

import '../../model/group_pujas_list_model.dart';
import 'custom_box_decoration.dart';

class GroupPoojaWidget extends StatelessWidget {
  final GroupPoojaListData groupPoojaListData;
  final Function? onPressed;

  const GroupPoojaWidget(this.groupPoojaListData, {super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed?.call();
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Column(
          children: [
            Container(
              // width: 120,
              // height: 120,
              padding: const EdgeInsets.all(0.0),
              // decoration: BoxDecoration(
              //   border: Border.all(
              //       color: ColorResources.colorPrimary.withOpacity(0.5)),
              //   borderRadius: BorderRadius.circular(12),
              // ),
              decoration: CustomBoxDecoration.getDecoration(),
              child:ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CustomNetworkImage(
                    imageUrl: groupPoojaListData.groupPujaImage.toString(),
                    height: 140,
                    width: Get.width * 0.5
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomTextMedium(
                groupPoojaListData.groupPujaName.toString(),
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
