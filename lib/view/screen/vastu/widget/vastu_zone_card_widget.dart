import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utill/color_resources.dart';
import '../vastu_compass/home_vastu_zone_detail.dart';

// class VastuZoneCardWidget extends StatelessWidget {
//   final String title;
//   final String icon;
//   final String type;
//
//   const VastuZoneCardWidget({super.key,
//     required this.title,
//     required this.icon,
//     required this.type,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if(type == 'Home'){
//           Get.toNamed('/home_vastu');
//         }else {
//           Get.to(HomeVastuZoneDetail(type));
//         }
//       },
//       child: Card(
//         color: Colors.white,
//         child: Center(
//           widthFactor: 100,// Centering content vertically and horizontally
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center, // Centering vertically
//             children: [
//               Image.asset(
//                 icon,
//                 width: 30,
//                 height: 30,
//               ),
//               const SizedBox(height: 8), // Adding some spacing between the icon and the title
//               Text(
//                 title,
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//
//   }
// }

class VastuZoneCardWidget extends StatelessWidget {
  final String title;
  final String icon;
  final String type;

  const VastuZoneCardWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (type == 'Home') {
          Get.toNamed('/home_vastu');
        } else {
          Get.to(HomeVastuZoneDetail(type));
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
