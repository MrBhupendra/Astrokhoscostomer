import 'package:flutter/material.dart';
import '../../utill/dimensions.dart';

class CustomTextMedium extends StatelessWidget {
  String text;
  int? maxLines;
  TextAlign? textAlign;
  double? fontSize;
  Color? color;
  bool lineThrough;
  CustomTextMedium(this.text, {this.maxLines, this.textAlign, this.fontSize,this.color,this.lineThrough = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'EuclidMedium',
        fontSize: fontSize ?? Dimensions.fontSizeDefault,
        color: color ?? Colors.black,
        decoration: lineThrough ? TextDecoration.lineThrough : null,
      ),
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      maxLines: maxLines,
      textAlign: textAlign ?? TextAlign.left,
    );
  }
}
