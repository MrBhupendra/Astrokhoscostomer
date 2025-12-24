import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utill/color_resources.dart';
import '../../../widget/custom_text_regular.dart';
import '../vastu_compass/office_vastu_zone_detail.dart';

class OfficeVastuZoneCardWidget extends StatelessWidget {
  final String title;
  final String icon;
  final String type;

  const OfficeVastuZoneCardWidget({super.key,
    required this.title,
    required this.icon,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(type == 'Home'){
          Get.toNamed('/home_vastu');
        }else {
          Get.to(OfficeVastuZoneDetail(type));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          decoration: BoxDecoration(
            color: ColorResources.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: ColorResources.colorPrimary,
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                  color: Colors.grey.withOpacity(0.5)
              ),
            ],
          ),
          child: Center(
            widthFactor: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  icon,
                  width: 30,
                  height: 30,
                ),
                const Gap(8),
                CustomTextRegular(
                  title,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }
}