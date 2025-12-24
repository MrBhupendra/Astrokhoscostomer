import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;
  final void Function()? onTap;
  final String? hintText;
  final bool isExpanded;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.onTap,
    this.hintText,
    this.value,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: isExpanded,
      items: _buildDropdownItems(items),
      onChanged: onChanged,
      onTap: onTap,
      value: value,
      hint: hintText != null ? Text(hintText!) : null,
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems(List<String> items) {
    return items.map((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}
