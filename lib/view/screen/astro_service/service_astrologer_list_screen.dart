import 'package:astro_brahmand/view/screen/astro_service/controller/service_controller.dart';
import 'package:astro_brahmand/view/widget/service_astrologer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utill/shared_preference.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_text_regular.dart';
import '../../widget/simmer_widget/simmer_astrologer.dart';

class ServiceAstrologerListScreen extends GetView<ServiceController> {
  const ServiceAstrologerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    String astrologerID = arguments['astrologerId'] ?? '';
    controller.astrologerOffsetCount = 0;
    controller.getAstrologer(controller.astrologerOffsetCount, controller.serviceData.id.toString(),astrologerUniId: astrologerID);
    //Scroll
    controller.astrologerScrollController.addListener(() {
      if (controller.astrologerScrollController.position.pixels ==
          controller.astrologerScrollController.position.maxScrollExtent) {
        if (controller.isAstrologerLoading.isFalse && !controller.astrologerIsNoMoreData) {
          controller.getAstrologer(controller.astrologerOffsetCount,
              controller.serviceData.id.toString());
        }
      }
    });
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(title: controller.serviceData.serviceName.toString()),
      body: Obx(
        () {
          if (controller.isAstrologerSuccess.isTrue) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.astrologerListData.length,
                    controller: controller.astrologerScrollController,
                    itemBuilder: (context, index) {
                      return ServiceAstrologerWidget(
                        controller.astrologerListData[index],
                        onPressed: () async {
                          bool isLogin =
                              await SharedPreferencesHelper.getIsLogin();
                          if (isLogin) {
                            controller.getServiceCalculation(
                                controller.astrologerListData[index].id
                                    .toString(),
                                controller.astrologerListData[index]
                                    .astrologerUniId
                                    .toString(),
                                0,
                                controller.serviceData,
                                "Open",
                                controller.astrologerListData[index].duration.toString(),
                                "",
                                context);
                          } else {
                            Get.toNamed('/login');
                          }
                        },
                        onSelect: () async {
                          bool isLogin = await SharedPreferencesHelper.getIsLogin();
                          if (isLogin) {
                            controller.getServiceCalculation(
                                controller.astrologerListData[index].id
                                    .toString(),
                                controller.astrologerListData[index]
                                    .astrologerUniId
                                    .toString(),
                                0,
                                controller.serviceData,
                                "Open",
                                controller.astrologerListData[index].duration.toString(),
                                "",
                                context);
                          } else {
                            Get.toNamed('/login');
                          }
                        },
                      );
                    },
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: controller.isAstrologerLoading.isTrue,
                    child: CustomTextRegular('Loading...'),
                  ),
                )
              ],
            );
          }
          else if (controller.isAstrologerLoading.isTrue) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (context, index) {
                return const SimmerAstrologer();
              },
            );
          }
          else {
            return const EmptyScreen();
          }
        },
      ),
    ));
  }
}
