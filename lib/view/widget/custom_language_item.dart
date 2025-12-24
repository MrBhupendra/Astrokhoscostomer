// import 'package:astro_brahmand/view/screen/language/controller/app_language_controller.dart';
// import 'package:astro_brahmand/view/screen/language/language_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class CustomLanguageItem extends StatelessWidget {
//   final int index;
//   const CustomLanguageItem({super.key, required this.index});
//
//   @override
//   Widget build(BuildContext context) {
//     LanguageModel item = Get.find<AppLanguageController>().items[index];
//     return ListTile(
//       title: Row(
//         children: [
//           // Checkbox(
//           //   value: item.selected,
//           //   onChanged: (value) {
//           //     Get.find<AppLanguageController>().toggleSelected(index);
//           //   },
//           // ),
//           Text(item.name),
//         ],
//       ),
//       // leading: CircleAvatar(
//       //   backgroundColor: item.color,
//       //   child: Icon(Icons.image),
//       // ),
//     );
//   }
// }