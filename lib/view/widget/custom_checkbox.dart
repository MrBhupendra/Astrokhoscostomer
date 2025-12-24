import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final Function(bool)? onChanged;

  const CustomCheckbox({super.key, this.onChanged});

  @override
  CustomCheckboxState createState() => CustomCheckboxState();
}

class CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value ?? false;
        });
        // Call onChanged callback if provided
        if (widget.onChanged != null) {
          widget.onChanged!(isChecked);
        }
      },
    );
  }
}
