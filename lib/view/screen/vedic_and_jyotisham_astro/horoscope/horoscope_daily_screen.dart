import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

class HoroscopeDailyScreen extends StatefulWidget {
  const HoroscopeDailyScreen({super.key});

  @override
  _HoroscopeDailyScreenState createState() => _HoroscopeDailyScreenState();
}

class _HoroscopeDailyScreenState extends State<HoroscopeDailyScreen> {

  final ConfigController configController = Get.find();

  List<MenuModel> horoscopeDailyListCo = [];
  int selectedIndex = 0;
  MenuModel? selectedHoroscope;
  final HoroscopeController controller = Get.put(HoroscopeController());
  String day = 'today';
  String weekScreenFont = AppStrings.thisWeek.tr;// Default value for week

  late DateTime selectedDate;

  Color yesterday = ColorResources.colorPrimaryLight;
  Color today = ColorResources.colorPrimary;
  Color tomorrow = ColorResources.colorPrimaryLight;

  Color yesterdayFont = ColorResources.black;
  Color todayFont = ColorResources.white;
  Color tomorrowFont = ColorResources.black;

  // @override
  // void initState() {
  //   super.initState();
  //   // Fetch the horoscope data when the page is entered
  //   horoscopesSign();
  //   fetchDailyHoroscope();
  // }

  @override
  void initState() {
    // Initialize selectedDate to DateTime.now()
    selectedDate = DateTime.now();
    super.initState();
    horoscopesSign();
    fetchDailyHoroscope(); // Fetch daily horoscope data when screen is loaded
  }

  // Method to fetch weekly horoscope data
  void fetchDailyHoroscope() {

    String? activeKundliApi = configController.config.data?.activeKundliApi.toString();
    if(activeKundliApi == AppConstants.vedicastro){
      if (selectedIndex < horoscopeDailyListCo.length) {
        // Fetch the daily horoscope for the selected horoscope and date
        controller.getDailyHoroscope(
          horoscopeDailyListCo[selectedIndex].number,
          DateFormat('dd/MM/yyyy').format(selectedDate),
        );
      }
    } else if(activeKundliApi == AppConstants.jyotisham){
      controller.getDailyHoroscope(horoscopeDailyListCo[selectedIndex].number, day);
    }

  }


  @override
  Widget build(BuildContext context) {

    String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

    if (activeKundliApi == AppConstants.jyotisham) {
      return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: AppStrings.dailyHoroscope.tr),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 105,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: horoscopeDailyListCo.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            fetchDailyHoroscope(); // Fetch daily horoscope data when horoscope is selected
                            selectedHoroscope = horoscopeDailyListCo[index];
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
                                        : ColorResources.colorPrimaryLight,width: 0.7
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
                            const Gap(7),
                            SizedBox(
                              width: 78,
                              child: CustomTextRegular(
                                horoscopeDailyListCo[index].title,
                                textAlign: TextAlign.center,
                                color: ColorResources.black,
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                            ),
                            const Gap(4),
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
                            selectWeek('yesterday', AppStrings.thisWeek.tr);
                            selectWeekFont('yesterday', AppStrings.thisWeek.tr);
                            selectedHoroscope = horoscopeDailyListCo[selectedIndex];
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: yesterday,
                            foregroundColor: yesterdayFont,
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            minimumSize: const Size(30, 30),
                          ),
                          child: const Text("Yesterday"),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            selectWeek('today', AppStrings.nextWeek.tr);
                            selectWeekFont('today', AppStrings.nextWeek.tr);
                            selectedHoroscope = horoscopeDailyListCo[selectedIndex];
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: today,
                            foregroundColor: todayFont,
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            minimumSize: const Size(30, 30),
                          ),
                          child: const Text("Today"),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            selectWeek('tomorrow', AppStrings.nextWeek.tr);
                            selectWeekFont('tomorrow', AppStrings.nextWeek.tr);
                            selectedHoroscope = horoscopeDailyListCo[selectedIndex];
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tomorrow,
                            foregroundColor: tomorrowFont,
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            minimumSize: const Size(30, 30),
                          ),
                          child: const Text("Tomorrow"),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(() {
                  if (controller.isDailyHoroscopeSuccess.isTrue) {
                    return Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      child: Column(
                        children: [
                          const Gap(Dimensions.gapExtraSmall),
                          HoroscopeLuckyDetailsWidget(
                            date: '${controller.dailyHoroscopeJyotishamAstroModel.response?.date}',
                            luckyColorCode: '${controller.dailyHoroscopeJyotishamAstroModel.response?.colorCode}',
                            number: '${controller.dailyHoroscopeJyotishamAstroModel.response?.luckyNumbers}',
                            image: selectedHoroscope != null ? selectedHoroscope!.image : Images.aries, nakshatra:
                          // '${controller.horoscopeDailyVedicAstroModel.response?.zodiac}',
                          selectedHoroscope != null ? selectedHoroscope!.title : AppStrings.aries,
                            colorName: '${controller.dailyHoroscopeJyotishamAstroModel.response?.luckyColor}',
                          ),
                          const Gap(Dimensions.gapLarge),
                          Row(
                            children: [
                              CustomTextMedium(
                                AppStrings.dailyHoroscope.tr,
                                textAlign: TextAlign.start,
                                fontSize: Dimensions.fontSizeLarge,
                              ),
                            ],
                          ),
                          const Gap(Dimensions.gapLarge),
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
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.paddingSizeSmall),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextRegular("${controller.dailyHoroscopeJyotishamAstroModel.response?.horoscopeData}",fontSize: Dimensions.fontSizeSmall),
                                      ),
                                    ],
                                  ),
                                ],
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
                                  data: "${controller.dailyHoroscopeJyotishamAstroModel.response?.total}%",
                                  color: ColorResources.colorPrimaryLight,
                                ),
                                CustomTableTwoRowWidget(
                                  title: AppStrings.finances.tr,
                                  data: "${controller.dailyHoroscopeJyotishamAstroModel.response?.finance}%",
                                  color: ColorResources.colorTableRow,
                                ),
                                CustomTableTwoRowWidget(
                                  title: AppStrings.status.tr,
                                  data: "${controller.dailyHoroscopeJyotishamAstroModel.response?.status}%",
                                  color: ColorResources.colorPrimaryLight,
                                ),
                                CustomTableTwoRowWidget(
                                  title: AppStrings.career.tr,
                                  data: "${controller.dailyHoroscopeJyotishamAstroModel.response?.career}%",
                                  color: ColorResources.colorTableRow,
                                ),
                                CustomTableTwoRowWidget(
                                  title: AppStrings.travel.tr,
                                  data: "${controller.dailyHoroscopeJyotishamAstroModel.response?.travel}%",
                                  color: ColorResources.colorPrimaryLight,
                                ),
                                CustomTableTwoRowWidget(
                                  title: AppStrings.family.tr,
                                  data: "${controller.dailyHoroscopeJyotishamAstroModel.response?.family}%",
                                  color: ColorResources.colorTableRow,
                                ),
                                CustomTableTwoRowWidget(
                                  title: AppStrings.friends.tr,
                                  data: "${controller.dailyHoroscopeJyotishamAstroModel.response?.friends}%",
                                  color: ColorResources.colorPrimaryLight,
                                ),
                                CustomTableTwoRowWidget(
                                  title: AppStrings.health.tr,
                                  data: "${controller.dailyHoroscopeJyotishamAstroModel.response?.health}%",
                                  color: ColorResources.colorTableRow,
                                ),
                                CustomTableTwoRowWidget(
                                  title: AppStrings.love.tr,
                                  data: "${controller.dailyHoroscopeJyotishamAstroModel.response?.relationship}%",
                                  color: ColorResources.colorPrimaryLight,
                                ),
                                CustomTableTwoRowWidget(
                                  title: AppStrings.physique.tr,
                                  data: "${controller.dailyHoroscopeJyotishamAstroModel.response?.physique}%",
                                  color: ColorResources.colorTableRow,
                                ),
                              ],
                            ),
                          ),
                          const Gap(Dimensions.gapDefault),
                        ],
                      ),
                    );
                  } else if (controller.isDailyHoroscopeLoading.isTrue) {
                    return ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return const SimmerListView();
                      },
                    );
                  } else {
                    return const Center(
                        child: EmptyScreen()
                    );
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
          appBar: CustomAppBar(title: AppStrings.dailyHoroscope.tr),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 85,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: horoscopeDailyListCo.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            fetchDailyHoroscope(); // Fetch daily horoscope data when horoscope is selected
                            selectedHoroscope = horoscopeDailyListCo[index];
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
                                        : ColorResources.colorPrimaryLight,width: 0.7
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
                              width: 78,
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeExtraSmall,
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedDate = DateTime.now().subtract(const Duration(days: 1));
                                yesterday = ColorResources.colorPrimary;
                                today = ColorResources.colorPrimaryLight;
                                tomorrow = ColorResources.colorPrimaryLight;

                                yesterdayFont = ColorResources.toolbarText;
                                todayFont = ColorResources.black;
                                tomorrowFont = ColorResources.black;

                                fetchDailyHoroscope(); // Fetch daily horoscope data for yesterday
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: yesterday,
                              foregroundColor:yesterdayFont,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              minimumSize: const Size(30, 30),
                            ),
                            child: Text(AppStrings.yesterday.tr),
                          ),
                        ),
                        const Gap(8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedDate = DateTime.now();
                                yesterday = ColorResources.colorPrimaryLight;
                                today = ColorResources.colorPrimary;
                                tomorrow = ColorResources.colorPrimaryLight;

                                yesterdayFont = ColorResources.black;
                                todayFont = ColorResources.toolbarText;
                                tomorrowFont = ColorResources.black;

                                fetchDailyHoroscope(); // Fetch daily horoscope data for today
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: today,
                              foregroundColor: todayFont,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              minimumSize: const Size(30, 30),
                            ),
                            child: Text(AppStrings.today.tr),
                          ),
                        ),
                        const Gap(8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedDate = DateTime.now().add(const Duration(days: 1));
                                yesterday = ColorResources.colorPrimaryLight;
                                today = ColorResources.colorPrimaryLight;
                                tomorrow = ColorResources.colorPrimary;

                                yesterdayFont = ColorResources.black;
                                todayFont = ColorResources.black;
                                tomorrowFont = ColorResources.toolbarText;
                                fetchDailyHoroscope(); // Fetch daily horoscope data for tomorrow
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: tomorrow,
                              foregroundColor: tomorrowFont,
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              minimumSize: const Size(30, 30),
                            ),
                            child: Text(AppStrings.tomorrow.tr),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(() {
                  if (controller.isDailyHoroscopeSuccess.isTrue) {
                    return Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      child: Column(
                        children: [
                          const Gap(Dimensions.gapExtraSmall),
                          HoroscopeLuckyDetailsWidget(
                            date: DateFormat('dd/MM/yyyy').format(selectedDate),
                            luckyColorCode: '${controller.horoscopeDailyVedicAstroModel.response?.luckyColorCode}',
                            number: '${controller.horoscopeDailyVedicAstroModel.response?.luckyNumber}',
                            image: selectedHoroscope != null ? selectedHoroscope!.image : Images.aries, nakshatra:
                          '${controller.horoscopeDailyVedicAstroModel.response?.zodiac}',
                            colorName: '${controller.horoscopeDailyVedicAstroModel.response?.luckyColor}',
                          ),
                          const Gap(Dimensions.gapLarge),
                          Row(
                            children: [
                              CustomTextMedium(
                                AppStrings.dailyHoroscope.tr,
                                textAlign: TextAlign.start,
                                fontSize: Dimensions.fontSizeLarge,
                              ),
                            ],
                          ),
                          const Gap(Dimensions.gapLarge),
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
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.paddingSizeSmall),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextRegular("${controller.horoscopeDailyVedicAstroModel.response?.botResponse}",fontSize: Dimensions.fontSizeSmall),
                                      ),
                                    ],
                                  ),
                                ],
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
                                  data: "${controller.horoscopeDailyVedicAstroModel.response?.totalScore}%",
                                  color: ColorResources.colorPrimaryLight,
                                ),
                                CustomTableTwoRowWidget(
                                  title: AppStrings.finances.tr,
                                  data: "${controller.horoscopeDailyVedicAstroModel.response?.finances}%",
                                  color: ColorResources.colorTableRow,
                                ),
                                CustomTableTwoRowWidget(
                                  title: AppStrings.status.tr,
                                  data: "${controller.horoscopeDailyVedicAstroModel.response?.status}%",
                                  color: ColorResources.colorPrimaryLight,
                                ),
                                CustomTableTwoRowWidget(
                                  title: AppStrings.career.tr,
                                  data: "${controller.horoscopeDailyVedicAstroModel.response?.career}%",
                                  color: ColorResources.colorTableRow,
                                ),
                                CustomTableTwoRowWidget(
                                  title: AppStrings.travel.tr,
                                  data: "${controller.horoscopeDailyVedicAstroModel.response?.travel}%",
                                  color: ColorResources.colorPrimaryLight,
                                ),
                                CustomTableTwoRowWidget(
                                  title: AppStrings.family.tr,
                                  data: "${controller.horoscopeDailyVedicAstroModel.response?.family}%",
                                  color: ColorResources.colorTableRow,
                                ),
                                CustomTableTwoRowWidget(
                                  title: AppStrings.friends.tr,
                                  data: "${controller.horoscopeDailyVedicAstroModel.response?.friends}%",
                                  color: ColorResources.colorPrimaryLight,
                                ),
                                CustomTableTwoRowWidget(
                                  title: AppStrings.health.tr,
                                  data: "${controller.horoscopeDailyVedicAstroModel.response?.health}%",
                                  color: ColorResources.colorTableRow,
                                ),
                                CustomTableTwoRowWidget(
                                  title: AppStrings.love.tr,
                                  data: "${controller.horoscopeDailyVedicAstroModel.response?.relationship}%",
                                  color: ColorResources.colorPrimaryLight,
                                ),
                                CustomTableTwoRowWidget(
                                  title: AppStrings.physique.tr,
                                  data: "${controller.horoscopeDailyVedicAstroModel.response?.physique}%",
                                  color: ColorResources.colorTableRow,
                                ),
                              ],
                            ),
                          ),
                          const Gap(Dimensions.gapDefault),
                        ],
                      ),
                    );
                  } else if (controller.isDailyHoroscopeLoading.isTrue) {
                    return ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return const SimmerListView();
                      },
                    );
                  } else {
                    return const Center(
                        child: EmptyScreen()
                    );
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

  // Method to select week
  void selectWeek(String selectedWeek, String selectWeekScreen) {
    setState(() {
      day = selectedWeek;
      weekScreenFont = selectWeekScreen;
      yesterday = selectedWeek == 'yesterday'
          ? ColorResources.colorPrimary
          : ColorResources.colorPrimaryLight;
      today = selectedWeek == 'today'
          ? ColorResources.colorPrimary
          : ColorResources.colorPrimaryLight;
      tomorrow = selectedWeek == 'tomorrow'
          ? ColorResources.colorPrimary
          : ColorResources.colorPrimaryLight;
      selectedHoroscope = horoscopeDailyListCo[selectedIndex]; // Update selectedHoroscope here
      fetchDailyHoroscope();
    });
  }

  void selectWeekFont(String selectedWeek, String selectWeekScreen) {
    setState(() {
      day = selectedWeek;
      weekScreenFont = selectWeekScreen;
      yesterdayFont = selectedWeek == 'yesterday'
          ? ColorResources.white
          : ColorResources.black;
      todayFont = selectedWeek == 'today'
          ? ColorResources.white
          : ColorResources.black;
      tomorrowFont = selectedWeek == 'tomorrow'
          ? ColorResources.white
          : ColorResources.black;
      selectedHoroscope = horoscopeDailyListCo[selectedIndex]; // Update selectedHoroscope here
      fetchDailyHoroscope();
    });
  }

}
