import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/view/screen/dashboard/dash_live_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/utill/dimensions.dart';
import 'package:astro_brahmand/utill/images.dart';
import 'package:astro_brahmand/view/screen/dashboard/controller/dashboard_controller.dart';
import 'package:astro_brahmand/view/screen/dashboard/dash_home_screen.dart';
import 'package:astro_brahmand/view/screen/dashboard/dash_profile_screen.dart';
import 'package:astro_brahmand/view/widget/custom_dashboard_drawer.dart';
import 'package:astro_brahmand/view/widget/custom_home_app_bar.dart';

import '../../../controller/app_update_controller.dart';
import '../../../controller/connectivity_service.dart';
import '../splash/controller/config_controller.dart';
import 'dash_call_chat_astrologer_screen.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final DashboardController controller = Get.put<DashboardController>(DashboardController());
  final AppUpdateController appUpdateController = Get.put(AppUpdateController());
  final ConnectivityController connectivityController = Get.put(ConnectivityController());
  final ConfigController configController = Get.find();

  @override
  Widget build(BuildContext context) {
    configController.setCurrentScreen('dashboard');
    return SafeArea(
      child: Scaffold(
        appBar: CustomHomeAppBar(controller),
        body: Obx(() => Center(
          child: _dashboardTab(controller.selectedIndex.value),
        )),
        // Drawer
        drawer: CustomDashboardDrawer(),

        bottomNavigationBar: Container(
          height: 60.0,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8.0),topRight: Radius.circular(8.0)),
            color: ColorResources.colorPrimary,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Obx(() => Row(
            children: [
              _buildIconButton(0, Images.navHome, AppStrings.home.tr),
              _buildIconButton(1, Images.navChat, AppStrings.chat.tr),
              _buildIconButton(2, Images.navLive, AppStrings.live.tr),
              _buildIconButton(3, Images.navCall, AppStrings.call.tr),
              _buildIconButton(4, Images.navProfile, AppStrings.profile.tr),
            ],
          ))
        ),
      ),
    );
  }

  Widget _dashboardTab(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return CallChatAstrologerScreen(AppConstants.chat);
      case 2:
        return const LiveAstrologerScreen();
      case 3:
        return CallChatAstrologerScreen(AppConstants.call);
      case 4:
        return const ProfileScreen();
      default:
        return HomeScreen();
    }
  }

  Widget _buildIconButton(int index, String imagePath, String label) {
    final isSelected = controller.selectedIndex.value == index;
    final color = isSelected ? ColorResources.toolbarText : ColorResources.white.withOpacity(0.7);

    void onItemTapped(int index) {
      controller.selectedIndex.value = index;
    }

    return Expanded(
      child: InkWell(
        onTap: () => onItemTapped(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagePath, width: 20, height: 20,color: color,),
            const Gap(2),
            Text(
              label,
              style: TextStyle(color: color, fontSize: Dimensions.fontSizeSmall),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
