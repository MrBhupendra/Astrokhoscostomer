import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import '../controller/kundli_controller.dart';
import '../model/vedic_data.dart';
import '../widget/custom_table_two_row_widget.dart';

class KundliPlanetaryScreen extends StatelessWidget {
   final KundliData data;
   KundliPlanetaryScreen(this.data, {super.key});

   final KundliController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getPlanets(data);
    return Obx(
          () {
        if (controller.isPlanetasLoading.value) {
          return  ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const SimmerListView();
            },
          );
        } else if (controller.planetasModel.status == 200) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextMedium(AppStrings.planetaryPossitions.tr,fontSize: Dimensions.fontSizeLarge,),
                    ],
                  ),
                  const Gap(Dimensions.gapDefault),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Card(
                      child:DataTable(
                        columnSpacing: 10,

                        columns: [
                          DataColumn(label: CustomTextMedium(AppStrings.planet.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.zodiac.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.globalDegree.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.localDegree.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.nakshatra.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.singLord.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.nakshatraLord.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.zodiacLord.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.rasiNo.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.nakshatraPada.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.nakshatraNo.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.house.tr)),

                        ],
                        rows:  [
                          DataRow(
                            cells: [
                              DataCell(Text('${controller.planetasModel.response?.p0?.fullName}')),
                              DataCell(Text('${controller.planetasModel.response?.p0?.zodiac}')),
                              DataCell(Text("${controller.planetasModel.response?.p0?.globalDegree?.toInt()}")),
                              DataCell(Text('${controller.planetasModel.response?.p0?.localDegree?.toInt()}')),
                              DataCell(Text('${controller.planetasModel.response?.p0?.nakshatra}')),
                              DataCell(Text('${controller.planetasModel.response?.p0?.zodiacLord}')),
                              DataCell(Text('${controller.planetasModel.response?.p0?.nakshatraLord}')),

                              DataCell(Text('${controller.planetasModel.response?.p0?.zodiacLord}')),
                              DataCell(Text('${controller.planetasModel.response?.p0?.rasiNo}')),
                              DataCell(Text('${controller.planetasModel.response?.p0?.nakshatraPada}')),
                              DataCell(Text('${controller.planetasModel.response?.p0?.nakshatraNo}')),
                              DataCell(Text('${controller.planetasModel.response?.p0?.house}')),

                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Text('${controller.planetasModel.response?.p1?.fullName}')),
                              DataCell(Text('${controller.planetasModel.response?.p1?.zodiac}')),
                              DataCell(Text("${controller.planetasModel.response?.p1?.globalDegree?.toInt()}")),
                              DataCell(Text('${controller.planetasModel.response?.p1?.localDegree?.toInt()}')),
                              DataCell(Text('${controller.planetasModel.response?.p1?.nakshatra}')),
                              DataCell(Text('${controller.planetasModel.response?.p1?.zodiacLord}')),
                              DataCell(Text('${controller.planetasModel.response?.p1?.nakshatraLord}')),

                              DataCell(Text('${controller.planetasModel.response?.p1?.zodiacLord}')),
                              DataCell(Text('${controller.planetasModel.response?.p1?.rasiNo}')),
                              DataCell(Text('${controller.planetasModel.response?.p1?.nakshatraPada}')),
                              DataCell(Text('${controller.planetasModel.response?.p1?.nakshatraNo}')),
                              DataCell(Text('${controller.planetasModel.response?.p1?.house}')),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Text('${controller.planetasModel.response?.p2?.fullName}')),
                              DataCell(Text('${controller.planetasModel.response?.p2?.zodiac}')),
                              DataCell(Text("${controller.planetasModel.response?.p2?.globalDegree?.toInt()}")),
                              DataCell(Text('${controller.planetasModel.response?.p2?.localDegree?.toInt()}')),
                              DataCell(Text('${controller.planetasModel.response?.p2?.nakshatra}')),
                              DataCell(Text('${controller.planetasModel.response?.p2?.zodiacLord}')),
                              DataCell(Text('${controller.planetasModel.response?.p2?.nakshatraLord}')),


                              DataCell(Text('${controller.planetasModel.response?.p2?.zodiacLord}')),
                              DataCell(Text('${controller.planetasModel.response?.p2?.rasiNo}')),
                              DataCell(Text('${controller.planetasModel.response?.p2?.nakshatraPada}')),
                              DataCell(Text('${controller.planetasModel.response?.p2?.nakshatraNo}')),
                              DataCell(Text('${controller.planetasModel.response?.p2?.house}')),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Text('${controller.planetasModel.response?.p3?.fullName}')),
                              DataCell(Text('${controller.planetasModel.response?.p3?.zodiac}')),
                              DataCell(Text("${controller.planetasModel.response?.p3?.globalDegree?.toInt()}")),
                              DataCell(Text('${controller.planetasModel.response?.p3?.localDegree?.toInt()}')),
                              DataCell(Text('${controller.planetasModel.response?.p3?.nakshatra}')),
                              DataCell(Text('${controller.planetasModel.response?.p3?.zodiacLord}')),
                              DataCell(Text('${controller.planetasModel.response?.p3?.nakshatraLord}')),

                              DataCell(Text('${controller.planetasModel.response?.p3?.zodiacLord}')),
                              DataCell(Text('${controller.planetasModel.response?.p3?.rasiNo}')),
                              DataCell(Text('${controller.planetasModel.response?.p3?.nakshatraPada}')),
                              DataCell(Text('${controller.planetasModel.response?.p3?.nakshatraNo}')),
                              DataCell(Text('${controller.planetasModel.response?.p3?.house}')),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Text('${controller.planetasModel.response?.p4?.fullName}')),
                              DataCell(Text('${controller.planetasModel.response?.p4?.zodiac}')),
                              DataCell(Text("${controller.planetasModel.response?.p4?.globalDegree?.toInt().toInt()}")),
                              DataCell(Text('${controller.planetasModel.response?.p4?.localDegree?.toInt()}')),
                              DataCell(Text('${controller.planetasModel.response?.p4?.nakshatra}')),
                              DataCell(Text('${controller.planetasModel.response?.p4?.zodiacLord}')),
                              DataCell(Text('${controller.planetasModel.response?.p4?.nakshatraLord}')),

                              DataCell(Text('${controller.planetasModel.response?.p4?.zodiacLord}')),
                              DataCell(Text('${controller.planetasModel.response?.p4?.rasiNo}')),
                              DataCell(Text('${controller.planetasModel.response?.p4?.nakshatraPada}')),
                              DataCell(Text('${controller.planetasModel.response?.p4?.nakshatraNo}')),
                              DataCell(Text('${controller.planetasModel.response?.p4?.house}')),

                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Text('${controller.planetasModel.response?.p5?.fullName}')),
                              DataCell(Text('${controller.planetasModel.response?.p5?.zodiac}')),
                              DataCell(Text("${controller.planetasModel.response?.p5?.globalDegree?.toInt()}")),
                              DataCell(Text('${controller.planetasModel.response?.p5?.localDegree?.toInt()}')),
                              DataCell(Text('${controller.planetasModel.response?.p5?.nakshatra}')),
                              DataCell(Text('${controller.planetasModel.response?.p5?.zodiacLord}')),
                              DataCell(Text('${controller.planetasModel.response?.p5?.nakshatraLord}')),

                              DataCell(Text('${controller.planetasModel.response?.p5?.zodiacLord}')),
                              DataCell(Text('${controller.planetasModel.response?.p5?.rasiNo}')),
                              DataCell(Text('${controller.planetasModel.response?.p5?.nakshatraPada}')),
                              DataCell(Text('${controller.planetasModel.response?.p5?.nakshatraNo}')),
                              DataCell(Text('${controller.planetasModel.response?.p5?.house}')),

                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Text('${controller.planetasModel.response?.p6?.fullName}')),
                              DataCell(Text('${controller.planetasModel.response?.p6?.zodiac}')),
                              DataCell(Text("${controller.planetasModel.response?.p6?.globalDegree?.toInt()}")),
                              DataCell(Text('${controller.planetasModel.response?.p6?.localDegree?.toInt()}')),
                              DataCell(Text('${controller.planetasModel.response?.p6?.nakshatra}')),
                              DataCell(Text('${controller.planetasModel.response?.p6?.zodiacLord}')),
                              DataCell(Text('${controller.planetasModel.response?.p6?.nakshatraLord}')),

                              DataCell(Text('${controller.planetasModel.response?.p6?.zodiacLord}')),
                              DataCell(Text('${controller.planetasModel.response?.p6?.rasiNo}')),
                              DataCell(Text('${controller.planetasModel.response?.p6?.nakshatraPada}')),
                              DataCell(Text('${controller.planetasModel.response?.p6?.nakshatraNo}')),
                              DataCell(Text('${controller.planetasModel.response?.p6?.house}')),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Text('${controller.planetasModel.response?.p7?.fullName}')),
                              DataCell(Text('${controller.planetasModel.response?.p7?.zodiac}')),
                              DataCell(Text("${controller.planetasModel.response?.p7?.globalDegree?.toInt()}")),
                              DataCell(Text('${controller.planetasModel.response?.p7?.localDegree?.toInt()}')),
                              DataCell(Text('${controller.planetasModel.response?.p7?.nakshatra}')),
                              DataCell(Text('${controller.planetasModel.response?.p7?.zodiacLord}')),
                              DataCell(Text('${controller.planetasModel.response?.p7?.nakshatraLord}')),

                              DataCell(Text('${controller.planetasModel.response?.p7?.zodiacLord}')),
                              DataCell(Text('${controller.planetasModel.response?.p7?.rasiNo}')),
                              DataCell(Text('${controller.planetasModel.response?.p7?.nakshatraPada}')),
                              DataCell(Text('${controller.planetasModel.response?.p7?.nakshatraNo}')),
                              DataCell(Text('${controller.planetasModel.response?.p7?.house}')),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(Text('${controller.planetasModel.response?.p8?.fullName}')),
                              DataCell(Text('${controller.planetasModel.response?.p8?.zodiac}')),
                              DataCell(Text("${controller.planetasModel.response?.p8?.globalDegree?.toInt()}")),
                              DataCell(Text('${controller.planetasModel.response?.p8?.localDegree?.toInt()}')),
                              DataCell(Text('${controller.planetasModel.response?.p8?.nakshatra}')),
                              DataCell(Text('${controller.planetasModel.response?.p8?.zodiacLord}')),
                              DataCell(Text('${controller.planetasModel.response?.p8?.nakshatraLord}')),

                              DataCell(Text('${controller.planetasModel.response?.p8?.zodiacLord}')),
                              DataCell(Text('${controller.planetasModel.response?.p8?.rasiNo}')),
                              DataCell(Text('${controller.planetasModel.response?.p8?.nakshatraPada}')),
                              DataCell(Text('${controller.planetasModel.response?.p8?.nakshatraNo}')),
                              DataCell(Text('${controller.planetasModel.response?.p8?.house}')),
                            ],
                          ),
                          DataRow(

                            cells: [
                              DataCell(Text('${controller.planetasModel.response?.p9?.fullName}')),
                              DataCell(Text('${controller.planetasModel.response?.p9?.zodiac}')),
                              DataCell(Text("${controller.planetasModel.response?.p9?.globalDegree?.toInt()}")),
                              DataCell(Text('${controller.planetasModel.response?.p9?.localDegree?.toInt()}')),
                              DataCell(Text('${controller.planetasModel.response?.p9?.nakshatra}')),
                              DataCell(Text('${controller.planetasModel.response?.p9?.zodiacLord}')),
                              DataCell(Text('${controller.planetasModel.response?.p9?.nakshatraLord}')),

                              DataCell(Text('${controller.planetasModel.response?.p9?.zodiacLord}')),
                              DataCell(Text('${controller.planetasModel.response?.p9?.rasiNo}')),
                              DataCell(Text('${controller.planetasModel.response?.p9?.nakshatraPada}')),
                              DataCell(Text('${controller.planetasModel.response?.p9?.nakshatraNo}')),
                              DataCell(Text('${controller.planetasModel.response?.p9?.house}')),
                            ],
                          ),
                        ],
                        headingRowColor: WidgetStateColor.resolveWith((states) {
                          // Change the color only for the enabled state (default state)
                          return ColorResources.colorPrimaryLight; // Change to any color you desire
                        }),
                      ),
                    ),
                  ),
                  const Gap(Dimensions.gapDefault),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextMedium(AppStrings.basicsDetails.tr,fontSize: Dimensions.fontSizeLarge,),
                    ],
                  ),
                  const Gap(Dimensions.gapDefault),
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
                            title: AppStrings.birthDasha.tr,
                            data: "${controller.planetasModel.response?.birthDasa}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title:AppStrings.currentDasa.tr,
                            data: "${controller.planetasModel.response?.currentDasa}",
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.birthDasaTime.tr,
                            data: "${controller.planetasModel.response?.birthDasaTime}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.currentDasaTime.tr,
                            data: "${controller.planetasModel.response?.currentDasaTime}",
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.luckyGem.tr,
                            data: "${controller.planetasModel.response?.luckyGem}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.luckyNumber.tr,
                            data: "${controller.planetasModel.response?.luckyNum}",
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.luckyColor.tr,
                            data: "${controller.planetasModel.response?.luckyColors}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.luckyLetters.tr,
                            data: "${controller.planetasModel.response?.luckyLetters}",
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.luckyNameStart.tr,
                            data: "${controller.planetasModel.response?.luckyNameStart}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.rasi.tr,
                            data: "${controller.planetasModel.response?.rasi}",
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.nakshatraPada.tr,
                            data: "${controller.planetasModel.response?.nakshatraPada}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.nakshatra.tr,
                            data: "${controller.planetasModel.response?.nakshatra}",
                            color: ColorResources.colorTableRow
                        ),

                      ],
                    ),
                  ),
                  const Gap(Dimensions.gapDefault),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextMedium(AppStrings.panchangDetails.tr,fontSize: Dimensions.fontSizeLarge,),
                    ],
                  ),
                  const Gap(Dimensions.gapDefault),
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
                            title: AppStrings.ayanamsa.tr,
                            data: "${controller.planetasModel.response?.panchang?.ayanamsa}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.ayanamsaName.tr,
                            data: "${controller.planetasModel.response?.panchang?.ayanamsaName}",
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.dayOfBirth.tr,
                            data: "${controller.planetasModel.response?.panchang?.dayOfBirth}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.dayLord.tr,
                            data: "${controller.planetasModel.response?.panchang?.dayLord}",
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.horaLord.tr,
                            data: "${controller.planetasModel.response?.panchang?.horaLord}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.sunriseBirth.tr,
                            data: "${controller.planetasModel.response?.panchang?.sunriseAtBirth}",
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title:AppStrings.sunsetBirth.tr,
                            data: "${controller.planetasModel.response?.panchang?.sunsetAtBirth}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.karana.tr,
                            data: "${controller.planetasModel.response?.panchang?.karana}",
                            color:ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.yog.tr,
                            data: "${controller.planetasModel.response?.panchang?.yoga}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.tithi.tr,
                            data: "${controller.planetasModel.response?.panchang?.tithi}",
                            color: ColorResources.colorTableRow
                        ),

                      ],
                    ),
                  ),
                  const Gap(Dimensions.gapDefault),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomTextMedium(AppStrings.ghatkaChakra.tr,fontSize: Dimensions.fontSizeLarge,),
                    ],
                  ),
                  const Gap(Dimensions.gapDefault),
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
                            title: AppStrings.rasi.tr,
                            data: "${controller.planetasModel.response?.ghatkaChakra?.rasi}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.tithi.tr,
                            data: "${controller.planetasModel.response?.ghatkaChakra?.tithi}",
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.day.tr,
                            data: "${controller.planetasModel.response?.ghatkaChakra?.day}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.nakshatra.tr,
                            data: "${controller.planetasModel.response?.ghatkaChakra?.nakshatra}",
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.tatva.tr,
                            data: "${controller.planetasModel.response?.ghatkaChakra?.tatva}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.lord.tr,
                            data: "${controller.planetasModel.response?.ghatkaChakra?.lord}",
                            color: ColorResources.colorTableRow
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.sameSexLagna.tr,
                            data: "${controller.planetasModel.response?.ghatkaChakra?.sameSexLagna}",
                            color: ColorResources.colorPrimaryLight
                        ),
                        CustomTableTwoRowWidget(
                            title: AppStrings.oppositeSexLagna.tr,
                            data: "${controller.planetasModel.response?.ghatkaChakra?.oppositeSexLagna}",
                            color: ColorResources.colorTableRow
                        ),

                      ],
                    ),
                  ),
                  const Gap(Dimensions.gapDefault),
                ],
              ),
            ),
          );
        } else {
          return const EmptyScreen();
        }
      },
    );
  }
}