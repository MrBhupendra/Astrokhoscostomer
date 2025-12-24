import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:flutter/material.dart';

import '../../utill/dimensions.dart';

class CustomButton extends StatelessWidget {

  final VoidCallback onPressed;
  String text;
  int? maxLines;
  TextAlign? textAlign;
  double? fontSize;
  Color? color;
  Size? minimumSize;
  final Color? backgroundColor;
  final double? borderRadius;

  CustomButton(
      this.text, {
        this.maxLines,
        this.textAlign,
        this.fontSize,
        this.color,
        required this.onPressed,
        this.minimumSize,
        this.backgroundColor,
        this.borderRadius,
        super.key,
      });
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: backgroundColor ?? ColorResources.colorPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 5.0),
        ),
        minimumSize: minimumSize,
      ),
      child:Text(
        text,
        style: TextStyle(
          fontFamily: 'EuclidRegular',
          fontSize: fontSize ?? Dimensions.fontSizeDefault,
          color: color ?? Colors.black,),
        overflow: maxLines != null ? TextOverflow.ellipsis : null,
        maxLines: maxLines,
        textAlign: textAlign,
      ),
    );
  }
}

