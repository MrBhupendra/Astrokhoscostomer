import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/view/screen/orders/controller/order_controller.dart';
import 'package:astro_brahmand/view/screen/orders/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:get/get.dart';

import '../../../utill/color_resources.dart';

class OrdersTabScreen extends GetView<OrderController> {
  const OrdersTabScreen({super.key});

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
          length: 4,
          initialIndex: 0,
          child: Scaffold(
            appBar: CustomAppBar(title: AppStrings.orderHistory.tr,onBackPressed:(){
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
                    isScrollable: true,
                    tabs: [
                      Tab(text: AppStrings.all.tr),
                      Tab(text: AppStrings.shop.tr),
                      Tab(text: AppStrings.service.tr),
                      Tab(text: AppStrings.wallet.tr),
                    ],
                  ),
                ),
                const Expanded(
                  child: TabBarView(
                    children: [
                      OrdersScreen("All"),
                      OrdersScreen("Shop"),
                      OrdersScreen("Service"),
                      OrdersScreen("Wallet"),
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
