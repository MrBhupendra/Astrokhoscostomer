import 'dart:convert';

import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:astro_brahmand/utill/images.dart';
import 'package:astro_brahmand/view/screen/remedies/controller/remedies_controller.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:astro_brahmand/view/widget/simmer_widget/simmer_list_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../utill/app_constants.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_network_image.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class RemediesScreen extends StatelessWidget {
  const RemediesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String astrologerUniId = "";
    dynamic arguments = Get.arguments;

    if (arguments is Map<String, dynamic>) {
      astrologerUniId = arguments['astrologer_uni_id'] ?? '';
    }
    AppLogger.d("astrologerUniId->$astrologerUniId");
    final RemediesController controller = Get.put(RemediesController());

    controller.getRemedies(controller.offsetCount,astrologerUniId);

    controller.scrollController.addListener(() {
      if (controller.scrollController.position.pixels ==
          controller.scrollController.position.maxScrollExtent) {
        if(controller.isLoading.isFalse && !controller.isNoMoreData) {
          controller.getRemedies(controller.offsetCount,astrologerUniId);
        }
      }
    });

    return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: AppStrings.remedies.tr),
          body: RefreshIndicator(
            onRefresh: () async {
              controller.offsetCount = 0;
              controller.getRemedies(controller.offsetCount,astrologerUniId);
            },
            child: Obx(
                  () {
                if (controller.isSuccess.isTrue) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.remediesListData.length,
                          controller: controller.scrollController,
                          itemBuilder: (context, index) {
                            String productName = "";
                            String productUrl = "";
                            try{
                              if(controller.remediesListData[index].message.toString().isNotEmpty){
                                Map<String, String> messageMap = Map<String, String>.from(jsonDecode(controller.remediesListData[index].message.toString()));
                                productName =  messageMap['name'].toString();
                                productUrl =  messageMap['productUrl'].toString();
                              }
                            }catch(e){
                              AppLogger.d("exception");
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall,right: Dimensions.paddingSizeExtraOverSmall,left:Dimensions.paddingSizeExtraOverSmall,bottom: 2),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ColorResources.white,
                                    borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      )
                                    ]
                                ),

                                child: GestureDetector(
                                  onTap: (){
                                    String type = controller.remediesListData[index].messageType.toString();
                                    if(type == AppConstants.product){
                                      if(productUrl.isNotEmpty){
                                        Uri uri = Uri.parse(productUrl);
                                        String productSlug = uri.pathSegments[1].toString();
                                        String astrologerId = uri.pathSegments[2].toString();
                                        Get.toNamed('/productDetail/$productSlug/$astrologerId');
                                      }
                                    }else if(type == AppConstants.service){
                                      Uri uri = Uri.parse(productUrl);
                                      String serviceSlug = uri.pathSegments[1].toString();
                                      String astrologerId = uri.pathSegments[2].toString();
                                      Get.toNamed('/serviceDetail/$serviceSlug/$astrologerId');
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall,horizontal: Dimensions.paddingSizeOverSmall),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if(controller.remediesListData[index].fileUrl != null && controller.remediesListData[index].fileUrl.toString().isNotEmpty)
                                          CustomNetworkImage(
                                            imageUrl: controller.remediesListData[index].fileUrl.toString(),
                                            height: 60,
                                            width: 60,
                                          ),

                                        if(controller.remediesListData[index].fileUrl.toString().isEmpty)
                                          Image.asset(Images.remedies,height: 50,width: 50,),

                                        const Gap(Dimensions.gapMedium),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: CustomTextMedium(
                                                      productName,
                                                      fontSize: Dimensions.fontSizeLarge,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Gap(Dimensions.gapExtraExtraSmall),
                                              CustomTextRegular(
                                               "${controller.remediesListData[index].userName.toString()} has recommended a $productName remedy just for you!",
                                                color: ColorResources.black1,
                                              ),
                                              const Gap(2),
                                              CustomTextMedium(
                                                "View Detail >",
                                                fontSize: Dimensions.fontSizeDefault,
                                                color: Colors.blueAccent,
                                              ),
                                              const Gap(2),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  CustomTextRegular(
                                                    CommonMethods().formatDateTimeOutput(controller.remediesListData[index].createdAt.toString()),
                                                    fontSize: Dimensions.fontSizeExtraSmall,
                                                    color: ColorResources.black3,
                                                    textAlign: TextAlign.end,

                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Obx(() => Visibility(
                        visible: controller.isLoading.isTrue,
                        child: const Text('Loading'),
                      ),)

                    ],
                  );
                }
                else if (controller.isLoading.isTrue) {
                  return ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const SimmerListView();
                    },
                  );
                }
                else {
                  return const EmptyScreen();
                }
              },
            ),
          ),
        ));
  }
}
