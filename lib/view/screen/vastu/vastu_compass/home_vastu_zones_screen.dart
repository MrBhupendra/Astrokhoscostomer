// ignore_for_file: prefer_const_constructors

import 'package:astro_brahmand/utill/vastu_strings.dart';
import 'package:flutter/material.dart';
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:get/get.dart';
import '../../../../utill/images.dart';
import '../widget/vastu_zone_card_widget.dart';

class HomeVastuZonesScreen extends StatelessWidget {
  const HomeVastuZonesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar(title: VastuStrings.homeVastuZones.tr),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 6),
              child: Column(
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      VastuZoneCardWidget(
                        title: VastuStrings.home.tr,
                        icon: Images.home,
                        type: "Home",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.homeEntrance.tr,
                        icon: Images.homeEntrance,
                        type: "Home Entrance",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.ac.tr,
                        icon: Images.ac,
                        type: "Ac",
                      ),VastuZoneCardWidget(
                        title: VastuStrings.bar.tr,
                        icon: Images.bar,
                        type: "Bar",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.bedRoom.tr,
                        icon: Images.bedroom,
                        type: "Bed Room",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.boreWell.tr,
                        icon: Images.boreWell,
                        type: "Bore well",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.basement.tr,
                        icon: Images.basement,
                        type: "Basement",
                      ),VastuZoneCardWidget(
                        title: VastuStrings.balcony.tr,
                        icon: Images.balcony,
                        type: "Balcony",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.computer.tr,
                        icon: Images.computer,
                        type: "Computer",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.dustbin.tr,
                        icon: Images.dustbin,
                        type: "Dustbin",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.diningPlace.tr,
                        icon: Images.diningPlace,
                        type: "Dining Place",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.drawingRoom.tr,
                        icon: Images.drawingRoom,
                        type: "Drawing Room",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.electricMeter.tr,
                        icon: Images.electricMeter,
                        type: "Electric meter",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.guestRoom.tr,
                        icon: Images.guestRoom,
                        type: "Guest Room",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.garage.tr,
                        icon: Images.garage,
                        type: "Garage",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.garden.tr,
                        icon: Images.garden,
                        type: "Garden",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.heater.tr,
                        icon: Images.heater,
                        type: "Heater",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.inverter.tr,
                        icon: Images.inverter,
                        type: "Inverter",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.kitchen.tr,
                        icon: Images.kitchen,
                        type: "Kitchen",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.locker.tr,
                        icon: Images.locker,
                        type: "Locker",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.mirror.tr,
                        icon: Images.mirror,
                        type: "Mirror",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.medicineBox.tr,
                        icon: Images.medicineBox,
                        type: "Medicine box",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.pets.tr,
                        icon: Images.pets,
                        type: "Pets",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.servantRoom.tr,
                        icon: Images.servantRoom,
                        type: "Servant Room",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.staircase.tr,
                        icon: Images.stairsCase,
                        type: "Staircase",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.storeRoom.tr,
                        icon: Images.storeRoom ,
                        type: "Store Room",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.studyTableLibrary.tr,
                        icon: Images.studyTable,
                        type: "Study table or library",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.temple.tr,
                        icon: Images.temple,
                        type: "Temple",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.television.tr,
                        icon: Images.television,
                        type: "Television",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.toiletSepticTank.tr,
                        icon: Images.toilet,
                        type: "Toilet or septic tank",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.watch.tr,
                        icon: Images.watch,
                        type: "Watch",
                      ),VastuZoneCardWidget(
                        title: VastuStrings.waterTank.tr,
                        icon: Images.waterTank,
                        type: "water tank",
                      ),
                      VastuZoneCardWidget(
                        title: VastuStrings.washingMachine.tr,
                        icon: Images.washingMachine,
                        type: "Washing Machine",
                      ),
                      // VastuZoneCardWidget(
                      //   title: VastuStrings.crockery.tr,
                      //   icon: Images.crockery,
                      //   type: "Crockery",
                      // ),
                      // VastuZoneCardWidget(
                      //   title: VastuStrings.musicalInstruments.tr,
                      //   icon: Images.musicalInstruments,
                      //   type: "Musical Ins Truments",
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}


