import 'package:astro_brahmand/view/screen/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../controller/connectivity_service.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
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
        body: Stack(
          children: [
            /// 🌌 Background Image
            Positioned.fill(
              child: Image.asset(
                Images.splashBackGround,
                fit: BoxFit.cover,
              ),
            ),


            /// 🌑 Optional dark overlay (text/logo clear dikhne ke liye)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),

            /// ⭐ Logo Center
            Positioned(
              top: (screenHeight - screenWidth * 0.7) / 2,
              left: (screenWidth - screenWidth * 0.7) / 2,
              child: Image.asset(
                Images.logo,
                width: screenWidth * 0.7,
                height: screenWidth * 0.7,
                fit: BoxFit.scaleDown,
              ),
            ),

            /// ⏳ Loader + Version (Bottom)
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Visibility(
                    visible: controller.isLoading.isTrue,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: ColorResources.black6,
                      ),
                    ),
                  ),
                  const Gap(Dimensions.gapDefault),
                  CustomTextMedium(
                    "Version: ${AppConstants.appVersion}",
                    fontSize: Dimensions.fontSizeSmall,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
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
