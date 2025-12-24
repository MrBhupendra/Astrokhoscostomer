
import 'package:flutter/material.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_text_regular.dart';

class CustomTableRow extends StatelessWidget {
  final String title;
  final String boy;
  final String girl;
  final Color? color;

  const CustomTableRow(
      {super.key, required this.title,
      required this.boy,
      required this.girl,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: color,
          ),
          children: [
            TableCell(
              child: Padding(
                padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall,bottom: Dimensions.paddingSizeSmall,left: Dimensions.paddingSizeDefault),
                child: CustomTextRegular(
                  title,
                ),
              ),
            ),

            TableCell(
              child: Padding(
                padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall,bottom: Dimensions.paddingSizeSmall,left: Dimensions.paddingSizeExtraLarge,right: Dimensions.paddingSizeDefault), // Adjust the padding as needed
                child: CustomTextRegular(boy,fontSize: Dimensions.fontSizeSmall),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall,bottom: Dimensions.paddingSizeSmall,left: Dimensions.paddingSizeExtraLarge,right: Dimensions.paddingSizeDefault),// Adjust the padding as needed
                child: CustomTextRegular(girl,fontSize: Dimensions.fontSizeSmall),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
class CustomTableRowRadius extends StatelessWidget {
  // final List<String> values;

   final String title;
   final String boy;
   final String girl;
   final Color? color;

  const CustomTableRowRadius(
      {super.key, required this.title,
        required this.boy,
        required this.girl,
        this.color});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),

            ),
              color: color ?? ColorResources.colorPrimaryVariant,
          ),
          children: [
            TableCell(
              child: Padding(
                padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall,bottom: Dimensions.paddingSizeSmall,left: Dimensions.paddingSizeDefault),
                child: CustomTextRegular(
                  title,color: ColorResources.toolbarText
                ),
              ),
            ),

            TableCell(
              child: Padding(
                padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall,bottom: Dimensions.paddingSizeSmall,left:Dimensions.paddingSizeExtraLarge,right: Dimensions.paddingSizeDefault),// Adjust the padding as needed
                child: CustomTextRegular(boy ,fontSize: Dimensions.fontSizeSmall,color: ColorResources.toolbarText,),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall,bottom: Dimensions.paddingSizeSmall,left: Dimensions.paddingSizeExtraLarge,right: Dimensions.paddingSizeDefault), // Adjust the padding as needed
                child: CustomTextRegular(girl,fontSize: Dimensions.fontSizeSmall,color: ColorResources.toolbarText),
              ),
            ),

          ],
        ),
      ],
    );
  }
}
class CustomTableRowBottum extends StatelessWidget {
  // final List<String> values;

  final String title;
  final String boy;
  final String girl;
  final Color? color;

  const CustomTableRowBottum(
      {super.key, required this.title,
        required this.boy,
        required this.girl,
        required this.color});

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),

            ),
            color: color,
          ),
          children: [
            TableCell(
              child: Padding(
                padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall,bottom: Dimensions.paddingSizeSmall,left: Dimensions.paddingSizeDefault),
                child: CustomTextRegular(
                  title,
                ),
              ),
            ),

            TableCell(
              child: Padding(
                padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall,bottom: Dimensions.paddingSizeSmall,left: Dimensions.paddingSizeExtraLarge,right: Dimensions.paddingSizeDefault), // Adjust the padding as needed
                child: CustomTextRegular(boy,fontSize: Dimensions.fontSizeSmall,),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall,bottom: Dimensions.paddingSizeSmall,left: Dimensions.paddingSizeExtraLarge,right: Dimensions.paddingSizeDefault), // Adjust the padding as needed
                child: CustomTextRegular(girl,fontSize: Dimensions.fontSizeSmall),
              ),
            ),
            // for (String value in values)
            //   TableCell(
            //     child: Center(
            //       child: Padding(
            //         padding: EdgeInsets.all(10),
            //         child: Text(value),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ],
    );
  }
}