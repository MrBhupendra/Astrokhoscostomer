import 'package:astro_brahmand/view/screen/assistant_chat/support_channels_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utill/color_resources.dart';
import '../../widget/custom_app_bar.dart';

class SupportTabScreen extends StatelessWidget {
  const SupportTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: const CustomAppBar(title: "Support Chat"),
          body: Column(
            children: [
              Container(
                color: ColorResources.colorPrimaryLight,
                child: TabBar(
                  tabs: [
                    SizedBox(
                      width: Get.width/1,
                      child: const Tab(text: "Astrologer's Assistant"),
                    ),
                    // SizedBox(
                    //   width: Get.width/4,
                    //   child: const Tab(text: 'Gift'),
                    // ),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    SupportChannelsScreen("Astrologer"),

                    // LiveOrdersScreen("Gift"),
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
