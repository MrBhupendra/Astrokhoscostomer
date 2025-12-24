import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/view/screen/orders/controller/paid_service_order_controller.dart';
import 'package:astro_brahmand/view/screen/orders/paid_service_orders_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:get/get.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';

class PaidServiceOrdersTabScreen extends GetView<PaidServiceOrderController> {
  const PaidServiceOrdersTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int initialIndexValue = 0;
    try{
      Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
      initialIndexValue = arguments['index'] ?? 0;
    }catch(e){
      if (kDebugMode) {
        print('OnInitException==> ${e.toString()}');
      }
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
          length: 4,
          initialIndex: initialIndexValue,
          child: Scaffold(
            appBar: CustomAppBar(title: "Paid Orders", onBackPressed:(){
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
                      Tab(text: AppStrings.jeevini.tr),
                      Tab(text: AppStrings.divineCode.tr),
                      Tab(text: AppStrings.ebook.tr),
                      Tab(text: AppStrings.report.tr),
                    ],
                  ),
                ),
                const Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      PaidServiceOrdersScreen(AppConstants.sanjeeviniOrder),
                      PaidServiceOrdersScreen(AppConstants.switchwordOrder),
                      PaidServiceOrdersScreen(AppConstants.pdfBookOrder),
                      PaidServiceOrdersScreen(AppConstants.reportOrder),
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
