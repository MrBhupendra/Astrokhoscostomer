import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/view/screen/orders/controller/order_controller.dart';
import 'package:astro_brahmand/view/screen/orders/orders_screen.dart';
import 'package:astro_brahmand/view/screen/slot_booking/slot_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:get/get.dart';

import '../../../utill/color_resources.dart';

/// Order history tabs. The index of each tab is used by navigation elsewhere
/// (payment success dialogs, notifications), so keep this order:
///   0 All, 1 Shop, 2 Service, 3 Group Pooja, 4 Slot Booking, 5 Wallet, 6 Mandir Darshan
/// Open a tab with: Get.toNamed('/orders_tab_screen', arguments: {'index': 3})
class OrdersTabScreen extends GetView<OrderController> {
  const OrdersTabScreen({super.key});

  static const int allTab = 0;
  static const int shopTab = 1;
  static const int serviceTab = 2;
  static const int groupPoojaTab = 3;
  static const int slotBookingTab = 4;
  static const int walletTab = 5;
  static const int mandirDarshanTab = 6;

  static List<_OrderTab> get _tabs => [
        _OrderTab(AppStrings.all, () => const OrdersScreen(AppConstants.allOrder)),
        _OrderTab(AppStrings.shop, () => const OrdersScreen(AppConstants.shopOrder)),
        _OrderTab(AppStrings.service, () => const OrdersScreen(AppConstants.serviceOrder)),
        _OrderTab(AppStrings.groupPooja, () => const OrdersScreen(AppConstants.groupPoojaOrder)),
        _OrderTab(AppStrings.slotBookingOrders, () => SlotOrdersScreen(AppConstants.slotBooking)),
        _OrderTab(AppStrings.wallet, () => const OrdersScreen(AppConstants.walletOrder)),
        _OrderTab(AppStrings.liveMandirDarshan, () => const OrdersScreen(AppConstants.orderMandirDarshan)),
      ];

  /// The tab requested through Get.arguments['index'] (it used to be ignored,
  /// so every "go to your order" link opened the "All" tab).
  static int _initialIndex() {
    final args = Get.arguments;
    final raw = args is Map ? args['index'] : null;
    final index = raw is int ? raw : int.tryParse('${raw ?? ''}') ?? allTab;
    return index.clamp(0, _tabs.length - 1);
  }

  void _back() {
    if (Get.key.currentState?.canPop() ?? false) {
      Get.back();
    } else {
      Get.offAllNamed('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabs = _tabs;
    return PopScope(
      onPopInvoked: (bool isPopGesture) {
        if (!isPopGesture) _back();
      },
      canPop: false,
      child: SafeArea(
        child: DefaultTabController(
          length: tabs.length,
          initialIndex: _initialIndex(),
          child: Scaffold(
            appBar: CustomAppBar(title: AppStrings.orderHistory.tr, onBackPressed: _back),
            body: Column(
              children: [
                Container(
                  color: ColorResources.colorPrimaryLight,
                  child: TabBar(
                    isScrollable: true,
                    tabs: [for (final t in tabs) Tab(text: t.title.tr)],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [for (final t in tabs) t.build()],
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

class _OrderTab {
  final String title;
  final Widget Function() build;
  const _OrderTab(this.title, this.build);
}
