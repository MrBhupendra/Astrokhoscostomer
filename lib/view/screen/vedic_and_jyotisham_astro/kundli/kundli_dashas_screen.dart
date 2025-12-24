import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import '../controller/kundli_controller.dart';
import '../model/vedic_data.dart';
import '../widget/current_mahadasha_widget.dart';

class KundliDashaScreen extends StatelessWidget {
  final KundliData data;

  KundliDashaScreen(this.data, {super.key});

  final KundliController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.dashaSelectedType.value = "Current Mahadasha";
    controller.getMahaDasha(data);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(5),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child:   Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => GestureDetector(
                    onTap: () {
                      controller.dashaSelectedType.value = "Current Mahadasha";
                      controller.getMahaDasha(data);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(Dimensions.marginSizeSmall),
                      decoration: BoxDecoration(
                          color: controller.dashaSelectedType.value ==
                              "Current Mahadasha"
                              ? ColorResources.colorPrimary
                              : ColorResources.white,
                          borderRadius: BorderRadius.circular(
                              Dimensions.borderRadiusSmall),
                          border: Border.all(
                              width: 1, color: ColorResources.colorPrimary)),
                      child: Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.paddingSizeExtraSmall),
                        child: CustomTextRegular(
                          "Current Mahadasha",

                          color: controller.dashaSelectedType.value ==
                              "Current Mahadasha"
                              ? ColorResources
                              .toolbarText // Set text color to white when selected
                              : ColorResources.black,


                        ),
                      ),
                    ),
                  )),
                  Obx(() => GestureDetector(
                    onTap: () {
                      controller.dashaSelectedType.value =
                      "Specific Dasha";
                      controller.getSpecificDasha(data, "", "", "", "", "mahadasha");
                    },
                    child: Container(
                      margin:
                      const EdgeInsets.all(Dimensions.marginSizeSmall),
                      decoration: BoxDecoration(
                          color: controller.dashaSelectedType.value ==
                              "Specific Dasha"
                              ? ColorResources.colorPrimary
                              : ColorResources.white,
                          borderRadius: BorderRadius.circular(
                              Dimensions.borderRadiusSmall),
                          border: Border.all(
                              width: 1, color: ColorResources.colorPrimary)),
                      child: Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.paddingSizeExtraSmall),
                        child: CustomTextRegular(
                          "Specific Dasha",
                          color: controller.dashaSelectedType.value ==
                              "Specific Dasha"
                              ? ColorResources
                              .white // Set text color to white when selected
                              : ColorResources.black,
                        ),
                      ),
                    ),
                  )),
                  Obx(() => GestureDetector(
                    onTap: () {
                      controller.dashaSelectedType.value = "Mahadasha Full";
                      controller.getCurrentMahaDashaFull(data);
                    },
                    child: Container(
                      margin:
                      const EdgeInsets.all(Dimensions.marginSizeSmall),
                      decoration: BoxDecoration(
                          color: controller.dashaSelectedType.value == "Mahadasha Full"
                              ? ColorResources.colorPrimary
                              : ColorResources.white,
                          borderRadius: BorderRadius.circular(
                              Dimensions.borderRadiusSmall),
                          border: Border.all(
                              width: 1, color: ColorResources.colorPrimary)),
                      child: Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.paddingSizeExtraSmall),
                        child: CustomTextRegular(
                          "Mahadasha Full",
                          color: controller.dashaSelectedType.value ==
                              "Mahadasha Full"
                              ? ColorResources
                              .white // Set text color to white when selected
                              : ColorResources.black,
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
            Obx(
              () {
                if (controller.isDashaSuccess.isTrue) {
                  return controller.dashaSelectedType.value == "Current Mahadasha"
                      ? _widgetMahadasha()
                      : controller.dashaSelectedType.value == "Specific Dasha"
                      ?  _widgetSpecificDasha()
                      : _widgetMahadashaFull();
                } else if (controller.isDashaLoading.value) {
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
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetMahadasha() {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      child: Column(
        children: [
          const Gap(Dimensions.gapDefault),
          CustomTextMedium(
            AppStrings.currentMahadasha.tr,
            fontSize: Dimensions.fontSizeExtraLarge,
          ),

          const Gap(Dimensions.gapDefault),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomTextMedium(
                AppStrings.mahadasha.tr,
                color: ColorResources.colorPrimaryDark,
                fontSize: Dimensions.fontSizeLarge,
              ),
            ],
          ),
          const Gap(Dimensions.gapExtraSmall),
          CurrentMahadasha(
            name: "${controller.mahadashaModel.response?.mahadasha?.name}",
            start: "${controller.mahadashaModel.response?.mahadasha?.start}",
            end: "${controller.mahadashaModel.response?.mahadasha?.end}",
            isForward: false,
          ),

          const Gap(Dimensions.gapDefault),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomTextMedium(
                AppStrings.antardasha.tr,
                color: ColorResources.colorPrimaryDark,
                fontSize: Dimensions.fontSizeLarge,
              ),
            ],
          ),
          const Gap(Dimensions.gapExtraSmall),
          CurrentMahadasha(
            name: "${controller.mahadashaModel.response?.antardasha?.name}",
            start: "${controller.mahadashaModel.response?.antardasha?.start}",
            end: "${controller.mahadashaModel.response?.antardasha?.end}",
            isForward: false,
          ),

          const Gap(Dimensions.gapDefault),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomTextMedium(
                AppStrings.paryantardasha.tr,
                color: ColorResources.colorPrimaryDark,
                fontSize: Dimensions.fontSizeLarge,
              ),
            ],
          ),
          const Gap(Dimensions.gapExtraSmall),
          CurrentMahadasha(
            name: "${controller.mahadashaModel.response?.paryantardasha?.name}",
            start:
                "${controller.mahadashaModel.response?.paryantardasha?.start}",
            end: "${controller.mahadashaModel.response?.paryantardasha?.end}",
            isForward: false,
          ),

          const Gap(Dimensions.gapDefault),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomTextMedium(
                AppStrings.shookshamadasha.tr,
                color: ColorResources.colorPrimaryDark,
                fontSize: Dimensions.fontSizeLarge,
              ),
            ],
          ),
          const Gap(Dimensions.gapExtraSmall),
          CurrentMahadasha(
            name:
                "${controller.mahadashaModel.response?.shookshamadasha?.name}",
            start:
                "${controller.mahadashaModel.response?.shookshamadasha?.start}",
            end: "${controller.mahadashaModel.response?.shookshamadasha?.end}",
            isForward: false,
          ),

          const Gap(Dimensions.gapDefault),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomTextMedium(
                AppStrings.pranadasha.tr,
                color: ColorResources.colorPrimaryDark,
                fontSize: Dimensions.fontSizeLarge,
              ),
            ],
          ),
          const Gap(Dimensions.gapExtraSmall),
          CurrentMahadasha(
            name: "${controller.mahadashaModel.response?.pranadasha?.name}",
            start: "${controller.mahadashaModel.response?.pranadasha?.start}",
            end: "${controller.mahadashaModel.response?.pranadasha?.end}",
            isForward: false,
          ),

          const Gap(Dimensions.gapOverLarge),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextMedium(
                AppStrings.orderDashas.tr,
                fontSize: Dimensions.fontSizeExtraLarge,
              ),
            ],
          ),

          const Gap(Dimensions.gapDefault),
          CurrentMahadasha(
            name: "${controller.mahadashaModel.response?.orderOfDashas?.major?.name}",
            start: "${controller.mahadashaModel.response?.orderOfDashas?.major?.start}",
            end: "${controller.mahadashaModel.response?.orderOfDashas?.major?.end}",
            isForward: false,
          ),
          const Gap(Dimensions.gapDefault),
          CurrentMahadasha(
            name: "${controller.mahadashaModel.response?.orderOfDashas?.minor?.name}",
            start: "${controller.mahadashaModel.response?.orderOfDashas?.minor?.start}",
            end: "${controller.mahadashaModel.response?.orderOfDashas?.minor?.end}",
            isForward: false,
          ),
          const Gap(Dimensions.gapDefault),
          CurrentMahadasha(
            name: "${controller.mahadashaModel.response?.orderOfDashas?.subMinor?.name}",
            start: "${controller.mahadashaModel.response?.orderOfDashas?.subMinor?.start}",
            end: "${controller.mahadashaModel.response?.orderOfDashas?.subMinor?.end}",
            isForward: false,
          ),
          const Gap(Dimensions.gapDefault),
          CurrentMahadasha(
            name: "${controller.mahadashaModel.response?.orderOfDashas?.subSubMinor?.name}",
            start: "${controller.mahadashaModel.response?.orderOfDashas?.subSubMinor?.start}",
            end: "${controller.mahadashaModel.response?.orderOfDashas?.subSubMinor?.end}",
            isForward: false,
          ),
        ],
      ),
    );
  }

  Widget _widgetSpecificDasha() {
    String show = "mahadasha";
    String? selectedMahadasha;
    String? selecteAntardasha;
    String? selecteParyantardasha;
    String? selecteShookshamadasha;
    // controller.getSpecificDasha(data, "", "", "", "", show);
    return Obx(
          () {
        if (controller.isMahaDashaLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        else if (controller.mahadashaSuccess.value) {
          return Visibility(
            visible: show == "mahadasha",
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: Column(
                children: [
                  const Gap(15),
                  CustomTextMedium(
                    AppStrings.mahadasha.tr,
                    fontSize: Dimensions.fontSizeExtraLarge,
                  ),
                  const Gap(Dimensions.gapDefault),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                    controller.dashaMahadasha.response!.mahadasha?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:
                        const EdgeInsets.only(top:  Dimensions.paddingSizeDefault),
                        child: GestureDetector(
                          onTap: () {
                            selectedMahadasha = controller.dashaMahadasha.response!.mahadasha![index].name.toString();
                            show = "antardasha";
                            controller.getSpecificDasha(
                                data,
                                selectedMahadasha,
                                "",
                                "",
                                "",
                                show);
                          },

                          child:CurrentMahadasha(
                            name: controller.dashaMahadasha.response!.mahadasha![index].name.toString(),
                            start: controller.dashaMahadasha.response!.mahadasha![index].start.toString(),
                            end: controller.dashaMahadasha.response!.mahadasha![index].end.toString(),
                            isForward: true,
                          ) ,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        }
        else if (controller.antardashaSuccess.value) {
          return Visibility(
            visible: show == "antardasha",
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: Column(
                children: [
                  const Gap(15),
                  CustomTextMedium(
                    AppStrings.antardasha.tr,
                    fontSize: Dimensions.fontSizeExtraLarge,
                  ),
                  const Gap(Dimensions.gapDefault),
                  GestureDetector(
                    onTap: (){
                      show = "mahadasha";
                      controller.antardashaSuccess(false);
                      controller.mahadashaSuccess(true);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_circle_left_rounded),
                        const Gap(5),
                        CustomTextMedium(
                          AppStrings.mahadasha.tr,
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.dashaAntardasha.response!.antardasha?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top:  Dimensions.paddingSizeSmall),
                        child: GestureDetector(
                          onTap: () {
                            selecteAntardasha = controller.dashaAntardasha
                                .response!.antardasha![index].name
                                .toString();
                            show = "paryatnadasha";
                            controller.getSpecificDasha(data, selectedMahadasha,
                                selecteAntardasha, "", "", show);
                          },
                          child:CurrentMahadasha(
                            name: controller.dashaAntardasha.response!.antardasha![index].name.toString(),
                            start:  controller.dashaAntardasha.response!.antardasha![index].start.toString(),
                            end: controller.dashaAntardasha.response!.antardasha![index].end.toString(),
                            isForward: true,
                          ),

                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        }
        else if (controller.paryantardashaSuccess.value) {
          return Visibility(
            visible: show == "paryatnadasha",
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: Column(
                children: [
                  const Gap(15),
                  CustomTextMedium(
                    AppStrings.paryantardasha.tr,
                    fontSize: Dimensions.fontSizeExtraLarge,
                  ),
                  GestureDetector(
                    onTap: (){
                      show = "antardasha";
                      controller.mahadashaSuccess(false);
                      controller.paryantardashaSuccess(false);
                      controller.antardashaSuccess(true);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_circle_left_rounded),
                        const Gap(5),
                        CustomTextMedium(
                          AppStrings.antardasha.tr,
                        ),
                      ],
                    ),
                  ),
                  const Gap(Dimensions.gapDefault),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount:
                    controller.dashaParyantardasha.response!.paryantardasha?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:
                        const EdgeInsets.only(top:  Dimensions.paddingSizeSmall),
                        child: GestureDetector(
                          onTap: () {
                            selecteParyantardasha = controller.dashaParyantardasha.response!.paryantardasha![index].name
                                .toString();
                            show = "shookshamadasha";
                            controller.getSpecificDasha(data, selectedMahadasha,
                                selecteAntardasha, selecteParyantardasha, "", show);
                          },
                          child:CurrentMahadasha(
                            name:  controller.dashaParyantardasha.response!.paryantardasha![index].name.toString(),
                            start: controller.dashaParyantardasha.response!.paryantardasha![index].start.toString(),
                            end: controller.dashaParyantardasha.response!.paryantardasha![index].end.toString(),
                            isForward: true,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        }
        else if (controller.shookshamadashaSuccess.value) {
          return Visibility(
            visible: show == "shookshamadasha",
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: Column(
                children: [
                  const Gap(15),
                  CustomTextMedium(
                    AppStrings.shookshamadasha.tr,
                    fontSize: Dimensions.fontSizeExtraLarge,
                  ),
                  const Gap(Dimensions.gapDefault),
                  GestureDetector(
                    onTap: (){
                      show = "paryatnadasha";
                      controller.mahadashaSuccess(false);
                      controller.antardashaSuccess(false);
                      controller.shookshamadashaSuccess(false);
                      controller.paryantardashaSuccess(true);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_circle_left_rounded),
                        const Gap(5),
                        CustomTextMedium(
                          AppStrings.paryantardasha.tr,
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true, physics: BouncingScrollPhysics(),
                    itemCount: controller.dashaShookshamadasha.response!.shookshamadasha?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:
                        const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                        child: GestureDetector(
                          onTap: () {
                            selecteShookshamadasha = controller.dashaShookshamadasha.response!.shookshamadasha![index].name
                                .toString();
                            show = "pranadasha";
                            controller.getSpecificDasha(data, selectedMahadasha,
                                selecteAntardasha, selecteParyantardasha, selecteShookshamadasha, show);
                          },
                          child:CurrentMahadasha(
                            name: controller.dashaShookshamadasha.response!.shookshamadasha![index].name.toString(),
                            start: controller.dashaShookshamadasha.response!.shookshamadasha![index].start.toString(),
                            end: controller.dashaShookshamadasha.response!.shookshamadasha![index].end.toString(),
                            isForward: true,
                          ),

                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        }
        else if (controller.pranadashaSuccess.value) {
          return Visibility(
            visible: show == "pranadasha",
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: Column(
                children: [
                  const Gap(15),
                  CustomTextMedium(
                    AppStrings.pranadasha.tr,
                    fontSize: Dimensions.fontSizeExtraLarge,
                  ),
                  const Gap(Dimensions.gapDefault),
                  GestureDetector(
                    onTap: (){
                      show = "shookshamadasha";
                      controller.mahadashaSuccess(false);
                      controller.antardashaSuccess(false);
                      controller.paryantardashaSuccess(false);
                      controller.pranadashaSuccess(false);
                      controller.shookshamadashaSuccess(true);
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_circle_left_rounded),
                        const Gap(5),
                        CustomTextMedium(
                          AppStrings.shookshamadasha.tr,
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount:
                    controller.dashaPranadasha.response!.pranadasha?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding:
                        const EdgeInsets.only(top: Dimensions.paddingSizeSmall),

                        child:CurrentMahadasha(
                          name: controller.dashaPranadasha.response!.pranadasha![index].name.toString(),
                          start: controller.dashaPranadasha.response!.pranadasha![index].start.toString(),
                          end: controller.dashaPranadasha.response!.pranadasha![index].end.toString(),
                          isForward: false,
                        ),

                      );
                    },
                  )
                ],
              ),
            ),
          );
        }
        else {
          return Center(
            child: Column(
              children: [
                const Gap(100),
                Text(
                  AppStrings.noRecordFound.tr,
                )
              ],
            ),
          );
        }
      },
    );
  }

  Widget _widgetMahadashaFull() {
    return Obx(() {
      if (controller.isCurrentMahaDashaFullLoading.isTrue) {
        return const Center(child: CircularProgressIndicator());
      } else if (controller.isCurrentMahaDashaFullSuccess.isTrue) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Gap(Dimensions.gapDefault),
              CustomTextMedium(
                AppStrings.currentMahadashaFull.tr,
                fontSize: Dimensions.fontSizeExtraLarge,
              ),
              const Gap(Dimensions.gapDefault),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextMedium(
                    AppStrings.mahadasha.tr,
                    color: ColorResources.colorPrimaryDark,
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                ],
              ),
              const Gap(Dimensions.gapDefault),
              ListView.builder(
                  itemCount:
                  controller.mahadashafullModel.response?.mahadasha?.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: Dimensions.paddingSizeDefault),
                      child: Container(
                        // Set the width as needed
                        // Set the height as needed
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              )
                            ],
                            border: Border.all(
                              color: ColorResources.colorPrimary,
                              width: 1.0,
                            ),
                            color: ColorResources.colorPrimaryLight,
                            // Background color
                            borderRadius: const BorderRadius.all(
                              Radius.circular(Dimensions
                                  .borderRadiusDefault), // Adjust the radius as needed
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.paddingSizeExtraSmall),
                            child: Row(
                              children: [
                                CustomTextMedium(
                                  controller.mahadashafullModel.response!
                                      .mahadasha![index].name
                                      .toString(),
                                ),
                                const Gap(Dimensions.gapExtraOverLarge),
                                Expanded(
                                  child: Column(
                                    children: [
                                      CustomTextRegular(
                                        controller.mahadashafullModel.response!
                                            .mahadasha![index].start
                                            .toString(),
                                      ),
                                      CustomTextRegular(
                                        controller.mahadashafullModel.response!
                                            .mahadasha![index].end
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                    );
                  }),
              const Gap(Dimensions.gapDefault),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextMedium(
                    AppStrings.antardasha.tr,
                    color: ColorResources.colorPrimaryDark,
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                ],
              ),
              const Gap(Dimensions.gapDefault),
              ListView.builder(
                  itemCount: controller
                      .mahadashafullModel.response?.antardasha?.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: Dimensions.paddingSizeDefault),
                      child: Container(
                        // Set the width as needed
                        // Set the height as needed
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              )
                            ],
                            border: Border.all(
                              color: ColorResources.colorPrimary,
                              width: 1.0,
                            ),
                            color: ColorResources.colorPrimaryLight,
                            // Background color
                            borderRadius: const BorderRadius.all(
                              Radius.circular(Dimensions
                                  .borderRadiusDefault), // Adjust the radius as needed
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.paddingSizeExtraSmall),
                            child: Row(
                              children: [
                                CustomTextMedium(
                                  controller.mahadashafullModel.response!
                                      .antardasha![index].name
                                      .toString(),
                                ),
                                const Gap(Dimensions.gapExtraOverLarge),
                                Expanded(
                                  child: Column(
                                    children: [
                                      CustomTextRegular(
                                        controller.mahadashafullModel.response!
                                            .antardasha![index].start
                                            .toString(),
                                      ),
                                      CustomTextRegular(
                                        controller.mahadashafullModel.response!
                                            .antardasha![index].end
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextMedium(
                    AppStrings.paryantardasha.tr,
                    color: ColorResources.colorPrimaryDark,
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                ],
              ),
              const Gap(Dimensions.gapDefault),
              ListView.builder(
                  itemCount: controller
                      .mahadashafullModel.response?.paryantardasha?.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: Dimensions.paddingSizeDefault),
                      child: Container(
                        // Set the width as needed
                        // Set the height as needed
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              )
                            ],
                            border: Border.all(
                              color: ColorResources.colorPrimary,
                              width: 1.0,
                            ),
                            color: ColorResources.colorPrimaryLight,
                            // Background color
                            borderRadius: const BorderRadius.all(
                              Radius.circular(Dimensions
                                  .borderRadiusDefault), // Adjust the radius as needed
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.paddingSizeExtraSmall),
                            child: Row(
                              children: [
                                CustomTextMedium(
                                  controller.mahadashafullModel.response!
                                      .paryantardasha![index].name
                                      .toString(),
                                ),
                                const Gap(Dimensions.gapExtraOverLarge),
                                Expanded(
                                  child: Column(
                                    children: [
                                      CustomTextRegular(
                                        controller.mahadashafullModel.response!
                                            .paryantardasha![index].start
                                            .toString(),
                                      ),
                                      CustomTextRegular(
                                        controller.mahadashafullModel.response!
                                            .paryantardasha![index].end
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextMedium(
                    AppStrings.shookshamadasha.tr,
                    color: ColorResources.colorPrimaryDark,
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                ],
              ),
              const Gap(Dimensions.gapDefault),
              ListView.builder(
                  itemCount: controller
                      .mahadashafullModel.response?.shookshamadasha?.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: Dimensions.paddingSizeDefault),
                      child: Container(
                        // Set the width as needed
                        // Set the height as needed
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              )
                            ],
                            border: Border.all(
                              color: ColorResources.colorPrimary,
                              width: 1.0,
                            ),
                            color: ColorResources.colorPrimaryLight,
                            // Background color
                            borderRadius: const BorderRadius.all(
                              Radius.circular(Dimensions
                                  .borderRadiusDefault), // Adjust the radius as needed
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.paddingSizeExtraSmall),
                            child: Row(
                              children: [
                                CustomTextMedium(
                                  controller.mahadashafullModel.response!
                                      .shookshamadasha![index].name
                                      .toString(),
                                ),
                                const Gap(Dimensions.gapExtraOverLarge),
                                Expanded(
                                  child: Column(
                                    children: [
                                      CustomTextRegular(
                                        controller.mahadashafullModel.response!
                                            .shookshamadasha![index].start
                                            .toString(),
                                      ),
                                      CustomTextRegular(
                                        controller.mahadashafullModel.response!
                                            .shookshamadasha![index].end
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextMedium(
                    AppStrings.pranadasha.tr,
                    color: ColorResources.colorPrimaryDark,
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                ],
              ),
              const Gap(Dimensions.gapDefault),
              ListView.builder(
                  itemCount: controller
                      .mahadashafullModel.response?.pranadasha?.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: Dimensions.paddingSizeDefault),
                      child: Container(
                        // Set the width as needed
                        // Set the height as needed
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              )
                            ],
                            border: Border.all(
                              color: ColorResources.colorPrimary,
                              width: 1.0,
                            ),
                            color: ColorResources.colorPrimaryLight,
                            // Background color
                            borderRadius: const BorderRadius.all(
                              Radius.circular(Dimensions
                                  .borderRadiusDefault), // Adjust the radius as needed
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.paddingSizeExtraSmall),
                            child: Row(
                              children: [
                                CustomTextMedium(
                                  controller.mahadashafullModel.response!
                                      .pranadasha![index].name
                                      .toString(),
                                ),
                                const Gap(Dimensions.gapExtraOverLarge),
                                Expanded(
                                  child: Column(
                                    children: [
                                      CustomTextRegular(
                                        controller.mahadashafullModel.response!
                                            .pranadasha![index].start
                                            .toString(),
                                      ),
                                      CustomTextRegular(
                                        controller.mahadashafullModel.response!
                                            .pranadasha![index].end
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                    );
                  }),
            ],
          ),
        );
      } else {
        return const EmptyScreen();
      }
    });
  }

}
