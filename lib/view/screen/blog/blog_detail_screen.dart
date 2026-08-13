import 'package:astro_brahmand/utill/app_fonts.dart';
import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:astro_brahmand/view/screen/blog/controller/blog_controller.dart';
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../widget/custom_network_image.dart';
import '../../widget/custom_text_regular.dart';
import 'package:astro_brahmand/utill/app_strings.dart';

class BlogDetailScreen extends StatelessWidget {
  BlogDetailScreen({super.key});
  final BlogController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorResources.white,
        appBar: CustomAppBar(title: AppStrings.astrologyBlog.tr),
        body: SingleChildScrollView(
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 8),
            child: Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1.5,
                        // Adjust the aspect ratio as needed
                        child:
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CustomNetworkImage(
                            imageUrl: controller.blogsData.blogImage.toString(),
                            height: 300, width: Get.width,
                          ),
                        ),
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(10),
                        //   child: Image.asset(
                        //     Images.testProduct,
                        //     height: 250,
                        //     width: Get.width * 0.8,
                        //   ),
                        // ),
                      ),
                    ),
                  ],
                ),
                const Gap(15),
                Row(
                  children: [
                    Expanded(
                      child:  CustomTextMedium(
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
                    fontFamily: AppFonts.euclidRegular,
                    fontFamilyFallback: AppFonts.fallback,
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
                      controller.blogsData.astrologer!.displayName.toString(),
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
                        CommonMethods().formatDateTimeOutput(controller.blogsData.createdAt.toString()),
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
        ),
      ),
    );
  }
}
