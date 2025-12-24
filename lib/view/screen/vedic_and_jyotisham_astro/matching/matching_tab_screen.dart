import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../widget/custom_app_bar.dart';
import '../controller/kundli_intake_form_controller.dart';
import '../controller/matching_controller.dart';
import '../model/vedic_data.dart';
import 'matching_aggregate_screen.dart';
import 'matching_asthakoot_screen.dart';
import 'matching_dashakoot_screen.dart';
import 'matching_nakshatra_screen.dart';

class MatchingTabScreen extends StatelessWidget {
  MatchingTabScreen({super.key});
  final MatchingController controller = Get.put(MatchingController());

  @override
  Widget build(BuildContext context) {
    KundliIntakeFormController kundliIntakeFormController = Get.put(KundliIntakeFormController());
    KundliMatchData data = kundliIntakeFormController.kundliMatchingdata;
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar:  CustomAppBar(title: AppStrings.matchMatching.tr,onBackPressed: (){
            Get.back();
            controller.getSavedKundli(0, AppConstants.vedicAstro);
          },),
          body: Column(
            children: [
              Container(
                color: ColorResources.colorPrimaryLight,
                child: TabBar(
                  labelColor: ColorResources.colorPrimaryDark,
                  dividerColor: ColorResources.colorPrimary,
                  unselectedLabelColor: ColorResources.black,
                  indicatorColor: ColorResources.colorPrimaryDark,
                  isScrollable: true, // Important flag for scrollable TabBar
                  tabs: <Widget>[
                    Tab(
                      text: AppStrings.asthakoot.tr,
                    ),
                    Tab(
                      text: AppStrings.dashakoot.tr,
                    ),
                    Tab(
                      text: AppStrings.aggregate.tr,
                    ),
                    Tab(
                      text: AppStrings.nakshatra.tr,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    MatchingAsthakootScreen(data),
                    MatchingDashakootScreen(data),
                    MatchingAggregateScreen(data),
                    MatchingNakshatraScreen(data),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
