import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../widget/custom_app_bar.dart';
import 'shubhmuhrat_chogadiya_screen.dart';
import 'shubhmuhrat_hora_screen.dart';


class ShubhMuhratTabScreen extends StatelessWidget {
  const ShubhMuhratTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar:  CustomAppBar(title: AppStrings.shubhMuhrat.tr),
          body:  Column(
            children: [
              Container(
                color: ColorResources.colorPrimaryLight,
                child:  TabBar(
                  labelColor: ColorResources.colorPrimaryDark,
                  dividerColor: ColorResources.colorPrimary,
                  unselectedLabelColor: ColorResources.black,
                  indicatorColor: ColorResources.colorPrimaryDark,
                  tabs: [
                    SizedBox(
                      child: Tab(text: AppStrings.chogadiya.tr),
                    ),
                    SizedBox(
                      child: Tab(text: AppStrings.hora.tr),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ChogadiyaScreen(),
                    HoraScreen()
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
