import 'package:astro_brahmand/view/widget/custom_box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_network_image.dart';
import '../../../widget/custom_text_medium.dart';
import '../../splash/controller/config_controller.dart';
import '../model/book_pdf_list_model.dart';

class BooksProductWidget extends StatelessWidget {
  BookPdfData bookPdfData;
  final Function? onPressed;

  BooksProductWidget(this.bookPdfData, {super.key,this.onPressed});

  @override
  Widget build(BuildContext context) {
    final ConfigController configController = Get.find();
    return GestureDetector(
      onTap: () {
        onPressed?.call();
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Column(
          children: [
            Container(
              // width: 120,
              // height: 120,
              padding: const EdgeInsets.all(0.0),
              // decoration: BoxDecoration(
              //   border: Border.all(
              //       color: ColorResources.green.withOpacity(0.5)),
              //   borderRadius: BorderRadius.circular(12),
              // ),
              decoration: CustomBoxDecoration.getBorderDecoration(),
              child:ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CustomNetworkImage(
                    imageUrl: bookPdfData.pdfImage.toString(),
                    height: 140,
                    width: Get.width * 0.5,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: CustomTextMedium(
                bookPdfData.title.toString(),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextMedium(
                  "${configController.currencySymbol} ${bookPdfData.price}/-",
                  fontSize: Dimensions.fontSizeSmall,
                  maxLines: 1,
                  color: ColorResources.colorPrimary,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
