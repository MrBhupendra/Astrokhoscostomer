import 'package:flutter/material.dart';

import '../../utill/dimensions.dart';

class CustomTextSmall extends StatelessWidget {
  String text;
  int? maxLines;
  TextAlign? textAlign;
  double? fontSize;

  CustomTextSmall(this.text, {this.maxLines, this.textAlign, this.fontSize, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'EuclidSmall',
        fontSize: fontSize ?? Dimensions.fontSizeSmall,
      ),
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.left,
    );
  }
}
