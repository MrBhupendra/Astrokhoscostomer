import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../utill/app_strings.dart';
import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final TextCapitalization? textCapitalization;
  final String? Function(String?)? validator;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final double? prefixIconSize;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Function(String)? onSubmitted;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.textCapitalization,
    this.enabled = true,
    this.inputFormatters,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.prefixIconSize,
    this.focusNode,
    this.textInputAction,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.paddingSizeMediumSmall,
        horizontal: Dimensions.borderRadiusDefault,
      ),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
      ),
      child: SizedBox(
        child: TextFormField(
          controller: controller,

          style: const TextStyle(color: ColorResources.black,fontSize: Dimensions.fontSizeDefault),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
                fontSize: Dimensions.fontSizeDefault,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
                color: ColorResources.black1),
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            isDense: true,
            suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
            // prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: prefixIconSize) : null,
          ),
          enabled: enabled,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization ?? TextCapitalization.sentences,
          validator: validator ?? _defaultValidator,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          focusNode: focusNode,
          textInputAction: textInputAction,
          onFieldSubmitted: onSubmitted,
        ),
      ),
    );
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.formError.tr;
    }
    // else if (!RegExp(r'^[a-zA-Z0-9 ]*$').hasMatch(value)) {
    //   return AppStrings.specialCharacterError;
    // }
    return null;
  }
}

class CustomText extends StatelessWidget {
  final String hintText;

  const CustomText({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: Dimensions.fontSizeDefault,
          color: ColorResources.black,
            fontFamily: "EuclidRegular"
        ),
        children: [
          TextSpan(text: hintText),
          const TextSpan(
            text: ' *',
            style: TextStyle(
              color: ColorResources.red,
              fontFamily: "EuclidRegular"
            ),
          ),
        ],
      ),
    );
  }
}

