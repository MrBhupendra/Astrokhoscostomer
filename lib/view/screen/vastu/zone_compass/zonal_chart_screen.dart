import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:astro_brahmand/utill/dimensions.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';

import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../widget/custom_app_bar.dart';
import '../../../widget/custom_icon_elevated_button.dart';
import '../../../widget/custom_service_button.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class DataModel {
  final int serialNo;
  final String name;
  String value;

  DataModel({required this.serialNo, required this.name, required this.value});
}

class ZonalChartScreen extends StatefulWidget {
  const ZonalChartScreen({super.key});

  @override
  State<ZonalChartScreen> createState() => _ZonalChartScreenState();
}

class _ZonalChartScreenState extends State<ZonalChartScreen> {
  String? selectedValue;

  List<DataModel> data = [
    DataModel(serialNo: 1, name: 'Bed Room 1', value: "Select"),
    DataModel(serialNo: 2, name: 'Bed Room 2', value: "Select"),
    DataModel(serialNo: 3, name: 'Bed Room 3', value: "Select"),
    DataModel(serialNo: 4, name: 'Bed Room 4', value: "Select"),
    DataModel(serialNo: 5, name: 'Kitchen', value: "Select"),
    DataModel(serialNo: 6, name: 'Toilet 1', value: "Select"),
    DataModel(serialNo: 7, name: 'Toilet 2', value: "Select"),
    DataModel(serialNo: 8, name: 'Bathroom', value: "Select"),
    DataModel(serialNo: 9, name: 'Entrance', value: "Select"),
    DataModel(serialNo: 10, name: 'Staircase', value: "Select"),
    DataModel(serialNo: 11, name: 'Drawing/Living Room', value: "Select"),
    DataModel(serialNo: 12, name: 'Balcony', value: "Select"),
    DataModel(serialNo: 13, name: 'Pooja Room', value: "Select"),
    DataModel(serialNo: 14, name: 'Study Room', value: "Select"),
    DataModel(serialNo: 15, name: 'Store Room', value: "Select"),
    DataModel(serialNo: 16, name: 'Cuts', value: "Select"),
    DataModel(serialNo: 17, name: 'Dinning', value: "Select"),
    DataModel(serialNo: 18, name: 'Centre', value: "Select"),
  ];

  final List<String> types = [
    "Select",
    "N",
    "NNE",
    "NE",
    "ENE",
    "E",
    "ESE",
    "SE",
    "SSE",
    "S",
    "SSW",
    "SW",
    "WSW",
    "W",
    "WNW",
    "NW",
    "NNW",
  ];

  final List<String> typesCentre = [
    "Select",
    "OPEN",
    "NEARWALL",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: AppStrings.zonalChart.tr),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Gap(10),
                    CustomTextMedium(
                      "FillUp Zonal Chart To Get Vastu Report",
                      color: ColorResources.colorPrimaryMedium,
                      fontSize: Dimensions.fontSizeDefault,
                    ),
                    const Gap(10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 15),
                      child: DataTable(
                        columnSpacing: 10,
                        decoration: BoxDecoration(border: Border.all(color: ColorResources.colorPrimary, width: 1.5)),
                        dataRowMinHeight: 20,
                        horizontalMargin: 0,
                        // border: TableBorder.all(color: ColorResources.colorPrimary, width: 1.5),
                        columns: [
                          DataColumn(
                            label: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: CustomTextMedium('No.'),
                            ),
                          ),
                          DataColumn(
                            label: CustomTextMedium('Architectural Activity'),
                          ),
                          DataColumn(
                            label: CustomTextMedium('Zone'),
                          ),
                        ],
                        rows: List.generate(
                          data.length,
                              (index) => DataRow(
                            cells: [
                              DataCell(
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(minWidth: 10),
                                    child: Text("${data[index].serialNo.toString()}."),
                                  ),
                                ),
                              ),
                              DataCell(
                                ConstrainedBox(
                                  constraints: const BoxConstraints(minWidth: 180),
                                  child: CustomTextRegular(data[index].name),
                                ),
                              ),
                              DataCell(
                                data[index].name == 'Centre'
                                    ? DropdownButtonFormField<String>(
                                  value: data[index].value,
                                  onChanged: (newValue) {
                                    setState(() {
                                      data[index].value = newValue!;
                                      selectedValue = newValue; // Update selectedValue
                                    });
                                  },
                                  items: typesCentre.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: CustomTextRegular(
                                        value,
                                        fontSize: Dimensions.fontSizeDefault,
                                      ),
                                    );
                                  }).toList(),
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                  ),
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent),
                                    ),
                                  ),
                                )
                                    : DropdownButtonFormField<String>(
                                  value: data[index].value,
                                  onChanged: (newValue) {
                                    setState(() {
                                      data[index].value = newValue!;
                                      selectedValue = newValue; // Update selectedValue
                                    });
                                  },
                                  items: types.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: CustomTextRegular(
                                        value,
                                        fontSize: Dimensions.fontSizeDefault,
                                      ),
                                    );
                                  }).toList(),
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                  ),
                                  decoration: const InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.transparent),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: ColorResources.white,
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeOverSmall),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: CustomServiceButton(
                          onTap: () async {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (BuildContext context) => const ZonalChartScreen(),
                              ),
                            );
                          },
                          service: 'Reset',
                          backgroundColor: ColorResources.colorPrimaryLight,
                          textColor: ColorResources.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: CustomServiceButton(
                          onTap: () async {
                            showCapturedWidget(context, data);
                          },
                          service: 'Generate Report',
                          backgroundColor: ColorResources.colorPrimary,
                          textColor: ColorResources.toolbarText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

GlobalKey _globalKey = GlobalKey();
Future<Uint8List?> captureWidgetToImage(BuildContext buildContext) async {
  RenderRepaintBoundary boundary = _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
  ui.Image image = await boundary.toImage(pixelRatio: ui.window.devicePixelRatio);
  ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  return byteData?.buffer.asUint8List();
}

Future<dynamic> showCapturedWidget(BuildContext context, List<DataModel> data) {
  final ScreenshotController screenshotController = ScreenshotController();

  void captureScreenshot(List<DataModel> data) {
    screenshotController
        .capture(delay: const Duration(milliseconds: 0))
        .then((capturedImage) async {
      generateAndSavePDF(data, capturedImage!);
    }).catchError((onError) {
      AppLogger.d(onError);
    });
  }

  void shareScreenshot(List<DataModel> data) {
    screenshotController
        .capture(delay: const Duration(milliseconds: 0))
        .then((capturedImage) async {
      shareScreenshotPDF(data, capturedImage!);
    }).catchError((onError) {
      AppLogger.d(onError);
    });
  }

  int auspiciousCount = 0;
  int inauspiciousCount = 0;
  int okCount = 0;
  int serialNumber = 1;
  calculatePoints(auspiciousCount, inauspiciousCount, okCount);
  return showDialog(
    context: context,
    builder: (context) => SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: "Report"),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Screenshot(
                      controller: screenshotController,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: DataTable(
                            columnSpacing: 10,
                            decoration: BoxDecoration(border: Border.all(color: ColorResources.colorPrimary,width: 1.5)),
                            dataRowMinHeight: 20,
                            horizontalMargin: 3,
                            columns: [
                              DataColumn(
                                label: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: CustomTextMedium('No.'),
                                ),
                              ),
                              DataColumn(
                                label: CustomTextMedium('Architectural\nActivity'),
                              ),
                              DataColumn(
                                label: CustomTextMedium('Zone'),
                              ),
                              DataColumn(
                                label: CustomTextMedium('Effect'),
                              ),
                            ],
                            rows: List.generate(
                              data.length,
                                  (index) => DataRow(
                                cells: [
                                  DataCell(
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: CustomTextRegular(data[index].serialNo.toString()),
                                    ),
                                  ),
                                  DataCell(
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(minWidth: 80),
                                      child: CustomTextRegular(data[index].name),
                                    ),
                                  ),
                                  DataCell(
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(maxWidth: 60),
                                      child: CustomTextRegular(data[index].value),
                                    ),
                                  ),
                                  DataCell(
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(
                                          maxWidth: 100
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: CustomTextRegular(
                                          (() {
                                            final serialNo =
                                            data[index].serialNo.toString();
                                            final value = data[index].value;
                                            final Map<String, String> statusMap = {
                                              "1:N": "Auspicious",
                                              "1:NNE": "Ok",
                                              "1:NE": "Ok",
                                              "1:ENE": "Ok",
                                              "1:E": "Auspicious",
                                              "1:ESE": "Inauspicious",
                                              "1:SE": "Inauspicious",
                                              "1:SSE": "Auspicious",
                                              "1:S": "Auspicious",
                                              "1:SSW": "Inauspicious",
                                              "1:SW": "Auspicious",
                                              "1:WSW": "Auspicious",
                                              "1:W": "Auspicious",
                                              "1:WNW": "Inauspicious",
                                              "1:NW": "Auspicious",
                                              "1:NNW": "Ok",
                                              "2:N": "Auspicious",
                                              "2:NNE": "Ok",
                                              "2:NE": "Ok",
                                              "2:ENE": "Ok",
                                              "2:E": "Auspicious",
                                              "2:ESE": "Inauspicious",
                                              "2:SE": "Inauspicious",
                                              "2:SSE": "Auspicious",
                                              "2:S": "Auspicious",
                                              "2:SSW": "Inauspicious",
                                              "2:SW": "Auspicious",
                                              "2:WSW": "Auspicious",
                                              "2:W": "Auspicious",
                                              "2:WNW": "Inauspicious",
                                              "2:NW": "Auspicious",
                                              "2:NNW": "Ok",
                                              "3:N": "Auspicious",
                                              "3:NNE": "Ok",
                                              "3:NE": "Ok",
                                              "3:ENE": "Ok",
                                              "3:E": "Auspicious",
                                              "3:ESE": "Inauspicious",
                                              "3:SE": "Inauspicious",
                                              "3:SSE": "Auspicious",
                                              "3:S": "Auspicious",
                                              "3:SSW": "Inauspicious",
                                              "3:SW": "Auspicious",
                                              "3:WSW": "Auspicious",
                                              "3:W": "Auspicious",
                                              "3:WNW": "Inauspicious",
                                              "3:NW": "Auspicious",
                                              "3:NNW": "Ok",
                                              "4:N": "Auspicious",
                                              "4:NNE": "Ok",
                                              "4:NE": "Ok",
                                              "4:ENE": "Ok",
                                              "4:E": "Auspicious",
                                              "4:ESE": "Inauspicious",
                                              "4:SE": "Inauspicious",
                                              "4:SSE": "Auspicious",
                                              "4:S": "Auspicious",
                                              "4:SSW": "Inauspicious",
                                              "4:SW": "Auspicious",
                                              "4:WSW": "Auspicious",
                                              "4:W": "Auspicious",
                                              "4:WNW": "Inauspicious",
                                              "4:NW": "Auspicious",
                                              "4:NNW": "Ok",
                                              "5:N": "Inauspicious",
                                              "5:NNE": "Inauspicious",
                                              "5:NE": "Inauspicious",
                                              "5:ENE": "Inauspicious",
                                              "5:E": "Inauspicious",
                                              "5:ESE": "Inauspicious",
                                              "5:SE": "Auspicious",
                                              "5:SSE": "Auspicious",
                                              "5:S": "Auspicious",
                                              "5:SSW": "Inauspicious",
                                              "5:SW": "Inauspicious",
                                              "5:WSW": "Inauspicious",
                                              "5:W": "Auspicious",
                                              "5:WNW": "Inauspicious",
                                              "5:NW": "Auspicious",
                                              "5:NNW": "Inauspicious",
                                              "6:N": "Inauspicious",
                                              "6:NNE": "Inauspicious",
                                              "6:NE": "Inauspicious",
                                              "6:ENE": "Inauspicious",
                                              "6:E": "Inauspicious",
                                              "6:ESE": "Auspicious",
                                              "6:SE": "Inauspicious",
                                              "6:SSE": "Inauspicious",
                                              "6:S": "Inauspicious",
                                              "6:SSW": "Auspicious",
                                              "6:SW": "Inauspicious",
                                              "6:WSW": "Inauspicious",
                                              "6:W": "Inauspicious",
                                              "6:WNW": "Auspicious",
                                              "6:NW": "Inauspicious",
                                              "6:NNW": "Inauspicious",
                                              "7:N": "Inauspicious",
                                              "7:NNE": "Inauspicious",
                                              "7:NE": "Inauspicious",
                                              "7:ENE": "Inauspicious",
                                              "7:E": "Inauspicious",
                                              "7:ESE": "Auspicious",
                                              "7:SE": "Inauspicious",
                                              "7:SSE": "Inauspicious",
                                              "7:S": "Inauspicious",
                                              "7:SSW": "Auspicious",
                                              "7:SW": "Inauspicious",
                                              "7:WSW": "Inauspicious",
                                              "7:W": "Inauspicious",
                                              "7:WNW": "Auspicious",
                                              "7:NW": "Inauspicious",
                                              "7:NNW": "Inauspicious",
                                              "8:N": "Inauspicious",
                                              "8:NNE": "Inauspicious",
                                              "8:NE": "Inauspicious",
                                              "8:ENE": "Inauspicious",
                                              "8:E": "Auspicious",
                                              "8:ESE": "Auspicious",
                                              "8:SE": "Inauspicious",
                                              "8:SSE": "Inauspicious",
                                              "8:S": "Inauspicious",
                                              "8:SSW": "Auspicious",
                                              "8:SW": "Inauspicious",
                                              "8:WSW": "Inauspicious",
                                              "8:W": "Inauspicious",
                                              "8:WNW": "Auspicious",
                                              "8:NW": "Ok",
                                              "8:NNW": "Ok",
                                              "9:N": "Auspicious",
                                              "9:NNE": "Ok",
                                              "9:NE": "Ok",
                                              "9:ENE": "Ok",
                                              "9:E": "Auspicious",
                                              "9:ESE": "Auspicious",
                                              "9:SE": "Inauspicious",
                                              "9:SSE": "Auspicious",
                                              "9:S": "Inauspicious",
                                              "9:SSW": "Inauspicious",
                                              "9:SW": "Inauspicious",
                                              "9:WSW": "Inauspicious",
                                              "9:W": "Auspicious",
                                              "9:WNW": "Inauspicious",
                                              "9:NW": "Inauspicious",
                                              "9:NNW": "Auspicious",
                                              "10:N": "Inauspicious",
                                              "10:NNE": "Inauspicious",
                                              "10:NE": "Inauspicious",
                                              "10:ENE": "Inauspicious",
                                              "10:E": "Auspicious",
                                              "10:ESE": "Inauspicious",
                                              "10:SE": "Inauspicious",
                                              "10:SSE": "Auspicious",
                                              "10:S": "Auspicious",
                                              "10:SSW": "Auspicious",
                                              "10:SW": "Auspicious",
                                              "10:WSW": "Auspicious",
                                              "10:W": "Auspicious",
                                              "10:WNW": "Inauspicious",
                                              "10:NW": "Auspicious",
                                              "10:NNW": "Ok",
                                              "11:N": "Auspicious",
                                              "11:NNE": "Auspicious",
                                              "11:NE": "Auspicious",
                                              "11:ENE": "Auspicious",
                                              "11:E": "Auspicious",
                                              "11:ESE": "Ok",
                                              "11:SE": "Ok",
                                              "11:SSE": "Ok",
                                              "11:S": "Ok",
                                              "11:SSW": "-",
                                              "11:SW": "Ok",
                                              "11:WSW": "Ok",
                                              "11:W": "Ok",
                                              "11:WNW": "Inauspicious",
                                              "11:NW": "Ok",
                                              "11:NNW": "Ok",
                                              "12:N": "Auspicious",
                                              "12:NNE": "Auspicious",
                                              "12:NE": "Auspicious",
                                              "12:ENE": "Auspicious",
                                              "12:E": "Auspicious",
                                              "12:ESE": "Inauspicious",
                                              "12:SE": "Inauspicious",
                                              "12:SSE": "Inauspicious",
                                              "12:S": "Inauspicious",
                                              "12:SSW": "Inauspicious",
                                              "12:SW": "Inauspicious",
                                              "12:WSW": "Inauspicious",
                                              "12:W": "Ok",
                                              "12:WNW": "Inauspicious",
                                              "12:NW": "Ok",
                                              "12:NNW": "Ok",
                                              "13:N": "Ok",
                                              "13:NNE": "Auspicious",
                                              "13:NE": "Auspicious",
                                              "13:ENE": "Ok",
                                              "13:E": "Ok",
                                              "13:ESE": "Inauspicious",
                                              "13:SE": "Inauspicious",
                                              "13:SSE": "Inauspicious",
                                              "13:S": "Inauspicious",
                                              "13:SSW": "Inauspicious",
                                              "13:SW": "Inauspicious",
                                              "13:WSW": "Inauspicious",
                                              "13:W": "Auspicious",
                                              "13:WNW": "Inauspicious",
                                              "13:NW": "Ok",
                                              "13:NNW": "Ok",
                                              "14:N": "Ok",
                                              "14:NNE": "Auspicious",
                                              "14:NE": "Auspicious",
                                              "14:ENE": "Ok",
                                              "14:E": "Auspicious",
                                              "14:ESE": "Inauspicious",
                                              "14:SE": "Inauspicious",
                                              "14:SSE": "Inauspicious",
                                              "14:S": "Inauspicious",
                                              "14:SSW": "Inauspicious",
                                              "14:SW": "Auspicious",
                                              "14:WSW": "Auspicious",
                                              "14:W": "Auspicious",
                                              "14:WNW": "Inauspicious",
                                              "14:NW": "Inauspicious",
                                              "14:NNW": "Inauspicious",
                                              "15:N": "Inauspicious",
                                              "15:NNE": "Inauspicious",
                                              "15:NE": "Inauspicious",
                                              "15:ENE": "Inauspicious",
                                              "15:E": "Inauspicious",
                                              "15:ESE": "Ok",
                                              "15:SE": "Ok",
                                              "15:SSE": "Auspicious",
                                              "15:S": "Auspicious",
                                              "15:SSW": "Auspicious",
                                              "15:SW": "Auspicious",
                                              "15:WSW": "Auspicious",
                                              "15:W": "Auspicious",
                                              "15:WNW": "Auspicious",
                                              "15:NW": "Auspicious",
                                              "15:NNW": "Ok",
                                              "16:N": "Inauspicious",
                                              "16:NNE": "Inauspicious",
                                              "16:NE": "Inauspicious",
                                              "16:ENE": "Inauspicious",
                                              "16:E": "Inauspicious",
                                              "16:ESE": "Ok",
                                              "16:SE": "Ok",
                                              "16:SSE": "Ok",
                                              "16:S": "Ok",
                                              "16:SSW": "Ok",
                                              "16:SW": "Inauspicious",
                                              "16:WSW": "Inauspicious",
                                              "16:W": "Ok",
                                              "16:WNW": "Ok",
                                              "16:NW": "Ok",
                                              "16:NNW": "Ok",
                                              "17:N": "Auspicious",
                                              "17:NNE": "Auspicious",
                                              "17:NE": "Auspicious",
                                              "17:ENE": "Auspicious",
                                              "17:E": "Auspicious",
                                              "17:ESE": "Inauspicious",
                                              "17:SE": "Ok",
                                              "17:SSE": "Ok",
                                              "17:S": "Ok",
                                              "17:SSW": "Inauspicious",
                                              "17:SW": "Ok",
                                              "17:WSW": "Ok",
                                              "17:W": "Ok",
                                              "17:WNW": "Inauspicious",
                                              "17:NW": "Ok",
                                              "17:NNW": "Ok",
                                            };
                                            final key = "$serialNo:$value";
                                            String status = statusMap[key] ?? "-";
                                            return status;
                                          })(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: data.any((element) => (element.name == "Bed Room 1" || element.name == "Bed Room 2" || element.name == "Bed Room 3" || element.name == "Bed Room 4" || element.name == "Kitchen" || element.name == "Toilet 1" || element.name == "Toilet 2" || element.name == "Bathroom" || element.name == "Entrance" || element.name == "Staircase" || element.name == "Drawing/Living Room" || element.name == "Balcony" || element.name == "Pooja Room" || element.name == "Study Room" || element.name == "Store Room" || element.name == "Cuts" || element.name == "Dinning") && (element.value == "N" || element.value == "NNE" || element.value == "NE" || element.value == "ENE" || element.value == "E" || element.value == "ESE" || element.value == "SE" || element.value == "SSE" || element.value == "S" || element.value == "SSW" || element.value == "SW" || element.value == "WSW" || element.value == "W" || element.value == "WNW" || element.value == "NW" || element.value == "NNW"))
                            ? BoxDecoration(
                          border: Border.all(color: ColorResources.colorPrimary, width: 1.5),
                        )
                            : null,
                        // Initialize serial number outside of the loo
                        child: Column(
                          children: List.generate(
                            data.length,
                                (index) {
                              String effect = getEffect(data[index]);
                              String treatment = getTreatment(data[index]);
                              if ((data[index].name == "Bed Room 1" || data[index].name == "Bed Room 2" || data[index].name == "Bed Room 3" || data[index].name == "Bed Room 4" || data[index].name == "Kitchen" || data[index].name == "Toilet 1" || data[index].name == "Toilet 2" || data[index].name == "Bathroom" || data[index].name == "Entrance" || data[index].name == "Staircase" || data[index].name == "Drawing/Living Room" || data[index].name == "Balcony" || data[index].name == "Pooja Room" || data[index].name == "Study Room" || data[index].name == "Store Room" || data[index].name == "Cuts" || data[index].name == "Dinning") && (data[index].value == "N" || data[index].value == "NNE" || data[index].value == "NE" || data[index].value == "ENE" || data[index].value == "E" || data[index].value == "ESE" || data[index].value == "SE" || data[index].value == "SSE" || data[index].value == "S" || data[index].value == "SSW" || data[index].value == "SW" || data[index].value == "WSW" || data[index].value == "W" || data[index].value == "WNW" || data[index].value == "NW" || data[index].value == "NNW")) {
                                final currentSerialNumber = serialNumber++;
                                return Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "$currentSerialNumber."),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: CustomTextMedium(
                                              data[index].name,
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          CustomTextRegular(
                                            "Selected Zone: ",
                                          ),
                                          Expanded(
                                            child: CustomTextMedium(
                                              data[index].value,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 15, top: 5),
                                        // Adjust margins as needed
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                             CustomTextMedium(
                                              "Effect:-",
                                            ),
                                            Text(effect),
                                            const SizedBox(height: 5),
                                            CustomTextMedium("Treatment:-"),
                                            Text(
                                                treatment
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                                serialNumber++;
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: false,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Status')),
                        ],
                        rows: List.generate(
                          data.length,
                              (index) => DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  (() {
                                    final serialNo = data[index].serialNo.toString();
                                    final value = data[index].value;
                                    final Map<String, String> statusMap = {
                                      "1:N": "Auspicious",
                                      "1:NNE": "Ok",
                                      "1:NE": "Ok",
                                      "1:ENE": "Ok",
                                      "1:E": "Auspicious",
                                      "1:ESE": "Inauspicious",
                                      "1:SE": "Inauspicious",
                                      "1:SSE": "Auspicious",
                                      "1:S": "Auspicious",
                                      "1:SSW": "Inauspicious",
                                      "1:SW": "Auspicious",
                                      "1:WSW": "Auspicious",
                                      "1:W": "Auspicious",
                                      "1:WNW": "Inauspicious",
                                      "1:NW": "Auspicious",
                                      "1:NNW": "Ok",
                                      "2:N": "Auspicious",
                                      "2:NNE": "Ok",
                                      "2:NE": "Ok",
                                      "2:ENE": "Ok",
                                      "2:E": "Auspicious",
                                      "2:ESE": "Inauspicious",
                                      "2:SE": "Inauspicious",
                                      "2:SSE": "Auspicious",
                                      "2:S": "Auspicious",
                                      "2:SSW": "Inauspicious",
                                      "2:SW": "Auspicious",
                                      "2:WSW": "Auspicious",
                                      "2:W": "Auspicious",
                                      "2:WNW": "Inauspicious",
                                      "2:NW": "Auspicious",
                                      "2:NNW": "Ok",
                                      "3:N": "Auspicious",
                                      "3:NNE": "Ok",
                                      "3:NE": "Ok",
                                      "3:ENE": "Ok",
                                      "3:E": "Auspicious",
                                      "3:ESE": "Inauspicious",
                                      "3:SE": "Inauspicious",
                                      "3:SSE": "Auspicious",
                                      "3:S": "Auspicious",
                                      "3:SSW": "Inauspicious",
                                      "3:SW": "Auspicious",
                                      "3:WSW": "Auspicious",
                                      "3:W": "Auspicious",
                                      "3:WNW": "Inauspicious",
                                      "3:NW": "Auspicious",
                                      "3:NNW": "Ok",
                                      "4:N": "Auspicious",
                                      "4:NNE": "Ok",
                                      "4:NE": "Ok",
                                      "4:ENE": "Ok",
                                      "4:E": "Auspicious",
                                      "4:ESE": "Inauspicious",
                                      "4:SE": "Inauspicious",
                                      "4:SSE": "Auspicious",
                                      "4:S": "Auspicious",
                                      "4:SSW": "Inauspicious",
                                      "4:SW": "Auspicious",
                                      "4:WSW": "Auspicious",
                                      "4:W": "Auspicious",
                                      "4:WNW": "Inauspicious",
                                      "4:NW": "Auspicious",
                                      "4:NNW": "Ok",
                                      "5:N": "Inauspicious",
                                      "5:NNE": "Inauspicious",
                                      "5:NE": "Inauspicious",
                                      "5:ENE": "Inauspicious",
                                      "5:E": "Inauspicious",
                                      "5:ESE": "Inauspicious",
                                      "5:SE": "Auspicious",
                                      "5:SSE": "Auspicious",
                                      "5:S": "Auspicious",
                                      "5:SSW": "Inauspicious",
                                      "5:SW": "Inauspicious",
                                      "5:WSW": "Inauspicious",
                                      "5:W": "Auspicious",
                                      "5:WNW": "Inauspicious",
                                      "5:NW": "Auspicious",
                                      "5:NNW": "Inauspicious",
                                      "6:N": "Inauspicious",
                                      "6:NNE": "Inauspicious",
                                      "6:NE": "Inauspicious",
                                      "6:ENE": "Inauspicious",
                                      "6:E": "Inauspicious",
                                      "6:ESE": "Auspicious",
                                      "6:SE": "Inauspicious",
                                      "6:SSE": "Inauspicious",
                                      "6:S": "Inauspicious",
                                      "6:SSW": "Auspicious",
                                      "6:SW": "Inauspicious",
                                      "6:WSW": "Inauspicious",
                                      "6:W": "Inauspicious",
                                      "6:WNW": "Auspicious",
                                      "6:NW": "Inauspicious",
                                      "6:NNW": "Inauspicious",
                                      "7:N": "Inauspicious",
                                      "7:NNE": "Inauspicious",
                                      "7:NE": "Inauspicious",
                                      "7:ENE": "Inauspicious",
                                      "7:E": "Inauspicious",
                                      "7:ESE": "Auspicious",
                                      "7:SE": "Inauspicious",
                                      "7:SSE": "Inauspicious",
                                      "7:S": "Inauspicious",
                                      "7:SSW": "Auspicious",
                                      "7:SW": "Inauspicious",
                                      "7:WSW": "Inauspicious",
                                      "7:W": "Inauspicious",
                                      "7:WNW": "Auspicious",
                                      "7:NW": "Inauspicious",
                                      "7:NNW": "Inauspicious",
                                      "8:N": "Inauspicious",
                                      "8:NNE": "Inauspicious",
                                      "8:NE": "Inauspicious",
                                      "8:ENE": "Inauspicious",
                                      "8:E": "Auspicious",
                                      "8:ESE": "Auspicious",
                                      "8:SE": "Inauspicious",
                                      "8:SSE": "Inauspicious",
                                      "8:S": "Inauspicious",
                                      "8:SSW": "Auspicious",
                                      "8:SW": "Inauspicious",
                                      "8:WSW": "Inauspicious",
                                      "8:W": "Inauspicious",
                                      "8:WNW": "Auspicious",
                                      "8:NW": "Ok",
                                      "8:NNW": "Ok",
                                      "9:N": "Auspicious",
                                      "9:NNE": "Ok",
                                      "9:NE": "Ok",
                                      "9:ENE": "Ok",
                                      "9:E": "Auspicious",
                                      "9:ESE": "Auspicious",
                                      "9:SE": "Inauspicious",
                                      "9:SSE": "Auspicious",
                                      "9:S": "Inauspicious",
                                      "9:SSW": "Inauspicious",
                                      "9:SW": "Inauspicious",
                                      "9:WSW": "Inauspicious",
                                      "9:W": "Auspicious",
                                      "9:WNW": "Inauspicious",
                                      "9:NW": "Inauspicious",
                                      "9:NNW": "Auspicious",
                                      "10:N": "Inauspicious",
                                      "10:NNE": "Inauspicious",
                                      "10:NE": "Inauspicious",
                                      "10:ENE": "Inauspicious",
                                      "10:E": "Auspicious",
                                      "10:ESE": "Inauspicious",
                                      "10:SE": "Inauspicious",
                                      "10:SSE": "Auspicious",
                                      "10:S": "Auspicious",
                                      "10:SSW": "Auspicious",
                                      "10:SW": "Auspicious",
                                      "10:WSW": "Auspicious",
                                      "10:W": "Auspicious",
                                      "10:WNW": "Inauspicious",
                                      "10:NW": "Auspicious",
                                      "10:NNW": "Ok",
                                      "11:N": "Auspicious",
                                      "11:NNE": "Auspicious",
                                      "11:NE": "Auspicious",
                                      "11:ENE": "Auspicious",
                                      "11:E": "Auspicious",
                                      "11:ESE": "Ok",
                                      "11:SE": "Ok",
                                      "11:SSE": "Ok",
                                      "11:S": "Ok",
                                      "11:SSW": "-",
                                      "11:SW": "Ok",
                                      "11:WSW": "Ok",
                                      "11:W": "Ok",
                                      "11:WNW": "Inauspicious",
                                      "11:NW": "Ok",
                                      "11:NNW": "Ok",
                                      "12:N": "Auspicious",
                                      "12:NNE": "Auspicious",
                                      "12:NE": "Auspicious",
                                      "12:ENE": "Auspicious",
                                      "12:E": "Auspicious",
                                      "12:ESE": "Inauspicious",
                                      "12:SE": "Inauspicious",
                                      "12:SSE": "Inauspicious",
                                      "12:S": "Inauspicious",
                                      "12:SSW": "Inauspicious",
                                      "12:SW": "Inauspicious",
                                      "12:WSW": "Inauspicious",
                                      "12:W": "Ok",
                                      "12:WNW": "Inauspicious",
                                      "12:NW": "Ok",
                                      "12:NNW": "Ok",
                                      "13:N": "Ok",
                                      "13:NNE": "Auspicious",
                                      "13:NE": "Auspicious",
                                      "13:ENE": "Ok",
                                      "13:E": "Ok",
                                      "13:ESE": "Inauspicious",
                                      "13:SE": "Inauspicious",
                                      "13:SSE": "Inauspicious",
                                      "13:S": "Inauspicious",
                                      "13:SSW": "Inauspicious",
                                      "13:SW": "Inauspicious",
                                      "13:WSW": "Inauspicious",
                                      "13:W": "Auspicious",
                                      "13:WNW": "Inauspicious",
                                      "13:NW": "Ok",
                                      "13:NNW": "Ok",
                                      "14:N": "Ok",
                                      "14:NNE": "Auspicious",
                                      "14:NE": "Auspicious",
                                      "14:ENE": "Ok",
                                      "14:E": "Auspicious",
                                      "14:ESE": "Inauspicious",
                                      "14:SE": "Inauspicious",
                                      "14:SSE": "Inauspicious",
                                      "14:S": "Inauspicious",
                                      "14:SSW": "Inauspicious",
                                      "14:SW": "Auspicious",
                                      "14:WSW": "Auspicious",
                                      "14:W": "Auspicious",
                                      "14:WNW": "Inauspicious",
                                      "14:NW": "Inauspicious",
                                      "14:NNW": "Inauspicious",
                                      "15:N": "Inauspicious",
                                      "15:NNE": "Inauspicious",
                                      "15:NE": "Inauspicious",
                                      "15:ENE": "Inauspicious",
                                      "15:E": "Inauspicious",
                                      "15:ESE": "Ok",
                                      "15:SE": "Ok",
                                      "15:SSE": "Auspicious",
                                      "15:S": "Auspicious",
                                      "15:SSW": "Auspicious",
                                      "15:SW": "Auspicious",
                                      "15:WSW": "Auspicious",
                                      "15:W": "Auspicious",
                                      "15:WNW": "Auspicious",
                                      "15:NW": "Auspicious",
                                      "15:NNW": "Ok",
                                      "16:N": "Inauspicious",
                                      "16:NNE": "Inauspicious",
                                      "16:NE": "Inauspicious",
                                      "16:ENE": "Inauspicious",
                                      "16:E": "Inauspicious",
                                      "16:ESE": "Ok",
                                      "16:SE": "Ok",
                                      "16:SSE": "Ok",
                                      "16:S": "Ok",
                                      "16:SSW": "Ok",
                                      "16:SW": "Inauspicious",
                                      "16:WSW": "Inauspicious",
                                      "16:W": "Ok",
                                      "16:WNW": "Ok",
                                      "16:NW": "Ok",
                                      "16:NNW": "Ok",
                                      "17:N": "Auspicious",
                                      "17:NNE": "Auspicious",
                                      "17:NE": "Auspicious",
                                      "17:ENE": "Auspicious",
                                      "17:E": "Auspicious",
                                      "17:ESE": "Inauspicious",
                                      "17:SE": "Ok",
                                      "17:SSE": "Ok",
                                      "17:S": "Ok",
                                      "17:SSW": "Inauspicious",
                                      "17:SW": "Ok",
                                      "17:WSW": "Ok",
                                      "17:W": "Ok",
                                      "17:WNW": "Inauspicious",
                                      "17:NW": "Ok",
                                      "17:NNW": "Ok",
                                    };
                                    final key = "$serialNo:$value";
                                    String status = statusMap[key] ?? "";

                                    // Counting statuses
                                    if (status == "Auspicious") {
                                      auspiciousCount++;
                                    } else if (status == "Inauspicious") {
                                      inauspiciousCount++;
                                    } else if (status == "Ok") {
                                      okCount++;
                                    }

                                    return status;
                                  })(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Text('Total Count: ${auspiciousCount + inauspiciousCount + okCount}',),
                    // Text('Points: ${calculatePoints(auspiciousCount, inauspiciousCount, okCount)}'),
                    // Visibility(
                    //   visible: false,
                    //   child: Text(
                    //       '${(calculatePoints(auspiciousCount, inauspiciousCount, okCount) / (auspiciousCount + inauspiciousCount + okCount) * 100).toStringAsFixed(2)}%'
                    //   ),
                    // ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if (data.any((element) => (element.name == "Bed Room 1" || element.name == "Bed Room 2" || element.name == "Bed Room 3" || element.name == "Bed Room 4" || element.name == "Kitchen" || element.name == "Toilet 1" || element.name == "Toilet 2" || element.name == "Bathroom" || element.name == "Entrance" || element.name == "Staircase" || element.name == "Drawing/Living Room" || element.name == "Balcony" || element.name == "Pooja Room" || element.name == "Study Room" || element.name == "Store Room" || element.name == "Cuts" || element.name == "Dinning") && (element.value == "N" || element.value == "NNE" || element.value == "NE" || element.value == "ENE" || element.value == "E" || element.value == "ESE" || element.value == "SE" || element.value == "SSE" || element.value == "S" || element.value == "SSW" || element.value == "SW" || element.value == "WSW" || element.value == "W" || element.value == "WNW" || element.value == "NW" || element.value == "NNW")))
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorResources.colorPrimary, width: 1.5),
                          ),
                          child: PercentageBarChart(
                            percentage: (calculatePoints(auspiciousCount, inauspiciousCount, okCount) / (auspiciousCount + inauspiciousCount + okCount) * 100),
                          ),
                        ),
                    ],
                  ),
                )

        ],
                ),
              ),
            ),
            // Container(
            //   color: Colors.white,
            //   padding: const EdgeInsets.only(left: 20, top: 10),
            //   child: const Center(
            //     child: Text(
            //       'Get Accurate manual checking report within\n 24 hours.',
            //       textAlign: TextAlign.center, // Set text alignment to center
            //       style: TextStyle(
            //         fontSize: 14,
            //         color:  ColorResources.colorPrimary,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(top: 10, bottom: 10,left: 10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomIconElevatedButton(
                      onPressed: () {
                        shareScreenshot(data);
                      },
                      text: "Share",
                      icon: Icons.share,
                      backgroundColor: ColorResources.colorPrimary,
                      textColor: ColorResources.toolbarText,
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: CustomIconElevatedButton(
                      onPressed: () {
                        captureScreenshot(data);
                      },
                      text: "Download",
                      icon: Icons.download,
                      backgroundColor: ColorResources.colorPrimary,
                      textColor: ColorResources.toolbarText,
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     shareScreenshot(data);
                  //   },
                  //   child: Expanded(
                  //     child: Container(
                  //       width: Get.width * 0.4,
                  //       // height: 40,
                  //       decoration: BoxDecoration(
                  //         color:  ColorResources.colorPrimary,
                  //         borderRadius: BorderRadius.circular(8),
                  //       ),
                  //       child: const Padding(
                  //         padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 14),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Icon(Icons.share, color: Colors.white, size: 20),
                  //             SizedBox(width: 10),
                  //             Text(
                  //               'Share',
                  //               style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 15,
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // InkWell(
                  //   onTap: ()  {
                  //     captureScreenshot(data);
                  //     // generateAndSavePDF(data);
                  //   },
                  //   child: Expanded(
                  //     child: Container(
                  //       width: Get.width * 0.4,
                  //       // height: 40,
                  //       decoration: BoxDecoration(
                  //         color: ColorResources.colorPrimary,
                  //         borderRadius: BorderRadius.circular(8),
                  //       ),
                  //       child: const Padding(
                  //         padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Icon(Icons.download, color: Colors.white, size: 20),
                  //             SizedBox(width: 1),
                  //             Text(
                  //               'Download',
                  //               style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 15,
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Screenshot(
// controller: screenshotController,
//ShowdWidget
// Future<dynamic> ShowdWidget(
//     BuildContext context, Uint8List capturedImage) {
//   return showDialog(
//     useSafeArea: false,
//     context: context,
//     builder: (context) => Scaffold(
//       body: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.only(top: 10),
//             width: MediaQuery.of(context).size.width * 1.0, // Adjust as needed
//             height:
//             MediaQuery.of(context).size.height * 0.6, // Adjust as needed
//             child: Image.memory(capturedImage),
//           ),
//         ],
//       ),
//     ),
//   );
// }


// Function to generate and save PDF

Future<void> generateAndSavePDF(List<DataModel> data, Uint8List capturedImage) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Container(
              child: pw.Image(
                pw.MemoryImage(capturedImage), // Adjust image fit as needed
              ),
            ), // Adding page number dynamically
          ],
        );
      },
    ),
  );

  final directory = await getTemporaryDirectory();
  final file = File('${directory.path}/VastuChart.pdf');
  await file.writeAsBytes(await pdf.save());
  OpenFile.open(file.path);
}

void shareScreenshotPDF(List<DataModel> data, Uint8List capturedImage) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Container(
              child: pw.Image(
                pw.MemoryImage(capturedImage), // Adjust image fit as needed
              ),
            ),// Adding page number dynamically
          ],
        );
      },
    ),
  );

  final directory = await getTemporaryDirectory();
  final file = File('${directory.path}/VastuChart.pdf');
  await file.writeAsBytes(await pdf.save());
  if (await file.exists()) {
    //Share.shareFiles([file.path]);
  } else {
    AppLogger.d('PDF file does not exist');
  }
}

//only capture image
// Future<void> generateAndSavePDF(List<DataModel> data, Uint8List capturedImage, context) async {
//   return showDialog(
//     context: context,
//     builder: (context) => Scaffold(
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           children: [
//             Image.memory(capturedImage),
//           ],
//         ),
//       ),
//     ),
//   );
// }


// Function to get the status based on serial number and value

String getStatus(DataModel data) {
  final Map<String, String> statusMap = { /* Your status map */ };
  final key = "${data.serialNo}:${data.value}";
  return statusMap[key] ?? "-";
}

// Future<void> generateAndSavePDF(List<DataModel> data) async {
//   final pdf = pw.Document();
//
//   // Define table headers
//   final headers = ['No', 'Arch. Activity', 'Zone', 'Effect'];
//
//   // Define table rows
//   final rows = data.map((item) {
//     final serialNo = item.serialNo.toString();
//     final value = item.value;
//     final key = "$serialNo:$value";
//     final statusMap = {
//       "1:N": "Auspicious",
//       "1:NNE": "Ok",
//       "1:NE": "Ok",
//       "1:ENE": "Ok",
//       "1:E": "Auspicious",
//       "1:ESE": "Inauspicious",
//       "1:SE": "Inauspicious",
//       "1:SSE": "Auspicious",
//       "1:S": "Auspicious",
//       "1:SSW": "Inauspicious",
//       "1:SW": "Auspicious",
//       "1:WSW": "Auspicious",
//       "1:W": "Auspicious",
//       "1:WNW": "Inauspicious",
//       "1:NW": "Auspicious",
//       "1:NNW": "Ok",
//       "2:N": "Auspicious",
//       "2:NNE": "Ok",
//       "2:NE": "Ok",
//       "2:ENE": "Ok",
//       "2:E": "Auspicious",
//       "2:ESE": "Inauspicious",
//       "2:SE": "Inauspicious",
//       "2:SSE": "Auspicious",
//       "2:S": "Auspicious",
//       "2:SSW": "Inauspicious",
//       "2:SW": "Auspicious",
//       "2:WSW": "Auspicious",
//       "2:W": "Auspicious",
//       "2:WNW": "Inauspicious",
//       "2:NW": "Auspicious",
//       "2:NNW": "Ok",
//       "3:N": "Auspicious",
//       "3:NNE": "Ok",
//       "3:NE": "Ok",
//       "3:ENE": "Ok",
//       "3:E": "Auspicious",
//       "3:ESE": "Inauspicious",
//       "3:SE": "Inauspicious",
//       "3:SSE": "Auspicious",
//       "3:S": "Auspicious",
//       "3:SSW": "Inauspicious",
//       "3:SW": "Auspicious",
//       "3:WSW": "Auspicious",
//       "3:W": "Auspicious",
//       "3:WNW": "Inauspicious",
//       "3:NW": "Auspicious",
//       "3:NNW": "Ok",
//       "4:N": "Auspicious",
//       "4:NNE": "Ok",
//       "4:NE": "Ok",
//       "4:ENE": "Ok",
//       "4:E": "Auspicious",
//       "4:ESE": "Inauspicious",
//       "4:SE": "Inauspicious",
//       "4:SSE": "Auspicious",
//       "4:S": "Auspicious",
//       "4:SSW": "Inauspicious",
//       "4:SW": "Auspicious",
//       "4:WSW": "Auspicious",
//       "4:W": "Auspicious",
//       "4:WNW": "Inauspicious",
//       "4:NW": "Auspicious",
//       "4:NNW": "Ok",
//       "5:N": "Inauspicious",
//       "5:NNE": "Inauspicious",
//       "5:NE": "Inauspicious",
//       "5:ENE": "Inauspicious",
//       "5:E": "Inauspicious",
//       "5:ESE": "Inauspicious",
//       "5:SE": "Auspicious",
//       "5:SSE": "Auspicious",
//       "5:S": "Auspicious",
//       "5:SSW": "Inauspicious",
//       "5:SW": "Inauspicious",
//       "5:WSW": "Inauspicious",
//       "5:W": "Auspicious",
//       "5:WNW": "Inauspicious",
//       "5:NW": "Auspicious",
//       "5:NNW": "Inauspicious",
//       "6:N": "Inauspicious",
//       "6:NNE": "Inauspicious",
//       "6:NE": "Inauspicious",
//       "6:ENE": "Inauspicious",
//       "6:E": "Inauspicious",
//       "6:ESE": "Auspicious",
//       "6:SE": "Inauspicious",
//       "6:SSE": "Inauspicious",
//       "6:S": "Inauspicious",
//       "6:SSW": "Auspicious",
//       "6:SW": "Inauspicious",
//       "6:WSW": "Inauspicious",
//       "6:W": "Inauspicious",
//       "6:WNW": "Auspicious",
//       "6:NW": "Inauspicious",
//       "6:NNW": "Inauspicious",
//       "7:N": "Inauspicious",
//       "7:NNE": "Inauspicious",
//       "7:NE": "Inauspicious",
//       "7:ENE": "Inauspicious",
//       "7:E": "Inauspicious",
//       "7:ESE": "Auspicious",
//       "7:SE": "Inauspicious",
//       "7:SSE": "Inauspicious",
//       "7:S": "Inauspicious",
//       "7:SSW": "Auspicious",
//       "7:SW": "Inauspicious",
//       "7:WSW": "Inauspicious",
//       "7:W": "Inauspicious",
//       "7:WNW": "Auspicious",
//       "7:NW": "Inauspicious",
//       "7:NNW": "Inauspicious",
//       "8:N": "Inauspicious",
//       "8:NNE": "Inauspicious",
//       "8:NE": "Inauspicious",
//       "8:ENE": "Inauspicious",
//       "8:E": "Auspicious",
//       "8:ESE": "Auspicious",
//       "8:SE": "Inauspicious",
//       "8:SSE": "Inauspicious",
//       "8:S": "Inauspicious",
//       "8:SSW": "Auspicious",
//       "8:SW": "Inauspicious",
//       "8:WSW": "Inauspicious",
//       "8:W": "Inauspicious",
//       "8:WNW": "Auspicious",
//       "8:NW": "Ok",
//       "8:NNW": "Ok",
//       "9:N": "Auspicious",
//       "9:NNE": "Ok",
//       "9:NE": "Ok",
//       "9:ENE": "Ok",
//       "9:E": "Auspicious",
//       "9:ESE": "Auspicious",
//       "9:SE": "Inauspicious",
//       "9:SSE": "Auspicious",
//       "9:S": "Inauspicious",
//       "9:SSW": "Inauspicious",
//       "9:SW": "Inauspicious",
//       "9:WSW": "Inauspicious",
//       "9:W": "Auspicious",
//       "9:WNW": "Inauspicious",
//       "9:NW": "Inauspicious",
//       "9:NNW": "Auspicious",
//       "10:N": "Inauspicious",
//       "10:NNE": "Inauspicious",
//       "10:NE": "Inauspicious",
//       "10:ENE": "Inauspicious",
//       "10:E": "Auspicious",
//       "10:ESE": "Inauspicious",
//       "10:SE": "Inauspicious",
//       "10:SSE": "Auspicious",
//       "10:S": "Auspicious",
//       "10:SSW": "Auspicious",
//       "10:SW": "Auspicious",
//       "10:WSW": "Auspicious",
//       "10:W": "Auspicious",
//       "10:WNW": "Inauspicious",
//       "10:NW": "Auspicious",
//       "10:NNW": "Ok",
//       "11:N": "Auspicious",
//       "11:NNE": "Auspicious",
//       "11:NE": "Auspicious",
//       "11:ENE": "Auspicious",
//       "11:E": "Auspicious",
//       "11:ESE": "Ok",
//       "11:SE": "Ok",
//       "11:SSE": "Ok",
//       "11:S": "Ok",
//       "11:SSW": "-",
//       "11:SW": "Ok",
//       "11:WSW": "Ok",
//       "11:W": "Ok",
//       "11:WNW": "Inauspicious",
//       "11:NW": "Ok",
//       "11:NNW": "Ok",
//       "12:N": "Auspicious",
//       "12:NNE": "Auspicious",
//       "12:NE": "Auspicious",
//       "12:ENE": "Auspicious",
//       "12:E": "Auspicious",
//       "12:ESE": "Inauspicious",
//       "12:SE": "Inauspicious",
//       "12:SSE": "Inauspicious",
//       "12:S": "Inauspicious",
//       "12:SSW": "Inauspicious",
//       "12:SW": "Inauspicious",
//       "12:WSW": "Inauspicious",
//       "12:W": "Ok",
//       "12:WNW": "Inauspicious",
//       "12:NW": "Ok",
//       "12:NNW": "Ok",
//       "13:N": "Ok",
//       "13:NNE": "Auspicious",
//       "13:NE": "Auspicious",
//       "13:ENE": "Ok",
//       "13:E": "Ok",
//       "13:ESE": "Inauspicious",
//       "13:SE": "Inauspicious",
//       "13:SSE": "Inauspicious",
//       "13:S": "Inauspicious",
//       "13:SSW": "Inauspicious",
//       "13:SW": "Inauspicious",
//       "13:WSW": "Inauspicious",
//       "13:W": "Auspicious",
//       "13:WNW": "Inauspicious",
//       "13:NW": "Ok",
//       "13:NNW": "Ok",
//       "14:N": "Ok",
//       "14:NNE": "Auspicious",
//       "14:NE": "Auspicious",
//       "14:ENE": "Ok",
//       "14:E": "Auspicious",
//       "14:ESE": "Inauspicious",
//       "14:SE": "Inauspicious",
//       "14:SSE": "Inauspicious",
//       "14:S": "Inauspicious",
//       "14:SSW": "Inauspicious",
//       "14:SW": "Auspicious",
//       "14:WSW": "Auspicious",
//       "14:W": "Auspicious",
//       "14:WNW": "Inauspicious",
//       "14:NW": "Inauspicious",
//       "14:NNW": "Inauspicious",
//       "15:N": "Inauspicious",
//       "15:NNE": "Inauspicious",
//       "15:NE": "Inauspicious",
//       "15:ENE": "Inauspicious",
//       "15:E": "Inauspicious",
//       "15:ESE": "Ok",
//       "15:SE": "Ok",
//       "15:SSE": "Auspicious",
//       "15:S": "Auspicious",
//       "15:SSW": "Auspicious",
//       "15:SW": "Auspicious",
//       "15:WSW": "Auspicious",
//       "15:W": "Auspicious",
//       "15:WNW": "Auspicious",
//       "15:NW": "Auspicious",
//       "15:NNW": "Ok",
//       "16:N": "Inauspicious",
//       "16:NNE": "Inauspicious",
//       "16:NE": "Inauspicious",
//       "16:ENE": "Inauspicious",
//       "16:E": "Inauspicious",
//       "16:ESE": "Ok",
//       "16:SE": "Ok",
//       "16:SSE": "Ok",
//       "16:S": "Ok",
//       "16:SSW": "Ok",
//       "16:SW": "Inauspicious",
//       "16:WSW": "Inauspicious",
//       "16:W": "Ok",
//       "16:WNW": "Ok",
//       "16:NW": "Ok",
//       "16:NNW": "Ok",
//       "17:N": "Auspicious",
//       "17:NNE": "Auspicious",
//       "17:NE": "Auspicious",
//       "17:ENE": "Auspicious",
//       "17:E": "Auspicious",
//       "17:ESE": "Inauspicious",
//       "17:SE": "Ok",
//       "17:SSE": "Ok",
//       "17:S": "Ok",
//       "17:SSW": "Inauspicious",
//       "17:SW": "Ok",
//       "17:WSW": "Ok",
//       "17:W": "Ok",
//       "17:WNW": "Inauspicious",
//       "17:NW": "Ok",
//       "17:NNW": "Ok",
//     };
//     final status = statusMap[key] ?? "-";
//     return [serialNo, item.name, item.value, status];
//   }).toList();
//
//   // Add content to the PDF document
//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) {
//         return pw.Column(
//           children: [
//             pw.Expanded(
//               child: pw.Column(
//                 children: [
//                   pw.Padding(
//                     padding: pw.EdgeInsets.all(8.0),
//                      child: pw.Container(
//                       padding: pw.EdgeInsets.only(top: 10),
//                       child: pw.TableHelper.fromTextArray(
//                         context: context,
//                         cellAlignment: pw.Alignment.center,
//                         headerHeight: 25,
//                         cellHeight: 20,
//                         headerStyle: pw.TextStyle(
//                           color: PdfColors.black,
//                           fontSize: 12,
//                           fontWeight: pw.FontWeight.bold,
//                         ),
//                         cellStyle: const pw.TextStyle(
//                           fontSize: 10,
//                         ),
//                         data: <List<String>>[
//                           headers,
//                           ...rows.map((row) => row.map((cell) => cell.toString()).toList()),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   // pw.Padding(
//                   //   padding: pw.EdgeInsets.all(8.0),
//                   //   child: pw.Container(
//                   //     padding: pw.EdgeInsets.only(left: 15, right: 15),
//                   //     decoration: pw.BoxDecoration(
//                   //       // border: pw.Border.all(color: pw.Colors.appbar, width: 3),
//                   //     ),
//                   //     // Initialize serial number outside of the loo
//                   //     child: pw.Column(
//                   //       children: List.generate(
//                   //         data.length,
//                   //             (index) {
//                   //           String effect = getEffect(data[index]);
//                   //           String treatment = getTreatment(data[index]);
//                   //           if ((data[index].name == "Bed Room 1" || data[index].name == "Bed Room 2" || data[index].name == "Bed Room 3" || data[index].name == "Bed Room 4" || data[index].name == "Kitchen" || data[index].name == "Toilet 1" || data[index].name == "Toilet 2" || data[index].name == "Bathroom" || data[index].name == "Entrance" || data[index].name == "Staircase" || data[index].name == "Drawing/Living Room" || data[index].name == "Balcony" || data[index].name == "Pooja Room" || data[index].name == "Study Room" || data[index].name == "Store Room" || data[index].name == "Cuts" || data[index].name == "Dinning") && (data[index].value == "N" || data[index].value == "NNE" || data[index].value == "NE" || data[index].value == "ENE" || data[index].value == "E" || data[index].value == "ESE" || data[index].value == "SE" || data[index].value == "SSE" || data[index].value == "S" || data[index].value == "SSW" || data[index].value == "SW" || data[index].value == "WSW" || data[index].value == "W" || data[index].value == "WNW" || data[index].value == "NW" || data[index].value == "NNW")) {
//                   //             // final pw;currentSerialNumber = pw.serialNumber++;
//                   //             return pw.Container(
//                   //               margin: pw.EdgeInsets.symmetric(vertical: 15),
//                   //               child: pw.Column(
//                   //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   //                 children: [
//                   //                   pw.Row(
//                   //                     children: [
//                   //                       // pw.Text(pw.currentSerialNumber.toString() + "."),
//                   //                       pw.SizedBox(width: 5),
//                   //                       pw.Text(
//                   //                         data[index].name,
//                   //                         style: pw.TextStyle(
//                   //                             fontWeight: pw.FontWeight.bold),
//                   //                       ),
//                   //                       pw.SizedBox(width: 20),
//                   //                       pw.Text(
//                   //                         "Selected Zone: ",
//                   //                       ),
//                   //                       pw.Text(
//                   //                         data[index].value,
//                   //                         style: pw.TextStyle(
//                   //                             fontWeight: pw.FontWeight.bold),
//                   //                       ),
//                   //                     ],
//                   //                   ),
//                   //                   pw.Container(
//                   //                     margin: pw.EdgeInsets.only(
//                   //                         left: 15, top: 5),
//                   //                     // Adjust margins as needed
//                   //                     child: pw.Column(
//                   //                       crossAxisAlignment:
//                   //                       pw.CrossAxisAlignment.start,
//                   //                       children: [
//                   //                         pw.Text(
//                   //                           "Effect:-",
//                   //                           style: pw.TextStyle(
//                   //                               fontWeight: pw.FontWeight.bold),
//                   //                         ),
//                   //                         pw.Text(effect),
//                   //                         pw.SizedBox(height: 5),
//                   //                         pw.Text("Treatment:-",
//                   //                             style: pw.TextStyle(
//                   //                                 fontWeight: pw.FontWeight.bold)),
//                   //                         pw.Text(
//                   //                             treatment
//                   //                         ),
//                   //                       ],
//                   //                     ),
//                   //                   ),
//                   //                 ],
//                   //               ),
//                   //             );
//                   //             pw.serialNumber++;
//                   //           }
//                   //           return SizedBox.shrink();
//                   //         },
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//
//
//
//
//
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     ),
//   );
//
//   // Save the PDF to the device
//   final directory = await getTemporaryDirectory();
//   final file = File('${directory.path}/Chart_pdf.pdf');
//   await file.writeAsBytes(await pdf.save());
//
//   // Open the PDF file
//   OpenFile.open(file.path);
// }

class PercentageBarChart extends StatelessWidget {
  final double percentage;

  const PercentageBarChart({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      // height: 390, // Fixed height for the container
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: _BarChartPainter(percentage: percentage),
              size: const ui.Size(50, 300), // Size for the CustomPaint
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(11, (index) {
                int number = 100 - index * 10; // Generate numbers in reverse order with a difference of 10
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0), // Add left and bottom padding
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('$number%'), // Add % sign after the number
                  ),
                );
              }).toList(),
            ),

            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Divider(
                height: 1,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BarChartPainter extends CustomPainter {
  final double percentage;

  _BarChartPainter({required this.percentage});

  @override
  void paint(Canvas canvas, ui.Size size) { // Use ui.Size here
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 30;

    double barHeight = size.height * (percentage / 100);
    Offset startPoint = Offset(size.width / 2, size.height); // Start from the bottom
    Offset endPoint = Offset(size.width / 2, size.height - barHeight); // End at the top

    canvas.drawLine(startPoint, endPoint, paint);
    TextSpan span = TextSpan(
      text: '${percentage.toStringAsFixed(1)}%', // Format percentage value
      style: const TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
    );
    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(endPoint.dx - tp.width / 2, endPoint.dy - tp.height - 8));
    // Paint underline only if not at the bottom
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

int calculatePoints(int auspiciousCount, int inauspiciousCount, int okCount) {
  int points = 0;
  points += auspiciousCount;
  points += okCount;
  return points;
}

String getEffect(DataModel data) {
  if (data.name == "Bed Room 1" || data.name == "Bed Room 2" || data.name == "Bed Room 3" || data.name == "Bed Room 4") {
    if (data.value == "NNE") {
      return 'A person whose bedroom is in this zone can never remain without work for long. Even a careless and lazy person can earn good money, if his/ her is having their bedroom here.';
    } else if (data.value == "NE") {
      return 'A bedroom in this zone is a big no, as it disturbs the mind and makes one irritable and irritating. Can cause problems like memory loss and dementia.';
    } else if (data.value == "ENE") {
      return 'A bedroom in this zone brings joy and happiness.';
    } else if (data.value == "E") {
      return 'East bedroom makes us more social. We take part in social activities without hesitation but can affect our family life.';
    } else if (data.value == "ESE") {
      return 'A bedroom in this zone causes anxiety. They cannot let go things easily and it also disturbs the relation of husband and wife.';
    } else if (data.value == "SE") {
      return 'Gives the zeal for money. The person can become money minded. His craving for money may also increase.And person face also the problem of miscarriage';
    } else if (data.value == "SSE") {
      return 'A person who sleeps here develops great mental and physical strength.';
    } else if (data.value == "S") {
      return 'Most recommended zone for bedroom / master bedroom, as it gives a peaceful life and calm mind.';
    } else if (data.value == "SSW") {
      return 'A bedroom in this zone is not at all recommended as it is the zone of expenditure and disposal. So, we should stop sleeping in this zone.';
    } else if (data.value == "SW") {
      return 'Good bedroom for people who are above 60. Not recommended for young couple as this is the zone of skills also and a partner expect his/ her partner to be perfect in all aspects. He wants perfection from his/her partner. So, if possible, avoid this bedroom. Otherwise, try to balance this.';
    } else if (data.value == "WSW") {
      return 'It is an excellent bedroom for a person but they should avoid talking negative topics. As this zone connects with universe very quickly so avoid discuss negative things.';
    } else if (data.value == "W") {
      return 'This is the zone of Saraswati Mata, so think before you speak and talk wisely.';
    } else if (data.value == "WNW") {
      return 'West is the zone of profits and gains. This bedroom is good for money as well as gains in every field of life.';
    } else if (data.value == "NW") {
      return 'This zone is the kop bhavan - where the person living is always annoyed at somebody. A bedroom in this zone is not recommended.';
    } else if (data.value == "NNW") {
      return 'Good bedroom and is highly beneficial for those who need loan or financial help or support.';
    } else if (data.value == "N") {
      return 'Good bedroom for newly wedded couples and kids who are below 12 years of age.';
    } else {
      return ' ';
    }
  }
  else if (data.name == "Kitchen") {
    if (data.value == "NNE") {
      return 'Starts spending money on doctors and medicines excessively. Have adverse effects on health and immunity.';
    } else if (data.value == "NE") {
      return 'Take wrong decisions about money and where it should be invested. A person may lose the clarity of mind and is always confused.';
    } else if (data.value == "ENE") {
      return 'You have to spend more to earn happiness. Causes people to become desperate for fun and enjoyment in life.';
    } else if (data.value == "E") {
      return 'Connect with people on the power of money you behold. To build connections, one spends money to influence/show-off/get a work done.';
    } else if (data.value == "ESE") {
      return 'Have diseases like diabetes and hypertension.';
    } else if (data.value == "SE") {
      return 'Good for kitchen. One needs to check that the family members do not keep talking about money/ways to earn.';
    } else if (data.value == "SSE") {
      return 'Ideal for kitchen. Offers power and confidence to family members. The food made is healthy and delicious.';
    } else if (data.value == "S") {
      return 'Good for kitchen. It brings in fame and recognition for the residents and offer a comfortable life';
    } else if (data.value == "SSW") {
      return 'A kitchen in this zone leads to a lot of expenditures and the food made is also not tasty. Usually, residents will have a bad stomach.';
    } else if (data.value == "SW") {
      return 'The residents of the house can not maintain healthy and loving relationships with each other. There is an instability in career & relationships at the same time.';
    } else if (data.value == "WSW") {
      return 'The savings are affected and children are not able to get good marks even after their best efforts. They start getting angry at name of studies.';
    } else if (data.value == "W") {
      return 'Ideal for kitchen. Ensures money gains and good health for the family. Beneficial for restaurants/hotels.';
    } else if (data.value == "WNW") {
      return 'Residents may have thyroid issues. Gets depressed because of earning/ spending money.';
    } else if (data.value == "NW") {
      return 'You may get support for money but most of the times you require support for money.';
    } else if (data.value == "NNW") {
      return 'Start spending money on oneself to make him/her attractive. It may cause disturbance between intimate relationship between wife and husband.';
    } else if (data.value == "NNW") {
      return 'Will start missing the opportunities for growth. North is governed by Water element and if a Kitchen is here, both Fire & Water gets polluted.';
    } else {
      return ' ';
    }
  }
  else if (data.name == "Toilet 1" || data.name == "Toilet 2") {
    if (data.value == "NNE") {
      return 'A toilet in this zone leads to poor immunity and ailments will take longer to recover.';
    } else if (data.value == "NE") {
      return 'Toilets in this zone cause serious mental problem and is prone to sickness. The person lacks wisdom, ideas and creativity.';
    } else if (data.value == "ENE") {
      return 'A person feels lethargic and never feels refreshed. The plans of holidays are not made / made with a lot of problems.';
    } else if (data.value == "E") {
      return 'Causes smaller social circles and the right connections for growth in a particular field. People in politics cannot afford to have toilet in thiszone. And people also suffer heart related problems.';
    } else if (data.value == "ESE") {
      return 'Toilet in this zone is beneficial as it reduces anxiety and over-thinking capacities.';
    } else if (data.value == "SE") {
      return 'Problems in the flow of money/ liquid cashflow. Not enough money to sustain a business or a normal living. There always a cash crunch.';
    } else if (data.value == "SSE") {
      return 'A toilet in this zone leads to low confidence, physical strength, & convert a thought into action.';
    } else if (data.value == "S") {
      return 'A toilet in this zone hampers the fame and relaxation of the residents. You are doing continuous efforts but are not recognised for the same.';
    } else if (data.value == "SSW") {
      return 'This is best zone for washroom as it is the zone of disposal. A toilet in this zone removes the wasteful expenditures, relationships, and so on from your life.';
    } else if (data.value == "SW") {
      return 'Family relationships get badly affected. Success comes very later/ never in life. This zone relates to Pitra and a toilet in this zone can leave you deprived of their blessings.';
    } else if (data.value == "WSW") {
      return 'Unable to save money due to a toilet in this zone. Old savings like property or jewellery starts to get disposed of. Also, it hampers the study growth of children.';
    } else if (data.value == "W") {
      return 'Do not receive the fruits of hard work invested. Dispose the profitable growth and hampers the achievements of wishes/ desires. Property related issues may also arise.';
    } else if (data.value == "WNW") {
      return 'Washroom is recommended in this zone as it helps releasing blocked emotions and detoxify depressed thoughts.';
    } else if (data.value == "NW") {
      return 'A toilet in this zone reduces help and support from friends, acquaintances, and society. Also, ignites problems related to bank and reduces bank balance.';
    } else if (data.value == "NNW") {
      return 'A toilet in this zone leads to loss of attraction between married couples. Also, there are issues in attracting/ impressing people in general.';
    } else if (data.value == "NNW") {
      return 'Toilets in this zone can create career related issues. There is less scope of opportunities to earn money & move ahead in life.';
    } else {
      return ' ';
    }
  }
  else if (data.name == "Bathroom") {
    return 'There is no effect.';
  }
  else if (data.name == "Entrance") {
    return 'There is no effect.';
  }
  else if (data.name == "Staircase") {
    if (data.value == "NNE") {
      return 'Anti-clockwise stairs in this zone improve the overall immunity of the residents. It helps them recover faster from their ailments.';
    } else if (data.value == "NE") {
      return 'Anti-Clockwise stairs in this zone provide more clarity to thoughts, bring new ideas, and enhance creativity for the users.';
    } else if (data.value == "ENE") {
      return 'Anti-Clockwise stairs made in this zone bring in more happiness, joy, and fun for the family.';
    } else if (data.value == "E") {
      return 'It is good to have Anti-Clockwise stairs in this zone, as it improves social connectivity and relations with the society are profitable. This also helps you to move ahead in life. Clockwise staircase made here reduces anxiety and unwanted or unnecessary processing of the mind. The reverse happens if the stairs are made Anti-Clockwise.';
    } else if (data.value == "ESE") {
      return 'Clockwise staircase made in this zone removes excess churning in life';
    } else if (data.value == "SE") {
      return 'Clockwise staircase made in this zone helps in controlling excessive anger and aggression of the residents. The reverse happens if the stairs are constructed Anti-Clockwise.';
    } else if (data.value == "SSE") {
      return 'Anti-Clockwise stairs made here augment mental and physical strength for the residents, helping to boost their confidence levels.';
    } else if (data.value == "S") {
      return 'Clockwise staircase in this zone brings fame and goodwill to the residents, and they receive due recognition for their efforts. Anti-Clockwise stairs here can lead to a bad reputation, making it difficult for people to feel relaxed.';
    } else if (data.value == "SSW") {
      return 'Stairs should always be made Clockwise in this zone. This reduces the wastage of resources and efforts and helps improve efficiency.';
    } else if (data.value == "SW") {
      return 'Clockwise staircase made in this zone provides stability in career, relationships, and life as a whole.Inhabitants feel inclined to use and sharpen their skills and expertise.';
    } else if (data.value == "WSW") {
      return 'Clockwise staircase made in this zone of a house helps a person to know exactly how much he/she should practice his/ her skills and channelize the practice/efforts towards the desired results. Anti-Clockwise staircase is recommended for places like educational institutions.';
    } else if (data.value == "W") {
      return 'Anti-Clockwise stairs made here augments materialistic gains for the residents. Every effort made here results in a useful and desired outcome.';
    } else if (data.value == "WNW") {
      return 'Clockwise staircase in this zone helps to maintain the emotional balance of the residents. It also helps to reduce their tendency to cry over trivial issues.';
    } else if (data.value == "NW") {
      return 'Clockwise staircase in this zone facilitates help and support for the residents, when required in their personal and professional lives.';
    } else if (data.value == "NNW") {
      return 'Staircase should be Anti-Clockwise in this zone of a house, as it builds the foundation for a strong and loving relationship between the residing couple or couples.';
    } else if (data.value == "NNW") {
      return 'An anti-clockwise staircase built in this direction helps generate opportunities for career and overall life growth.';
    } else {
      return ' ';
    }
  }
  else if (data.name == "Drawing/Living Room") {
    if (data.value == "NNE") {
      return 'Inhabitants of a drawing room located in the north-northeast (NNE) direction often receive tips for better health from visitors. However, it is important to pay attention to the color of the sofas and other furnishings, as certain colors, such as red, can have adverse effects on their health.';
    } else if (data.value == "NE") {
      return 'A drawing room located in the northeast direction tends to encourage discussions related to spirituality and religion. Inhabitants of such a drawing room are more likely to connect with religious individuals.';
    } else if (data.value == "ENE") {
      return 'A drawing room located in the east-northeast direction is ideal for hosting guests and visitors. It creates a welcoming atmosphere where the homeowner can enjoy family gatherings and social events.';
    } else if (data.value == "E") {
      return 'The eastern direction is the ideal location for a drawing room. People who gather in such drawing rooms tend to build strong connections and understanding that grow stronger over time. The social bonds formed in this zone are enduring and long-lasting.';
    } else if (data.value == "ESE") {
      return 'Meetings held in this zone, known as the Zone of Churning (ESE), tend to be unproductive. Discussions held here often do not lead to any useful conclusions.';
    } else if (data.value == "SE") {
      return 'Meetings held in the southeast (SE) direction tend to yield positive results, but the discussions can be quite intense and far from peaceful';
    } else if (data.value == "SSE") {
      return 'Meetings held in the south-southeast (SSE) direction tend to result in unanimous agreements, and discussions are conducted in a peaceful and dignified manner.';
    } else if (data.value == "S") {
      return 'Meetings in the south direction tend to be more relaxed.';
    } else if (data.value == "SSW") {
      return 'The south-southwest (SSW) direction is considered the Zone of Disposal. If a drawing room is located in this zone, it may lead to financial losses.';
    } else if (data.value == "SW") {
      return 'Discussions held in the southwest (SW) direction often revolve around family matters, relationships, ancestral topics, and stability in both career and life as a whole.';
    } else if (data.value == "WSW") {
      return 'In the west-southwest (WSW) direction, discussions often revolve around topics related to education, especially the education of their children, as well as government-related issues.';
    } else if (data.value == "W") {
      return 'Meetings held in the west direction tend to be more productive and yield positive results.';
    } else if (data.value == "WNW") {
      return 'Drawing rooms located in the west-northwest (WNW) direction often serve as spaces for catharsis. The residents of houses in this direction tend to share their life is problems, challenges, and difficulties with';
    } else if (data.value == "NW") {
      return 'Meetings held in the northwest (NW) direction, especially those involving negotiations, are likely to be fruitful and favorable for the residents. Seeking assistance while sitting in this drawing room can make it difficult for visitors to decline.';
    } else if (data.value == "NNW") {
      return 'A drawing room located in the north-northwest (NNW) direction influences its users in a way that they often engage in meetings and helping others without seeking monetary benefits for themselves. Nevertheless, they find joy in discussing topics of their choice.';
    } else if (data.value == "NNW") {
      return 'When people discuss various topics while sitting in a drawing room located in the north direction, new opportunities and possibilities for earning money often emerge, which leverage the skills and capabilities of all those involved in the discussion.';
    } else {
      return ' ';
    }
  }
  else if (data.name == "Balcony") {
    if (data.value == "NNE") {
      return 'Balconies face the NNE direction are believed to gain the health immunity.';
    } else if (data.value == "NE") {
      return 'This direction is associated with the element of water, and it’s believed that by facing northeast, individuals can attract positive energy and spiritual growth and also for mind clearity.';
    } else if (data.value == "ENE") {
      return 'This zone is considered for fun and enjoyment .';
    } else if (data.value == "E") {
      return 'This direction is associated with the rising sun, and it’s believed that by spending time on an east-facing balcony in the morning, individuals can attract positive energy for the day and also make a social network .';
    } else if (data.value == "ESE") {
      return 'This zone is not well for balconies, so covered a balcony with green or red curtain.';
    } else if (data.value == "SE") {
      return 'This is not a suitable because in this zone person can affect from anger issue. For better results this area covered with red curtains.';
    } else if (data.value == "SSE") {
      return 'This zone is not suitable because in this zone person can affect from anger issue . For better results this area covered with red curtains.';
    } else if (data.value == "S") {
      return 'They are believed to attract negative energy and can cause blood related problems. For better results this area covered with red curtains.';
    } else if (data.value == "SSW") {
      return 'Balconies facings in this direction are very harmfully. For better results this area covered with yellow curtains.';
    } else if (data.value == "SW") {
      return 'This is not suitable zone for balconies it can create major conflicts between father and son.So better results it can covered with yellow curtains.';
    } else if (data.value == "WSW") {
      return 'This zone is not suitable for balconies. For better results this area covered with white or grey curtains.';
    } else if (data.value == "W") {
      return 'This is dangerous zone for balconies. For better results this area can covered with white or grey curtains.';
    } else if (data.value == "WNW") {
      return 'This zone can create a depression. For better results it can covered with white or grey curtains.';
    } else if (data.value == "NW") {
      return 'This area is not suitable because this area is known as money borrow problem . For better results this area can covered with white or grey curtains.';
    } else if (data.value == "NNW") {
      return 'Balconies face the NNW direction are believed to attract love and attraction .';
    } else if (data.value == "NNW") {
      return 'This direction is associated with the god of wealth, Kubera, and it’s believed that by facing north, individuals can attract positive energy and financial abundance.';
    } else {
      return ' ';
    }
  }
  else if (data.name == "Pooja Room") {
    return 'There is no effect.';
  }
  else if (data.name == "Study Room") {
    return 'There is no effect.';
  }
  else if (data.name == "Store Room") {
    if (data.value == "NNE") {
      return 'A store in this zone can affect the health of the inhabitants adversely and hence should be avoided.';
    } else if (data.value == "NE") {
      return 'In this zone lacks the clarity of mind and usually have blocked mind.';
    } else if (data.value == "ENE") {
      return 'Store room here will cause lethargy, procrastination and detachment from happiness.';
    } else if (data.value == "E") {
      return 'Your social connections will be weak and you will not find anything good in creating connection.';
    } else if (data.value == "ESE") {
      return 'A store can be located in this zone.A store in this zone reduces anxiety and unwanted flow of thoughts that can cause tension in life';
    } else if (data.value == "SE") {
      return 'A store in this zone hampers expansion in business and inflow of money. A stc also causes blocked payments in business. So, the inhabitants of the houshen will try to accumulate money for future and avoid expenditures. If you are service sector, store in South East can secures your job.';
    } else if (data.value == "SSE") {
      return 'A store in this zone is good. In this zone, it gives a feeling of power, confidence and security.';
    } else if (data.value == "S") {
      return 'Store in this zone is good and provide relaxation if kept organised.';
    } else if (data.value == "SSW") {
      return 'You can make store in this zone for disposable and unwanted things but make sure that you should not any valuables or important documents here.';
    } else if (data.value == "SW") {
      return 'This zone is good for storage of valuable things and things related with your skills. A clean and organized store can be made but avoid junk and useless things.';
    } else if (data.value == "WSW") {
      return 'This is also a very good location for a store. Again, no junk or waste, but seful articles should be stored here.';
    } else if (data.value == "W") {
      return 'Store in this zone gives secured gains to occupants if junk is not placed. Keep the iron safe, or store other important goods.';
    } else if (data.value == "WNW") {
      return 'Good space for store, helps to overcome emotions and low mood.';
    } else if (data.value == "NW") {
      return 'This is an ideal place for a store. As mentioned in Vishwakarma Prakash, it is the best zone for any kind of storage. A store in this zone brings helpful people in their life.';
    } else if (data.value == "NNW") {
      return 'A Store is not advisable in this zone. An organised store can be less problematic , but store of junk in this zone will increase females seeking out male companionship, outside of their home. A store contains various types of articles that have different metals and shapes.';
    } else if (data.value == "NNW") {
      return 'It can hamper growth of career and inflow of money.';
    } else {
      return ' ';
    }
  }
  else if (data.name == "Cuts") {
    return 'There is no effect.';
  }
  else if (data.name == "Dinning") {
    if (data.value == "NNE") {
      return 'Resident becomes more health conscious and careful about his diet.';
    } else if (data.value == "NE") {
      return 'More satvik and vegetarian food keeping religious aspect in the mind.';
    } else if (data.value == "ENE") {
      return 'Occupant will enjoy the food and without keeping nutritional facts in the mind. It can increase the habit of junk food, specially in children.';
    } else if (data.value == "E") {
      return 'This zone encourages social gatherings.';
    } else if (data.value == "ESE") {
      return 'Person will become more analytical about the taste of the food. Which leads to conflict over the food.';
    } else if (data.value == "SE") {
      return 'A dining hall in this zone works as an appetizer. People try to have their meals on time. It improves digestion, but makes the person more aggressive in nature.';
    } else if (data.value == "SSE") {
      return 'Very good zone for dinning area. Food gets digested easily and also provides required nutrients and strength to the body.';
    } else if (data.value == "S") {
      return 'This is again a good zone for dining. Food gets digested properly and people feel relaxed with peace of mind in their lives.';
    } else if (data.value == "SSW") {
      return 'Food eaten here does not provide any strength or nutrition to the body and leads to health problems.';
    } else if (data.value == "SW") {
      return 'Not a good zone for the placement of dinning table. Having meals here creates relationship problems in the family. The father will scold his children for not having table manners, and his wife for not educating their children properly, and so on.';
    } else if (data.value == "WSW") {
      return 'People become very careful about proper etiquette and table manners to eat food.';
    } else if (data.value == "W") {
      return 'Good zone for dinning area. Food consumed here will assure absorption of nutrients and thus, good health is achieved.';
    } else if (data.value == "WNW") {
      return 'Leads to negative thinking of the occupant regarding the food.';
    } else if (data.value == "NW") {
      return 'Occupant get support and help when required, leading to fulfillment of their desires.';
    } else if (data.value == "NNW") {
      return 'People dining here will try to taste new and different preparations every time and enjoy their food.';
    } else if (data.value == "N") {
      return 'Occupant becomes more focused in career and leaves the muddle of life behind. Digestion will be little bit poor in this zone.';
    } else {
      return ' ';
    }
  }
  else if (data.name == "Centre") {
    return 'There is no effect.';
  }
  else {
    return ' ';
  }
  //centre
}

String getTreatment(DataModel data) {
  if (data.name == "Bed Room 1" || data.name == "Bed Room 2" || data.name == "Bed Room 3" || data.name == "Bed Room 4") {
    if (data.value == "NNE") {
      return 'Blue/pista color is allowed. Avoid red/yellow. \n1 Use sampuran disc.';
    } else if (data.value == "NE") {
      return 'Blue/skyblue/pista is allowed. Avoid red/yellow. \n1 Use sampuran disc.';
    } else if (data.value == "ENE") {
      return 'Should be balanced. Anti-colours should be removed. Green, brown, cream, sky blue can be used. A strict NO to Red, Pink, violet, dark yellow, white and grey \n1 Use sampuran disc.';
    } else if (data.value == "E") {
      return 'Good zone for bedroom. Avoid yellow or red color . And green or pista is best color in this zone . \n1 Use sampuran disc.';
    } else if (data.value == "ESE") {
      return 'Avoid blue or cream color . Use green or pistachio color in this zone \n1 Use sampuran disc.';
    } else if (data.value == "SE") {
      return 'Should be balanced with red / pink / purple / violet and cream (avoid using blue/black, white and grey) \n1 Use sampuran disc.';
    } else if (data.value == "SSE") {
      return 'Good zone for bedroom. Use pink/purple/cream color . Avoid white/blue color \n1 Use sampuran disc.';
    } else if (data.value == "S") {
      return 'Good zone for bedroom. Use pink/purple/red color. Avoid black/white color. \n1 Use sampuran disc.';
    } else if (data.value == "SSW") {
      return 'Should be strictly avoided. Use cream/yellow color. And rest of all color avoid. \n1 Use sampuran disc.';
    } else if (data.value == "SW") {
      return 'Use yellow colour and cream, little white can be used. Avoid blue, black,green brown and red. \n1 use sampuran disc.';
    } else if (data.value == "WSW") {
      return 'White/grey, cream, light yellow, light blue. Avoid dark shades of water zone, green, brown and red \n1.Use sampuran disc.';
    } else if (data.value == "W") {
      return 'Avoid green or blue color. Use more grey/cream/lightyellow \n1 Use sampuran disc';
    } else if (data.value == "WNW") {
      return 'Good zone for bedroom. Use white/grey color. Avoid rest of the color. \n1 Use sampuran disc.';
    } else if (data.value == "NW") {
      return 'Use white/grey color. Avoid rest of the color \n1 use sampuran disc.';
    } else if (data.value == "NNW") {
      return 'Use white/grey, cream, light yellow, light blue. Avoid dark shades of water zone, green , brown , red . For increase love in relationship \n1 Use sampuran disc .';
    } else if (data.value == "N") {
      return 'Blue/black/cream and light green is allowed. Avoid red/yellow. For make financially stronger. \n1 Use sampuran disc.';
    } else {
      return ' ';
    }
  }
  else if (data.name == "Kitchen") {
    if (data.value == "NNE") {
      return '1. Green tape below the stove. \n2.Green kitchen energy.';
    } else if (data.value == "NE") {
      return '1.Green tape below the stove. \n2.Green kitchen energy.';
    } else if (data.value == "ENE") {
      return '1 Green tape below the stove. \n2 Green kitchen energy.';
    } else if (data.value == "E") {
      return '1 Green tape below the stove. \n2 Green kitchen energy.';
    } else if (data.value == "ESE") {
      return '1 Green tape below the stove. \n2 Green kitchen energy.';
    } else if (data.value == "SE") {
      return 'No need to balance but can shift stove to SSE if facing money related over-thinking. Do not use blue/black granite. If use so you can place yellow color tape below the stove.';
    } else if (data.value == "SSE") {
      return 'Do not use blue/black granite. If use so you can place yellow color tape below the stove.';
    } else if (data.value == "S") {
      return 'Do not use blue/black granite. If use so you can place yellow color tape below the stove.';
    } else if (data.value == "SSW") {
      return '1 Yellow tape below the stove. \n2 Yellow kitchen energy';
    } else if (data.value == "SW") {
      return '1 Yellow tape below the stove. \n2 Yellow kitchen energy.';
    } else if (data.value == "WSW") {
      return '1 Yellow tape below the stove. \n2 Yellow kitchen energy.';
    } else if (data.value == "W") {
      return '1 Yellow tape below the stove.\n2 Yellow kitchen energy.';
    } else if (data.value == "WNW") {
      return '1 Yellow tape below the stove. \n2 Yellow kitchen energy.';
    } else if (data.value == "NW") {
      return '1 yellow tape below the stove. \n2 Yellow kitchen energy.';
    } else if (data.value == "NNW") {
      return '1 Green tape below the stove. \n2. Green kitchen energy.';
    } else if (data.value == "NNW") {
      return '1.Green tape below the stove. \n2. Green kitchen energy.';
    } else {
      return ' ';
    }
  }
  else if (data.name == "Toilet 1" || data.name == "Toilet 2") {
    if (data.value == "NNE") {
      return '1 Blue Tape \n2 Aluminium Strip \n3 Blue Bath sinker \n4 Blue wall band';
    } else if (data.value == "NE") {
      return '1 Blue Tape \n2.Aluminium strip \n3.Blue Bath sinker \n4 Blue wall Band';
    } else if (data.value == "ENE") {
      return '1 Green tape \n2 Stainless steel strip \n3 Green Bath sinker \n4 Green wall band';
    } else if (data.value == "E") {
      return '1.Green tape \n2 Stainless Steel strip \n3.Green bath sinker \n4.Green wall ban';
    } else if (data.value == "ESE") {
      return 'No treatment required.';
    } else if (data.value == "SE") {
      return '1 Red tape \n2 Copper strip \n3 Red bath sinker \n4 Red wall band.';
    } else if (data.value == "SSE") {
      return '1.Red tape \n2. Copper strip \n3.Red Bath sinker \n4.Red wall band';
    } else if (data.value == "S") {
      return '1.Red tape \n2.Copper strip \n3.Red bath sinker \n4 Red wall band';
    } else if (data.value == "SSW") {
      return 'No treatment required.';
    } else if (data.value == "SW") {
      return '1.Yellow tape \n2.Brass strip \n3. Yellow bath sinker \n4. yellow wall band';
    } else if (data.value == "WSW") {
      return '1.White tape \n2.Iron strip \n3.White wall band \n4.White Bath sinker';
    } else if (data.value == "W") {
      return '1.White tape \n2. Iron strip \n3.White wall band \n4.white bath sinker';
    } else if (data.value == "WNW") {
      return 'No treatment required.';
    } else if (data.value == "NW") {
      return '1.White tape \n2.Iron strip \n3.white bath sinker \n4.White wall band';
    } else if (data.value == "NNW") {
      return '1 Blue tape \n2 Aluminium strip \n3 Blue bath sinker \n4 Blue wall band';
    } else if (data.value == "NNW") {
      return '1 Blue Tape \n2 Aluminium Strip \n3 Blue Bath Sinker \n4 Blue wall Band';
    } else {
      return ' ';
    }
  }
  else if (data.name == "Bathroom") {
    return 'There is no treatment.';
  }
  else if (data.name == "Entrance") {
    return 'There is no treatment.';
  }
  else if (data.name == "Staircase") {
    if (data.value == "NNE") {
      return '1 Use blue stair energy.';
    } else if (data.value == "NE") {
      return '1 Use blue stair energy.';
    } else if (data.value == "ENE") {
      return '1 Use green stair energy.';
    } else if (data.value == "E") {
      return '1 Use green stair energy.';
    } else if (data.value == "ESE") {
      return '1 Use green stair energy.';
    } else if (data.value == "SE") {
      return '1 Use red stair energy.';
    } else if (data.value == "SSE") {
      return '1 Use red stair energy.';
    } else if (data.value == "S") {
      return '1 Use red stair energy.';
    } else if (data.value == "SSW") {
      return '1 Use blue stair energy.';
    } else if (data.value == "SW") {
      return '1 Use blue stair energy.';
    } else if (data.value == "WSW") {
      return '1 Use white stair energy.';
    } else if (data.value == "W") {
      return '1 Use white stair energy.';
    } else if (data.value == "WNW") {
      return '1 Use white stair energy.';
    } else if (data.value == "NW") {
      return '1 Use white stair energy.';
    } else if (data.value == "NNW") {
      return '1 Use blue stair energy.';
    } else if (data.value == "NNW") {
      return '1 Use blue stair energy.';
    } else {
      return ' ';
    }
  }
  else if (data.name == "Drawing/Living Room") {
    return 'There is no treatment.';
  }
  else if (data.name == "Balcony") {
    return 'There is no treatment.';
  }
  else if (data.name == "Pooja Room") {
    return 'There is no treatment.';
  }
  else if (data.name == "Study Room") {
    return 'There is no treatment.';
  }
  else if (data.name == "Store Room") {
    if (data.value == "NNE") {
      return '1 Use blue light. \n2 Use water element chanting machine. \n3 Use blue pyramid (4”).';
    } else if (data.value == "NE") {
      return '1 Enhance blue bulb. \n2 Use water element chanting machine. \n3 Use blue pyramid ( 4”).';
    } else if (data.value == "ENE") {
      return '1 Use green bulb. \n2 Use air element chanting machine. \n3 Use green pyramid (4”).';
    } else if (data.value == "E") {
      return '1 Use green bulb. \n2 Use air element chanting machine. \n3 Use green pyramid (4”).';
    } else if (data.value == "ESE") {
      return '1 Use green bulb. \n2 Use air element chanting machine. \n3 Use green pyramid (4”)';
    } else if (data.value == "SE") {
      return '1 Use red bulb \n2 Use fire element chanting machine. \n3 Use red pyramid (4”).';
    } else if (data.value == "SSE") {
      return 'For increase confidence \n1 Use red light. \n2 Use fire element chanting machine. \n3 Use red pyramid (4”).';
    } else if (data.value == "S") {
      return 'For increase fame and relaxation \n1 use red light. \n2 Use fire element chanting machine. \n3 Use red pyramid (4”).';
    } else if (data.value == "SSW") {
      return '1 Use Yellow light. \n2 Use earth element chanting machine. \n3 Use yellow pyramid (4”).';
    } else if (data.value == "SW") {
      return 'For increase skills and make best relations. \n1 Use Yellow light. \n2 Use earth element chanting machine. \n3 Use Yellow pyramid (4”).';
    } else if (data.value == "WSW") {
      return '1 Use white light. \n2 Use space element chanting machine. \n3 Use white pyramid (4”).';
    } else if (data.value == "W") {
      return '1 Use white light. \n2 Use space element chanting machine. \n3 Use white pyramid (4”).';
    } else if (data.value == "WNW") {
      return 'For cure from depression \n1 Use white light. \n2 Use space element chanting machine. \n3 Use white pyramid (4”).';
    } else if (data.value == "NW") {
      return 'For increase social support or make stability. \n1 Use white light. \n2 Use space element chanting machine. \n3 Use white pyramid (4”).';
    } else if (data.value == "NNW") {
      return '1 Use blue light. \n2 Use water element chanting machine. \n3 Use blue pyramid (4”).';
    } else if (data.value == "NNW") {
      return '1 Use blue light \n2 Use water element chanting machine. \n3. Use blue pyramid (4”).';
    } else {
      return ' ';
    }
  }
  else if (data.name == "Cuts") {
    return 'There is no treatment.';
  }
  else if (data.name == "Dinning") {
    return 'There is no treatment.';
  }
  else if (data.name == "Centre") {
    return 'There is no treatment.';
  }
  else {
    return ' ';
  }
  //centre
}