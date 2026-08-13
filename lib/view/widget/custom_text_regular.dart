import 'package:flutter/material.dart';
import '../../utill/app_fonts.dart';
import '../../utill/dimensions.dart';

class CustomTextRegular extends StatelessWidget {
  String text;
  int? maxLines;
  TextAlign? textAlign;
  double? fontSize;
  Color? color;

  CustomTextRegular(this.text, {this.maxLines,this.textAlign,this.fontSize,this.color,super.key });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: AppFonts.euclidRegular,
          fontFamilyFallback: AppFonts.fallback,
        fontSize: fontSize ?? Dimensions.fontSizeDefault,
        color: color ?? Colors.black),
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
