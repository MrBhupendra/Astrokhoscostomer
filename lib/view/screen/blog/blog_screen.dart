import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:astro_brahmand/view/widget/simmer_widget/simmer_list_view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../utill/color_resources.dart';
import '../../../utill/common_methods.dart';
import '../../../utill/dimensions.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_html_expanded.dart';
import '../../widget/custom_round_network_image.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'controller/blog_controller.dart';

class BlogScreen extends GetView<BlogController> {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.blog.tr),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.offsetCount = 0;
            controller.getBlog(controller.offsetCount, "");
          },

          child: Obx(
                () {
              if (controller.isSuccess.isTrue) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.blogsListData.length,
                        controller: controller.scrollController,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              controller.blogsData = controller.blogsListData[index];
                              Get.toNamed("/blog_detail");
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.paddingSizeExtraSmall,
                                  horizontal: Dimensions.paddingSizeOverSmall),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: ColorResources.white,
                                    borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: const Offset(0, 1),
                                      )
                                    ]),
                                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall,horizontal: Dimensions.paddingSizeDefault),
                                        child: Row(
                                          children: [
                                            // Image.asset(
                                            //   Images.pngProfile,
                                            //   height: 60,
                                            // ),
                                            CustomRoundNetworkImage(
                                              imageUrl: controller.blogsListData[index].astrologer!.astroImg.toString(),
                                              height: 45,
                                              width: 45,
                                            ),
                                            const Gap(Dimensions.gapMedium),
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                crossAxisAlignment:CrossAxisAlignment.start,
                                                children: [
                                                  CustomTextMedium(
                                                    controller.blogsListData[index].astrologer!.displayName.toString(),
                                                    maxLines: 2,
                                                  ),
                                                  const SizedBox(
                                                      height: Dimensions
                                                          .sizedBoxExtraExtraSmall),
                                                  CustomTextRegular(
                                                    controller.blogsListData[index].day.toString(),
                                                    fontSize: Dimensions.fontSizeSmall,
                                                    color: ColorResources.colorFontRed,
                                                  )
                                                ],
                                              ),
                                            ),
                                            const Gap(8),
                                            Visibility(
                                              visible: false,
                                              child: PopupMenuButton<String>(
                                                onSelected: (value) {
                                                  if (value == 'report') {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          title: const Text('Report'),
                                                          content: const Text('Are you sure you want to Report this blog?'),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              onPressed:
                                                                  () {
                                                                Get.back();
                                                              },
                                                              child: const Text('No'),
                                                            ),
                                                            TextButton(
                                                              onPressed:
                                                                  () {
                                                                Get.back();
                                                                // num? id = controller.blogModel.data?[index].id;
                                                                // controller.deleteBlog(index,id!);
                                                              },
                                                              child:const Text('Yes'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }
                                                },
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                                itemBuilder: (BuildContext context) => [
                                                  const PopupMenuItem<String>(
                                                    value: 'report',
                                                    child: Center(
                                                        child: Text(
                                                          'Report',
                                                          style: TextStyle(
                                                              fontSize: Dimensions.fontSizeDefault),
                                                        )
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // const Icon(Icons.more_vert,color: ColorResources.black2)
                                          ],
                                        ),
                                      ),

                                      const Divider(color: ColorResources.black7,height: 1),
                                      const Gap(Dimensions.gapDefault),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child:  CustomTextMedium(
                                                controller.blogsListData[index].title.toString(),
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Gap(4),
                                      // Row(
                                      //   children: [
                                      //     Expanded(
                                      //       child:  CustomTextRegular(
                                      //         controller.blogsListData[index].content.toString(),
                                      //         maxLines: 3,
                                      //         color: ColorResources.black1,
                                      //         fontSize: Dimensions.fontSizeSmall,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                        child: CustomHtmlTextExpanded(
                                            fullText: controller.blogsListData[index].content.toString()
                                            ,mainAxisAlignment: MainAxisAlignment.end,
                                            textColor: ColorResources.colorText,
                                            iconColor: ColorResources.colorText
                                        ),
                                      ),
                                      const Gap(Dimensions.gapDefault),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: AspectRatio(
                                                aspectRatio: 1.85,
                                                // Adjust the aspect ratio as needed
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: CustomNetworkImage(
                                                    imageUrl: controller.blogsListData[index]
                                                        .blogImage
                                                        .toString(),
                                                    height: 300, width: Get.width * 0.8,
                                                  ),
                                                ),
                                                // Image.asset(
                                                //   Images.test1,
                                                //   height: 80,
                                                // ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const Gap(Dimensions.gapDefault),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: CustomTextRegular(
                                                CommonMethods().formatDateTimeOutput(controller.blogsListData[index].createdAt.toString()),
                                                maxLines: 1,
                                                color: ColorResources.black1,
                                                fontSize: Dimensions.fontSizeSmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Gap(Dimensions.gapLarge),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                                        child: Row(
                                          children: [
                                            // IconButton(
                                            //   icon: Icon(
                                            //     controller.blogsListData[index].isLikes == true ? Icons.favorite : Icons.favorite_border,
                                            //     color: Colors.pink,
                                            //     size: Dimensions.iconSizeMedium,
                                            //   ),
                                            //   onPressed: () async {
                                            //     // String status = controller.isLike.value ? "0" : "1";
                                            //     // await controller.blogLike(
                                            //     //   status,
                                            //     //   controller.blogsListData[index].id.toString(),
                                            //     // );
                                            //     //
                                            //     // // Update the isLike value after the blogLike call
                                            //     // controller.isLike.value = !controller.isLike.value;
                                            //     //
                                            //     // if (status == "0") {
                                            //     //   CustomSnackBar.showTop(AppStrings.blogUnlikeMsg);
                                            //     // } else {
                                            //     //   CustomSnackBar.showTop(AppStrings.blogLikeMsg);
                                            //     // }
                                            //
                                            //     print(controller.isLike.value);
                                            //   },
                                            // ),
                                            Obx(()=>
                                                IconButton(
                                                  icon: Icon(
                                                    controller.blogsListData[index].liked.value == true ? Icons.favorite : Icons.favorite_border,
                                                    color: Colors.pink,
                                                    size: Dimensions.iconSizeMedium,
                                                  ),
                                                  onPressed: () async {
                                                    String status = controller.blogsListData[index].liked.value ? "0" : "1";
                                                    int likeCount = controller.blogsListData[index].count.value.toInt();
                                                    if(status == "1"){
                                                      likeCount = likeCount + 1;
                                                    }else{
                                                      likeCount = likeCount - 1;
                                                    }
                                                    await controller.blogLike(
                                                        status,
                                                        controller.blogsListData[index].id.toString(),
                                                        index,
                                                        likeCount
                                                    );
                                                    print(controller.blogsListData[index].liked.value);
                                                  },
                                                )),
                                            Expanded(
                                              child: Obx(()=>
                                                  CustomTextRegular(
                                                    controller.blogsListData[index].count.value.toString(),
                                                    maxLines: 1,
                                                    color: ColorResources.black1,
                                                    // fontSize: Dimensions.fontSizeSmall,
                                                  ),
                                              ),
                                            ),
                                            // const Icon(
                                            //   Icons.favorite,
                                            //     color: Colors.pink,
                                            //     size: Dimensions.iconSizeMedium,
                                            // ),
                                            // const Gap(Dimensions.gapMedium),
                                            // Expanded(
                                            //   child: CustomTextRegular(
                                            //     controller.blogsListData[index].likeCount.toString(),
                                            //     maxLines: 1,
                                            //     color: ColorResources.black1,
                                            //     fontSize: Dimensions.fontSizeSmall,
                                            //   ),
                                            // ),
                                            const Gap(Dimensions.gapMedium),
                                            GestureDetector(
                                              onTap: () async {
                                                String astroSlugUrl = controller.blogsListData[index].slug.toString();
                                                String quoteSlug = controller.blogsListData[index].title.toString() ?? '';
                                                String blogUrl = controller.blogsListData[index].content.toString() ?? '';
                                                String imageUrl = controller.blogsListData[index].blogImage.toString();
                                                CommonMethods().shareApp("blog", astroSlugUrl: astroSlugUrl, quoteSlug: quoteSlug, blogUrl: blogUrl, imageUrl: imageUrl);
                                              },
                                              child: const Icon(
                                                Icons.share,
                                                color: ColorResources.black1,
                                              ),
                                            ),
                                            const Gap(18),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: Dimensions.sizedBoxLarge),
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
                      child: const Text('Loading..'),
                    ),)
                  ],
                );
              } else if (controller.isLoading.isTrue) {
                return ListView.builder(
                  itemCount: 10,
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
      ),
    );
  }
}

Future<File> _downloadAndSaveImage(String imageUrl) async {
  try {
    http.Response response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      final Directory tempDir = await getTemporaryDirectory();
      final String tempPath = tempDir.path;
      const String fileName = 'Blog Image.png';
      final File localImage = File('$tempPath/$fileName');
      await localImage.writeAsBytes(response.bodyBytes);
      return localImage;
    } else {
      throw Exception('Failed to download image: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to download image: $e');
  }
}