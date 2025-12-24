import 'package:astro_brahmand/view/screen/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../controller/connectivity_service.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../widget/custom_default_indicator.dart';
import '../../widget/custom_text_medium.dart';

class SplashScreen extends GetView<SplashController> {
  SplashScreen({super.key});
  final ConnectivityController connectivityController = Get.put(ConnectivityController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          child: Stack(
            children: [
              // Logo centered vertically and horizontally
              Positioned(
                top: (screenHeight - screenWidth * 0.7) / 2, // Center vertically
                left: (screenWidth - screenWidth * 0.7) / 2, // Center horizontally
                child: Image.asset(
                  Images.logo,
                  width: screenWidth * 0.7,
                  height: screenWidth * 0.7,
                  fit: BoxFit.scaleDown,
                ),
              ),
              // Progress indicator at the bottom center
              Positioned(
                bottom: 2,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Visibility(
                      visible: controller.isLoading.isTrue,
                      child: const CustomDefaultProgressIndicator(),
                    ),
                    const Gap(Dimensions.gapDefault),
                    CustomTextMedium("Version: ${AppConstants.appVersion}",fontSize: Dimensions.fontSizeSmall)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// class SplashScreen extends GetView<SplashController> {
//   const SplashScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = Get.width;
//     double screenHeight = Get.height;
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Positioned(
//               top: (screenHeight - screenWidth * 0.7) / 2,
//               left: (screenWidth - screenWidth * 0.7) / 2,
//               child: Image.asset(
//                 Images.logo,
//                 width: screenWidth * 0.7,
//                 height: screenWidth * 0.7,
//                 fit: BoxFit.scaleDown,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
