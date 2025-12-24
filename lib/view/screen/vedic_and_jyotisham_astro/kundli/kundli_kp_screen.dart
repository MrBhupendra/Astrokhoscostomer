import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import '../../splash/controller/config_controller.dart';
import '../controller/kundli_controller.dart';
import '../model/vedic_data.dart';

class KundliKpScreen extends StatelessWidget {
  final KundliData data;
  KundliKpScreen(this.data, {super.key});

  final KundliController controller = Get.find();
  final ConfigController configController = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getKPCharts(data,"north");
    controller.getKP(data);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(Dimensions.gapDefault),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTextMedium(AppStrings.bhavChart.tr,color: ColorResources.black1,fontSize: Dimensions.fontSizeExtraLarge,),
              ],
            ),
            const Gap(Dimensions.gapOverLarge),
            Obx(() {
              if (controller.isKpChartSuccess.isTrue) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Display SVG chart
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
                          color: ColorResources.colorChart
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SvgPicture.string(
                          controller.chartSvg.value, // Assuming chartSvg is a valid SVG string
                        ),
                      ),
                    ),
                  ],
                );
              } else if (controller.isKpChartLoading.isTrue) {
                return ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const SimmerListView();
                  },
                );
              } else {
                return ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const SimmerListView();
                  },
                );
              }
            }),
            const Gap(Dimensions.gapDefault),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTextMedium(AppStrings.planet.tr,color: ColorResources.black1,fontSize: Dimensions.fontSizeExtraLarge,),
              ],
            ),
            const Gap(Dimensions.gapOverLarge),

            Obx(() {
              if (controller.isKpPlanetSuccess.isTrue) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Card(
                    child:DataTable(
                      columnSpacing: 9,

                      columns: [
                        DataColumn(label: CustomTextMedium(AppStrings.rasino.tr,fontSize:Dimensions.fontSizeLarge)),
                        DataColumn(label: CustomTextMedium(AppStrings.zodiac.tr,fontSize: Dimensions.fontSizeLarge)),
                      //  DataColumn(label: CustomTextMedium(AppStrings.retro.tr,fontSize:Dimensions.fontSizeLarge)),
                        DataColumn(label: CustomTextMedium(AppStrings.name.tr,fontSize:Dimensions.fontSizeLarge)),
                        DataColumn(label: CustomTextMedium(AppStrings.house.tr,fontSize:Dimensions.fontSizeLarge)),
                        DataColumn(label: CustomTextMedium(AppStrings.globalD.tr,fontSize: Dimensions.fontSizeLarge)),

                        DataColumn(label: CustomTextMedium(AppStrings.localD.tr,fontSize: Dimensions.fontSizeLarge)),
                        DataColumn(label: CustomTextMedium(AppStrings.pseudoRasiNo.tr,fontSize: Dimensions.fontSizeLarge)),
                        DataColumn(label: CustomTextMedium(AppStrings.pseudoRasi.tr,fontSize: Dimensions.fontSizeLarge)),
                        DataColumn(label: CustomTextMedium(AppStrings.pseudoRasiLoad.tr,fontSize: Dimensions.fontSizeLarge)),
                        DataColumn(label: CustomTextMedium(AppStrings.pseudoNakshatra.tr,fontSize: Dimensions.fontSizeLarge)),
                        DataColumn(label: CustomTextMedium(AppStrings.pseudoNakshatraNO.tr,fontSize: Dimensions.fontSizeLarge)),

                        DataColumn(label: CustomTextMedium(AppStrings.pseudoNakshatraPada.tr,fontSize: Dimensions.fontSizeLarge)),
                        DataColumn(label: CustomTextMedium(AppStrings.pseudoNakshatraLoad.tr,fontSize: Dimensions.fontSizeLarge)),
                        DataColumn(label: CustomTextMedium(AppStrings.subLoad.tr,fontSize: Dimensions.fontSizeLarge)),
                        DataColumn(label: CustomTextMedium(AppStrings.subSubLoad.tr,fontSize: Dimensions.fontSizeLarge)),
                        DataColumn(label: CustomTextMedium(AppStrings.fullName.tr,fontSize: Dimensions.fontSizeLarge)),

                      ],
                      rows:  [
                        DataRow(
                          cells: [
                            DataCell(Text('${controller.kundliKpModel.response?.k0?.rasiNo}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k0?.zodiac}')),
                           // DataCell(Text("${controller.kundliKpModel.response?.k0?.retro}")),
                            DataCell(Text('${controller.kundliKpModel.response?.k0?.name}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k0?.house}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k0?.globalDegree?.toInt()}')),

                            DataCell(Text('${controller.kundliKpModel.response?.k0?.localDegree?.toInt()}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k0?.pseudoRasiNo}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k0?.pseudoRasi}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k0?.pseudoRasiLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k0?.pseudoNakshatra}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k0?.pseudoNakshatraNo}')),

                            DataCell(Text('${controller.kundliKpModel.response?.k0?.pseudoNakshatraPada}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k0?.pseudoNakshatraLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k0?.subLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k0?.subSubLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k0?.fullName}')),

                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('${controller.kundliKpModel.response?.k1?.rasiNo}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k1?.zodiac}')),
                           // DataCell(Text("${controller.kundliKpModel.response?.k1?.retro}")),
                            DataCell(Text('${controller.kundliKpModel.response?.k1?.name}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k1?.house}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k1?.globalDegree?.toInt()}')),

                            DataCell(Text('${controller.kundliKpModel.response?.k1?.localDegree?.toInt()}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k1?.pseudoRasiNo}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k1?.pseudoRasi}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k1?.pseudoRasiLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k1?.pseudoNakshatra}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k1?.pseudoNakshatraNo}')),

                            DataCell(Text('${controller.kundliKpModel.response?.k1?.pseudoNakshatraPada}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k1?.pseudoNakshatraLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k1?.subLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k1?.subSubLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k1?.fullName}')),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('${controller.kundliKpModel.response?.k2?.rasiNo}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k2?.zodiac}')),
                          //  DataCell(Text("${controller.kundliKpModel.response?.k2?.retro}")),
                            DataCell(Text('${controller.kundliKpModel.response?.k2?.name}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k2?.house}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k2?.globalDegree?.toInt()}')),

                            DataCell(Text('${controller.kundliKpModel.response?.k2?.localDegree?.toInt()}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k2?.pseudoRasiNo}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k2?.pseudoRasi}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k2?.pseudoRasiLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k2?.pseudoNakshatra}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k2?.pseudoNakshatraNo}')),

                            DataCell(Text('${controller.kundliKpModel.response?.k2?.pseudoNakshatraPada}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k2?.pseudoNakshatraLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k2?.subLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k2?.subSubLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k2?.fullName}')),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('${controller.kundliKpModel.response?.k3?.rasiNo}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k3?.zodiac}')),
                          //  DataCell(Text("${controller.kundliKpModel.response?.k3?.retro}")),
                            DataCell(Text('${controller.kundliKpModel.response?.k3?.name}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k3?.house}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k3?.globalDegree?.toInt()}')),

                            DataCell(Text('${controller.kundliKpModel.response?.k3?.localDegree?.toInt()}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k3?.pseudoRasiNo}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k3?.pseudoRasi}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k3?.pseudoRasiLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k3?.pseudoNakshatra}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k3?.pseudoNakshatraNo}')),

                            DataCell(Text('${controller.kundliKpModel.response?.k3?.pseudoNakshatraPada}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k3?.pseudoNakshatraLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k3?.subLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k3?.subSubLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k3?.fullName}')),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('${controller.kundliKpModel.response?.k4?.rasiNo}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k4?.zodiac}')),
                          //  DataCell(Text("${controller.kundliKpModel.response?.k4?.retro}")),
                            DataCell(Text('${controller.kundliKpModel.response?.k4?.name}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k4?.house}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k4?.globalDegree?.toInt()}')),

                            DataCell(Text('${controller.kundliKpModel.response?.k4?.localDegree?.toInt()}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k4?.pseudoRasiNo}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k4?.pseudoRasi}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k4?.pseudoRasiLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k4?.pseudoNakshatra}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k4?.pseudoNakshatraNo}')),

                            DataCell(Text('${controller.kundliKpModel.response?.k4?.pseudoNakshatraPada}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k4?.pseudoNakshatraLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k4?.subLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k4?.subSubLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k4?.fullName}')),

                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('${controller.kundliKpModel.response?.k5?.rasiNo}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k5?.zodiac}')),
                           // DataCell(Text("${controller.kundliKpModel.response?.k5?.retro}")),
                            DataCell(Text('${controller.kundliKpModel.response?.k5?.name}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k5?.house}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k5?.globalDegree?.toInt()}')),

                            DataCell(Text('${controller.kundliKpModel.response?.k5?.localDegree?.toInt()}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k5?.pseudoRasiNo}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k5?.pseudoRasi}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k5?.pseudoRasiLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k5?.pseudoNakshatra}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k5?.pseudoNakshatraNo}')),

                            DataCell(Text('${controller.kundliKpModel.response?.k5?.pseudoNakshatraPada}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k5?.pseudoNakshatraLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k5?.subLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k5?.subSubLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k5?.fullName}')),

                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('${controller.kundliKpModel.response?.k6?.rasiNo}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k6?.zodiac}')),
                          //  DataCell(Text("${controller.kundliKpModel.response?.k6?.retro}")),
                            DataCell(Text('${controller.kundliKpModel.response?.k6?.name}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k6?.house}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k6?.globalDegree?.toInt()}')),

                            DataCell(Text('${controller.kundliKpModel.response?.k6?.localDegree?.toInt()}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k6?.pseudoRasiNo}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k6?.pseudoRasi}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k6?.pseudoRasiLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k6?.pseudoNakshatra}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k6?.pseudoNakshatraNo}')),

                            DataCell(Text('${controller.kundliKpModel.response?.k6?.pseudoNakshatraPada}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k6?.pseudoNakshatraLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k6?.subLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k6?.subSubLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k6?.fullName}')),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('${controller.kundliKpModel.response?.k7?.rasiNo}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k7?.zodiac}')),
                          //  DataCell(Text("${controller.kundliKpModel.response?.k7?.retro}")),
                            DataCell(Text('${controller.kundliKpModel.response?.k7?.name}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k7?.house}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k7?.globalDegree?.toInt()}')),

                            DataCell(Text('${controller.kundliKpModel.response?.k7?.localDegree?.toInt()}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k7?.pseudoRasiNo}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k7?.pseudoRasi}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k7?.pseudoRasiLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k7?.pseudoNakshatra}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k7?.pseudoNakshatraNo}')),

                            DataCell(Text('${controller.kundliKpModel.response?.k7?.pseudoNakshatraPada}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k7?.pseudoNakshatraLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k7?.subLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k7?.subSubLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k7?.fullName}')),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('${controller.kundliKpModel.response?.k8?.rasiNo}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k8?.zodiac}')),
                           // DataCell(Text("${controller.kundliKpModel.response?.k8?.retro}")),
                            DataCell(Text('${controller.kundliKpModel.response?.k8?.name}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k8?.house}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k8?.globalDegree?.toInt()}')),

                            DataCell(Text('${controller.kundliKpModel.response?.k8?.localDegree?.toInt()}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k8?.pseudoRasiNo}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k8?.pseudoRasi}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k8?.pseudoRasiLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k8?.pseudoNakshatra}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k8?.pseudoNakshatraNo}')),

                            DataCell(Text('${controller.kundliKpModel.response?.k8?.pseudoNakshatraPada}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k8?.pseudoNakshatraLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k8?.subLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k8?.subSubLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k8?.fullName}')),
                          ],
                        ),
                        DataRow(

                          cells: [
                            DataCell(Text('${controller.kundliKpModel.response?.k9?.rasiNo}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k9?.zodiac}')),
                          //  DataCell(Text("${controller.kundliKpModel.response?.k9?.retro}")),
                            DataCell(Text('${controller.kundliKpModel.response?.k9?.name}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k9?.house}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k9?.globalDegree?.toInt()}')),

                            DataCell(Text('${controller.kundliKpModel.response?.k9?.localDegree?.toInt()}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k9?.pseudoRasiNo}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k9?.pseudoRasi}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k9?.pseudoRasiLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k9?.pseudoNakshatra}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k9?.pseudoNakshatraNo}')),

                            DataCell(Text('${controller.kundliKpModel.response?.k9?.pseudoNakshatraPada}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k9?.pseudoNakshatraLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k9?.subLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k9?.subSubLord}')),
                            DataCell(Text('${controller.kundliKpModel.response?.k9?.fullName}')),
                          ],
                        ),
                      ],
                      headingRowColor: MaterialStateColor.resolveWith((states) {
                        // Change the color only for the enabled state (default state)
                        return ColorResources.colorPrimaryLight; // Change to any color you desire
                      }),
                    ),
                  ),
                );
              } else if (controller.isKpPlanetLoading.isTrue) {
                return ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const SimmerListView();
                  },
                );
              } else {
                return ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const SimmerListView();
                  },
                );
              }
            }),
          ],
        ),
      ),
    );

  }
}

