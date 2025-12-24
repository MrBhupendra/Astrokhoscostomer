import 'package:astro_brahmand/view/widget/simmer_widget/simmer_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/view/widget/custom_elevated_button.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/simmer_widget/simmer_grid_container.dart';
import '../astro_service/controller/service_controller.dart';
import '../splash/controller/config_controller.dart';


class DeeplinkServiceDetail extends StatelessWidget {
  const DeeplinkServiceDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();
    String serviceSlug = Get.parameters['slug'] ?? " ";
    String astrologerRefId = Get.parameters['id'] ?? " ";

    final ServiceController controller = Get.put(ServiceController());
    controller.getServices(0,"0", "",slug: serviceSlug.toString());
    controller.refId.value = astrologerRefId.toString();

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.serviceDetail.tr),
        body: Obx(
              () {
            if (controller.isServiceSuccess.isTrue) {
              controller.serviceData = controller.serviceModel.data![0];
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeMediumSmall,
                            vertical: Dimensions.paddingSizeSmall),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image.asset(Images.testProduct,height: 200,width: Get.width,),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                              child: CustomNetworkImage(
                                  imageUrl: controller.serviceData.serviceImage.toString(),
                                  height: 200,
                                  width: Get.width
                              ),
                            ),
                            const Gap(15),
                            CustomTextMedium(controller.serviceData.serviceName.toString(),fontSize: Dimensions.fontSizeLarge),
                            const Gap(5),
                            const Divider(),
                            const Gap(5),
                            HtmlWidget(
                              controller.serviceData.serviceDescription.toString(),
                              textStyle: const TextStyle(
                                color: ColorResources.black2,
                              ),

                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: ColorResources.white,
                    child: Padding(
                      padding:
                      const EdgeInsets.all(Dimensions.paddingSizeMediumSmall),
                      child: CustomElevatedButton(
                        onPressed: (){
                          Get.toNamed("/service_astrologer_list",arguments: {
                            'astrologerId': astrologerRefId
                          });
                        },
                        text: AppStrings.bookNow.tr,
                        backgroundColor: ColorResources.colorPrimary,
                        textColor: ColorResources.toolbarText,
                      ),
                    ),
                  ),
                ],
              );
            }
            else if (controller.isServiceLoading.isTrue) {
              return ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const SimmerListView();
                },
              );
            } else {
              return const EmptyScreen();
            }
          },
        ),
      ),
    );
  }
}
