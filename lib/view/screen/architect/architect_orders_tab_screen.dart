import 'package:astro_brahmand/view/screen/architect/architect_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../widget/custom_app_bar.dart';
import 'controller/architect_orders_controller.dart';

class ArchitectOrdersTabScreen extends GetView<ArchitectOrdersController> {
  const ArchitectOrdersTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool isPopGesture) {
        if (!isPopGesture) {
          if (Get.key.currentState?.canPop() ?? false) {
            Get.back();
          } else {
            Get.offAllNamed('/dashboard');
          }
        }
      },
      canPop: false,
      child: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: CustomAppBar(title: AppStrings.vastuArchitectOrders.tr,onBackPressed:(){
              if (Get.key.currentState?.canPop() ?? false) {
                Get.back();
              } else {
                Get.offAllNamed('/dashboard');
              }
            }),
            body: Column(
              children: [
                Container(
                  color: ColorResources.colorPrimaryLight,
                  child: TabBar(
                    tabs: [
                      SizedBox(
                        width: Get.width/4,
                        child: const Tab(text: 'In-Progress'),
                      ),
                      SizedBox(
                        width: Get.width/4,
                        child: const Tab(text: 'Completed'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ArchitectOrdersScreen("InProgress"),

                      ArchitectOrdersScreen("Completed"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
