import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import '../../splash/controller/config_controller.dart';
import '../controller/kundli_controller.dart';
import '../model/vedic_data.dart';

class KundliRudrakshSuggestionScreen extends StatelessWidget {
  final KundliData data;
  KundliRudrakshSuggestionScreen(this.data, {super.key});

  final KundliController controller = Get.find();
  final ConfigController configController = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getRudrakshSuggestion(data);

    String? activeKundliApi =
        configController.config.data?.activeKundliApi.toString();

    if (activeKundliApi == AppConstants.jyotisham) {
      return Obx(() {
        if (controller.isRudrakshaSuggestionsSuccess.isTrue) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: Dimensions.paddingSizeDefault),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ],
                  color: ColorResources.white,
                  borderRadius:
                      BorderRadius.circular(Dimensions.borderRadiusDefault),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ColorResources.white,
                        borderRadius: const BorderRadius.only(
                          topRight:
                              Radius.circular(Dimensions.borderRadiusDefault),
                          topLeft:
                              Radius.circular(Dimensions.borderRadiusDefault),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    Dimensions.borderRadiusDefault),
                                topRight: Radius.circular(
                                    Dimensions.borderRadiusDefault),
                              ),
                              color: ColorResources.colorPrimary,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeSmall,
                                horizontal: Dimensions.paddingSizeDefault,
                              ),
                              child: CustomTextMedium(
                                "Purification",
                                fontSize: Dimensions.fontSizeLarge,
                                color: ColorResources.toolbarText,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.paddingSizeDefault),
                            child: CustomTextRegular(
                              "${controller.rudrakshaSuggestionsModel.response?.purification}",
                              fontSize: Dimensions.fontSizeDefault,
                              color: ColorResources.black2,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildDivider(),
                    _buildListSection(
                      "Rudraksh",
                      controller.rudrakshaSuggestionsModel.response?.rudraksh,
                      0,
                    ),
                    _buildListSection(
                      "Name",
                      controller.rudrakshaSuggestionsModel.response?.name,
                      1,
                    ),
                    _buildListSection(
                      "Qualities",
                      controller.rudrakshaSuggestionsModel.response?.qualities,
                      0,
                    ),
                    _buildListSection(
                      "Mantra",
                      controller.rudrakshaSuggestionsModel.response?.mantra,
                      1,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorResources.colorTableRowEven,
                        borderRadius:
                            BorderRadius.circular(Dimensions.borderRadiusSmall),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CustomTextMedium(
                                "How to wear",
                                fontSize: Dimensions.fontSizeDefault,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            const Gap(Dimensions.gapSmall),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CustomTextRegular(
                                "${controller.rudrakshaSuggestionsModel.response?.howToWear}",
                                fontSize: Dimensions.fontSizeDefault,
                                color: ColorResources.black2,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            const Gap(Dimensions.gapDefault),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CustomTextMedium(
                                "Time to wear",
                                fontSize: Dimensions.fontSizeDefault,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            const Gap(Dimensions.gapSmall),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CustomTextRegular(
                                "${controller.rudrakshaSuggestionsModel.response?.timeToWear}",
                                fontSize: Dimensions.fontSizeDefault,
                                color: ColorResources.black2,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorResources.colorTableRowOdd,
                        borderRadius: BorderRadius.circular(
                            Dimensions.borderRadiusDefault),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: CustomTextRegular(
                          "${controller.rudrakshaSuggestionsModel.response?.personalizedResponse}",
                          fontSize: Dimensions.fontSizeDefault,
                          color: ColorResources.black2,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (controller.isRudrakshaSuggestionsLoading.isTrue) {
          return ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const SimmerListView();
            },
          );
        } else {
          return const EmptyScreen();
        }
      });
    } else if (activeKundliApi == AppConstants.vedicastro) {
      return Obx(() {
        if (controller.isRudrakshaSuggestionsSuccess.isTrue) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: Dimensions.paddingSizeDefault),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ],
                      color: ColorResources.white,
                      borderRadius:
                          BorderRadius.circular(Dimensions.borderRadiusDefault),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Gap(Dimensions.gapDefault),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeDefault),
                          child: CustomTextMedium(
                            "${controller.kundliRudrakshaSuggestionsVedicAstroModel.response?.name}",
                            fontSize: Dimensions.fontSizeExtraLarge,
                            color: ColorResources.colorPrimary,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        _buildDivider(),
                        Container(
                          decoration: BoxDecoration(
                            color: ColorResources.white,
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        Dimensions.borderRadiusDefault),
                                    topRight: Radius.circular(
                                        Dimensions.borderRadiusDefault),
                                  ),
                                  color: ColorResources.colorPrimary,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.paddingSizeSmall,
                                    horizontal: Dimensions.paddingSizeDefault,
                                  ),
                                  child: CustomTextMedium(
                                    AppStrings.mukhiDescription.tr,
                                    fontSize: Dimensions.fontSizeLarge,
                                    color: ColorResources.toolbarText,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.paddingSizeDefault),
                                child: CustomTextRegular(
                                  "${controller.kundliRudrakshaSuggestionsVedicAstroModel.response?.mukhiDescription}",
                                  fontSize: Dimensions.fontSizeDefault,
                                  color: ColorResources.black2,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildDivider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeDefault),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      )
                                    ],
                                    color: ColorResources.colorTableRowEven,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.borderRadiusDefault),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        Dimensions.paddingSizeDefault),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTextMedium(
                                          AppStrings.mukhiForDisease.tr,
                                          fontSize: Dimensions.fontSizeDefault,
                                        ),
                                        const Gap(Dimensions.gapSmall),
                                        CustomTextRegular(
                                          "${controller.kundliRudrakshaSuggestionsVedicAstroModel.response?.mukhiForDiseaseCure}",
                                          fontSize: Dimensions.fontSizeDefault,
                                          color: ColorResources.black2,
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(Dimensions.gapDefault),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      )
                                    ],
                                    color: ColorResources.colorTableRowOdd,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.borderRadiusDefault),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        Dimensions.paddingSizeDefault),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTextMedium(
                                          AppStrings.mukhiMoney.tr,
                                          fontSize: Dimensions.fontSizeDefault,
                                        ),
                                        const Gap(Dimensions.gapSmall),
                                        CustomTextRegular(
                                          "${controller.kundliRudrakshaSuggestionsVedicAstroModel.response?.mukhiForMoney}",
                                          fontSize: Dimensions.fontSizeDefault,
                                          color: ColorResources.black2,
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        _buildDivider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeDefault),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorResources.colorTableRowEven,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.borderRadiusDefault),
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.paddingSizeDefault),
                              child: CustomTextRegular(
                                "${controller.kundliRudrakshaSuggestionsVedicAstroModel.response?.botResponse}",
                                fontSize: Dimensions.fontSizeDefault,
                                color: ColorResources.black2,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (controller.isRudrakshaSuggestionsLoading.isTrue) {
          return ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const SimmerListView();
            },
          );
        } else {
          return const EmptyScreen();
        }
      });
    }
    // Fallback Widget
    return const Center(
      child: Text('No valid API configuration found.'),
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimensions.gapDefault),
      height: 1,
      child: CustomPaint(
        painter: DashedLinePainter(),
        child: Container(),
      ),
    );
  }

  Widget _buildListSection(String title, List<dynamic>? items, int colorIndex) {
    if (items == null || items.isEmpty) {
      return const SizedBox.shrink();
    }

    // Name section should have full container color (grey)
    final bool isNameSection = title == "Name";
    final Color backgroundColor = isNameSection
        ? ColorResources.colorTableRowOdd
        : (colorIndex % 2 == 0
            ? ColorResources.colorTableRowEven
            : ColorResources.colorTableRowOdd);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusSmall),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextMedium(
              "$title:",
              fontSize: Dimensions.fontSizeDefault,
              textAlign: TextAlign.left,
            ),
            const Gap(Dimensions.gapSmall),
            ...items.asMap().entries.map((entry) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom:
                      entry.key < items.length - 1 ? Dimensions.gapSmall : 0,
                ),
                child: CustomTextRegular(
                  entry.value.toString(),
                  fontSize: Dimensions.fontSizeDefault,
                  color: ColorResources.black2,
                  textAlign: TextAlign.left,
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..strokeWidth = 1;

    const double dashWidth = 5;
    const double dashSpace = 3;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
