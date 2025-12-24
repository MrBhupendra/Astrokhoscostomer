import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/utill/dimensions.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../controller/all_astrologer_controller.dart';

Widget filterItemListWidget(RxInt selectedIndexFilter, bool isFilterSelected,int index, String title) {
  return GestureDetector(
    onTap: () {
      selectedIndexFilter.value = index;
    },
    child: Obx(() => Container(
      height: 45,
      color: selectedIndexFilter.value == index
          ? ColorResources.colorPrimaryLight
          : Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 45,
            width: 5.0,
            color: selectedIndexFilter.value == index
                ? ColorResources.colorPrimary
                : Colors.transparent,
          ),
          Padding(
            padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
            child: CustomTextRegular(
              title,
              fontSize: Dimensions.fontSizeSmall,
              textAlign: TextAlign.left,
            ),
          ),
          const Spacer(),
          if (isFilterSelected)
            const Padding(
              padding: EdgeInsets.only(right: Dimensions.paddingSizeSmall),
              child: CircleAvatar(
                radius: 2.5,
                backgroundColor: Colors.black,
              ),
            ),
        ],
      ),
    )),
  );
}

Widget filterOptionWidget(String title, bool isSelected, Function(bool?) onChanged) {
  return Row(
    children: [
      Checkbox(
        value: isSelected,
        onChanged: onChanged,
        activeColor: ColorResources.colorPrimary,
        side: WidgetStateBorderSide.resolveWith(
              (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return const BorderSide(color: ColorResources.colorPrimary);
            }
            return const BorderSide(color: ColorResources.colorPrimary);
          },
        ),
      ),
      Text(title),
    ],
  );
}