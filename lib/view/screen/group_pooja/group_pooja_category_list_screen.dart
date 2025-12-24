import 'package:astro_brahmand/view/widget/simmer_widget/simmer_grid_container.dart';
import 'package:flutter/material.dart';
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:get/get.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/group_pooja_category_widget.dart';
import 'controller/group_pooja_controller.dart';

class GroupPoojaCategoryListScreen extends GetView<GroupPoojaController> {
  const GroupPoojaCategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getGroupPoojaCategory("", "");

    // TextEditingController searchController = TextEditingController();
    //
    // void performSearch(String query) {
    //   Future.delayed(const Duration(seconds: 2), () {
    //     controller.getServiceCategory("", query);
    //   });
    // }

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.appBarGroupPoojaCategories.tr),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.getGroupPoojaCategory("", "");
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
                      controller.searchGroupPoojaCategory(value);
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Search Group Pooja Category',
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
                    if (controller.isCategorySuccess.isTrue) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 0.0),
                          child: GridView.builder(
                            itemCount: controller.groupPujaCategoryModel.data?.length ?? 0,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 0.0,
                              crossAxisSpacing: 0.0,
                              childAspectRatio: 0.75,
                            ),
                            itemBuilder: (context, index) {
                              return GroupPoojaCategoryWidget(
                                controller.groupPujaCategoryModel.data![index],
                                onPressed: () {
                                  Get.toNamed('/group_pooja_list_screen', arguments: {
                                    'id': controller.groupPujaCategoryModel.data![index].id.toString(),
                                    'title': controller.groupPujaCategoryModel.data![index].title.toString()
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      );
                    }
                    else if (controller.isCategoryLoading.isTrue) {
                      return const SimmerGridContainer();
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
