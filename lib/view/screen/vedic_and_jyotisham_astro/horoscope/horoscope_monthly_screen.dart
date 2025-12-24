import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../model/menu_model.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import '../controller/horoscope_controller.dart';
import '../widget/custom_table_two_row_widget.dart';

class HoroscopeMonthalyScreen extends StatefulWidget {
  const HoroscopeMonthalyScreen({super.key});


  @override
  _HoroscopeMonthalyScreenState createState() => _HoroscopeMonthalyScreenState();
}
class _HoroscopeMonthalyScreenState extends State<HoroscopeMonthalyScreen> {

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
    controller.getMonthlyHoroscope(horoscopeDailyListCo[selectedIndex].number);
  }

  @override
  Widget build(BuildContext context) {
    horoscopesSign();
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.monthlyHoroscope.tr),
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
                  if (controller.isMonthlySuccess.isTrue) {
                    return Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      child: Column(
                        children: [
                          Column(
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
                                  child: CustomTextMedium("${controller.horoscopeMonthlyModel.response?.month}"),
                                ),
                              ),
                              const Gap(20),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                      child: Column(
                                        children: [
                                          CustomTextMedium("Challenging Days"),
                                          CustomTextMedium("${controller.horoscopeMonthlyModel.response?.challengingDays}"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Gap(10),
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
                                       child: Column(
                                         children: [
                                            CustomTextMedium("Standout Days"),
                                            CustomTextMedium("${controller.horoscopeMonthlyModel.response?.standoutDays}"),
                                         ],
                                       ),
                                    ),
                                  ),
                                ],
                              ),



                              const SizedBox(height: Dimensions.gapDefault),
                              Row(
                                children: [
                                  CustomTextMedium(
                                    AppStrings.monthlyHoroscope.tr,
                                    textAlign: TextAlign.start,
                                    fontSize: Dimensions.fontSizeLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(height: Dimensions.gapDefault),
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorResources.white,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.borderRadiusDefault),
                                  border: Border.all(
                                    color: ColorResources.colorPrimaryVariant,
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(0, 1),
                                    )
                                  ],
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
                                              child: CustomTextRegular("${controller.horoscopeMonthlyModel.response?.horoscopeData}",fontSize: Dimensions.fontSizeSmall,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(Dimensions.gapExtraExtraLarge),
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
                                        title: AppStrings.love.tr,
                                        data: "${controller.horoscopeMonthlyModel.response?.love}",
                                        color: ColorResources.colorPrimaryLight
                                    ),
                                    CustomTableTwoRowWidget(
                                        title: AppStrings.finances.tr,
                                        data: "${controller.horoscopeMonthlyModel.response?.finances}",
                                        color: ColorResources.colorTableRow
                                    ),
                                    CustomTableTwoRowWidget(
                                        title: AppStrings.status.tr,
                                        data: "${controller.horoscopeMonthlyModel.response?.status}",
                                        color: ColorResources.colorPrimaryLight
                                    ),
                                    CustomTableTwoRowWidget(
                                        title: AppStrings.career.tr,
                                        data: "${controller.horoscopeMonthlyModel.response?.career}",
                                        color: ColorResources.colorTableRow
                                    ),
                                    CustomTableTwoRowWidget(
                                        title: AppStrings.travel.tr,
                                        data: "${controller.horoscopeMonthlyModel.response?.travel}",
                                        color: ColorResources.colorPrimaryLight
                                    ),
                                    CustomTableTwoRowWidget(
                                        title: AppStrings.family.tr,
                                        data: "${controller.horoscopeMonthlyModel.response?.family}",
                                        color: ColorResources.colorTableRow
                                    ),
                                    CustomTableTwoRowWidget(
                                        title: AppStrings.friends.tr,
                                        data: "${controller.horoscopeMonthlyModel.response?.friends}",
                                        color: ColorResources.colorPrimaryLight
                                    ),
                                    CustomTableTwoRowWidget(
                                        title: AppStrings.health.tr,
                                        data: "${controller.horoscopeMonthlyModel.response?.health}",
                                        color: ColorResources.colorTableRow
                                    ),
                                    CustomTableTwoRowWidget(
                                        title: AppStrings.total.tr,
                                        data: "${controller.horoscopeMonthlyModel.response?.total}",
                                        color: ColorResources.colorTableRow
                                    ),
                                  ],
                                ),
                              )

                            ],
                          )
                        ],
                      ),
                    );
                  } else if (controller.isMonthlyLoading.isTrue) {
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
    horoscopeDailyListCo.add(MenuModel(AppStrings.pisces.tr, Images.pisces,'12'));
  }
}
