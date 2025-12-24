import 'package:flutter/material.dart';
import 'package:astro_brahmand/view/screen/vastu/model/book_pdf_catgeory_model.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';

import '../../../../utill/dimensions.dart';
import '../../../widget/custom_network_image.dart';
import '../../../widget/custom_box_decoration.dart';

class BooksCategoryWidget extends StatelessWidget {
  BookPdfCategoryData bookPdfCategoryData;
  final Function? onPressed;

  BooksCategoryWidget(this.bookPdfCategoryData, {this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    // print(bookPdfCategoryData.image.toString());
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
              padding: const EdgeInsets.all(20.0),
              // decoration: BoxDecoration(
              //   color: ColorResources.white,
              //   border: Border.all(color: ColorResources.green.withOpacity(0.5)),
              //   borderRadius: BorderRadius.circular(12),
              // ),
              decoration: CustomBoxDecoration.getBorderDecoration(),
              child: CustomNetworkImage(
                  imageUrl: bookPdfCategoryData.image.toString(),
                  height: 70,
                  width: 70),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 90,
              ),
              child: CustomTextRegular(
                bookPdfCategoryData.title.toString(),
                fontSize: Dimensions.fontSizeHomeText,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
