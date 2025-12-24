import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/view/widget/custom_text_regular.dart';

class CustomGenderWidget extends StatefulWidget {
  final Function(String?) onGenderChanged;
  String? selectedGender;
  CustomGenderWidget({super.key, required this.onGenderChanged,this.selectedGender});

  @override
  _CustomGenderWidgetState createState() => _CustomGenderWidgetState();
}

class _CustomGenderWidgetState extends State<CustomGenderWidget> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Gap(5),
        CustomTextRegular("Gender"),
        const Gap(10),
        Expanded(
          child: RadioListTile<String>(
            fillColor: const WidgetStatePropertyAll(ColorResources.colorPrimary),
            contentPadding: EdgeInsets.zero,
            title: CustomTextRegular('Male'),
            value: 'male',
            groupValue: widget.selectedGender,
            onChanged: (value) {
              setState(() {
                widget.selectedGender = value;
              });
              widget.onGenderChanged(value);
            },
          ),
        ),
        Expanded(
          child: RadioListTile<String>(
            fillColor: const WidgetStatePropertyAll(ColorResources.colorPrimary),
            contentPadding: EdgeInsets.zero,
            title: CustomTextRegular('Female'),
            value: 'female',
            groupValue: widget.selectedGender,
            onChanged: (value) {
              setState(() {
                widget.selectedGender = value;
              });
              widget.onGenderChanged(value);
            },
          ),
        ),
      ],
    );
  }
}
