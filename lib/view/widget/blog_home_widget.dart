import 'package:flutter/material.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:translator/translator.dart';

import '../../model/blog_model.dart';
import '../../utill/dimensions.dart';
import 'custom_box_decoration.dart';

class BlogHomeWidget extends StatelessWidget {
  BlogsData blogs;
  final Function? onPressed;
  BlogHomeWidget(this.blogs, {super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    // final box = GetStorage();
    return GestureDetector(
      onTap: () {
        onPressed?.call();
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0,bottom: 4,left: 2),
        child: Container(
          width: 240,
          // height: 100,
          padding: const EdgeInsets.all(0.0),
          decoration: CustomBoxDecoration.getDecoration(),

          // decoration: BoxDecoration(
          //     color: Colors.white.withOpacity(0.9),
          //     borderRadius: BorderRadius.circular(10.0),
          //     border: Border.all(color: ColorResources.colorPrimaryVariant, width: 0.5),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.withOpacity(0.3),
          //         spreadRadius: 1,
          //         blurRadius: 2,
          //         offset: const Offset(0, 2),
          //       )
          //     ]),
          child: Column(
            children: [
              // Image.asset(
              //   Images.bannerHome,
              //   height: 135,
              //   width: Get.width,
              //   fit: BoxFit.fill,
              // ),
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.borderRadiusDefault)),
                child: CustomNetworkImage(
                  imageUrl: blogs.blogImage.toString(),
                  height: 135,
                  width: Get.width,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextMedium(
                        blogs.title.toString(),
                        maxLines: 1,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextMedium(
                        blogs.astrologer!.displayName.toString(),
                        maxLines: 1,
                        fontSize: Dimensions.fontSizeExtraSmall,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    CustomTextRegular(
                      blogs.day.toString(),
                      maxLines: 1,
                      fontSize: Dimensions.fontSizeExtraSmall,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
// Future<String> _translateName(String name) async {
//   final translator = GoogleTranslator();
//   Translation translatedName = await translator.translate(name, to: 'hi');
//   return translatedName.text; // Extract the translated text and return it as a String
// }