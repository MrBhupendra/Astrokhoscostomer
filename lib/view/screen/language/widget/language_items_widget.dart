import 'package:flutter/material.dart';

import '../../../../utill/color_resources.dart';

class LanguageItemWidget extends StatelessWidget {
  final Item item;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageItemWidget({
    required this.item,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          decoration: BoxDecoration(
            color: ColorResources.colorPrimaryLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? ColorResources.colorPrimary : Colors.grey.withOpacity(0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 1),
              )
            ],
          ),
          child: ListTile(
            title: Row(
              children: [
                Radio(
                  activeColor: ColorResources.colorPrimary,
                  value: isSelected,
                  groupValue: true,
                  onChanged: (_) => onTap(),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        item.langName.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                ColorFiltered(
                  colorFilter: isSelected
                      ? ColorFilter.mode(Colors.grey.withOpacity(0), BlendMode.srcOver)
                      : const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  child: Image.asset(
                    item.imagePath,
                    height: 70,
                    width: 120,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Item {
  final String name;
  final String langName;
  final String imagePath;
  final Locale locale;

  Item({required this.name, required this.langName, required this.imagePath, required this.locale});
}
