import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import '../controller/kundli_controller.dart';
import '../model/vedic_data.dart';


class KundliAshtakvargaScreen extends StatelessWidget {
  final KundliData data;
  KundliAshtakvargaScreen(this.data, {super.key});

  final KundliController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.getAshtakvarga(data);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTextMedium(AppStrings.astakvarga.tr,fontSize: Dimensions.fontSizeLarge,),
              ],
            ),
            const Gap(Dimensions.gapDefault),
            Obx(
                  () {
                if (controller.isAshtakvargaLoading.value) {
                  return  ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return const SimmerListView();
                    },
                  );
                }
                else if (controller.ashtakvargaModel.status == 200) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Card(
                      child:DataTable(
                        columnSpacing: 10,
                        columns: [
                          DataColumn(label: CustomTextMedium(AppStrings.astakvarga.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.ar.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.ta.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.ge.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.ca.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.le.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.vi.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.li.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.sc.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.sa.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.cp.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.aq.tr)),
                          DataColumn(label: CustomTextMedium(AppStrings.pi.tr)),
                        ],
                        rows:  [
                          DataRow(
                            cells: [
                              DataCell(CustomTextMedium(controller.ashtakvargaModel.response!.ashtakvargaOrder![0].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![0][0].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![0][1].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![0][2].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![0][3].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![0][4].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![0][5].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![0][6].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![0][7].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![0][8].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![0][9].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![0][10].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![0][11].toString())),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(CustomTextMedium(controller.ashtakvargaModel.response!.ashtakvargaOrder![1].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![1][0].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![1][1].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![1][2].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![1][3].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![1][4].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![1][5].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![1][6].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![1][7].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![1][8].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![1][9].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![1][10].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![1][11].toString())),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(CustomTextMedium(controller.ashtakvargaModel.response!.ashtakvargaOrder![2].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![2][0].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![2][1].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![2][2].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![2][3].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![2][4].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![2][5].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![2][6].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![2][7].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![2][8].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![2][9].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![2][10].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![2][11].toString())),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(CustomTextMedium(controller.ashtakvargaModel.response!.ashtakvargaOrder![3].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![3][0].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![3][1].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![3][2].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![3][3].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![3][4].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![3][5].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![3][6].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![3][7].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![3][8].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![3][9].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![3][10].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![3][11].toString())),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(CustomTextMedium(controller.ashtakvargaModel.response!.ashtakvargaOrder![4].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![4][0].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![4][1].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![4][2].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![4][3].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![4][4].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![4][5].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![4][6].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![4][7].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![4][8].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![4][9].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![4][10].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![4][11].toString())),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(CustomTextMedium(controller.ashtakvargaModel.response!.ashtakvargaOrder![5].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![5][0].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![5][1].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![5][2].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![5][3].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![5][4].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![5][5].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![5][6].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![5][7].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![5][8].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![5][9].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![5][10].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![5][11].toString())),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(CustomTextMedium(controller.ashtakvargaModel.response!.ashtakvargaOrder![6].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![6][0].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![6][1].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![6][2].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![6][3].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![6][4].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![6][5].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![6][6].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![6][7].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![6][8].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![6][9].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![6][10].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaPoints![6][11].toString())),
                            ],
                          ),

                          DataRow(
                            cells: [
                              DataCell(CustomTextMedium(AppStrings.total.tr)),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaTotal![0].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaTotal![1].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaTotal![2].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaTotal![3].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaTotal![4].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaTotal![5].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaTotal![6].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaTotal![7].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaTotal![8].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaTotal![9].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaTotal![10].toString())),
                              DataCell(Text(controller.ashtakvargaModel.response!.ashtakvargaTotal![11].toString())),
                            ],
                          ),
                        ],
                        headingRowColor: WidgetStateColor.resolveWith((states) {
                          // Change the color only for the enabled state (default state)
                          return ColorResources.colorPrimaryLight; // Change to any color you desire
                        }),
                      ),
                    ),
                  );
                } else {
                  return const EmptyScreen();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}