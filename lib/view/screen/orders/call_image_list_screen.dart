import 'package:astro_brahmand/view/screen/orders/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_network_image.dart';
import '../../widget/simmer_widget/simmer_grid_container2.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class CallImageListScreen extends StatelessWidget {
  const CallImageListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderController controller = Get.put(OrderController());

    dynamic arguments = Get.arguments;
    String uniqueId = "";

    if (arguments is Map<String, dynamic>) {
      uniqueId = arguments["uniqueId"] ?? "";
    }
    AppLogger.d("uniqueId->$uniqueId");
    controller.getImage(uniqueId);
    return SafeArea(
        child: Scaffold(
          appBar: const CustomAppBar(title: "Call Images"),
          body: Obx(
                () {
              if(controller.isImageSuccess.isTrue){
                return GridView.builder(
                  itemCount: controller.getImageModel.data?.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                      childAspectRatio: 1.00,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 10
                  ),
                  // physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeExtraSmall,
                      vertical: Dimensions.paddingSizeExtraSmall),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        showImagePreviewDialog(controller.getImageModel.data![index].fileUrl.toString());
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CustomNetworkImage(
                          imageUrl: controller.getImageModel.data![index].fileUrl.toString(),
                          height: 45,
                          width: 45
                        ),
                      ),
                    );
                  },
                );
              }
              if (controller.isImageLoading.isTrue) {
                return ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const SimmerGridContainer2();
                  },
                );
              } else {
                return const EmptyScreen();
              }
            },
          ),
        ));
  }

  void showImagePreviewDialog(String imageUrl) {
    Get.dialog(
      useSafeArea: true,
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        content: Stack(
          children: <Widget>[
            InteractiveViewer(
              panEnabled: true,
              minScale: 1.0,
              maxScale: 2.0,
              child: CustomNetworkImage(
                imageUrl: imageUrl,
                height: Get.height * 0.7,
                width: Get.width,
                fit: BoxFit.contain,
              ),
            ),
            // Close button
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    Images.crossFill,
                    height: 26,
                    color: ColorResources.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
