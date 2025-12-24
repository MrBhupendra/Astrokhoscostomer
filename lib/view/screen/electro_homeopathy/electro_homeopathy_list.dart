import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/all_astrologer_controller.dart';
import '../../../utill/app_strings.dart';
import '../../widget/astrologer_widget.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/simmer_widget/simmer_astrologer.dart';

class ElectroHomeopathyList extends StatelessWidget {
  const ElectroHomeopathyList({super.key});

  @override
  Widget build(BuildContext context) {
    AllAstrologerController controller = Get.find();
    controller.offsetCount = 0;
    //TODO HANDLE
    //controller.getAllAstrologer(controller.offsetCount,controller.searchValue,controller.categorySelected,"init");

    //Scroll
    controller.scrollController.addListener(() {
      if (controller.scrollController.position.pixels ==
          controller.scrollController.position.maxScrollExtent) {
        if(controller.isAstrologerLoading.isFalse && !controller.isNoMoreData) {
          //TODO HANDLE
          //controller.getAllAstrologer(controller.offsetCount,controller.searchValue,controller.categorySelected,"scroll");
        }
      }
    });

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.electroHomeopathy.tr),
        body: RefreshIndicator(
          onRefresh: () async {

          },
          child: Obx(
                () {
              if (controller.isAstrologerSuccess.isTrue) {
                return Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TextFormField(
                    //     onChanged: (value) {
                    //       Future.delayed(const Duration(seconds: 2));
                    //       if (value.isEmpty || value.toString().isEmpty || value.toString() == '' || value.toString() == "") {
                    //         controller.searchSelected = "";
                    //       } else {
                    //          controller.searchSelected = value.toString();
                    //       }
                    //     },
                    //     decoration: InputDecoration(
                    //       contentPadding: const EdgeInsets.all(10.0),
                    //       filled: true,
                    //       fillColor: ColorResources.colorPrimaryLight,
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(8.0),
                    //         borderSide: BorderSide.none,
                    //       ),
                    //       hintText: AppStrings.searchAstrologers.tr,
                    //       prefixIcon: const Icon(
                    //         Icons.search_rounded,
                    //         color: ColorResources.black2,
                    //         size: 20,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.astrologerListData.length,
                        controller: controller.scrollController,
                        itemBuilder: (context, index) {
                          return AstrologerWidget(
                            controller.astrologerListData[index],
                            onPressed: () {
                              controller.selectedAstrologerData.value = controller.astrologerListData[index];
                              Get.toNamed("/astroProfile");
                            },
                          );
                        },
                      ),
                    ),
                    Obx(() => Visibility(
                      visible: controller.isAstrologerLoading.isTrue,
                      child: const Text('Loading..'),
                    ),)
                  ],
                );
              }
              else if (controller.isAstrologerLoading.isTrue) {
                return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const SimmerAstrologer();
                  },
                );
              } else {
                return const EmptyScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
