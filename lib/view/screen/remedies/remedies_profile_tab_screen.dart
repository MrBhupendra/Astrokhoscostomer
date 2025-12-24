// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import '../../../utill/app_strings.dart';
// import '../../../utill/color_resources.dart';
// import '../../../utill/dimensions.dart';
// import '../../widget/custom_app_bar.dart';
// import '../../widget/custom_text_medium.dart';
// import '../../widget/custom_text_regular.dart';
//
// class RemediesProfileTabScreen extends StatelessWidget {
//   const RemediesProfileTabScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final RemediesProfileTabController controller = Get.put(RemediesProfileTabController());
//
//     return PopScope(
//       onPopInvoked: (bool isPopGesture) {
//         if (!isPopGesture) {
//           if (Get.key.currentState?.canPop() ?? false) {
//             Get.back();
//           } else {
//             Get.offAllNamed('/login');
//           }
//         }
//       },
//       canPop: false,
//       child: SafeArea(
//         child: Scaffold(
//           appBar: CustomAppBar(
//             title: AppStrings.remedies.tr,
//             onBackPressed: () {
//               if (Get.key.currentState?.canPop() ?? false) {
//                 Get.back();
//               } else {
//                 Get.offAllNamed('/login');
//               }
//             },
//           ),
//           body: RefreshIndicator(
//             onRefresh: () async {
//               controller.offset = 0;
//               await controller.getSuggestionHistory(controller.offset);
//             },
//             child: Obx(() {
//               if (controller.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               }
//
//               if (controller.errorMessage.isNotEmpty) {
//                 return Center(child: Text(controller.errorMessage.value));
//               }
//               return Column(
//                 children: [
//                   Expanded(
//                     child: ListView.builder(
//                       padding: const EdgeInsets.all(8.0),
//                       itemCount: controller.remedySuggestionList.length,
//                       controller: controller.scrollController,
//                       itemBuilder: (context, index) {
//                         final remedySuggestion = controller.remedySuggestionList[index];
//
//                         String productName = 'Product Name';
//                         String productUrl = 'No URL';
//                         String serviceUrl = 'No URL';
//                         try {
//                           final Map<String, dynamic> data = json.decode(remedySuggestion.message.toString());
//                           productUrl = data['productUrl'] ?? productUrl;
//                           serviceUrl = data['service'] ?? serviceUrl;
//                           productName = data['name'] ?? productUrl;
//                         } catch (e) {
//                           print("e$e");
//                         }
//
//                         DateTime? createdAt = DateTime.tryParse(remedySuggestion.createdAt!);
//
//                         String formattedDate = createdAt != null
//                             ? DateFormat('dd/MM/yyyy').format(createdAt)
//                             : "No date available";
//
//                         return Card(
//                           margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
//                           elevation: 2,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: ListTile(
//                             onTap: () {
//                               Uri uri = productUrl != 'No URL' ? Uri.parse(productUrl) : Uri.parse(serviceUrl);
//                               String productSlug = uri.pathSegments[1].toString();
//                               String astrologerId = uri.pathSegments[2].toString();
//                               if(productUrl == 'No URL' && serviceUrl != null){
//                                 Get.toNamed('/serviceDetail/$productSlug/$astrologerId');
//                               } else if(serviceUrl == 'No URL' && productUrl != null){
//                                 Get.toNamed('/productDetail/$productSlug/$astrologerId');
//                               }
//                             },
//                             leading: (remedySuggestion.fileUrl != null && remedySuggestion.fileUrl!.isNotEmpty)
//                                 ? SizedBox(
//                               width: 30,
//                               height: 30,
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: Image.network(
//                                   remedySuggestion.fileUrl.toString(),
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (context, error, stackTrace) {
//                                     return const Icon(
//                                       Icons.production_quantity_limits_outlined,
//                                       color: ColorResources.colorPrimary,
//                                       size: 25,
//                                     );
//                                   },
//                                   loadingBuilder: (context, child, loadingProgress) {
//                                     if (loadingProgress == null) return child;
//                                     return const Center(child: CircularProgressIndicator());
//                                   },
//                                 ),
//                               ),
//                             )
//                                 : const Icon(
//                               Icons.production_quantity_limits_outlined,
//                               color: ColorResources.colorPrimary,
//                               size: 25,
//                             ),
//                             title: CustomTextMedium(
//                               "Remedy: "+productName,
//                               fontSize: Dimensions.fontSizeFifteen,
//                             ),
//                             subtitle: Padding(
//                               padding: const EdgeInsets.only(top: 4.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   CustomTextRegular(
//                                     remedySuggestion.channelName ?? 'No Channel',                                    color: Colors.black,
//                                   ),
//                                   SizedBox(height: 3.0,),
//                                   CustomTextRegular(
//                                     fontSize: Dimensions.fontSizeExtraSmall,
//                                     "Suggested At: "+formattedDate,
//                                     color: Colors.black,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   // Pagination loading indicator
//                   Obx(
//                         () => Visibility(
//                       visible: controller.isPaginationLoading.isTrue,
//                       child: const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Center(child: CircularProgressIndicator()),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }
