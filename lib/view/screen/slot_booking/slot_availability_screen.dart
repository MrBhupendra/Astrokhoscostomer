import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/view/screen/slot_booking/controller/slot_booking_controller.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/simmer_widget/simmer_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utill/common_methods.dart';
import '../../widget/custom_app_bar.dart';
import '../../widget/custom_empty_screen.dart';
import '../../widget/custom_text_regular.dart';
import '../chat/controller/chat_intake_form_controller.dart';

class SlotAvailabilityScreen extends StatelessWidget {
  SlotAvailabilityScreen({super.key});

  final SlotBookingController controller = Get.put(SlotBookingController());

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;
    String astrologerID = arguments['astrologerId'] ?? '';

    controller.offsetCount = 0;
    controller.getSchedules(controller.offsetCount,astrologerID.toString());
    //Scroll
    // controller.scrollController.addListener(() {
    //   if (controller.scrollController.position.pixels == controller.scrollController.position.maxScrollExtent) {
    //     if (controller.isScheduleLoading.isFalse && !controller.isNoMoreData) {
    //       controller.getSchedules(controller.offsetCount, astrologerID.toString());
    //     }
    //   }
    // });
    return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(title: AppStrings.slotAvailability.tr),
          body: Obx(
                () {
              if (controller.isScheduleSuccess.isTrue) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.slotAvailabilityListData.length,
                        itemBuilder: (context, index) {
                          final schedule = controller.slotAvailabilityListData[index];

                          return Card(
                            margin: const EdgeInsets.all(10),
                            child: ExpansionTile(
                              title:CustomTextMedium("Date: ${schedule.slotDate}"),
                              subtitle: CustomTextRegular("Slot Duration: ${CommonMethods().getFormattedTimeFromMin(int.parse(schedule.perSlotDuration.toString()))}"),
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: schedule.slotList?.length ?? 0,
                                  itemBuilder: (context, slotIndex) {
                                    final slot = schedule.slotList![slotIndex];

                                    return GestureDetector(
                                      onTap: (){
                                        if(slot.isBooked == 0){
                                          // controller.selectSlot(slot,schedule.id.toString());
                                          // Get.toNamed("/chat_intake_form");
                                         controller.bookSchedule(astrologerID, slot.slotStart.toString(), slot.slotEnd.toString(), slot.serialNo.toString(), schedule.id.toString());
                                        }

                                      },
                                      child: ListTile(
                                        title: Text("Slot ${slot.serialNo}"),
                                        subtitle: Text("${slot.timeFrom} - ${slot.timeTo} (${slot.isBooked == 1 ? "Booked" : "Available"})"),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Obx(
                          () => Visibility(
                        visible: controller.isScheduleLoading.isTrue,
                        child: CustomTextRegular('Loading...'),
                      ),
                    )
                  ],
                );
              }
              else if (controller.isScheduleLoading.isTrue) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return const SimmerListView();
                  },
                );
              }
              else {
                return const EmptyScreen();
              }
            },
          ),
        ));
  }
}
