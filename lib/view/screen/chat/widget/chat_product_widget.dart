import 'dart:convert';

import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/images.dart';
import '../../../widget/custom_network_image.dart';
import '../../../widget/custom_round_network_image.dart';
import '../../../widget/custom_text_regular.dart';
import '../model/chat_message_model.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class ChatProductWidget extends StatelessWidget {
  final ChatMessageModel message;
  final String? userUniId;
  final String? type;
  const ChatProductWidget(this.message, this.userUniId,this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    String productName = "";
    String productUrl = "";
    try{
      if(message.text.toString().isNotEmpty){
        Map<String, String> messageMap = Map<String, String>.from(jsonDecode(message.text.toString()));
        productName =  messageMap['name'].toString();
        productUrl =  messageMap['productUrl'].toString();
      }
    }catch(e){
      AppLogger.d("exception");
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          //Me
          if (message.senderUniId == userUniId) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: message.selectedText.toString().isNotEmpty && message.selectedType == AppConstants.text,
                        // Set the visibility condition here
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 6),
                          decoration: BoxDecoration(
                            color: ColorResources.black7,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          constraints: const BoxConstraints(maxWidth: 250.0),
                          child: CustomTextRegular(
                            message.selectedText.toString(),
                          ),
                        ),
                      ), //Text Selected
                      Visibility(
                        visible: message.selectedText.toString().isNotEmpty && message.selectedType == AppConstants.image,
                        // Set the visibility condition here
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 6),
                          decoration: BoxDecoration(
                            color: ColorResources.black7,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          constraints: const BoxConstraints(maxWidth: 250.0),
                          child: GestureDetector(
                            onTap: () {
                              showPreviewDialog(message.selectedText.toString());
                            },
                            child: CustomNetworkImage(
                                imageUrl: message.selectedText.toString(),
                                height: 100,
                                width: 100),
                          ),
                        ),
                      ), //Image Selected
                      GestureDetector(
                        onTap: (){
                          if(type == AppConstants.product){
                            if(productUrl.isNotEmpty){
                              Uri uri = Uri.parse(productUrl);
                              String productSlug = uri.pathSegments[1].toString();
                              String astrologerId = uri.pathSegments[2].toString();
                              Get.toNamed('/productDetail/$productSlug/$astrologerId');
                            }
                          }else if(type == AppConstants.service){
                            Uri uri = Uri.parse(productUrl);
                            String serviceSlug = uri.pathSegments[1].toString();
                            String astrologerId = uri.pathSegments[2].toString();
                            Get.toNamed('/serviceDetail/$serviceSlug/$astrologerId');
                          }
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 6),
                            decoration: BoxDecoration(
                              color: ColorResources.lightYellow,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            constraints: const BoxConstraints(maxWidth: 250.0),
                            child:  Row(
                              children: [
                                CustomRoundNetworkImage(imageUrl: message.fileUrl.toString(), height: 50, width: 50),
                                const Gap(10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomTextRegular(
                                        productName,
                                        fontSize: 14,
                                      ),
                                      CustomTextRegular(
                                        "View Detail >",
                                        fontSize: 12,
                                        color: Colors.blueAccent,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),
                      const Gap(2),
                      CustomTextRegular(
                        message.date.toString(),
                        fontSize: 10.0,
                        color: ColorResources.black4,
                      ),
                    ],
                  ),
                  const SizedBox(width: 5.0),
                  CustomRoundNetworkImage(
                      imageUrl: message.profileImageUrl.toString(),
                      height:
                      30,
                      width:
                      30
                  ),
                ],
              ),
            ),
          ] else ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomRoundNetworkImage(
                      imageUrl: message.profileImageUrl.toString(),
                      height:
                      30,
                      width:
                      30
                  ),
                  const SizedBox(width: 5.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: message.selectedText.toString().isNotEmpty && message.selectedType == AppConstants.text,
                        // Set the visibility condition here
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 6),
                          decoration: BoxDecoration(
                            color: ColorResources.black7,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          constraints: const BoxConstraints(maxWidth: 250.0),
                          child: CustomTextRegular(
                            message.selectedText.toString(),
                          ),
                        ),
                      ),//Text Selected
                      Visibility(
                        visible: message.selectedText.toString().isNotEmpty && message.selectedType == AppConstants.image,
                        // Set the visibility condition here
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 6),
                          decoration: BoxDecoration(
                            color: ColorResources.black7,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          constraints: const BoxConstraints(maxWidth: 250.0),
                          child: GestureDetector(
                            onTap: () {
                              showPreviewDialog(message.selectedText.toString());
                            },
                            child: CustomNetworkImage(
                                imageUrl: message.selectedText.toString(),
                                height: 100,
                                width: 100),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          if(type == AppConstants.product){
                            if(productUrl.isNotEmpty){
                              Uri uri = Uri.parse(productUrl);
                              String productSlug = uri.pathSegments[1].toString();
                              String astrologerId = uri.pathSegments[2].toString();
                              Get.toNamed('/productDetail/$productSlug/$astrologerId');
                            }
                          }else if(type == AppConstants.service){
                            Uri uri = Uri.parse(productUrl);
                            String serviceSlug = uri.pathSegments[1].toString();
                            String astrologerId = uri.pathSegments[2].toString();
                            Get.toNamed('/serviceDetail/$serviceSlug/$astrologerId');
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 6),
                          decoration: BoxDecoration(
                            color: ColorResources.white,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          constraints: const BoxConstraints(maxWidth: 250.0),
                          child:  Row(
                            children: [
                              CustomRoundNetworkImage(imageUrl: message.fileUrl.toString(), height: 50, width: 50),
                              const Gap(10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextRegular(
                                      productName,
                                      fontSize: 14,
                                    ),
                                    CustomTextRegular(
                                      "View Detail >",
                                      fontSize: 12,
                                      color: Colors.blueAccent,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(2),
                      Text(
                        message.date.toString(),
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void showPreviewDialog(String imageUrl) async {
    Get.dialog(
      useSafeArea: true,
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        content: Stack(
          children: <Widget>[
            CustomNetworkImage(
              imageUrl: imageUrl,
              height: Get.height * 0.7,
              width: Get.width * 0.8,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    Images.crossFill,
                    height: 26,
                    color: ColorResources.colorPrimaryDark,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
