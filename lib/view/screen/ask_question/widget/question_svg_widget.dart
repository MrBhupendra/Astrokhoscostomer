import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../utill/color_resources.dart';
import '../../../widget/custom_round_network_image.dart';
import '../model/question_history_list_model.dart';
import 'package:xml/xml.dart' as xml;

class QuestionSvgWidget extends StatelessWidget {
  final QuestionHistoryData message;
  final String? userUniId;

  const QuestionSvgWidget(this.message, this.userUniId, {super.key});

  @override
  Widget build(BuildContext context) {
    var decodedData = xml.XmlDocument.parse(message.message.toString());
    String chartSvg = decodedData.toString();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          //Me
          if (message.userUniId == userUniId) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 6),
                          decoration: BoxDecoration(
                            color: ColorResources.lightYellow,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          constraints: const BoxConstraints(maxWidth: 250.0),
                          child: GestureDetector(
                            onTap: () {
                              showPreviewDialog(message.message.toString());
                            },
                            child: SvgPicture.memory(
                                Uint8List.fromList(chartSvg.codeUnits),
                                height: 160,
                                width: 160,
                              ),
                          )),

                    ],
                  ),
                  const SizedBox(width: 5.0),
                  CustomRoundNetworkImage(
                      imageUrl: message.userImageUrl.toString(),
                      height: 30,
                      width: 30),
                ],
              ),
            ),
          ] else ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomRoundNetworkImage(
                      imageUrl: message.userImageUrl.toString(),
                      height: 30,
                      width: 30),
                  const SizedBox(width: 5.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 6),
                          decoration: BoxDecoration(
                            color: ColorResources.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          constraints: const BoxConstraints(maxWidth: 250.0),
                          child: GestureDetector(
                            onTap: () {
                              showPreviewDialog(message.message.toString());
                            },
                            child: SvgPicture.memory(
                              Uint8List.fromList(chartSvg.codeUnits),
                              height: 160,
                              width: 160,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  static void showPreviewDialog(String svgImage) {
    var decodedData = xml.XmlDocument.parse(svgImage);
    String chartSvg = decodedData.toString();
    Get.dialog(
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                  color: ColorResources.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.memory(
                      Uint8List.fromList(chartSvg.codeUnits),
                      height: Get.height * 0.9,
                      width: Get.width * 0.8,
                    ),
                  )),
            ),
          ],
        ),
      ),
      barrierDismissible: true,
    );
  }

  static void dismissDialog() {
    Get.back();
  }
}
