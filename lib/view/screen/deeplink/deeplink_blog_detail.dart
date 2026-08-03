import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:astro_brahmand/view/screen/blog/controller/blog_controller.dart';
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:astro_brahmand/view/widget/custom_empty_screen.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:astro_brahmand/view/widget/simmer_widget/simmer_grid_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';

class DeeplinkBlogDetail extends StatelessWidget {
  const DeeplinkBlogDetail({super.key});

  @override
  Widget build(BuildContext context) {
    String blogSlug = Get.parameters['slug'] ?? "";

    final BlogController controller = Get.put(BlogController());
    controller.getBlogBySlug(blogSlug.toString());

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorResources.white,
        appBar: CustomAppBar(title: AppStrings.astrologyBlog.tr),
        body: Obx(
          () {
            if (controller.isBlogDetailSuccess.isTrue) {
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1.5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CustomNetworkImage(
                                  imageUrl:
                                      controller.blogsData.blogImage.toString(),
                                  height: 300,
                                  width: Get.width,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(15),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextMedium(
                              controller.blogsData.title.toString(),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      const Gap(8),
                      HtmlWidget(
                        controller.blogsData.content.toString(),
                        textStyle: const TextStyle(
                          fontSize: Dimensions.fontSizeDefault,
                        ),
                      ),
                      const Gap(10),
                      Row(
                        children: [
                          CustomTextRegular(
                            "POSTED BY : ",
                            maxLines: 1,
                            fontSize: Dimensions.fontSizeSmall,
                          ),
                          CustomTextRegular(
                            controller.blogsData.astrologer?.displayName
                                    .toString() ??
                                "",
                            maxLines: 1,
                            color: ColorResources.colorPrimaryDark,
                            fontSize: Dimensions.fontSizeSmall,
                          ),
                        ],
                      ),
                      const Gap(2),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextRegular(
                              CommonMethods().formatDateTimeOutput(
                                  controller.blogsData.createdAt.toString()),
                              maxLines: 1,
                              color: ColorResources.colorPrimaryDark,
                              fontSize: Dimensions.fontSizeSmall,
                            ),
                          ),
                        ],
                      ),
                      const Gap(8),
                    ],
                  ),
                ),
              );
            } else if (controller.isBlogDetailLoading.isTrue) {
              return ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const SimmerGridContainer();
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
