import 'package:astro_brahmand/utill/app_features.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../widget/custom_app_bar.dart';
import '../../splash/controller/config_controller.dart';
import '../controller/kundli_controller.dart';
import '../controller/kundli_intake_form_controller.dart';
import '../model/vedic_data.dart';
import '../report/controller/report_controller.dart';
import 'kundli_Dosh_screen.dart';
import 'kundli_ashtakvarga_screen.dart';
import 'kundli_friendship_screen.dart';
import 'kundli_gemSuggestion_screen.dart';
import 'kundli_kp_screen.dart';
import 'kundli_planetary_screen.dart';
import 'kundli_ascendants_screen.dart';
import 'kundli_basics_screen.dart';
import 'kundli_chart_screen.dart';
import 'kundli_dashas_screen.dart';
import 'kundli_rudraksh_suggestion_screen.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class KundliTabScreen extends StatelessWidget {
  KundliTabScreen({super.key});

  final KundliController controller = Get.put(KundliController());
  final ConfigController configController = Get.find();
  final ReportController reportController = Get.put(ReportController());


  @override
  Widget build(BuildContext context) {
    KundliIntakeFormController kundliIntakeFormController = Get.put(KundliIntakeFormController());
    KundliData data = kundliIntakeFormController.kundliData;

    String? activeKundliApi = configController.config.data?.activeKundliApi?.toString();

    if (activeKundliApi == AppConstants.jyotisham) {
      return _buildTabScreen(data, 11, activeKundliApi);
    } else if (activeKundliApi == AppConstants.vedicastro) {
      return _buildTabScreen(data, 10, activeKundliApi);
    } else {
      // Default fallback UI
      return Scaffold(
        appBar: AppBar(title: Text("Kundli")),
        body: Center(child: Text("Invalid Kundli API")),
      );
    }
  }

  Widget _buildTabScreen(KundliData data, int length, String? activeKundliApi) {
    return SafeArea(
      child: DefaultTabController(
        length: length,
        child: Scaffold(
          appBar:  CustomAppBar(title: AppStrings.kundli.tr,onBackPressed: (){
            Get.back();
            controller.getSavedKundli(0,AppConstants.vedicAstro);
          },
            icon: AppFeatures.downloadJyotishamPDF == true ? Icons.download : null,
            iconSize: 18,
            onActionPressed: () {
              AppLogger.d("form data-> ${data.name} ${data.dob} ${data.tob} ${AppConstants.staticTimezone} ${data.latitude} ${data.longitude} ${data.place}");
              reportController.paidKundliCalculation(AppConstants.reportHoroscope, 0, "Open",  KundliMatchData(
                  data.name,
                  data.dob,
                  data.tob,
                  AppConstants.staticTimezone,
                  data.latitude,
                  data.longitude,
                  data.place,
                  "",
                  "",
                  "",
                  "",
                  "",
                  "",
                  "",
                  "",
                  "en"));
            },),
          body: Column(
            children: [
              Container(
                color: ColorResources.grey,
                child: TabBar(
                  labelColor: ColorResources.colorPrimaryDark,
                  dividerColor: ColorResources.colorPrimary,
                  unselectedLabelColor: ColorResources.black,
                  indicatorColor: ColorResources.colorPrimaryDark,
                  isScrollable: true,
                  tabs: _buildTabs(activeKundliApi),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: _buildTabViews(data, activeKundliApi),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabs(String? activeKundliApi) {
    List<Widget> tabs = [
      Tab(text: AppStrings.chart.tr),
      Tab(text: AppStrings.basics.tr),
      Tab(text: AppStrings.planetary.tr),
      Tab(text: AppStrings.dashas.tr),
      Tab(text: AppStrings.ashtakvarga.tr),
      Tab(text: AppStrings.ascendants.tr),
      Tab(text: AppStrings.kp.tr),
      Tab(text: AppStrings.dosh.tr),
      Tab(text: AppStrings.rudrakshSuggestion.tr),
      Tab(text: AppStrings.gemSuggestion.tr),
    ];

    if (activeKundliApi == AppConstants.jyotisham) {
      tabs.insert(4, Tab(text: AppStrings.friendship.tr)); // Insert friendship tab at the correct position
    }

    return tabs;
  }

  List<Widget> _buildTabViews(KundliData data, String? activeKundliApi) {
    List<Widget> tabViews = [
      KundliChartScreen(data),
      KundliBasicsScreen(data),
      KundliPlanetaryScreen(data),
      KundliDashaScreen(data),
      KundliAshtakvargaScreen(data),
      KundliAscendantsScreen(data),
      KundliKpScreen(data),
      KundliDoshScreen(data),
      KundliRudrakshSuggestionScreen(data),
      KundliGemsuggestionScreen(data),
    ];

    if (activeKundliApi == AppConstants.jyotisham) {
      tabViews.insert(4, KundliFriendshipScreen(data)); // Insert friendship tab view at the correct position
    }

    return tabViews;
  }
}
