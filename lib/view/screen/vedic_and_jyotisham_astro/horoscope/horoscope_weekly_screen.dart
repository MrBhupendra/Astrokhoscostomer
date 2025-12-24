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
import '../../../widget/custom_text_regular.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import '../../splash/controller/config_controller.dart';
import '../controller/horoscope_controller.dart';
import '../widget/custom_table_two_row_widget.dart';
import '../widget/horoscope_lucky_ditals_widget.dart';

class HoroscopeWeeklyScreen extends StatefulWidget {
  const HoroscopeWeeklyScreen({super.key});

  @override
  _HoroscopeWeeklyScreenState createState() => _HoroscopeWeeklyScreenState();
}

class _HoroscopeWeeklyScreenState extends State<HoroscopeWeeklyScreen> {

  final ConfigController configController = Get.find();

  List<MenuModel> horoscopeDailyListCo = [];
  int selectedIndex = 0;
  MenuModel? selectedHoroscope;
  final HoroscopeController controller = Get.put(HoroscopeController());

  String week = 'thisweek';
  String weekScreen = AppStrings.thisWeek.tr; // Default value for week
  Color thisweekColor = ColorResources.colorPrimary;
  Color nextweekColor = ColorResources.colorPrimaryLight;

  Color thisweekTextColor = ColorResources.black;
  Color nextweekTextColor = ColorResources.toolbarText;

  @override
  void initState() {
    super.initState();
    // Fetch the horoscope data when the page is entered
    horoscopesSign();
    fetchWeeklyHoroscope();
  }


  void fetchWeeklyHoroscope() {
    String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

    if(activeKundliApi == AppConstants.jyotisham){
      controller.getWeeklyHoroscope(horoscopeDailyListCo[selectedIndex].number,"");
    } else if(activeKundliApi == AppConstants.vedicastro){
      controller.getWeeklyHoroscope(horoscopeDailyListCo[selectedIndex].number,week);
    }

  }

  @override
  Widget build(BuildContext context) {

    String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

    if (activeKundliApi == AppConstants.jyotisham) {
      return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: AppStrings.weeklyHoroscope.tr),
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
                            fetchWeeklyHoroscope();
                            selectedHoroscope = horoscopeDailyListCo[index];
                          });
                        },
                        child: Column(
                          children: [
                            const SizedBox(height: Dimensions.gapExtraSmall),
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
                  if (controller.isWeeklyHoroscopeSuccess.isTrue) {
                    return Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorResources.colorPrimaryLight,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 1),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomTextMedium("${controller.weeklyHoroscopeJyotishamAstroModel.response?.week}"),
                            ),
                          ),
                          const Gap(Dimensions.gapSmall),
                          HoroscopeLuckyDetailsWidget(
                            date: '${controller.weeklyHoroscopeJyotishamAstroModel.response?.week}',
                            luckyColorCode: '${controller.weeklyHoroscopeJyotishamAstroModel.response?.colorCode}',
                            number: '${controller.weeklyHoroscopeJyotishamAstroModel.response?.luckyNumbers}',
                            image: selectedHoroscope != null ? selectedHoroscope!.image : Images.aries,
                            nakshatra: selectedHoroscope != null ? selectedHoroscope!.title : AppStrings.aries,
                            colorName: '${controller.weeklyHoroscopeJyotishamAstroModel.response?.luckyColor}',
                          ),
                          const SizedBox(height: Dimensions.gapLarge),
                          Row(
                            children: [
                              CustomTextMedium(
                                AppStrings.weeklyHoroscope.tr,
                                textAlign: TextAlign.start,
                                fontSize: Dimensions.fontSizeLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimensions.gapLarge),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              color: ColorResources.white,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.borderRadiusDefault),
                              border: Border.all(
                                color: ColorResources.colorPrimaryVariant,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.paddingSizeSmall),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomTextRegular("${controller.weeklyHoroscopeJyotishamAstroModel.response?.horoscopeData}",fontSize: Dimensions.fontSizeSmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Gap(Dimensions.gapExtraLarge),
                          Container(
                            decoration:  BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                CustomTableTwoRowWidget(
                                    title: AppStrings.totalScore.tr,
                                    data: "${controller.weeklyHoroscopeJyotishamAstroModel.response?.total}%",
                                    color: ColorResources.colorPrimaryLight),
                                CustomTableTwoRowWidget(
                                    title: AppStrings.finances.tr,
                                    data: "${controller.weeklyHoroscopeJyotishamAstroModel.response?.finance}%",
                                    color: ColorResources.colorTableRow),
                                CustomTableTwoRowWidget(
                                    title: AppStrings.status.tr,
                                    data: "${controller.weeklyHoroscopeJyotishamAstroModel.response?.status}%",
                                    color: ColorResources.colorPrimaryLight),
                                CustomTableTwoRowWidget(
                                    title: AppStrings.career.tr,
                                    data: "${controller.weeklyHoroscopeJyotishamAstroModel.response?.career}%",
                                    color: ColorResources.colorTableRow),
                                CustomTableTwoRowWidget(
                                    title: AppStrings.travel.tr,
                                    data: "${controller.weeklyHoroscopeJyotishamAstroModel.response?.travel}%",
                                    color: ColorResources.colorPrimaryLight),
                                CustomTableTwoRowWidget(
                                    title: AppStrings.family.tr,
                                    data: "${controller.weeklyHoroscopeJyotishamAstroModel.response?.family}%",
                                    color: ColorResources.colorTableRow),
                                CustomTableTwoRowWidget(
                                    title: AppStrings.friends.tr,
                                    data: "${controller.weeklyHoroscopeJyotishamAstroModel.response?.friends}%",
                                    color: ColorResources.colorPrimaryLight),
                                CustomTableTwoRowWidget(
                                    title: AppStrings.health.tr,
                                    data: "${controller.weeklyHoroscopeJyotishamAstroModel.response?.health}%",
                                    color: ColorResources.colorTableRow),
                                CustomTableTwoRowWidget(
                                    title: AppStrings.love.tr,
                                    data: "${controller.weeklyHoroscopeJyotishamAstroModel.response?.relationship}%",
                                    color: ColorResources.colorPrimaryLight),
                              ],
                            ),
                          ),
                          const Gap(Dimensions.gapDefault),
                        ],
                      ),
                    );
                  } else if (controller.isWeeklyHoroscopeLoading.isTrue) {
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
                }),
              ],
            ),
          ),
        ),
      );
    } else if (activeKundliApi == AppConstants.vedicastro) {
      return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: AppStrings.weeklyHoroscope.tr),
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
                            fetchWeeklyHoroscope();
                            selectedHoroscope = horoscopeDailyListCo[index];
                          });
                        },
                        child: Column(
                          children: [
                            const SizedBox(height: Dimensions.gapExtraSmall),
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
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: ColorResources.colorPrimaryVariant,
                        width: 1.5,
                      ),
                      bottom: BorderSide(
                        color: ColorResources.colorPrimaryVariant,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: Dimensions.paddingSizeSmall,
                        left: Dimensions.paddingSizeSmall),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            selectWeek('thisweek', AppStrings.thisWeek.tr);
                            selectedHoroscope = horoscopeDailyListCo[selectedIndex];

                            thisweekTextColor = ColorResources.black;
                            nextweekTextColor = ColorResources.toolbarText;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: thisweekColor,
                            foregroundColor: nextweekTextColor,
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            minimumSize: const Size(30, 30),
                          ),
                          child: Text(AppStrings.thisWeek.tr),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            selectWeek('nextweek', AppStrings.nextWeek.tr);
                            selectedHoroscope = horoscopeDailyListCo[selectedIndex];

                            thisweekTextColor = ColorResources.toolbarText;
                            nextweekTextColor = ColorResources.black;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: nextweekColor,
                            foregroundColor: thisweekTextColor,
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            minimumSize: const Size(30, 30),
                          ),
                          child: Text(AppStrings.nextWeek.tr),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(() {
                  if (controller.isWeeklyHoroscopeSuccess.isTrue) {
                    return Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      child: Column(
                        children: [
                          const Gap(Dimensions.gapExtraSmall),
                          HoroscopeLuckyDetailsWidget(
                            date: weekScreen,
                            luckyColorCode: controller.horoscopeWeeklyVedicAstroModel.response?.luckyColorCode ?? "#FFFFFF",
                            number: '${controller.horoscopeWeeklyVedicAstroModel.response?.luckyNumber}',
                            image: selectedHoroscope != null ? selectedHoroscope!.image : Images.aries,
                            nakshatra: '${controller.horoscopeWeeklyVedicAstroModel.response?.zodiac}',
                            colorName: '${controller.horoscopeWeeklyVedicAstroModel.response?.luckyColor}',
                          ),
                          const SizedBox(height: Dimensions.gapLarge),
                          Row(
                            children: [
                              CustomTextMedium(
                                AppStrings.weeklyHoroscope.tr,
                                textAlign: TextAlign.start,
                                fontSize: Dimensions.fontSizeLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimensions.gapLarge),
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              color: ColorResources.white,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.borderRadiusDefault),
                              border: Border.all(
                                color: ColorResources.colorPrimaryVariant,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.paddingSizeSmall),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomTextRegular("${controller.horoscopeWeeklyVedicAstroModel.response?.botResponse}",fontSize: Dimensions.fontSizeSmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Gap(Dimensions.gapExtraLarge),
                          Container(
                            decoration:  BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                CustomTableTwoRowWidget(
                                    title: AppStrings.totalScore.tr,
                                    data: "${controller.horoscopeWeeklyVedicAstroModel.response?.totalScore}%",
                                    color: ColorResources.colorPrimaryLight),
                                CustomTableTwoRowWidget(
                                    title: AppStrings.finances.tr,
                                    data: "${controller.horoscopeWeeklyVedicAstroModel.response?.finances}%",
                                    color: ColorResources.colorTableRow),
                                CustomTableTwoRowWidget(
                                    title: AppStrings.status.tr,
                                    data: "${controller.horoscopeWeeklyVedicAstroModel.response?.status}%",
                                    color: ColorResources.colorPrimaryLight),
                                CustomTableTwoRowWidget(
                                    title: AppStrings.career.tr,
                                    data: "${controller.horoscopeWeeklyVedicAstroModel.response?.career}%",
                                    color: ColorResources.colorTableRow),
                                CustomTableTwoRowWidget(
                                    title: AppStrings.travel.tr,
                                    data: "${controller.horoscopeWeeklyVedicAstroModel.response?.travel}%",
                                    color: ColorResources.colorPrimaryLight),
                                CustomTableTwoRowWidget(
                                    title: AppStrings.family.tr,
                                    data: "${controller.horoscopeWeeklyVedicAstroModel.response?.family}%",
                                    color: ColorResources.colorTableRow),
                                CustomTableTwoRowWidget(
                                    title: AppStrings.friends.tr,
                                    data: "${controller.horoscopeWeeklyVedicAstroModel.response?.friends}%",
                                    color: ColorResources.colorPrimaryLight),
                                CustomTableTwoRowWidget(
                                    title: AppStrings.health.tr,
                                    data: "${controller.horoscopeWeeklyVedicAstroModel.response?.health}%",
                                    color: ColorResources.colorTableRow),
                                CustomTableTwoRowWidget(
                                    title: AppStrings.love.tr,
                                    data: "${controller.horoscopeWeeklyVedicAstroModel.response?.relationship}%",
                                    color: ColorResources.colorPrimaryLight),
                              ],
                            ),
                          ),
                          const Gap(Dimensions.gapDefault),
                        ],
                      ),
                    );
                  } else if (controller.isWeeklyHoroscopeLoading.isTrue) {
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
                }),
              ],
            ),
          ),
        ),
      );
    }
    // Fallback Widget
    return const Center(
      child: Text('No valid API configuration found.'),
    );

  }

  void horoscopesSign() {
    horoscopeDailyListCo.clear();
    horoscopeDailyListCo.add(MenuModel(AppStrings.aries.tr, Images.aries, '1'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.taurus.tr, Images.taurus, '2'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.gemini.tr, Images.gemini, '3'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.cancer.tr, Images.cancer, '4'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.leo.tr, Images.leo, '5'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.virgo.tr, Images.virgo, '6'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.libra.tr, Images.libra, '7'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.scorpio.tr, Images.scorpio, '8'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.sagittarius.tr, Images.sagittarius, '9'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.capricorn.tr, Images.capricorn, '10'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.aquarius.tr, Images.aquarius, '11'));
    horoscopeDailyListCo.add(MenuModel(AppStrings.pisces.tr, Images.pisces, '12'));
  }

  void selectWeek(String selectedWeek, String selectWeekScreen) {
    setState(() {
      week = selectedWeek;
      weekScreen = selectWeekScreen;
      thisweekColor = selectedWeek == 'thisweek'
          ? ColorResources.colorPrimary
          : ColorResources.colorPrimaryLight;
      nextweekColor = selectedWeek == 'nextweek'
          ? ColorResources.colorPrimary
          : ColorResources.colorPrimaryLight;
      selectedHoroscope = horoscopeDailyListCo[selectedIndex]; // Update selectedHoroscope here
      fetchWeeklyHoroscope();
    });
  }

}
