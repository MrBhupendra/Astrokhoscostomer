import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';

class CustomLanguageWidget extends StatefulWidget {
  final Function(String?) onLanguageChanged;
  String? selectedLanguage;
  CustomLanguageWidget({super.key, required this.onLanguageChanged,this.selectedLanguage});

  @override
  _CustomLanguageWidgetState createState() => _CustomLanguageWidgetState();
}

class _CustomLanguageWidgetState extends State<CustomLanguageWidget> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Gap(5),
        CustomTextRegular("Language"),
        const Gap(10),
        Expanded(
          child: RadioListTile<String>(
            fillColor: const WidgetStatePropertyAll(ColorResources.colorPrimary),
            contentPadding: EdgeInsets.zero,
            title: CustomTextRegular('English'),
            value: 'English',
            groupValue: widget.selectedLanguage,
            onChanged: (value) {
              setState(() {
                widget.selectedLanguage = value;
              });
              widget.onLanguageChanged(value);
            },
          ),
        ),
        Expanded(
          child: RadioListTile<String>(
            fillColor: const WidgetStatePropertyAll(ColorResources.colorPrimary),
            contentPadding: EdgeInsets.zero,
            title: CustomTextRegular('Hindi'),
            value: 'Hindi',
            groupValue: widget.selectedLanguage,
            onChanged: (value) {
              setState(() {
                widget.selectedLanguage = value;
              });
              widget.onLanguageChanged(value);
            },
          ),
        ),
      ],
    );
  }
}
