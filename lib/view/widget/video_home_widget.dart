import 'package:astro_brahmand/model/dashboard_model.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../utill/images.dart';
import 'custom_text_regular.dart';
import 'custom_box_decoration.dart';

class VideoHomeWidget extends StatelessWidget {
  Videosection videosection;
  final Function? onPressed;

  VideoHomeWidget(this.videosection, {super.key, this.onPressed});

  // Blogs blogs;
  // final Function? onPressed;
  @override
  Widget build(BuildContext context) {
    String videoId;
    String imageUrl;

    if (videosection.videoType == "youtube") {
      // videoId = getYouTubeId(videosection.url.toString());
      if (videosection.url.toString().contains("shorts")) {
        videoId = getYouTubeShortsId(videosection.url.toString());
      } else {
        videoId = getYouTubeId(videosection.url.toString());
      }
      imageUrl = "http://img.youtube.com/vi/$videoId/0.jpg";
    } else {
      videoId = getVimeoId(videosection.url.toString());
      imageUrl = "https://vumbnail.com/$videoId.jpg";
    }
    return GestureDetector(
      onTap: () {
        onPressed?.call();
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0,bottom: 4,left: 2),
        child: Container(
          width: 190,
          // height: 100,
          padding: const EdgeInsets.all(0.0),
          decoration: CustomBoxDecoration.getDecoration(),
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
                      height: 100,
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
              const Gap(5),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4),
                child: CustomTextRegular(
                  videosection.title.toString(),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
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
