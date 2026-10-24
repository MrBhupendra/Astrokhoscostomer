import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:astro_brahmand/utill/dimensions.dart';
import 'package:astro_brahmand/view/screen/mandir_darshan/controller/mandir_darshan_controller.dart';
import 'package:astro_brahmand/view/screen/mandir_darshan/model/mandir_assign_list_model.dart';
import 'package:astro_brahmand/view/widget/custom_app_bar.dart';
import 'package:astro_brahmand/view/widget/custom_network_image.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

/// Customer: upcoming and live temple darshan sessions.
/// Book -> price sheet (wallet / gateway); Join -> live stream (once booked).
/// Route: /mandir_darshan_list (opened from the home services row).
class MandirDarshanListScreen extends StatelessWidget {
  MandirDarshanListScreen({super.key});

  final MandirDarshanController controller = Get.put(MandirDarshanController());

  Future<void> _refresh() => controller.getLiveMandirDarshan(0);

  String _when(MandirAssignData d) {
    final date = d.liveTempleDarshanDate?.toString() ?? '';
    final time = d.liveTempleDarshanTime?.toString() ?? '';
    try {
      return '${CommonMethods().convertDateOutput(date)}  ${CommonMethods().convertTimeToAmPm(time)}';
    } catch (_) {
      return '$date $time';
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!controller.isMandirLoading.value && controller.mandirAssignListData.isEmpty) _refresh();
    });

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.liveMandirDarshan.tr),
        body: Obx(() {
          if (controller.isMandirLoading.isTrue && controller.mandirAssignListData.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = controller.mandirAssignListData;
          return RefreshIndicator(
            onRefresh: _refresh,
            child: items.isEmpty
                ? ListView(children: [
                    const Gap(120),
                    Center(child: CustomTextRegular(AppStrings.noMandirDarshan.tr)),
                  ])
                : ListView.separated(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const Gap(10),
                    itemBuilder: (context, index) => _card(context, items[index]),
                  ),
          );
        }),
      ),
    );
  }

  Widget _card(BuildContext context, MandirAssignData d) {
    final temple = d.liveTempleDarshan;
    final astro = d.mandirAstrologer;
    final booked = (d.isPurchased ?? 0) == 1;
    final minutes = (d.duration ?? 0).toInt();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorResources.black7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: CustomNetworkImage(
              imageUrl: temple?.liveTempleDarshanImage?.toString() ?? '',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextMedium(temple?.liveTempleDarshanName ?? '', fontSize: Dimensions.fontSizeLarge, maxLines: 2),
                const Gap(4),
                CustomTextRegular('${AppStrings.darshanBy.tr} ${astro?.displayName ?? ''}', color: ColorResources.black4),
                const Gap(4),
                CustomTextRegular(_when(d)),
                CustomTextRegular('${CommonMethods().getFormattedTimeFromMin(minutes)}  •  ₹${d.price ?? ''}'),
                const Gap(8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: booked ? Colors.green : ColorResources.colorPrimary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (booked) {
                        // The server checks the time window and the booking.
                        controller.joinMandirDarshan(
                          (astro?.id ?? 0).toInt(),
                          d.liveTempleDarshanChannelName ?? '',
                          d.astrologerUniId ?? '',
                          '${d.id}',
                        );
                      } else if (temple != null) {
                        controller.getMandirDarshanCalculation(
                          '${d.id}',
                          d.astrologerUniId ?? '',
                          0,
                          temple,
                          'Open',
                          '$minutes',
                          context,
                        );
                      }
                    },
                    child: Text(booked ? AppStrings.joinDarshan.tr : AppStrings.bookDarshan.tr),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
