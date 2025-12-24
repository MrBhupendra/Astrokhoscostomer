import 'dart:async';

import 'package:astro_brahmand/view/widget/simmer_widget/simmer_grid_container2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/group_pujas_list_model.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/group_pooja_widget.dart';
import 'controller/group_pooja_controller.dart';

class GroupPoojaListScreen extends GetView<GroupPoojaController> {
  const GroupPoojaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic arguments = Get.arguments;
    String title = '';
    String categoryId = '';

    if (arguments is Map<String, dynamic>) {
      title = arguments['title'] ?? '';
      categoryId = arguments['id'] ?? '';
    }
    else if (arguments is GroupPoojaListData) {
      title = arguments.groupPujaName.toString();
      categoryId = arguments.groupPujaCategoryId.toString();
    }

    controller.getGroupPoojaList(controller.serviceOffsetCount, categoryId, "");

    void searchServices(String query) {
      if (controller.debounce?.isActive ?? false) controller.debounce!.cancel();
      controller.debounce = Timer(const Duration(seconds: 1), () {
        controller.searchQuery.value = query;
        controller.offsetCount = 0;
        controller.getGroupPoojaList(controller.offsetCount,categoryId, query);
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: title),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.getGroupPoojaList(controller.serviceOffsetCount, categoryId, "");
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
                      hintText: AppStrings.searchGroupPooja.tr,
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
                    if (controller.isGroupPoojaSuccess.isTrue) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 2.0),
                        child: GridView.builder(
                          itemCount: controller.groupPujasListModel.data?.length ?? 0,
                          // shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                            childAspectRatio: 0.90,
                          ),
                          itemBuilder: (context, index) {
                            return GroupPoojaWidget(
                              controller.groupPujasListModel.data![index],
                              onPressed: () {
                                controller.groupPoojaListData = controller.groupPujasListModel.data![index];
                                Get.toNamed("/group_pooja_detail");
                              },
                            );
                          },
                        ),
                      );
                    } else if (controller.isGroupPoojaLoading.isTrue) {
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
