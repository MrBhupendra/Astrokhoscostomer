import 'package:astro_brahmand/utill/app_features.dart';
import 'package:astro_brahmand/view/screen/blog/controller/blog_controller.dart';
import 'package:astro_brahmand/view/screen/video_section/video_play_screen.dart';
import 'package:astro_brahmand/view/widget/home_header_widget.dart';
import 'package:astro_brahmand/view/widget/simmer_widget/simmer_banner_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/utill/images.dart';
import 'package:astro_brahmand/view/widget/blog_home_widget.dart';
import 'package:astro_brahmand/view/widget/custom_button.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:astro_brahmand/view/widget/free_service_widget.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:astro_brahmand/view/widget/dash_astrologer_widget1.dart';
import 'package:astro_brahmand/view/widget/product_category_widget.dart';
import 'package:astro_brahmand/view/widget/service_category_widget.dart';
import 'package:astro_brahmand/view/widget/simmer_widget/simmer_dash_astrologer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../controller/all_astrologer_controller.dart';
import '../../../model/home_menu_model.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/shared_preference.dart';
import '../../widget/astrologer_profile_card.dart';
import '../../widget/custom_round_network_image.dart';
import '../../widget/custom_text_regular.dart';
import '../../widget/dash_live_astrologer_widget.dart';
import '../../widget/dash_orders_widget.dart';
import '../../widget/simmer_widget/simmer_dash_container.dart';
import '../../widget/video_home_widget.dart';
import '../agora/live_stream/controller/live_stream_init_controller.dart';
import '../chat/controller/chat_history_controller.dart';
import '../chat/controller/chat_intake_form_controller.dart';
import '../splash/controller/config_controller.dart';
import 'controller/dashboard_controller.dart';
import 'controller/home_controller.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final ConfigController configController = Get.find();

  final List<HomeMenuModel> freeServicesList = [];
  final List<HomeMenuModel> paidServicesList = [];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _feedbackTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getFreeServices();
    getPaidServices();
    HomeController controller = Get.put<HomeController>(HomeController());
    AllAstrologerController astrologerController =
        Get.put<AllAstrologerController>(AllAstrologerController());
    DashboardController dashboardController =
        Get.put<DashboardController>(DashboardController());

    controller.getDashboard(false);
    controller.getAllAstrologer();
    controller.getAllAIAstrologer();
    return RefreshIndicator(
      onRefresh: () async {
        controller.getDashboard(true);
        controller.getAllAstrologer();
        controller.getAllAIAstrologer();
        bool isLogin = await SharedPreferencesHelper.getIsLogin();
        if (isLogin) {
          dashboardController.getWalletBalance();
        }
      },
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(() {
                    return Visibility(
                        visible: controller.isDashboardRefreshing.value,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: CustomTextRegular('Refreshing...'),
                        ));
                  }),

                  //Free services section
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10),
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: freeServicesList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: SizedBox(
                              width: 80,
                              child: GestureDetector(
                                  onTap: () async {
                                    bool isLogin = await SharedPreferencesHelper
                                        .getIsLogin();
                                    if (isLogin) {
                                      if (freeServicesList[index].title ==
                                          AppStrings.dashHomeVastu.tr) {
                                        Get.toNamed('/vastu_zones');
                                      } else if (freeServicesList[index]
                                              .title ==
                                          AppStrings.dashDailyQuote.tr) {
                                        Get.toNamed("/daily_quote");
                                      } else if (freeServicesList[index]
                                              .title ==
                                          AppStrings.dashMatchMatching.tr) {
                                        Get.toNamed(
                                            "/saveMatchingKundliScreen");
                                      } else if (freeServicesList[index]
                                              .title ==
                                          AppStrings.dashKundali.tr) {
                                        Get.toNamed("/savedKundliScreen");
                                      } else if (freeServicesList[index]
                                              .title ==
                                          AppStrings.dashHoroscope.tr) {
                                        Get.toNamed('/horoscopeTabScreen');
                                      } else if (freeServicesList[index]
                                              .title ==
                                          AppStrings.dashNumerology.tr) {
                                        Get.toNamed('/numerology_submit');
                                      } else if (freeServicesList[index]
                                              .title ==
                                          AppStrings.dashPanchang.tr) {
                                        Get.toNamed("/panchang_detail");
                                      } else if (freeServicesList[index]
                                              .title ==
                                          AppStrings.dashShubhMuhrat.tr) {
                                        Get.toNamed("/shubhmuhrat_details");
                                      } else if (freeServicesList[index]
                                              .title ==
                                          AppStrings.dashZonalChart.tr) {
                                        Get.toNamed("/zonal_chart");
                                      } else if (freeServicesList[index]
                                              .title ==
                                          AppStrings.dashMobileNumerology.tr) {
                                        Get.toNamed("/mobile_numerology");
                                      } else if (freeServicesList[index]
                                              .title ==
                                          AppStrings.dashOfficeVastu.tr) {
                                        Get.toNamed("/office_vastu");
                                      } else if (freeServicesList[index]
                                              .title ==
                                          AppStrings.dashLoveCompatibility.tr) {
                                        Get.toNamed(
                                            "/love_compatibility_submit_screen");
                                      } else if (freeServicesList[index]
                                              .title ==
                                          AppStrings.dashTarot.tr) {
                                        Get.toNamed("/dailyTarotReading");
                                      }
                                    } else {
                                      Get.toNamed('/login');
                                    }
                                  },
                                  child: FreeServiceWidget(
                                      item: freeServicesList[index])),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Banner section
                  Obx(
                    () {
                      if (controller.isDashboardSuccess.isTrue) {
                        return Visibility(
                          visible: controller.bannerList!.isNotEmpty,
                          child: SizedBox(
                            height: 140,
                            child: ImageSlideshow(
                              indicatorBackgroundColor: ColorResources.grey,
                              indicatorColor: ColorResources.colorPrimary,
                              // height: 300,
                              autoPlayInterval: 7000,
                              indicatorRadius: 4,
                              isLoop: true,
                              children: List.generate(
                                controller.bannerList!.length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    if (controller.bannerList![index].url
                                            .toString() !=
                                        "") {
                                      launchUrlString(controller
                                          .bannerList![index].url
                                          .toString());
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CustomNetworkImage(
                                          imageUrl: controller
                                              .bannerList![index].bannerImage
                                              .toString(),
                                          height: 160,
                                          width: Get.width),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (controller.isDashboardLoading.isTrue) {
                        return const SimmerBannerContainer();
                      } else {
                        return const SimmerBannerContainer();
                      }
                    },
                  ),

                  //LiveAstrologers
                  Obx(() {
                    if (controller.isDashboardSuccess.isTrue) {
                      if (controller.liveAstrologerListData.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CustomTextMedium(
                                      AppStrings.liveAstrologer.tr,
                                      maxLines: 1,
                                      fontSize: Dimensions.fontSizeLarge,
                                    ),
                                  ),
                                  CustomButton(
                                    AppStrings.viewAll.tr,
                                    onPressed: () {
                                      dashboardController.selectedIndex.value =
                                          2;
                                    },
                                    color: ColorResources.toolbarText,
                                    fontSize: Dimensions.fontSizeExtraSmall,
                                    minimumSize: const Size(35, 25),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 135,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      controller.liveAstrologerListData.length,
                                  itemBuilder: (context, index) {
                                    return DashLiveAstrologerWidget(
                                      controller.liveAstrologerListData[index],
                                      onActionPressed: () async {
                                        bool isLogin =
                                            await SharedPreferencesHelper
                                                .getIsLogin();
                                        if (isLogin) {
                                          String callRate = '**',
                                              callDuration = '**',
                                              videoRate = '**',
                                              videoDuration = '**',
                                              privateCallRate = '**',
                                              privateCallDuration = '**',
                                              privateVideoRate = '**',
                                              privateVideoDuration = '**';
                                          controller
                                              .liveAstrologerListData[index]
                                              .prices
                                              ?.forEach((priceItem) {
                                            String type =
                                                priceItem.type.toString();
                                            switch (type) {
                                              case AppConstants.liveAudioCall:
                                                callRate =
                                                    priceItem.price.toString();
                                                callDuration = priceItem
                                                    .timeInMinutes
                                                    .toString();
                                                break;
                                              case AppConstants.liveVideoCall:
                                                videoRate =
                                                    priceItem.price.toString();
                                                videoDuration = priceItem
                                                    .timeInMinutes
                                                    .toString();
                                                break;
                                              case AppConstants
                                                    .privateLiveAudioCall:
                                                privateCallRate =
                                                    priceItem.price.toString();
                                                privateCallDuration = priceItem
                                                    .timeInMinutes
                                                    .toString();
                                                break;
                                              case AppConstants
                                                    .privateLiveVideoCall:
                                                privateVideoRate =
                                                    priceItem.price.toString();
                                                privateVideoDuration = priceItem
                                                    .timeInMinutes
                                                    .toString();
                                                break;
                                            }
                                          });

                                          final LiveStreamInitController
                                              liveController = Get.put(
                                                  LiveStreamInitController());
                                          String astrologerName = controller
                                              .liveAstrologerListData[index]
                                              .displayName
                                              .toString();
                                          String astrologerImage = controller
                                              .liveAstrologerListData[index]
                                              .astroImg
                                              .toString();
                                          liveController.setAstrologerData(
                                              astrologerName,
                                              astrologerImage,
                                              callRate,
                                              videoRate,
                                              callDuration,
                                              videoDuration,
                                              privateCallRate,
                                              privateVideoRate,
                                              privateCallDuration,
                                              privateVideoDuration,
                                              AppConstants.live);

                                          // Join Live
                                          int astrologerUID = controller
                                              .liveAstrologerListData[index]
                                              .user!
                                              .id!
                                              .toInt();
                                          String uniqueId = controller
                                              .liveAstrologerListData[index]
                                              .liveChannel
                                              .toString();
                                          String astrologerUniId = controller
                                              .liveAstrologerListData[index]
                                              .astrologerUniId
                                              .toString();
                                          controller.joinLiveStream(
                                              astrologerUID,
                                              uniqueId,
                                              astrologerUniId);
                                        } else {
                                          Get.toNamed('/login');
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),

                  //Astrologers
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14.0, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomTextMedium(
                            AppStrings.chatCallWithAstrologer.tr,
                            maxLines: 1,
                            fontSize: Dimensions.fontSizeLarge,
                          ),
                        ),
                        CustomButton(
                          AppStrings.viewAll.tr,
                          onPressed: () {
                            Get.toNamed("/search");
                          },
                          color: ColorResources.toolbarText,
                          fontSize: Dimensions.fontSizeExtraSmall,
                          minimumSize: const Size(35, 25),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 225,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeExtraOverSmall,
                          horizontal: Dimensions.paddingSizeOverSmall),
                      child: Obx(
                        () {
                          if (controller.isAstrologerSuccess.isTrue) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.astrologerListData.length,
                              itemBuilder: (context, index) {
                                // return DashAstrologerWidget1(
                                //   controller.astrologerListData[index],
                                //   onActionPressed: () {
                                //     astrologerController.selectedAstrologerData.value = controller.astrologerListData[index];
                                //     Get.toNamed("/astroProfile");
                                //   },
                                // );
                                return AstrologerProfileCard(
                                  controller.astrologerListData[index],
                                  onActionPressed: () {
                                    astrologerController
                                            .selectedAstrologerData.value =
                                        controller.astrologerListData[index];
                                    Get.toNamed("/astroProfile");
                                  },
                                );
                              },
                            );
                          } else if (controller.isAstrologerLoading.isTrue) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return const SimmerDashAstrologer();
                              },
                            );
                          } else {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return const SimmerDashAstrologer();
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),

                  //AI Astrologers
                  if (AppFeatures.aiAstrologer)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomTextMedium(
                                  AppStrings.aiAstrologers.tr,
                                  maxLines: 1,
                                  fontSize: Dimensions.fontSizeLarge,
                                ),
                              ),
                              CustomButton(
                                AppStrings.viewAll.tr,
                                onPressed: () {
                                  Get.toNamed("/search",
                                      arguments: {'isVirtualAstrologer': '1'});
                                },
                                color: ColorResources.toolbarText,
                                fontSize: Dimensions.fontSizeExtraSmall,
                                minimumSize: const Size(35, 25),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 225,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeExtraOverSmall,
                                horizontal: Dimensions.paddingSizeOverSmall),
                            child: Obx(
                              () {
                                if (controller.isAIAstrologerSuccess.isTrue) {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        controller.aiAstrologerListData.length,
                                    itemBuilder: (context, index) {
                                      return DashAstrologerWidget1(
                                        controller.aiAstrologerListData[index],
                                        onActionPressed: () {
                                          astrologerController
                                                  .selectedAstrologerData
                                                  .value =
                                              controller
                                                  .aiAstrologerListData[index];
                                          Get.toNamed("/astroProfile");
                                        },
                                      );
                                    },
                                  );
                                } else if (controller
                                    .isAIAstrologerLoading.isTrue) {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return const SimmerDashAstrologer();
                                    },
                                  );
                                } else {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return const SimmerDashAstrologer();
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                  // Orders
                  Obx(
                    () {
                      AppLogger.d("SK->${controller.isLogin.isFalse} ${controller.chatChannels?.length}");
                      if (controller.isDashboardSuccess.isTrue) {
                        if (controller.isLogin.isFalse ||
                            controller.chatChannels!.isEmpty) {
                          return Container();
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14.0, vertical: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CustomTextMedium(
                                    AppStrings.dashMyOrders.tr,
                                    maxLines: 1,
                                    fontSize: Dimensions.fontSizeLarge,
                                  ),
                                ),
                                CustomButton(
                                  AppStrings.viewAll.tr,
                                  onPressed: () async {
                                    bool isLogin = await SharedPreferencesHelper
                                        .getIsLogin();
                                    if (isLogin) {
                                      Get.toNamed("/chatChannels");
                                    } else {
                                      Get.toNamed('/login');
                                    }
                                  },
                                  color: ColorResources.toolbarText,
                                  fontSize: Dimensions.fontSizeExtraSmall,
                                  minimumSize: const Size(35, 25),
                                ),
                              ],
                            ),
                          );
                        }
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  Obx(
                    () {
                      if (controller.isDashboardSuccess.isTrue) {
                        if (controller.isLogin.isFalse ||
                            controller.chatChannels!.isEmpty) {
                          return Container();
                        } else {
                          return SizedBox(
                            height: 120,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: Dimensions.paddingSizeExtraSmall),
                              child: Obx(
                                () {
                                  if (controller.isDashboardSuccess.isTrue) {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          controller.chatChannels?.length,
                                      itemBuilder: (context, index) {
                                        return DashOrdersWidget(
                                          controller.chatChannels![index],
                                          onPressed: () {
                                            ChatHistoryController
                                                chatHistoryController =
                                                Get.put<ChatHistoryController>(
                                                    ChatHistoryController());

                                            chatHistoryController
                                                    .astrologerName =
                                                controller.chatChannels![index]
                                                    .displayName
                                                    .toString();
                                            chatHistoryController
                                                    .astrologerImage =
                                                controller.chatChannels![index]
                                                    .astroImg
                                                    .toString();
                                            chatHistoryController.channelName =
                                                controller.chatChannels![index]
                                                    .channelName
                                                    .toString();

                                            Get.toNamed('/chatHistory');
                                          },
                                        );
                                      },
                                    );
                                  } else if (controller
                                      .isDashboardLoading.isTrue) {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        return const SimmerDashContainer();
                                      },
                                    );
                                  } else {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        return const SimmerDashContainer();
                                      },
                                    );
                                  }
                                },
                              ),
                            ),
                          );
                        }
                      } else {
                        return Container();
                      }
                    },
                  ),

                  // Product Section
                  Obx(() {
                    final items = controller.productCategoryList;
                    final isEmpty = items == null || items.isEmpty;
                    if (controller.isDashboardLoading.isFalse && isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomTextMedium(
                                  AppStrings.dashAstroShop.tr,
                                  maxLines: 1,
                                  fontSize: Dimensions.fontSizeLarge,
                                ),
                              ),
                              CustomButton(
                                AppStrings.viewAll.tr,
                                onPressed: () {
                                  Get.toNamed("/products_category");
                                },
                                color: ColorResources.toolbarText,
                                fontSize: Dimensions.fontSizeExtraSmall,
                                minimumSize: const Size(35, 25),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: SizedBox(
                            height: 155,
                            child: Obx(
                              () {
                                if (controller.isDashboardSuccess.isTrue) {
                                  final items = controller.productCategoryList ?? [];
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      return ProductCategoryWidget(
                                        items[index],
                                        onPressed: () {
                                          Get.toNamed('/products', arguments: {
                                            'id': items[index].id.toString(),
                                            'title': items[index].title.toString()
                                          });
                                        },
                                      );
                                    },
                                  );
                                } else if (controller.isDashboardLoading.isTrue) {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return const SimmerDashContainer();
                                    },
                                  );
                                } else {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return const SimmerDashContainer();
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }),

                  //Service Section
                  Obx(() {
                    final items = controller.serviceCategoryList;
                    final isEmpty = items == null || items.isEmpty;
                    if (controller.isDashboardLoading.isFalse && isEmpty) {
                      return const SizedBox.shrink();
                    }

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomTextMedium(
                                  AppStrings.dashAstroService.tr,
                                  maxLines: 1,
                                  fontSize: Dimensions.fontSizeLarge,
                                ),
                              ),
                              CustomButton(
                                AppStrings.viewAll.tr,
                                onPressed: () {
                                  Get.toNamed("/services_category");
                                },
                                color: ColorResources.toolbarText,
                                fontSize: Dimensions.fontSizeExtraSmall,
                                minimumSize: const Size(35, 25),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: SizedBox(
                            height: 155,
                            child: Obx(
                              () {
                                if (controller.isDashboardSuccess.isTrue) {
                                  final items = controller.serviceCategoryList ?? [];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: items.length,
                                      itemBuilder: (context, index) {
                                        return ServiceCategoryWidget(
                                          items[index],
                                          onPressed: () {
                                            Get.toNamed('/services', arguments: {
                                              'id': items[index].id.toString(),
                                              'title': items[index].title.toString()
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  );
                                } else if (controller.isDashboardLoading.isTrue) {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return const SimmerDashContainer();
                                    },
                                  );
                                } else {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return const SimmerDashContainer();
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }),

                  // Blog Section
                  Obx(
                    () {
                      if (controller.isDashboardSuccess.isTrue) {
                        if (controller.blogList!.isNotEmpty) {
                          return HomeHeaderWidget(
                              title: AppStrings.blog.tr,
                              onPressed: () {
                                Get.toNamed("/blog");
                              });
                        } else {
                          return const SizedBox.shrink();
                        }
                      } else if (controller.isDashboardLoading.isTrue) {
                        return HomeHeaderWidget(
                            title: AppStrings.blog.tr,
                            onPressed: () {
                              Get.toNamed("/blog");
                            });
                      } else {
                        return HomeHeaderWidget(
                            title: AppStrings.blog.tr,
                            onPressed: () {
                              Get.toNamed("/blog");
                            });
                      }
                    },
                  ),
                  Obx(
                    () {
                      if (controller.isDashboardSuccess.isTrue) {
                        if (controller.blogList!.isNotEmpty) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 20),
                            child: SizedBox(
                              height: 185,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.blogList!.length,
                                  itemBuilder: (context, index) {
                                    return BlogHomeWidget(
                                      controller.blogList![index],
                                      onPressed: () {
                                        BlogController blogController =
                                            Get.put(BlogController());
                                        blogController.blogsData =
                                            controller.blogList![index];
                                        Get.toNamed("/blog_detail");
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      } else if (controller.isDashboardLoading.isTrue) {
                        return SizedBox(
                          height: 185,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return const SimmerDashContainer();
                            },
                          ),
                        );
                      } else {
                        return SizedBox(
                          height: 185,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return const SimmerDashContainer();
                            },
                          ),
                        );
                      }
                    },
                  ),

                  // Video Section
                  Obx(
                    () {
                      if (controller.isDashboardSuccess.isTrue) {
                        if (controller.videoList!.isNotEmpty) {
                          return HomeHeaderWidget(
                              title: AppStrings.videos.tr,
                              onPressed: () {
                                Get.toNamed("/video_list");
                              });
                        } else {
                          return const SizedBox.shrink();
                        }
                      } else if (controller.isDashboardLoading.isTrue) {
                        return HomeHeaderWidget(
                            title: AppStrings.videos.tr,
                            onPressed: () {
                              Get.toNamed("/video_list");
                            });
                      } else {
                        return HomeHeaderWidget(
                            title: AppStrings.videos.tr,
                            onPressed: () {
                              Get.toNamed("/video_list");
                            });
                      }
                    },
                  ),
                  Obx(
                    () {
                      if (controller.isDashboardSuccess.isTrue) {
                        if (controller.videoList!.isNotEmpty) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            child: SizedBox(
                              height: 160,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.videoList?.length,
                                  itemBuilder: (context, index) {
                                    return VideoHomeWidget(
                                      controller.videoList![index],
                                      onPressed: () {
                                        Get.to(VideoPlayScreen(
                                            controller.videoList![index].url
                                                .toString(),
                                            controller.videoList![index].title
                                                .toString()));
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      } else if (controller.isDashboardLoading.isTrue) {
                        return SizedBox(
                          height: 160,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return const SimmerDashContainer();
                            },
                          ),
                        );
                      } else {
                        return SizedBox(
                          height: 160,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return const SimmerDashContainer();
                            },
                          ),
                        );
                      }
                    },
                  ),

                  // Feedback to CEO
                  Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(
                            Dimensions.borderRadiusMedium),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: Dimensions.paddingSizeSmall,
                            horizontal: Dimensions.paddingSizeMediumSmall),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextMedium(
                              AppStrings.feedbackToAdmin.tr,
                              fontSize: Dimensions.fontSizeDefault,
                            ),
                            const Gap(Dimensions.gapSmall),
                            CustomTextRegular(
                              AppStrings.shareYourFeedbackToHelp.tr,
                              color: ColorResources.black4,
                              fontSize: Dimensions.fontSizeSmall,
                            ),
                            const Gap(Dimensions.gapLarge),
                            Form(
                              key: _formKey,
                              child: TextFormField(
                                controller: _feedbackTextController,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: AppStrings.startTypingHere.tr,
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: Dimensions.fontSizeDefault,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.borderRadiusDefault),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return AppStrings.formError.tr;
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const Gap(Dimensions.gapDefault),
                            Center(
                              child: GestureDetector(
                                onTap: () async {
                                  bool isLogin = await SharedPreferencesHelper
                                      .getIsLogin();
                                  if (isLogin) {
                                    if (_formKey.currentState!.validate()) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      controller.sendSuggestions(
                                          _feedbackTextController.text
                                              .toString());
                                      _feedbackTextController.clear();
                                    }
                                  } else {
                                    Get.offAllNamed('/login');
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.paddingSizeSmall,
                                      vertical:
                                          Dimensions.paddingSizeExtraSmall),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.borderRadiusMedium),
                                    color: ColorResources.colorPrimary,
                                  ),
                                  child: CustomTextRegular(
                                    AppStrings.sendFeedback.tr,
                                    textAlign: TextAlign.center,
                                    fontSize: Dimensions.fontSizeSmall,
                                    color: ColorResources.toolbarText,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(5),
                  // bottom icons
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: ColorResources.grey,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Image.asset(
                                Images.privateConf,
                                height: 40,
                              ),
                            ),
                            const Gap(4),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: Get.width * 0.27,
                              ),
                              child: CustomTextRegular(
                                AppStrings.privateConfidential.tr,
                                fontSize: Dimensions.fontSizeSmall,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: ColorResources.grey,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Image.asset(
                                Images.verifiedAstro,
                                height: 40,
                              ),
                            ),
                            const Gap(4),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: Get.width * 0.27,
                              ),
                              child: CustomTextRegular(
                                AppStrings.verifiedAstrologers.tr,
                                fontSize: Dimensions.fontSizeSmall,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: ColorResources.grey,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Image.asset(
                                Images.securePayments,
                                height: 40,
                              ),
                            ),
                            const Gap(4),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: Get.width * 0.27,
                              ),
                              child: CustomTextRegular(
                                AppStrings.securePayments.tr,
                                fontSize: Dimensions.fontSizeSmall,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Gap(10),
                ],
              ),
            ),
          ),
          //ResumeChat
          Obx(
            () {
              if (controller.isDashboardSuccess.isTrue) {
                return Visibility(
                  visible: controller.inProgressStatus.value == 1 &&
                          controller.callType.value == AppConstants.chat ||
                      controller.callType.value == AppConstants.emergencyChat,
                  child: Container(
                    color: ColorResources.colorPrimaryLight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomRoundNetworkImage(
                              imageUrl: controller.dashboardModel.data!
                                  .inProgressOrder!.astroImage
                                  .toString(),
                              height: 35,
                              width: 35),
                          const Gap(Dimensions.gapLarge),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextRegular(
                                    controller.dashboardModel.data!
                                        .inProgressOrder!.astroName
                                        .toString(),
                                    fontSize: Dimensions.fontSizeLarge,
                                    maxLines: 1),
                                CustomTextRegular(
                                  "Chat in progress",
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: ColorResources.colorSecondary,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          CustomButton(
                            "Chat",
                            onPressed: () async {
                              //FOR CHAT INIT
                              String? astrologerUniId = controller
                                  .dashboardModel
                                  .data
                                  ?.inProgressOrder
                                  ?.astroUniId
                                  .toString();
                              String? uniqueId = controller
                                  .dashboardModel.data?.inProgressOrder?.uniqeid
                                  .toString();

                              final ChatIntakeFormController
                                  chatIntakeFormController =
                                  Get.put(ChatIntakeFormController());
                              chatIntakeFormController.setAstrologerData(
                                  controller.dashboardModel.data!
                                      .inProgressOrder!.astroName
                                      .toString(),
                                  controller.dashboardModel.data!
                                      .inProgressOrder!.astroImage
                                      .toString(),
                                  astrologerUniId.toString(),
                                  AppConstants.chat,
                                  controller
                                          .dashboardModel
                                          .data!
                                          .inProgressOrder!
                                          .isVirtualAstrologer ??
                                      0);

                              String? customerUniUd =
                                  await SharedPreferencesHelper.getData(
                                      AppConstants.userUniId);
                              String channelName =
                                  '$customerUniUd-$astrologerUniId';
                              Get.toNamed('/chat_screen', arguments: {
                                'channelName': channelName,
                                'uniqueId': uniqueId
                              });
                            },
                            color: ColorResources.toolbarText,
                            fontSize: Dimensions.fontSizeSmall,
                            backgroundColor: ColorResources.colorSecondary,
                            borderRadius: 20,
                            minimumSize: const Size(58, 32),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          //ResumeVideoCall
          Obx(
            () {
              if (controller.isDashboardSuccess.isTrue) {
                return Visibility(
                  visible: controller.inProgressStatus.value == 1 &&
                          controller.callType.value == AppConstants.video ||
                      controller.callType.value ==
                          AppConstants.emergencyVideoCall,
                  child: Container(
                    color: ColorResources.colorPrimaryLight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomRoundNetworkImage(
                              imageUrl: controller.dashboardModel.data!
                                  .inProgressOrder!.astroImage
                                  .toString(),
                              height: 35,
                              width: 35),
                          const Gap(Dimensions.gapLarge),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextRegular(
                                    controller.dashboardModel.data!
                                        .inProgressOrder!.astroName
                                        .toString(),
                                    fontSize: Dimensions.fontSizeLarge,
                                    maxLines: 1),
                                CustomTextRegular(
                                  "Video Call in progress",
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: ColorResources.colorSecondary,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          CustomButton(
                            "Join",
                            onPressed: () async {
                              //FOR CHAT INIT
                              String? astrologerUniId = controller
                                  .dashboardModel
                                  .data
                                  ?.inProgressOrder
                                  ?.astroUniId
                                  .toString();
                              String? uniqueId = controller
                                  .dashboardModel.data?.inProgressOrder?.uniqeid
                                  .toString();
                              String? agoraAppId =
                                  await SharedPreferencesHelper.getData(
                                      AppConstants.agoraAppId);

                              final ChatIntakeFormController
                                  chatIntakeFormController =
                                  Get.put(ChatIntakeFormController());
                              chatIntakeFormController.setAstrologerData(
                                  controller.dashboardModel.data!
                                      .inProgressOrder!.astroName
                                      .toString(),
                                  controller.dashboardModel.data!
                                      .inProgressOrder!.astroImage
                                      .toString(),
                                  astrologerUniId.toString(),
                                  AppConstants.video,
                                  0);

                              String? customerUniUd =
                                  await SharedPreferencesHelper.getData(
                                      AppConstants.userUniId);
                              String channelName =
                                  '$customerUniUd-$astrologerUniId-Video';

                              Get.toNamed('/videoCallScreen', arguments: {
                                'channelName': channelName,
                                'uniqueId': uniqueId,
                                'agoraAppId': agoraAppId,
                                'token': controller
                                    .dashboardModel.data!.inProgressOrder!.token
                                    .toString(),
                              });
                            },
                            color: ColorResources.toolbarText,
                            fontSize: Dimensions.fontSizeSmall,
                            backgroundColor: ColorResources.colorSecondary,
                            borderRadius: 20,
                            minimumSize: const Size(58, 32),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          //ResumeInAppCall
          Obx(
            () {
              if (controller.isDashboardSuccess.isTrue) {
                return Visibility(
                  visible: controller.inProgressStatus.value == 1 &&
                          controller.callType.value == AppConstants.call ||
                      controller.callType.value == AppConstants.emergencyCall,
                  child: Container(
                    color: ColorResources.colorPrimaryLight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomRoundNetworkImage(
                              imageUrl: controller.dashboardModel.data!
                                  .inProgressOrder!.astroImage
                                  .toString(),
                              height: 35,
                              width: 35),
                          const Gap(Dimensions.gapLarge),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomTextRegular(
                                    controller.dashboardModel.data!
                                        .inProgressOrder!.astroName
                                        .toString(),
                                    fontSize: Dimensions.fontSizeLarge,
                                    maxLines: 1),
                                CustomTextRegular(
                                  "Voice Call in progress",
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: ColorResources.colorSecondary,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          CustomButton(
                            "Join",
                            onPressed: () async {
                              //FOR CHAT INIT
                              String? astrologerUniId = controller
                                  .dashboardModel
                                  .data
                                  ?.inProgressOrder
                                  ?.astroUniId
                                  .toString();
                              String? uniqueId = controller
                                  .dashboardModel.data?.inProgressOrder?.uniqeid
                                  .toString();
                              String? agoraAppId =
                                  await SharedPreferencesHelper.getData(
                                      AppConstants.agoraAppId);

                              final ChatIntakeFormController
                                  chatIntakeFormController =
                                  Get.put(ChatIntakeFormController());
                              chatIntakeFormController.setAstrologerData(
                                  controller.dashboardModel.data!
                                      .inProgressOrder!.astroName
                                      .toString(),
                                  controller.dashboardModel.data!
                                      .inProgressOrder!.astroImage
                                      .toString(),
                                  astrologerUniId.toString(),
                                  AppConstants.call,
                                  0);

                              String? customerUniUd =
                                  await SharedPreferencesHelper.getData(
                                      AppConstants.userUniId);
                              String channelName =
                                  '$customerUniUd-$astrologerUniId-Call';

                              Get.toNamed('/voiceCallScreen', arguments: {
                                'channelName': channelName,
                                'uniqueId': uniqueId,
                                'agoraAppId': agoraAppId,
                                'token': controller
                                    .dashboardModel.data!.inProgressOrder!.token
                                    .toString(),
                              });
                            },
                            color: ColorResources.toolbarText,
                            fontSize: Dimensions.fontSizeSmall,
                            backgroundColor: ColorResources.colorSecondary,
                            borderRadius: 20,
                            minimumSize: const Size(58, 32),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          //Architect Service
          Obx(
            () {
              if (controller.isDashboardSuccess.isTrue) {
                return Visibility(
                  visible:
                      controller.dashboardModel.data?.architectServiceStatus ==
                          1,
                  child: Container(
                    color: ColorResources.colorPrimaryLight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Gap(Dimensions.gapLarge),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextRegular(
                                  "Vastu Architect Order In Progress",
                                  fontSize: Dimensions.fontSizeSmall,
                                  color: ColorResources.colorSecondary,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          CustomButton(
                            "JOIN",
                            onPressed: () async {
                              Get.toNamed("/architect_orders_tab_screen");
                            },
                            color: ColorResources.toolbarText,
                            fontSize: Dimensions.fontSizeSmall,
                            borderRadius: 20,
                            minimumSize: const Size(58, 32),
                            backgroundColor: ColorResources.colorSecondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  void getFreeServices() {
    String? activeKundliApi =
        configController.config.data?.activeKundliApi.toString();
    freeServicesList.clear();
    freeServicesList
        .add(HomeMenuModel(AppStrings.dashHoroscope.tr, Images.dashHoroscope));
    freeServicesList
        .add(HomeMenuModel(AppStrings.dashKundali.tr, Images.dashKundali));
    freeServicesList.add(
        HomeMenuModel(AppStrings.dashMatchMatching.tr, Images.dashMatchMaking));
    // freeServicesList.add(HomeMenuModel(AppStrings.dashHomeVastu.tr, Images.dashVastu));
    // freeServicesList.add(HomeMenuModel(AppStrings.dashOfficeVastu.tr, Images.officeVastu));
    // freeServicesList.add(HomeMenuModel(AppStrings.dashZonalChart.tr, Images.dashZonalChart));

    // freeServicesList.add(HomeMenuModel(AppStrings.dashMobileNumerology.tr, Images.dashMobileNumerology));

    // freeServicesList.add(HomeMenuModel(AppStrings.dashLoveCompatibility.tr, Images.dashLoveCompatibility));
    freeServicesList
        .add(HomeMenuModel(AppStrings.dashPanchang.tr, Images.dashPanchang));
    if (activeKundliApi == AppConstants.jyotisham) {
      freeServicesList
          .add(HomeMenuModel(AppStrings.dashTarot.tr, Images.dashTarot));
    }
    // freeServicesList.add(HomeMenuModel(AppStrings.dashNumerology.tr, Images.dashNumerology));
    // freeServicesList.add(HomeMenuModel(AppStrings.dashShubhMuhrat.tr, Images.dashShubhMuhrat));
    // freeServicesList.add(HomeMenuModel(AppStrings.dashDailyQuote.tr, Images.dashDailyQuote));
  }

  void getPaidServices() {
    paidServicesList.clear();
    paidServicesList
        .add(HomeMenuModel(AppStrings.jeevini.tr, Images.dashJeevini));
    paidServicesList
        .add(HomeMenuModel(AppStrings.divineCode.tr, Images.dashDivineCode));
    paidServicesList.add(HomeMenuModel(AppStrings.ebook.tr, Images.dashEBook));
    paidServicesList
        .add(HomeMenuModel(AppStrings.report.tr, Images.dashReport));
    paidServicesList.add(HomeMenuModel(
        AppStrings.electroHomeopathy.tr, Images.dashElectroHomeopathy));
    paidServicesList.add(
        HomeMenuModel(AppStrings.vastuArchitect.tr, Images.dashVastuArchitect));
    paidServicesList
        .add(HomeMenuModel(AppStrings.astroShop.tr, Images.dashAstroShop));
    paidServicesList
        .add(HomeMenuModel(AppStrings.askAQuestion.tr, Images.askAQuestion));
  }
}
