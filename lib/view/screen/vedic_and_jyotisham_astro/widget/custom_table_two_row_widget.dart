import 'package:flutter/cupertino.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_text_regular.dart';

class CustomTableTwoRowWidget extends StatelessWidget {
  // final List<String> values;

  final String title;
  final String data;
  final Color? color;

  const CustomTableTwoRowWidget(
      {super.key, required this.title,
        required this.data,
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
                padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall,bottom: Dimensions.paddingSizeSmall,left: Dimensions.paddingSizeSmall),
                child:  CustomTextRegular(title, color: ColorResources.black),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall,bottom: Dimensions.paddingSizeSmall,left: Dimensions.paddingSizeThirtyFive,right: Dimensions.paddingSizeSmall), // Adjust the padding as needed
                child: CustomTextRegular(data, color: ColorResources.black,fontSize:Dimensions.fontSizeSmall,),
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