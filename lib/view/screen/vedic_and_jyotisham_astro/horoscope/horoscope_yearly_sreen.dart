import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../model/menu_model.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import '../../splash/controller/config_controller.dart';
import '../controller/horoscope_controller.dart';
import '../widget/horoscope_yearly_Box_widget.dart';
import '../widget/horoscope_yearly_card_widget.dart';

class HoroscopeYearlyScreen extends StatefulWidget {
  const HoroscopeYearlyScreen({super.key});


  @override
  _HoroscopeYearlyScreenState createState() => _HoroscopeYearlyScreenState();
}
class _HoroscopeYearlyScreenState extends State<HoroscopeYearlyScreen> {

  final ConfigController configController = Get.find();

  final HoroscopeController controller = Get.put(HoroscopeController());
  int selectedIndex = 0;
  List<MenuModel> horoscopeDailyListCo = [];


  @override
  void initState() {
    super.initState();
    horoscopesSign();
    fetchWeeklyHoroscope();
  }

  void fetchWeeklyHoroscope() {
    controller.getYearlyHoroscope(horoscopeDailyListCo[selectedIndex].number);
  }
  @override
  Widget build(BuildContext context) {

    String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

    horoscopesSign();

    if (activeKundliApi == AppConstants.jyotisham) {
      return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: AppStrings.yearlyHoroscope.tr),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 85, // Set an explicit height for the ListView
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: horoscopeDailyListCo.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            fetchWeeklyHoroscope(); // Fetch weekly horoscope data when horoscope sign is selected
                          });
                        },
                        child: Column(
                          children: [
                            const Gap(Dimensions.gapExtraSmall),
                            Container(
                              width: 60,
                              height: 60,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedIndex == index
                                      ? ColorResources.colorPrimaryDark
                                      : ColorResources.colorPrimaryLight,
                                ),
                                borderRadius: BorderRadius.circular(50),
                                color: selectedIndex == index
                                    ? ColorResources.colorPrimaryLight
                                    : ColorResources.white,
                              ),
                              child: Image.asset(
                                horoscopeDailyListCo[index].image,
                                height: 50,
                                width: 50,
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              // height: 22,
                              child: CustomTextMedium(
                                horoscopeDailyListCo[index].title,
                                textAlign: TextAlign.center,
                                color: ColorResources.colorPrimaryDark,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Obx(() {
                  if (controller.isYearlySuccess.isTrue) {
                    return Padding(
                      padding: const EdgeInsets.all(
                          Dimensions.paddingSizeSmall),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.borderRadiusDefault),
                                border: Border.all(
                                  color: ColorResources.colorPrimaryMedium,
                                  width: 1,
                                )
                            ),
                            child: Column(
                              children: [
                                HoroscopeYearlyCardWidget(
                                  title: "${controller.horoscopeYearlyModel
                                      .response?.phase1?.period}",
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase1?.prediction}',
                                  image: Images.yearlyHoroscope,
                                  score: '${controller.horoscopeYearlyModel
                                      .response?.phase1?.score}',
                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.status.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase1?.status?.prediction}',
                                  image: Images.battery,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase1?.status?.score}',
                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.finances.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase1?.finances?.prediction}',
                                  image: Images.dollar,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase1?.finances?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.career.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase1?.career?.prediction}',
                                  image: Images.bag,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase1?.career?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.travel.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase1?.travel?.prediction}',
                                  image: Images.airplane,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase1?.travel?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.family.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase1?.family?.prediction}',
                                  image: Images.family,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase1?.family?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.friends.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase1?.friends?.prediction}',
                                  image: Images.friendship,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase1?.friends?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.health.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase1?.health?.prediction}',
                                  image: Images.health,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase1?.health?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.love.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase1?.relationship
                                      ?.prediction}',
                                  image: Images.love,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase1?.relationship?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.education.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase1?.education
                                      ?.prediction}',
                                  image: Images.education,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase1?.education?.score}',
                                ),
                                const Gap(Dimensions.gapDefault),
                              ],
                            ),
                          ),
                          const Gap(Dimensions.gapDefault),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.borderRadiusDefault),
                                border: Border.all(
                                  color: ColorResources.colorPrimaryMedium,
                                  width: 1,
                                )
                            ),
                            child: Column(
                              children: [
                                HoroscopeYearlyCardWidget(
                                  title: "${controller.horoscopeYearlyModel
                                      .response?.phase2?.period}",
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase2?.prediction}',
                                  image: Images.yearlyHoroscope,
                                  score: '${controller.horoscopeYearlyModel
                                      .response?.phase2?.score}',
                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.status.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase2?.status?.prediction}',
                                  image: Images.battery,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase2?.status?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.finances.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase2?.finances?.prediction}',
                                  image: Images.dollar,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase2?.finances?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.career.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase2?.career?.prediction}',
                                  image: Images.bag,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase2?.career?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.travel.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase2?.travel?.prediction}',
                                  image: Images.airplane,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase2?.travel?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.family.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase2?.family?.prediction}',
                                  image: Images.family,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase2?.family?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.friends.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase2?.friends?.prediction}',
                                  image: Images.friendship,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase2?.friends?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.health.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase2?.health?.prediction}',
                                  image: Images.health,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase2?.health?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.love.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase2?.relationship
                                      ?.prediction}',
                                  image: Images.love,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase2?.relationship?.score}',
                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.education.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase2?.education
                                      ?.prediction}',
                                  image: Images.education,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase2?.education?.score}',
                                ),
                                const Gap(Dimensions.gapDefault),
                              ],
                            ),
                          ),
                          const Gap(Dimensions.gapDefault),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.borderRadiusDefault),
                                border: Border.all(
                                  color: ColorResources.colorPrimaryMedium,
                                  width: 1,
                                )
                            ),
                            child: Column(
                              children: [
                                HoroscopeYearlyCardWidget(
                                  title: "${controller.horoscopeYearlyModel
                                      .response?.phase3?.period}",
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase3?.prediction}',
                                  image: Images.yearlyHoroscope,
                                  score: '${controller.horoscopeYearlyModel
                                      .response?.phase3?.score}',
                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.status.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase3?.status?.prediction}',
                                  image: Images.battery,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase3?.status?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.finances.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase3?.finances?.prediction}',
                                  image: Images.dollar,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase3?.finances?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.career.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase3?.career?.prediction}',
                                  image: Images.bag,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase3?.career?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.travel.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase3?.travel?.prediction}',
                                  image: Images.airplane,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase3?.travel?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.family.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase3?.family?.prediction}',
                                  image: Images.family,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase3?.family?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.friends.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase3?.friends?.prediction}',
                                  image: Images.friendship,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase3?.friends?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.health.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase3?.health?.prediction}',
                                  image: Images.health,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase3?.health?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.love.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase3?.relationship
                                      ?.prediction}',
                                  image: Images.love,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase3?.relationship?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.education.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase3?.education
                                      ?.prediction}',
                                  image: Images.education,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase3?.education?.score}',
                                ),
                                const Gap(Dimensions.gapDefault),
                              ],
                            ),
                          ),
                          const Gap(Dimensions.gapDefault),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.borderRadiusDefault),
                                border: Border.all(
                                  color: ColorResources.colorPrimaryMedium,
                                  width: 1,
                                )
                            ),
                            child: Column(
                              children: [
                                HoroscopeYearlyCardWidget(
                                  title: "${controller.horoscopeYearlyModel
                                      .response?.phase4?.period}",
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase4?.prediction}',
                                  image: Images.yearlyHoroscope,
                                  score: '${controller.horoscopeYearlyModel
                                      .response?.phase4?.score}',
                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.status.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase4?.status?.prediction}',
                                  image: Images.battery,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase4?.status?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.finances.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase4?.finances?.prediction}',
                                  image: Images.dollar,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase4?.finances?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.career.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase4?.career?.prediction}',
                                  image: Images.bag,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase4?.career?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.travel.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase4?.travel?.prediction}',
                                  image: Images.airplane,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase4?.travel?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.family.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase4?.family?.prediction}',
                                  image: Images.family,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase4?.family?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.friends.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase4?.friends?.prediction}',
                                  image: Images.friendship,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase4?.friends?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.health.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase4?.health?.prediction}',
                                  image: Images.health,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase4?.health?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.love.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase4?.relationship
                                      ?.prediction}',
                                  image: Images.love,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase4?.relationship?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.education.tr,
                                  data: '${controller.horoscopeYearlyModel
                                      .response?.phase4?.education
                                      ?.prediction}',
                                  image: Images.education,
                                  prashent: '${controller.horoscopeYearlyModel
                                      .response?.phase4?.education?.score}',
                                ),
                                const Gap(Dimensions.gapDefault),
                              ],
                            ),
                          ),
                          const Gap(Dimensions.gapDefault),
                        ],
                      ),
                    );
                  } else if (controller.isYearlyLoading.isTrue) {
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
              ],
            ),
          ),
        ),
      );
    } else if (activeKundliApi == AppConstants.vedicastro) {
      return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: AppStrings.yearlyHoroscope.tr),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 85, // Set an explicit height for the ListView
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: horoscopeDailyListCo.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            fetchWeeklyHoroscope(); // Fetch weekly horoscope data when horoscope sign is selected
                          });
                        },
                        child: Column(
                          children: [
                            const Gap(Dimensions.gapExtraSmall),
                            Container(
                              width: 60,
                              height: 60,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedIndex == index
                                      ? ColorResources.colorPrimaryDark
                                      : ColorResources.colorPrimaryLight,
                                ),
                                borderRadius: BorderRadius.circular(50),
                                color: selectedIndex == index
                                    ? ColorResources.colorPrimaryLight
                                    : ColorResources.white,
                              ),
                              child: Image.asset(
                                horoscopeDailyListCo[index].image,
                                height: 50,
                                width: 50,
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              // height: 22,
                              child: CustomTextMedium(
                                horoscopeDailyListCo[index].title,
                                textAlign: TextAlign.center,
                                color: ColorResources.colorPrimaryDark,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Obx(() {
                  if (controller.isYearlySuccess.isTrue) {
                    return Padding(
                      padding: const EdgeInsets.all(
                          Dimensions.paddingSizeSmall),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.borderRadiusDefault),
                                border: Border.all(
                                  color: ColorResources.colorPrimaryMedium,
                                  width: 1,
                                )
                            ),
                            child: Column(
                              children: [
                                HoroscopeYearlyCardWidget(
                                  title: "${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase1?.period}",
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase1?.prediction}',
                                  image: Images.yearlyHoroscope,
                                  score: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase1?.score}',
                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.status.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase1?.status?.prediction}',
                                  image: Images.battery,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase1?.status?.score}',
                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.finances.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase1?.finances?.prediction}',
                                  image: Images.dollar,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase1?.finances?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.career.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase1?.career?.prediction}',
                                  image: Images.bag,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase1?.career?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.travel.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase1?.travel?.prediction}',
                                  image: Images.airplane,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase1?.travel?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.family.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase1?.family?.prediction}',
                                  image: Images.family,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase1?.family?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.friends.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase1?.friends?.prediction}',
                                  image: Images.friendship,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase1?.friends?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.health.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase1?.health?.prediction}',
                                  image: Images.health,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase1?.health?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.love.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase1?.relationship
                                      ?.prediction}',
                                  image: Images.love,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase1?.relationship?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.physique.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase1?.physique
                                      ?.prediction}',
                                  image: Images.physique,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase1?.physique?.score}',
                                ),
                                const Gap(Dimensions.gapDefault),
                              ],
                            ),
                          ),
                          const Gap(Dimensions.gapDefault),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.borderRadiusDefault),
                                border: Border.all(
                                  color: ColorResources.colorPrimaryMedium,
                                  width: 1,
                                )
                            ),
                            child: Column(
                              children: [
                                HoroscopeYearlyCardWidget(
                                  title: "${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase2?.period}",
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase2?.prediction}',
                                  image: Images.yearlyHoroscope,
                                  score: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase2?.score}',
                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.status.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase2?.status?.prediction}',
                                  image: Images.battery,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase2?.status?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.finances.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase2?.finances?.prediction}',
                                  image: Images.dollar,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase2?.finances?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.career.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase2?.career?.prediction}',
                                  image: Images.bag,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase2?.career?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.travel.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase2?.travel?.prediction}',
                                  image: Images.airplane,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase2?.travel?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.family.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase2?.family?.prediction}',
                                  image: Images.family,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase2?.family?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.friends.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase2?.friends?.prediction}',
                                  image: Images.friendship,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase2?.friends?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.health.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase2?.health?.prediction}',
                                  image: Images.health,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase2?.health?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.love.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase2?.relationship
                                      ?.prediction}',
                                  image: Images.love,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase2?.relationship?.score}',
                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.physique.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase2?.physique
                                      ?.prediction}',
                                  image: Images.physique,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase2?.physique?.score}',
                                ),
                                const Gap(Dimensions.gapDefault),
                              ],
                            ),
                          ),
                          const Gap(Dimensions.gapDefault),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.borderRadiusDefault),
                                border: Border.all(
                                  color: ColorResources.colorPrimaryMedium,
                                  width: 1,
                                )
                            ),
                            child: Column(
                              children: [
                                HoroscopeYearlyCardWidget(
                                  title: "${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase3?.period}",
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase3?.prediction}',
                                  image: Images.yearlyHoroscope,
                                  score: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase3?.score}',
                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.status.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase3?.status?.prediction}',
                                  image: Images.battery,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase3?.status?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.finances.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase3?.finances?.prediction}',
                                  image: Images.dollar,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase3?.finances?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.career.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase3?.career?.prediction}',
                                  image: Images.bag,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase3?.career?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.travel.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase3?.travel?.prediction}',
                                  image: Images.airplane,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase3?.travel?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.family.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase3?.family?.prediction}',
                                  image: Images.family,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase3?.family?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.friends.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase3?.friends?.prediction}',
                                  image: Images.friendship,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase3?.friends?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.health.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase3?.health?.prediction}',
                                  image: Images.health,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase3?.health?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.love.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase3?.relationship
                                      ?.prediction}',
                                  image: Images.love,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase3?.relationship?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.physique.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase3?.physique
                                      ?.prediction}',
                                  image: Images.physique,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase3?.physique?.score}',
                                ),
                                const Gap(Dimensions.gapDefault),
                              ],
                            ),
                          ),
                          const Gap(Dimensions.gapDefault),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.borderRadiusDefault),
                                border: Border.all(
                                  color: ColorResources.colorPrimaryMedium,
                                  width: 1,
                                )
                            ),
                            child: Column(
                              children: [
                                HoroscopeYearlyCardWidget(
                                  title: "${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase4?.period}",
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase4?.prediction}',
                                  image: Images.yearlyHoroscope,
                                  score: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase4?.score}',
                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.status.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase4?.status?.prediction}',
                                  image: Images.battery,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase4?.status?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.finances.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase4?.finances?.prediction}',
                                  image: Images.dollar,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase4?.finances?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.career.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase4?.career?.prediction}',
                                  image: Images.bag,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase4?.career?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.travel.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase4?.travel?.prediction}',
                                  image: Images.airplane,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase4?.travel?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.family.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase4?.family?.prediction}',
                                  image: Images.family,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase4?.family?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.friends.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase4?.friends?.prediction}',
                                  image: Images.friendship,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase4?.friends?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.health.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase4?.health?.prediction}',
                                  image: Images.health,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase4?.health?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.love.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase4?.relationship
                                      ?.prediction}',
                                  image: Images.love,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase4?.relationship?.score}',

                                ),
                                HoroscopYearlyBoxWidget(
                                  title: AppStrings.physique.tr,
                                  data: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase4?.physique
                                      ?.prediction}',
                                  image: Images.physique,
                                  prashent: '${controller.horoscopeYearlyVedicAstroModel
                                      .response?.phase4?.physique?.score}',
                                ),
                                const Gap(Dimensions.gapDefault),
                              ],
                            ),
                          ),
                          const Gap(Dimensions.gapDefault),
                        ],
                      ),
                    );
                  } else if (controller.isYearlyLoading.isTrue) {
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
              ],
            ),
          ),
        ),
      );
    }
    return const Center(
      child: Text('No valid API configuration found.'),
    );
  }

  void horoscopesSign() {
    horoscopeDailyListCo.clear();
    horoscopeDailyListCo.add(MenuModel(AppStrings.aries.tr, Images.aries,'1'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.taurus.tr, Images.taurus,'2'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.gemini.tr, Images.gemini,'3'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.cancer.tr, Images.cancer,'4'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.leo.tr, Images.leo,'5'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.virgo.tr, Images.virgo,'6'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.libra.tr, Images.libra,'7'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.scorpio.tr, Images.scorpio,'8'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.sagittarius.tr, Images.sagittarius,'9'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.capricorn.tr, Images.capricorn,'10'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.aquarius.tr, Images.aquarius,'11'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.pisces.tr, Images.pisces,'1'));
  }
}
