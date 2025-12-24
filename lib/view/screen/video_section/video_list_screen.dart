import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/view/screen/video_section/controller/video_controller.dart';
import 'package:astro_brahmand/view/screen/video_section/video_play_screen.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:astro_brahmand/view/widget/simmer_widget/simmer_banner_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_text_regular.dart';

class VideoListScreen extends GetView<VideoController> {
  const VideoListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.videos.tr.toLowerCase()),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.offsetCount = 0;
            controller.getVideoList(controller.offsetCount);
          },

          child: Obx(
                () {
              if (controller.isSuccess.isTrue) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.videoList.length,
                          controller: controller.scrollController,
                          itemBuilder: (context, index) {
                            String videoId;
                            String imageUrl;

                            if (controller.videoList[index].videoType == "youtube") {
                              // videoId = getYouTubeId(controller.videoList[index].url.toString());
                              if (controller.videoList[index].url.toString().contains("shorts")) {
                                videoId = getYouTubeShortsId(controller.videoList[index].url.toString());
                              } else {
                                videoId = getYouTubeId(controller.videoList[index].url.toString());
                              }
                              imageUrl = "http://img.youtube.com/vi/$videoId/0.jpg";
                            } else {
                              videoId = getVimeoId(controller.videoList[index].url.toString());
                              imageUrl = "https://vumbnail.com/$videoId.jpg";
                            }
                            return GestureDetector(
                              onTap: (){
                                Get.to(VideoPlayScreen(
                                    controller.videoList[index].url.toString(),
                                    controller.videoList[index].title.toString()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(10.0),
                                      // border: Border.all(color: ColorResources.colorPrimaryVariant, width: 0.5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: const Offset(0, 2),
                                        )
                                      ]
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          ClipRRect(
                                            borderRadius: const BorderRadius.vertical(top: Radius.circular(9)),
                                            child: CustomNetworkImage(
                                              imageUrl: imageUrl,
                                              height: 170,
                                              width: Get.width,
                                            ),
                                          ),
                                          Image.asset(
                                            Images.youtubeLogo,
                                            height: 30,
                                            width: 30,
                                          ),
                                        ],
                                      ),
                                      const Gap(0),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6),
                                        child: CustomTextRegular(
                                          controller.videoList[index].title.toString(),
                                          maxLines: 2,
                                          fontSize: Dimensions.fontSizeLarge,
                                          // textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
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
                  ),
                );
              } else if (controller.isLoading.isTrue) {
                return ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: SimmerBannerContainer(),
                    );
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

  String getYouTubeId(String youTubeUrl) {
    RegExp regExp = RegExp(r'(?<=youtu.be/|watch\?v=|/videos/|embed\/)[^#\&\?]*');
    Match? match = regExp.firstMatch(youTubeUrl);
    if (match != null) {
      return match.group(0)!;
    } else {
      return 'error';
    }
  }
  String getVimeoId(String vimeoUrl) {
    RegExp regExp = RegExp(r'(?:vimeo\.com/(?:video/)?|player\.vimeo\.com/video/)?(\d+)');
    Match? match = regExp.firstMatch(vimeoUrl);
    if (match != null) {
      return match.group(1)!;
    } else {
      return 'error';
    }
  }
  String getYouTubeShortsId(String youTubeShortsUrl) {
    RegExp regExp = RegExp(r'(?<=shorts/)[^#\&\?]*');
    Match? match = regExp.firstMatch(youTubeShortsUrl);
    if (match != null) {
      return match.group(0)!;
    } else {
      return 'error';
    }
  }
}