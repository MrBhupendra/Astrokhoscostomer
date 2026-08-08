import 'package:astro_brahmand/utill/app_features.dart';
import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/view/screen/orders/controller/order_controller.dart';
import 'package:astro_brahmand/view/screen/orders/orders_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:get/get.dart';

import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../slot_booking/slot_orders_screen.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class OrdersTabScreen extends GetView<OrderController> {
  OrdersTabScreen({super.key});
  final List<String> tabs = [];
  @override
  Widget build(BuildContext context) {
    getTabs();
    int initialIndexValue = 0;
    try{
      Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
      initialIndexValue = arguments['index'] ?? 0;
    }catch(e){
      AppLogger.d('OnInitException==> ${e.toString()}');
    }

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
          length: tabs.length,
          // initialIndex: initialIndexValue,
          initialIndex: (tabs.isNotEmpty && initialIndexValue < tabs.length) ? initialIndexValue : 0,
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
                      if(AppFeatures.groupPooja)
                        Tab(text: AppStrings.groupPooja.tr),
                      Tab(text: AppStrings.wallet.tr),
                      if(AppFeatures.slotBooking)
                        Tab(text: AppStrings.slotBookings.tr),
                      if(AppFeatures.mandirDarshan)
                        Tab(text: AppStrings.liveMandirDarshan.tr),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      const OrdersScreen("All"),

                      const OrdersScreen("Shop"),

                      const OrdersScreen("Service"),

                      if(AppFeatures.groupPooja)
                        const OrdersScreen("Group Pooja"),

                      const OrdersScreen("Wallet"),

                      if(AppFeatures.slotBooking)
                        SlotOrdersScreen(AppConstants.slotBooking),

                      if(AppFeatures.mandirDarshan)
                        const OrdersScreen("Mandir Darshan"),
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

  void getTabs(){
    tabs.add(AppStrings.all.tr);
    tabs.add(AppStrings.shop.tr);
    tabs.add(AppStrings.service.tr);
    if(AppFeatures.groupPooja) {
      tabs.add(AppStrings.groupPooja.tr);
    }
    tabs.add(AppStrings.wallet.tr);
    if(AppFeatures.slotBooking){
      tabs.add(AppStrings.slotBookings.tr);
    }
    if(AppFeatures.mandirDarshan){
      tabs.add(AppStrings.liveMandirDarshan.tr);
    }

  }
}
