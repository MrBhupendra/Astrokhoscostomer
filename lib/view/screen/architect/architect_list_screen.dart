import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/view/screen/architect/controller/architect_controller.dart';
import 'package:astro_brahmand/view/screen/architect/widget/architect_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/images.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/simmer_widget/simmer_astrologer.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class ArchitectListScreen extends GetView<ArchitectController> {
  const ArchitectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //Get Arg from request
    Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    String type = arguments['type'] ?? '';

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.vastuArchitect.tr),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.offsetCount = 0;
            await controller.getArchitects(controller.offsetCount, '', 'init');
          },
          child: Obx(
                () {
              if (controller.isAstrologerLoading.isTrue) {
                AppLogger.d("isAstrologerLoading.isTrue");
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const SimmerAstrologer();
                  },
                );
              }
              else if (controller.isAstrologerSuccess.isTrue) {
                AppLogger.d("isAstrologerSuccess.isTrue");
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      // Search Box
                      Padding(
                        padding: const EdgeInsets.all(8),
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
                              AppLogger.d("Search Value-> $value");
                              // Add search logic
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Search Astrologer here',
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.astrologerListData.length,
                        itemBuilder: (context, index) {
                          return ArchitectWidget(
                            controller.astrologerListData[index],
                            onPressed: () {
                              Get.toNamed("/architect_profile_screen", arguments: {
                                "data": controller.astrologerListData[index],
                                "type": type
                              });
                            },
                          );
                        },
                      ),
                      Visibility(
                        visible: controller.isAstrologerLoading.isTrue,
                        child: const Text('Loading...'),
                      ),
                    ],
                  ),
                );
            }
              else {
                  return const EmptyScreen();
            }
              // } else if (controller.isAstrologerLoading.isTrue) {
              //   return SingleChildScrollView(
              //     physics: AlwaysScrollableScrollPhysics(),
              //     child: Column(
              //       children: List.generate(5, (index) => const SimmerAstrologer()),
              //     ),
              //   );
              // } else {
              //   return SingleChildScrollView(
              //     physics: AlwaysScrollableScrollPhysics(),
              //     child: const EmptyScreen(),
              //   );
              // }
            },
          ),
        ),
      ),
    );

    // return SafeArea(
    //     child: Scaffold(
    //   appBar: CustomAppBar(title: AppStrings.vastuArchitect.tr),
    //   body: RefreshIndicator(
    //     onRefresh: () async {
    //       controller.offsetCount = 0;
    //       controller.getArchitects(controller.offsetCount,'','init');
    //     },
    //     child: Obx(
    //       () {
    //         if (controller.isAstrologerSuccess.isTrue) {
    //           return Column(
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: TextFormField(
    //                   onChanged: (value) {
    //                     Future.delayed(const Duration(seconds: 2));
    //                     controller.getArchitects(
    //                         controller.offsetCount, value, 'search');
    //
    //                     if (value.isEmpty) {
    //                       controller.getArchitects(
    //                           controller.offsetCount, '', 'search');
    //                     }
    //                   },
    //                   decoration: InputDecoration(
    //                     contentPadding: const EdgeInsets.all(10.0),
    //                     filled: true,
    //                     fillColor: ColorResources.colorPrimaryLight,
    //                     border: OutlineInputBorder(
    //                       borderRadius: BorderRadius.circular(8.0),
    //                       borderSide: BorderSide.none,
    //                     ),
    //                     hintText: 'Search Architects..',
    //                     prefixIcon: const Icon(
    //                       Icons.search_rounded,
    //                       color: ColorResources.black2,
    //                       size: 20,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               Expanded(
    //                 child: ListView.builder(
    //                   itemCount: controller.astrologerListData.length,
    //                   controller: controller.scrollController,
    //                   itemBuilder: (context, index) {
    //                     return ArchitectWidget(
    //                       controller.astrologerListData[index],
    //                       onPressed: () {
    //                         Get.toNamed("/architect_profile_screen",
    //                             arguments: {
    //                               "data": controller.astrologerListData[index],
    //                               "type": type
    //                             });
    //                       },
    //                     );
    //                   },
    //                 ),
    //               ),
    //               Obx(
    //                 () => Visibility(
    //                   visible: controller.isAstrologerLoading.isTrue,
    //                   child: const Text('Loading...'),
    //                 ),
    //               )
    //             ],
    //           );
    //         } else if (controller.isAstrologerLoading.isTrue) {
    //           return ListView.builder(
    //             itemCount: 5,
    //             itemBuilder: (context, index) {
    //               return const SimmerAstrologer();
    //             },
    //           );
    //         } else {
    //           return const EmptyScreen();
    //         }
    //       },
    //     ),
    //   ),
    // ));
  }
}
