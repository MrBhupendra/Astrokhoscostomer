import 'dart:async';

import 'package:astro_brahmand/model/services_model.dart';
import 'package:astro_brahmand/view/widget/simmer_widget/simmer_grid_container2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/services_widget.dart';
import 'controller/service_controller.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class ServiceListScreen extends GetView<ServiceController> {
  const ServiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic arguments = Get.arguments;
    String title = '';
    String categoryId = '';

    if (arguments is Map<String, dynamic>) {
      title = arguments['title'] ?? '';
      categoryId = arguments['id'] ?? '';
    }
    else if (arguments is ServicesData) {
      title = arguments.serviceName.toString();
      categoryId = arguments.id.toString();
    }

    AppLogger.d("controller.serviceOffsetCount-> ${controller.serviceOffsetCount}");
    controller.getServices(controller.serviceOffsetCount, categoryId, "");

    void searchServices(String query) {
      if (controller.debounce?.isActive ?? false) controller.debounce!.cancel();
      controller.debounce = Timer(const Duration(seconds: 1), () {
        controller.searchQuery.value = query;
        controller.offsetCount = 0;
        controller.getServices(controller.offsetCount,categoryId, query);
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: title),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.getServices(controller.serviceOffsetCount, categoryId, "");
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorResources.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 3.0,
                        spreadRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: (value) {
                      searchServices(value);
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: AppStrings.searchServices.tr,
                      // hintStyle: TextStyle(color: ColorResources.colorPrimary),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          Images.search,
                          width: 18,
                          height: 18,
                          color: ColorResources.colorPrimary,
                          // fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () {
                    if (controller.isServiceSuccess.isTrue) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8,top: 2, right: 8),
                        child: GridView.builder(
                          itemCount: controller.serviceModel.data?.length ?? 0,
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 250,
                              childAspectRatio: 1.10,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 10
                          ),
                          // physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 10),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ServicesWidget(
                              controller.serviceModel.data![index],
                              onPressed: () {
                                controller.serviceData = controller.serviceModel.data![index];
                                Get.toNamed("/service_detail");
                              },
                            );
                          },
                        ),
                      );
                    } else if (controller.isServiceLoading.isTrue) {
                      return const SimmerGridContainer2();
                    } else {
                      return const EmptyScreen();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
