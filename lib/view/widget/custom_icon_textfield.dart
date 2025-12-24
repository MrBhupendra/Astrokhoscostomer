import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utill/app_strings.dart';
import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';

class CustomIconTextField extends StatelessWidget {
  final String hintText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final TextInputType keyboardType;
  final bool enabled;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;

  const CustomIconTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.enabled = true,
    this.inputFormatters,
    this.onChanged,
    required this.controller,
    this.focusNode,
    this.textInputAction,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: ColorResources.black,fontSize: Dimensions.fontSizeDefault),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            width: 1.5,
            color: ColorResources.colorPrimary,
          ),
        ),
        contentPadding: const EdgeInsets.only(left: 12),
        hintText: hintText,
        prefixIcon: prefixIcon != null ? IconTheme(
          data: const IconThemeData(color: ColorResources.colorPrimaryDark,size: 20),
          child: prefixIcon!,
        ) : null,

        suffixIcon: suffixIcon != null ? IconTheme(
          data: const IconThemeData(color: ColorResources.colorPrimaryDark,size: 20),
          child: suffixIcon!,
        ) : null,

        hintStyle: const TextStyle(fontSize: Dimensions.fontSizeDefault,fontWeight: FontWeight.w400,letterSpacing: 0.5,color: ColorResources.black1),
      ),
      keyboardType: keyboardType,
      enabled: enabled,
      validator: validator ?? _defaultValidator,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmitted,
    );
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.formError.tr;
    }
    return null;
  }
}
