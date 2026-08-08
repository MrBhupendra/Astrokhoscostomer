import 'package:astro_brahmand/view/screen/dashboard/controller/live_astrologer_controller.dart';
import 'package:astro_brahmand/view/widget/custom_empty_screen.dart';
import 'package:astro_brahmand/view/widget/live_astrologer_widget.dart';
import 'package:astro_brahmand/view/widget/upcoming_live_astrologer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../../utill/shared_preference.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';
import '../../widget/simmer_widget/simmer_astrologer.dart';
import '../agora/live_stream/controller/live_stream_init_controller.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class LiveAstrologerScreen extends StatelessWidget {
  const LiveAstrologerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LiveAstrologerController controller = Get.put<LiveAstrologerController>(LiveAstrologerController());
    controller.isAstrologerSuccess(false);
    controller.getAllAstrologer("live");
    controller.getUpcomingLiveAstrologer();
    return RefreshIndicator(
      onRefresh: () async {
        controller.getAllAstrologer("live");
        controller.getUpcomingLiveAstrologer();
      },
      child: Obx(
            () {
          if (controller.isAstrologerSuccess.isTrue || controller.isUpcomingSuccess.isTrue) {
            return Column(
              children: [
                if(controller.isAstrologerSuccess.isTrue)
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.astrologerModel.data?.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return LiveAstrologerWidget(
                          controller.astrologerModel.data![index],
                          onPressed: () async {
                            bool isLogin = await SharedPreferencesHelper.getIsLogin();
                            if (isLogin) {
                              String callRate = '**', callDuration = '**', videoRate = '**', videoDuration = '**',privateCallRate = '**', privateCallDuration = '**', privateVideoRate = '**', privateVideoDuration = '**';
                              controller.astrologerModel.data?[index].prices?.forEach((priceItem) {
                                String type = priceItem.type.toString();
                                switch (type) {
                                  case AppConstants.liveAudioCall:
                                    callRate = priceItem.price.toString();
                                    callDuration = priceItem.timeInMinutes.toString();
                                    break;
                                  case AppConstants.liveVideoCall:
                                    videoRate = priceItem.price.toString();
                                    videoDuration = priceItem.timeInMinutes.toString();
                                    break;
                                  case AppConstants.privateLiveAudioCall:
                                    privateCallRate = priceItem.price.toString();
                                    privateCallDuration = priceItem.timeInMinutes.toString();
                                    break;
                                  case AppConstants.privateLiveVideoCall:
                                    privateVideoRate = priceItem.price.toString();
                                    privateVideoDuration = priceItem.timeInMinutes.toString();
                                    break;
                                }
                              });

                              final LiveStreamInitController liveController = Get.put(LiveStreamInitController());
                              String astrologerName = controller.astrologerModel.data![index].displayName.toString();
                              String astrologerImage = controller.astrologerModel.data![index].astroImg.toString();
                              liveController.setAstrologerData(astrologerName, astrologerImage, callRate, videoRate, callDuration, videoDuration,privateCallRate, privateVideoRate, privateCallDuration, privateVideoDuration,AppConstants.live);

                              // Join Live
                              int astrologerUID = controller.astrologerModel.data![index].user!.id!.toInt();
                              String uniqueId = controller.astrologerModel.data![index].liveChannel.toString();
                              String astrologerUniId = controller.astrologerModel.data![index].astrologerUniId.toString();
                              controller.joinLiveStream(astrologerUID, uniqueId, astrologerUniId);
                              AppLogger.d("astrologerUID->$astrologerUID uniqueId->$uniqueId astrologerUniId->$astrologerUniId");
                            }else{
                              Get.toNamed('/login');
                            }
                          },
                        );
                      },
                    ),
                  ),
                if(controller.isUpcomingSuccess.isTrue)
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.upcomingLiveAstrologerModel.data?.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return UpcomingLiveAstrologerWidget(
                          controller.upcomingLiveAstrologerModel.data![index],
                          onPressed: () async {
                            bool isLogin = await SharedPreferencesHelper.getIsLogin();
                            if (isLogin) {

                            }else{
                              Get.toNamed('/login');
                            }
                          },
                        );
                      },
                    ),
                  ),
              ],
            );
          }
          else if (controller.isAstrologerLoading.isTrue || controller.isUpcomingLoading.isTrue) {
            return ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const SimmerAstrologer();
              },
            );
          } else {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeLarge,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Images.liveEmptyImage,
                      height: 200,
                    ),
                    const SizedBox(height: Dimensions.gapLarge),
                    CustomTextMedium(
                      "No One is Live Right Now",
                      textAlign: TextAlign.center,
                      fontSize: Dimensions.fontSizeOverLarge,
                      color: ColorResources.black2,
                    ),
                    const SizedBox(height: Dimensions.gapSmall),
                    CustomTextRegular(
                      "Our experts will be back shortly.\nStay tuned or explore upcoming sessions.",
                      textAlign: TextAlign.center,
                      fontSize: Dimensions.fontSizeSmall,
                      color: ColorResources.black5,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}