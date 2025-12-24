import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import '../../splash/controller/config_controller.dart';
import '../controller/kundli_controller.dart';
import '../model/chart_menu_model.dart';
import '../model/vedic_data.dart';

class KundliChartScreen extends StatelessWidget {
  final KundliData data;

  KundliChartScreen(this.data, {super.key});

  final KundliController controller = Get.find();
  final ConfigController configController = Get.find();

  final List<ChartMenuModel> chartTypesList = [];
  final List<ChartMenuModel> chartChannelList = [];

  @override
  Widget build(BuildContext context) {
    getChartTypes();
    getChartChannel();

    // Ensure the lists are not empty before accessing their elements
    if (chartTypesList.isNotEmpty && chartChannelList.isNotEmpty) {
      // Set initial selection
      controller.chartSelectedIndex.value = 0;
      controller.chartChannelSelectedIndex.value = 0;
      // Fetch the initial chart
      controller.getCharts(
        chartTypesList[0].name,
        data,
        chartChannelList[0].name,
      );

    }

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Chart types ListView
          SizedBox(
            height: 55,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: chartTypesList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.chartSelectedIndex.value = index;

                    if(chartTypesList[index].title == AppStrings.transit.tr) {
                      controller.getTransitChart(
                        chartTypesList[index].name,
                        data,
                        chartChannelList[controller.chartChannelSelectedIndex.value].name,
                      );
                    }else{
                      controller.getCharts(
                        chartTypesList[index].name,
                        data,
                        chartChannelList[controller.chartChannelSelectedIndex.value].name,
                      );
                    }

                    // controller.getCharts(
                    //   chartTypesList[index].name,
                    //   data,
                    //   chartChannelList[controller.chartChannelSelectedIndex.value].name,
                    // );
                  },
                  child: Obx(() => Container(
                    margin: const EdgeInsets.all(Dimensions.marginSizeSmall),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        )
                      ],
                      color: controller.chartSelectedIndex.value == index
                          ? ColorResources.colorPrimary
                          : ColorResources.white,
                      borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                      border: Border.all(
                        width: 1,
                        color: controller.chartSelectedIndex.value == index
                            ? ColorResources.colorPrimary
                            : Colors.grey, // Use a different color when not selected
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                      child: Text(
                        chartTypesList[index].title,
                        style: TextStyle(
                          color: controller.chartSelectedIndex.value == index
                              ? ColorResources.toolbarText // Set text color to white when selected
                              : ColorResources.black,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  )),
                );
              },
            ),
          ),

          // Chart channel ListView
          SizedBox(

            width: 215,
            child: Container(
              height: 55,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: chartChannelList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.chartChannelSelectedIndex.value = index;
                      if(chartTypesList[controller.chartSelectedIndex.value].title == AppStrings.transit.tr) {
                        controller.getTransitChart(chartTypesList[controller.chartSelectedIndex.value].name, data, chartChannelList[index].name);
                      }else{
                        controller.getCharts(chartTypesList[controller.chartSelectedIndex.value].name, data, chartChannelList[index].name);
                      }

                      // controller.getCharts(chartTypesList[controller.chartSelectedIndex.value].name, data, chartChannelList[index].name);
                    },
                    child: Obx(() => Container(
                      margin: const EdgeInsets.all(Dimensions.marginSizeSmall),
                      decoration: BoxDecoration(
                          color: controller.chartChannelSelectedIndex.value == index
                              ? ColorResources.colorPrimary
                              : ColorResources.white,
                          borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
                          border: Border.all(width: 1, color: ColorResources.colorPrimary)),
                      child: Padding(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                        child: Text(
                          chartChannelList[index].title,
                          style: TextStyle(
                            color: controller.chartChannelSelectedIndex.value == index
                                ? ColorResources.toolbarText // Set text color to white when selected
                                : ColorResources.black,
                            // Set text color to black when not selected
                            fontSize: 13,
                          ),
                        ),
                      ),
                    )),
                  );
                },
              ),
            ),
          ),

          // Chart display area
          Expanded(
            child: Obx(() {
              if (controller.isChartSuccess.isTrue) {
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
              } else if (controller.isChartLoading.isTrue) {
                return ListView.builder(
                  itemCount: 5,
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
          ),
        ],
      ),
    );
  }




    void getChartTypes() {

      chartTypesList.clear();

      String? activeKundliApi = configController.config.data?.activeKundliApi.toString();
      if(activeKundliApi == AppConstants.jyotisham) {
        chartTypesList.add(ChartMenuModel(AppStrings.lagna.tr, "D1"));
        chartTypesList.add(ChartMenuModel(AppStrings.navamsa.tr, "D9"));
        chartTypesList.add(ChartMenuModel(AppStrings.dasamsa.tr, "D10"));
        chartTypesList.add(ChartMenuModel(AppStrings.saptamsa.tr, "D7"));
        chartTypesList.add(ChartMenuModel(AppStrings.khaVedamsa.tr, "D40"));
        chartTypesList.add(ChartMenuModel(AppStrings.moon.tr, "moon"));
        chartTypesList.add(ChartMenuModel(AppStrings.drekkana.tr, "D3"));
        chartTypesList.add(ChartMenuModel(AppStrings.chaturthamsa.tr, "D4"));
        chartTypesList.add(ChartMenuModel(AppStrings.shastiamsha.tr, "D6"));
        chartTypesList.add(ChartMenuModel(AppStrings.ashtamsa.tr, "D8"));
        chartTypesList.add(ChartMenuModel(AppStrings.dwadasamsa.tr, "D12"));
        chartTypesList.add(ChartMenuModel(AppStrings.shodasamsa.tr, "D16"));
        chartTypesList.add(ChartMenuModel(AppStrings.vimshama.tr, "D20"));
        chartTypesList.add(ChartMenuModel(AppStrings.chaturVimshamsa.tr, "D24"));
        chartTypesList.add(ChartMenuModel(AppStrings.nakshatramsa.tr, "D27"));
        chartTypesList.add(ChartMenuModel(AppStrings.trimshamsha.tr, "D30"));
        chartTypesList.add(ChartMenuModel(AppStrings.akshaKhaVedamsa.tr, "D45"));
        chartTypesList.add(ChartMenuModel(AppStrings.shastiamsha.tr, "D60"));
        chartTypesList.add(ChartMenuModel(AppStrings.transit.tr, "transit_chart"));
        chartTypesList.add(ChartMenuModel(AppStrings.bhavChalit.tr, "bhav_chalit_chart"));
      } else if(activeKundliApi == AppConstants.vedicastro) {
        chartTypesList.add(ChartMenuModel(AppStrings.lagna.tr, "D1"));
        chartTypesList.add(ChartMenuModel(AppStrings.dreshkana.tr, "D3"));
        chartTypesList.add(ChartMenuModel(AppStrings.somanatha.tr, "D3-s"));
        chartTypesList.add(ChartMenuModel(AppStrings.saptamsa.tr, "D7"));
        chartTypesList.add(ChartMenuModel(AppStrings.navamsa.tr, "D9"));
        chartTypesList.add(ChartMenuModel(AppStrings.dasamsa.tr, "D10"));
        chartTypesList.add(ChartMenuModel(AppStrings.dasamsaEvenReverse.tr, "D10-R"));
        chartTypesList.add(ChartMenuModel(AppStrings.dwadasamsa.tr, "D12"));
        chartTypesList.add(ChartMenuModel(AppStrings.shodashamsa.tr, "D16"));
        chartTypesList.add(ChartMenuModel(AppStrings.vimshama.tr, "D20"));
        chartTypesList.add(ChartMenuModel(AppStrings.chaturVimshamsa.tr, "D24"));
        chartTypesList.add(ChartMenuModel(AppStrings.d24R.tr, "D24-R"));
        chartTypesList.add(ChartMenuModel(AppStrings.trimshamsha.tr, "D30"));
        chartTypesList.add(ChartMenuModel(AppStrings.khaVedamsa.tr, "D40"));
        chartTypesList.add(ChartMenuModel(AppStrings.akshaKhaVedamsa.tr, "D45"));
        chartTypesList.add(ChartMenuModel(AppStrings.shastiamsha.tr, "D60"));
        chartTypesList.add(ChartMenuModel(AppStrings.bhavChalit.tr, "chalit"));
        chartTypesList.add(ChartMenuModel(AppStrings.moonchart.tr, "moon"));
        chartTypesList.add(ChartMenuModel(AppStrings.sun.tr, "sun"));
      }
  }

  void getChartChannel() {
    chartChannelList.clear();
    String? activeKundliApi = configController.config.data?.activeKundliApi.toString();

    chartChannelList.add(ChartMenuModel(AppStrings.north.tr, "north"));
    chartChannelList.add(ChartMenuModel(AppStrings.south.tr, "south"));
    if (activeKundliApi == AppConstants.jyotisham){
      chartChannelList.add(ChartMenuModel(AppStrings.east.tr, "east"));
    }
  }

}

