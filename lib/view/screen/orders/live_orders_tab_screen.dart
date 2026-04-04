import 'package:astro_brahmand/view/screen/orders/controller/order_controller.dart';
import 'package:astro_brahmand/view/screen/orders/live_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:get/get.dart';

import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';

class LiveOrdersTabScreen extends GetView<OrderController> {
  const LiveOrdersTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar:  CustomAppBar(title: AppStrings.liveOrders.tr),
          body: Column(
            children: [
              Container(
                color: ColorResources.colorPrimaryLight,
                child: TabBar(
                  tabs: [
                    SizedBox(
                      width: Get.width/4,
                      child: Tab(text: AppStrings.consulting.tr),
                    ),
                    SizedBox(
                      width: Get.width/4,
                      child: Tab(text: AppStrings.gift.tr),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    LiveOrdersScreen("Consulting"),

                    LiveOrdersScreen("Gift"),
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
