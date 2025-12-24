import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utill/app_constants.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/images.dart';
import '../../../../utill/shared_preference.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/custom_text_regular.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import '../../searchPlace/search_place_screen.dart';
import '../widget/custom_table_two_row_widget.dart';
import '../controller/panchang_controller.dart';

class PanchangDetailScreen extends StatelessWidget {
  PanchangDetailScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final PanchangController controller = Get.put(PanchangController());
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _birthPlaceController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.getPanchang();
    // final List<String> languages = ['en', 'hi', 'ta','ka', 'te','ml','be','sp','fr'];
    final List<String> languages = ['en', 'hi', 'ta', 'ka', 'te', 'ml', 'be', 'sp', 'fr'];
    final Map<String, String> languageNames = {
      'en': 'English',
      'hi': 'Hindi',
      'ta': 'Tamil',
      'ka': 'Kannada',
      'te': 'Telugu',
      'ml': 'Malayalam',
      'be': 'Bengali',
      'sp': 'Spanish',
      'fr': 'French',
    };
    return SafeArea(
      child: Scaffold(
        // appBar: CustomAppBar(title: AppStrings.panchang.tr),
        appBar: AppBar(backgroundColor: ColorResources.colorPrimary,
          title: CustomTextRegular(
            AppStrings.panchang.tr,
            fontSize: 16,
            color: ColorResources.toolbarText,
            maxLines: 1,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 18,
              color: ColorResources.toolbarText,), // Replace with your desired icon and color
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            Row(
              children: [
                Image.asset(
                  Images.language,
                  height: 16,
                  color: ColorResources.toolbarText,
                ),
                const Gap(5),
                Obx(() => DropdownButton(
                  dropdownColor: ColorResources.colorPrimaryLight,
                  iconEnabledColor: ColorResources.toolbarText,
                  value: controller.selectedLanguage.value,
                  items: languages.map((String lang) {
                    bool isSelected = controller.selectedLanguage.value == lang;
                    return DropdownMenuItem(
                      value: lang,
                      child: Container(
                        color: isSelected ? ColorResources.colorPrimary : Colors.transparent,
                        padding: EdgeInsets.symmetric(vertical: isSelected ? 4.0 : 0,horizontal: isSelected ? 4.0 : 0),
                        child: CustomTextRegular(
                          languageNames[lang] ?? lang,
                          color: isSelected ? ColorResources.toolbarText : Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newLanguage) {
                    print(newLanguage);
                    if (newLanguage != null) {
                      controller.selectedLanguage.value = newLanguage;
                      controller.getPanchang(language: newLanguage);
                      // controller.selectedLanguage.value = newLanguage;
                      // // Update language in SharedPreferences or storage mechanism
                      // SharedPreferencesHelper.saveData(newLanguage, AppConstants.appLanguage);
                      // // Call API with new language
                      // controller.getPanchang();
                    }
                  },
                )),
              ],
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Obx(
                () {
              if (controller.isPanchangLoading.value) {
                return ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const SimmerListView();
                  },
                );
              } else if (controller.isPanchangSuccess.isTrue) {

                return  Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Form(
                          key: _formKey,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    String? placeApiKey = await SharedPreferencesHelper.getData(AppConstants.placeApiKey);
                                    var result = await Get.to(SearchPlaceScreen(placeApiKey.toString()));
                                    if (result != null) {
                                      _birthPlaceController.text = result['name'].toString();
                                      _latitudeController.text = result['latitude'].toString();
                                      _longitudeController.text = result['longitude'].toString();
                                    }
                                  },
                                  child: TextFormField(
                                    controller: _birthPlaceController,
                                    style: const TextStyle(color: ColorResources.black1,
                                        fontSize: Dimensions.fontSizeDefault),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(0.0),
                                      filled: true,
                                      fillColor: ColorResources.colorPrimaryLight,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: 'Select place',
                                      hintStyle: const TextStyle(
                                          fontSize: Dimensions.fontSizeDefault,
                                          color: ColorResources.black1),
                                      prefixIcon: const Icon(
                                        CupertinoIcons.building_2_fill,
                                        color: ColorResources.black4,
                                        size: 20,
                                      ),
                                      enabled: false,
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppStrings.formError.tr;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              const Gap(2),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    showDatePickerDialog(context,_birthDateController);
                                  },
                                  child: TextFormField(
                                    controller: _birthDateController,
                                    style: const TextStyle(
                                        color: ColorResources.black1,
                                        fontSize: Dimensions.fontSizeDefault),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(left: 0.0),
                                      filled: true,
                                      fillColor: ColorResources.colorPrimaryLight,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: 'Select date',
                                      hintStyle: const TextStyle(
                                          fontSize: Dimensions.fontSizeDefault,
                                          color: ColorResources.black1),
                                      enabled: false,
                                      prefixIcon: const Icon(
                                        CupertinoIcons.calendar,
                                        color: ColorResources.black4,
                                        size: 20,
                                      ),

                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppStrings.formError.tr;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              const Gap(2),
                              GestureDetector(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      String formattedDate;
                                      try {
                                        formattedDate = DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy').parse(_birthDateController.text));
                                      } catch (e) {
                                        formattedDate = DateTime.now().toString();
                                      }
                                      controller.getPanchang(
                                          latitude: _latitudeController.text,
                                          longitude: _longitudeController.text,
                                          date: formattedDate,
                                          language: controller.selectedLanguage.value
                                      );
                                    }
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                          color: ColorResources.colorPrimaryLight,
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                      child: const Icon(Icons.search,size: 18)))
                            ],
                          ),
                        ),
                      ),
                      const Gap(Dimensions.gapExtraLarge),
                      Column(
                        children: [
                          CustomTextMedium(
                            "${controller.panchangModel.response?.date}",
                            textAlign: TextAlign.center,
                            color: ColorResources.colorPrimary,
                            fontSize: Dimensions.fontSizeLarge,
                          ),
                          const SizedBox(height: Dimensions.gapExtraSmall),
                          CustomTextMedium(
                            "${controller.panchangModel.response?.rasi?.name}",
                            textAlign: TextAlign.center,
                            color: ColorResources.colorPrimary,
                            fontSize: Dimensions.fontSizeLarge,
                          ),
                          const SizedBox(height: Dimensions.gapExtraSmall),
                          // start
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorResources.colorPrimaryLight,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2),
                                      )
                                    ],
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(Images.panchangSun, width: 30),
                                        const Gap(Dimensions.gapDefault),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomTextRegular("${controller.panchangModel.response?.advancedDetails?.sunRise}", fontSize: Dimensions.fontSizeSmall),
                                              CustomTextRegular("${controller.panchangModel.response?.advancedDetails?.sunSet}", fontSize: Dimensions.fontSizeSmall),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(Dimensions.gapLarge),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorResources.colorPrimaryLight,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2),
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(Images.panchangMoon, width: 25),
                                        const Gap(Dimensions.gapDefault),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomTextRegular("${controller.panchangModel.response?.advancedDetails?.moonRise}", fontSize: Dimensions.fontSizeSmall),
                                              CustomTextRegular("${controller.panchangModel.response?.advancedDetails?.moonSet}", fontSize: Dimensions.fontSizeSmall),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // end
                          const Gap(Dimensions.gapLarge),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorResources.colorPrimaryLight,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomTextRegular(AppStrings.nextFullMoon.tr),
                                      const SizedBox(width: Dimensions.gapDefault),
                                      Expanded(
                                        child: CustomTextRegular("${controller.panchangModel.response?.advancedDetails?.nextFullMoon}", fontSize: Dimensions.fontSizeSmall),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: Dimensions.gapDefault),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomTextRegular(AppStrings.nextNewMoon.tr),
                                      const SizedBox(width: Dimensions.gapDefault),
                                      Expanded(
                                        child: CustomTextRegular("${controller.panchangModel.response?.advancedDetails?.nextNewMoon}", fontSize: Dimensions.fontSizeSmall),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: Dimensions.gapDefault),
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(color: ColorResources.colorPrimary, width: 0.5),
                                        bottom: BorderSide(color: ColorResources.colorPrimary, width: 0.5),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        const SizedBox(height: Dimensions.gapExtraSmall),
                                        CustomTextMedium(
                                          AppStrings.abhijitMuhurta.tr,
                                        ),
                                        const Gap(5),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomTextRegular(AppStrings.startMuhurta.tr),
                                            const SizedBox(width: Dimensions.gapSmall),
                                            Expanded(child: CustomTextRegular("${controller.panchangModel.response?.advancedDetails?.abhijitMuhurta?.start}", fontSize: Dimensions.fontSizeSmall)),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomTextRegular(AppStrings.endMuhurta.tr),
                                            const SizedBox(width: Dimensions.gapSmall),
                                            Expanded(child: CustomTextRegular("${controller.panchangModel.response?.advancedDetails?.abhijitMuhurta?.end}", fontSize: Dimensions.fontSizeSmall)),
                                          ],
                                        ),
                                        const SizedBox(height: Dimensions.gapExtraSmall),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: Dimensions.gapDefault),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomTextRegular(AppStrings.vaara.tr),
                                      const SizedBox(width: Dimensions.gapSizeFifty),
                                      Expanded(
                                        child: CustomTextRegular("${controller.panchangModel.response?.advancedDetails?.vaara}", fontSize: Dimensions.fontSizeSmall),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomTextRegular(AppStrings.dishaShool.tr),
                                      const SizedBox(width: Dimensions.gapLarge),
                                      Expanded(
                                        child: CustomTextRegular("${controller.panchangModel.response?.advancedDetails?.dishaShool}", fontSize: Dimensions.fontSizeSmall),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomTextRegular(AppStrings.rahukaal.tr,),
                                      const SizedBox(width: Dimensions.gapOverLarge),
                                      Expanded(
                                        child: CustomTextRegular("${controller.panchangModel.response?.rahukaal}", fontSize: Dimensions.fontSizeSmall),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomTextRegular(AppStrings.gulika.tr,),
                                      const SizedBox(width: Dimensions.gapSizeFifty),
                                      Expanded(
                                        child: CustomTextRegular("${controller.panchangModel.response?.gulika}", fontSize: Dimensions.fontSizeSmall),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomTextRegular(AppStrings.yamakanto.tr,),
                                      const SizedBox(width: Dimensions.gapLarge),
                                      Expanded(
                                        child: CustomTextRegular("${controller.panchangModel.response?.yamakanta}", fontSize: Dimensions.fontSizeSmall),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Gap(Dimensions.gapDefault),
                      // code by sunil
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          decoration:  BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              CustomTableTwoRowWidget(
                                  title: AppStrings.sakaSamvaatName.tr,
                                  data: "${controller.panchangModel.response?.advancedDetails?.years?.sakaSamvaatName}",
                                  color: ColorResources.colorPrimaryLight
                              ),
                              CustomTableTwoRowWidget(
                                  title: AppStrings.ayana.tr,
                                  data: "${controller.panchangModel.response?.advancedDetails?.masa?.ayana}",
                                  color: ColorResources.colorTableRow
                              ),
                              CustomTableTwoRowWidget(
                                  title: AppStrings.ritu.tr,
                                  data: "${controller.panchangModel.response?.advancedDetails?.masa?.ritu}",
                                  color: ColorResources.colorPrimaryLight
                              ),
                              CustomTableTwoRowWidget(
                                  title: AppStrings.adhikMaasa.tr,
                                  data: "${controller.panchangModel.response?.advancedDetails?.masa?.adhikMaasa}",
                                  color: ColorResources.colorTableRow
                              ),
                              CustomTableTwoRowWidget(
                                  title: AppStrings.paksha.tr,
                                  data: "${controller.panchangModel.response?.advancedDetails?.masa?.paksha}",
                                  color: ColorResources.colorPrimaryLight
                              ),
                              CustomTableTwoRowWidget(
                                  title: AppStrings.tithi.tr,
                                  data: "${controller.panchangModel.response?.tithi?.name}",
                                  color: ColorResources.colorTableRow
                              ),
                              CustomTableTwoRowWidget(
                                  title: AppStrings.nakshatra.tr,
                                  data: "${controller.panchangModel.response?.nakshatra?.name}",
                                  color: ColorResources.colorPrimaryLight
                              ),

                            ],
                          ),
                        ),
                      ),

                      const Gap(Dimensions.gapDefault),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTextMedium(AppStrings.tithi.tr,color: ColorResources.black1,fontSize: Dimensions.fontSizeLarge,),
                        ],
                      ),
                      const Gap(Dimensions.gapDefault),
                      Container(
                        decoration:  BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            CustomTableTwoRowWidget(
                                title: AppStrings.tithi.tr,
                                data: "${controller.panchangModel.response?.tithi?.name}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.tithiNumber.tr,
                                data: "${controller.panchangModel.response?.tithi?.number}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.nextTithi.tr,
                                data: "${controller.panchangModel.response?.tithi?.nextTithi}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.tithiType.tr,
                                data: "${controller.panchangModel.response?.tithi?.type}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.tithiDiety.tr,
                                data: "${controller.panchangModel.response?.tithi?.diety}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.tithiStart.tr,
                                data: "${controller.panchangModel.response?.tithi?.start}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.tithiEnd.tr,
                                data: "${controller.panchangModel.response?.tithi?.end}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.tithiMeaning.tr,
                                data: "${controller.panchangModel.response?.tithi?.meaning}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title:AppStrings.tithiSpecial.tr,
                                data: "${controller.panchangModel.response?.tithi?.special}",
                                color: ColorResources.colorPrimaryLight
                            ),

                          ],
                        ),
                      ),
                      const Gap(Dimensions.gapDefault),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTextMedium(AppStrings.masa.tr,color: ColorResources.black1,fontSize: Dimensions.fontSizeLarge,),
                        ],
                      ),
                      const Gap(Dimensions.gapDefault),
                      Container(
                        decoration:  BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            CustomTableTwoRowWidget(
                                title: AppStrings.amantaName.tr,
                                data: "${controller.panchangModel.response?.advancedDetails?.masa?.amantaName}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.alternateAmantaName.tr,
                                data: "${controller.panchangModel.response?.advancedDetails?.masa?.alternateAmantaName}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.adhikMaasa.tr,
                                data: "${controller.panchangModel.response?.advancedDetails?.masa?.adhikMaasa}",
                                color: ColorResources.colorPrimaryLight
                            ),

                            CustomTableTwoRowWidget(
                                title: AppStrings.ayana.tr,
                                data: "${controller.panchangModel.response?.advancedDetails?.masa?.ayana}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.purnimantaName.tr,
                                data: "${controller.panchangModel.response?.advancedDetails?.masa?.purnimantaName}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.moonPhase.tr,
                                data: "${controller.panchangModel.response?.advancedDetails?.masa?.moonPhase}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.paksha.tr,
                                data: "${controller.panchangModel.response?.advancedDetails?.masa?.paksha}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.ritu.tr,
                                data: "${controller.panchangModel.response?.advancedDetails?.masa?.ritu}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.rituTamil.tr,
                                data: "${controller.panchangModel.response?.advancedDetails?.masa?.rituTamil}",
                                color: ColorResources.colorPrimaryLight
                            ),

                          ],
                        ),
                      ),
                      const Gap(Dimensions.gapDefault),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTextMedium(AppStrings.nakshatra.tr,color: ColorResources.black1,fontSize: Dimensions.fontSizeLarge,),
                        ],
                      ),
                      const Gap(Dimensions.gapDefault),
                      Container(
                        decoration:  BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            CustomTableTwoRowWidget(
                                title: AppStrings.nakshatra.tr,
                                data: "${controller.panchangModel.response?.nakshatra?.name}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.nakshatraLord.tr,
                                data: "${controller.panchangModel.response?.nakshatra?.lord}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.nakshatraDiety.tr,
                                data: "${controller.panchangModel.response?.nakshatra?.diety}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.nakshatraStartTime.tr,
                                data: "${controller.panchangModel.response?.nakshatra?.start}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.nakshatraEndTime.tr,
                                data: "${controller.panchangModel.response?.nakshatra?.end}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.nextNakshatra.tr,
                                data: "${controller.panchangModel.response?.nakshatra?.nextNakshatra}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.nakshatraNumber.tr,
                                data: "${controller.panchangModel.response?.nakshatra?.number}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.nakshatraMeaning.tr,
                                data: "${controller.panchangModel.response?.nakshatra?.meaning}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.nakshatraSpecial.tr,
                                data: "${controller.panchangModel.response?.nakshatra?.special}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.nakshatraSummary.tr,
                                data: "${controller.panchangModel.response?.nakshatra?.summary}",
                                color: ColorResources.colorTableRow
                            ),

                          ],
                        ),
                      ),
                      const Gap(Dimensions.gapDefault),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTextMedium(AppStrings.years.tr,color: ColorResources.black1,fontSize: Dimensions.fontSizeLarge,),
                        ],
                      ),
                      const Gap(Dimensions.gapDefault),
                      Container(
                        decoration:  BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            CustomTableTwoRowWidget(
                                title: AppStrings.kali.tr,
                                data: "${controller.panchangModel.response?.advancedDetails?.years?.kali}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.saka.tr,
                                data: "${controller.panchangModel.response?.advancedDetails?.years?.saka}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.vikramSamvaat.tr,
                                data: "${controller.panchangModel.response?.advancedDetails?.years?.vikramSamvaat}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.kaliSamvaatNumber.tr,
                                data: "${controller.panchangModel.response?.advancedDetails?.years?.kaliSamvaatNumber}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.kaliSamvaatName.tr,
                                data: "${controller.panchangModel.response?.advancedDetails?.years?.kaliSamvaatName}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.vikramSamvaatNumber.tr,
                                data: "${controller.panchangModel.response?.advancedDetails?.years?.vikramSamvaatNumber}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.vikramSamvaatName.tr,
                                data: "${controller.panchangModel.response?.advancedDetails?.years?.vikramSamvaatName}",
                                color: ColorResources.colorPrimaryLight
                            ),

                            CustomTableTwoRowWidget(
                                title: AppStrings.sakaSamvaatNumber.tr,
                                data: "${controller.panchangModel.response?.advancedDetails?.years?.sakaSamvaatNumber}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.sakaSamvaatName.tr,
                                data: "${controller.panchangModel.response?.advancedDetails?.years?.sakaSamvaatName}",
                                color: ColorResources.colorPrimaryLight
                            ),
                          ],
                        ),
                      ),
                      const Gap(Dimensions.gapDefault),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTextMedium(AppStrings.yoga.tr,color: ColorResources.black1,fontSize: Dimensions.fontSizeLarge,),
                        ],
                      ),
                      const Gap(Dimensions.gapDefault),
                      Container(
                        decoration:  BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            CustomTableTwoRowWidget(
                                title: AppStrings.yoga.tr,
                                data: "${controller.panchangModel.response?.yoga?.name}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.yogaNumber.tr,
                                data: "${controller.panchangModel.response?.yoga?.number}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.yogaStartTime.tr,
                                data: "${controller.panchangModel.response?.yoga?.start}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.yogaEndTime.tr,
                                data: "${controller.panchangModel.response?.yoga?.end}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.nextYoga.tr,
                                data: "${controller.panchangModel.response?.yoga?.nextYoga}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.yogaMeaning.tr,
                                data: "${controller.panchangModel.response?.yoga?.meaning}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.yogaSpecial.tr,
                                data: "${controller.panchangModel.response?.yoga?.special}",
                                color: ColorResources.colorPrimaryLight
                            ),
                          ],
                        ),
                      ),
                      const Gap(Dimensions.gapDefault),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTextMedium(AppStrings.karana.tr,color: ColorResources.black1,fontSize: Dimensions.fontSizeLarge,),
                        ],
                      ),
                      const Gap(Dimensions.gapDefault),
                      Container(
                        decoration:  BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            CustomTableTwoRowWidget(
                                title: AppStrings.karana.tr,
                                data: "${controller.panchangModel.response?.karana?.name}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.karanaNumber.tr,
                                data: "${controller.panchangModel.response?.karana?.number}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.karanaLord.tr,
                                data: "${controller.panchangModel.response?.karana?.lord}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.karanaType.tr,
                                data: "${controller.panchangModel.response?.karana?.type}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.karanaDiety.tr,
                                data: "${controller.panchangModel.response?.karana?.diety}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.karanaStartTime.tr,
                                data: "${controller.panchangModel.response?.karana?.start}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.karanaEndTime.tr,
                                data: "${controller.panchangModel.response?.karana?.end}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.nextKarana.tr,
                                data: "${controller.panchangModel.response?.karana?.nextKarana}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.karanaSpecial.tr,
                                data: "${controller.panchangModel.response?.karana?.special}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.karanaNext.tr,
                                data: "${controller.panchangModel.response?.karana?.nextKarana}",
                                color: ColorResources.colorTableRow
                            ),
                          ],
                        ),
                      ),
                      const Gap(Dimensions.gapDefault),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTextMedium(AppStrings.advancedDetails.tr,color: ColorResources.black1,fontSize: Dimensions.fontSizeLarge,),
                        ],
                      ),
                      const Gap(Dimensions.gapDefault),
                      Container(
                        decoration:  BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            CustomTableTwoRowWidget(
                                title: AppStrings.dayName.tr,
                                data: "${controller.panchangModel.response?.day?.name}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.ayanamsaName.tr,
                                data: "${controller.panchangModel.response?.ayanamsa?.name}",
                                color: ColorResources.colorTableRow
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.moonYoginiNivas.tr,
                                data: "${controller.panchangModel.response?.advancedDetails?.moonYoginiNivas}",
                                color: ColorResources.colorPrimaryLight
                            ),
                            CustomTableTwoRowWidget(
                                title: AppStrings.ahargana.tr,
                                data: "${controller.panchangModel.response?.advancedDetails?.ahargana}",
                                color: ColorResources.colorTableRow
                            ),
                          ],
                        ),
                      ),
                      const Gap(Dimensions.gapDefault)
                    ],
                  ),
                );
              } else {
                return const EmptyScreen();
              }
            },
          ),
        ),
      ),
    );
  }
  Future<void> showDatePickerDialog(
      BuildContext context, TextEditingController textController) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      textController.text = formattedDate;
    }
  }
}
