import 'package:astro_brahmand/utill/vastu_strings.dart';
import 'package:flutter/material.dart';
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:get/get.dart';
import '../../../../utill/images.dart';
import '../widget/office_vastu_zone_card_widget.dart';

class OfficeVastuZonesScreen extends StatelessWidget {
  const OfficeVastuZonesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar(title:VastuStrings.officeVastuZones.tr),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 6),
              child: Column(
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    children: [
                      OfficeVastuZoneCardWidget(
                        title: VastuStrings.accountDepartment.tr,
                        icon: Images.accountDepartment,
                        type: "Account Department",
                      ),OfficeVastuZoneCardWidget(
                        title: VastuStrings.basementOffice.tr,
                        icon: Images.officeBasement,
                        type: "Basement Office",
                      ),OfficeVastuZoneCardWidget(
                        title: VastuStrings.computerTable.tr,
                        icon: Images.officeComputerTable,
                        type: "Computer Table",
                      ),OfficeVastuZoneCardWidget(
                        title: VastuStrings.ceoRoom.tr,
                        icon: Images.ceoRoom,
                        type: "CEO Room",
                      ),
                      OfficeVastuZoneCardWidget(
                        title: VastuStrings.dustbinOffice.tr,
                        icon: Images.dustinOffice,
                        type: "Dustbin Office",
                      ),OfficeVastuZoneCardWidget(
                        title: VastuStrings.drinkingWater.tr,
                        icon: Images.drinkWater,
                        type: "Drinking Water",
                      ),OfficeVastuZoneCardWidget(
                        title: VastuStrings.entranceMainDoor.tr,
                        icon: Images.officeEntranceDoor,
                        type: "Entrance/Main Door",
                      ),OfficeVastuZoneCardWidget(
                        title: VastuStrings.marketingDepartment.tr,
                        icon: Images.marketingDepartment,
                        type: "Marketing department",
                      ),OfficeVastuZoneCardWidget(
                        title: VastuStrings.officeReception.tr,
                        icon: Images.officeReception,
                        type: "Office Reception",
                      ),OfficeVastuZoneCardWidget(
                        title: VastuStrings.officeInverter.tr,
                        icon: Images.inverter,
                        type: "Inverter",
                      ),OfficeVastuZoneCardWidget(
                        title: VastuStrings.officeAc.tr,
                        icon: Images.ac,
                        type: "Ac",
                      ),OfficeVastuZoneCardWidget(
                        title: VastuStrings.officeElectricMeter.tr,
                        icon: Images.electricMeter,
                        type: "Electric meter",
                      ),OfficeVastuZoneCardWidget(
                        title: VastuStrings.officeWatch.tr,
                        icon: Images.watch,
                        type: "Watch",
                      ),OfficeVastuZoneCardWidget(
                        title: VastuStrings.officeStaircase.tr,
                        icon: Images.stairsCase,
                        type: "Staircase",
                      ), OfficeVastuZoneCardWidget(
                        title: VastuStrings.purchaseDepartment.tr,
                        icon: Images.purchaseDepartment,
                        type: "Purchase Department",
                      ),OfficeVastuZoneCardWidget(
                        title: VastuStrings.rndDepartment.tr,
                        icon: Images.rndDepartment,
                        type: "RND Department",
                      ),OfficeVastuZoneCardWidget(
                        title: VastuStrings.waitingRoom.tr,
                        icon: Images.waitingRoom,
                        type: "Waiting Room",
                      ),OfficeVastuZoneCardWidget(
                        title: VastuStrings.washroomOffice.tr,
                        icon: Images.washroomOffice,
                        type: "Washroom Office",
                      ),
                      OfficeVastuZoneCardWidget(
                        title: VastuStrings.weightMachine.tr,
                        icon: Images.weightMachine,
                        type: "Weight Machine",
                      ),

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


