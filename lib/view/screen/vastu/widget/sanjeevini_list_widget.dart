import 'package:astro_brahmand/view/widget/custom_box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/view/screen/vastu/model/sanjeevini_model.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:get/get.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/custom_text_show_more.dart';
import '../../splash/controller/config_controller.dart';

class SanjeeviniWidget extends StatelessWidget {
  final SanjeeviniData sanjeeviniData;
  final Function? onPaymentPressed;
  final Function? onOpenPressed;

  const SanjeeviniWidget(this.sanjeeviniData, {this.onPaymentPressed, this.onOpenPressed, super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0, bottom: 2),
      child: GestureDetector(
        onTap: () {
          if (sanjeeviniData.paymentStatus == 1) {
            onOpenPressed?.call();
          }
        },
        child: Container(
          decoration: CustomBoxDecoration.getBorderDecoration(),
          // decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(10),
          //     boxShadow: const [
          //       BoxShadow(
          //           offset: Offset(1, 1),
          //           blurRadius: 1,
          //           color: Colors.grey
          //       ),
          //     ],
          //     border: Border.all(
          //       color: Colors.greenAccent,
          //       width: 0.5,
          //     )),
          child: Padding(
            padding: const EdgeInsets.only(top: 0, left: 12, right: 12),
            child: Column(
              children: [
                const Gap(6.0),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextMedium(sanjeeviniData.title.toString(),
                          color: ColorResources.colorPrimary),
                    ),
                    const Gap(4),
                    sanjeeviniData.paymentStatus == 1
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
                                        color: ColorResources.colorPrimary
                                    )),
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
                            'PAY ${configController.currencySymbol}${sanjeeviniData.price}',
                            onPressed: () {
                              onPaymentPressed?.call();
                            },
                            minimumSize: const Size(40, 25),
                            color: ColorResources.toolbarText,
                          ),
                  ],
                ),
                const Gap(5.0),
                CustomTextShowMore(fullText: sanjeeviniData.description.toString()),
                // CustomHtmlTextExpanded(fullText:  sanjeeviniData.description.toString()),
                const Gap(5.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
