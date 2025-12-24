import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:astro_brahmand/view/screen/vastu/model/switch_word_model.dart';
import 'package:get/get.dart';
import '../../../../utill/color_resources.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_show_more.dart';
import '../../../widget/custom_box_decoration.dart';
import '../../splash/controller/config_controller.dart';

class SwitchWordWidget extends StatelessWidget {
  SwitchWordData switchWordData;
  final Function? onPaymentPressed;
  final Function? onOpenPressed;

  SwitchWordWidget(this.switchWordData, {this.onPaymentPressed, this.onOpenPressed, super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0, bottom: 2),
      child: GestureDetector(
        onTap: () {
          if (switchWordData.paymentStatus == 1) {
            onOpenPressed?.call();
          }
        },
        child: Container(
          decoration: CustomBoxDecoration.getBorderDecoration(),
          child: Padding(
            padding: const EdgeInsets.only(top: 0, left: 12, right: 12),
            child: Column(
              children: [
                const Gap(6.0),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextMedium(switchWordData.title.toString(),
                          color: ColorResources.colorPrimary),
                    ),
                    const Gap(4),
                    switchWordData.paymentStatus == 1
                        ? GestureDetector(
                      onTap: () {
                        onOpenPressed?.call();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  width: 2,
                                  color: ColorResources.colorPrimary)),
                          child: const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 12,
                              color: ColorResources.colorPrimary,
                            ),
                          ),
                        ),
                      ),
                    )
                        : CustomButton(
                      'PAY ${configController.currencySymbol}${switchWordData.price}',
                      onPressed: () {
                        onPaymentPressed?.call();
                      },
                      minimumSize: const Size(40, 25),
                      color: ColorResources.toolbarText,
                    ),
                  ],
                ),
                const Gap(5.0),
                CustomTextShowMore(fullText: switchWordData.description.toString()),
                // CustomHtmlTextExpanded(fullText: switchWordData.description.toString()),
                const Gap(5.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
