import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../model/dashboard_model.dart';
import '../../utill/color_resources.dart';
import '../../utill/common_methods.dart';
import '../../utill/dimensions.dart';
import 'custom_round_network_image.dart';
import 'custom_text_medium.dart';
import 'custom_text_regular.dart';


class DashOrdersWidget extends StatelessWidget {
  final ChatChannels chatChannels;
  final Function? onPressed;

  const DashOrdersWidget(this.chatChannels, {this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    // String chatRate = '**', callRate = '**', videoRate = '**';
    // astrologer.prices?.forEach((priceItem) {
    //   String type = priceItem.type.toString();
    //   switch (type) {
    //     case AppConstants.chat:
    //       chatRate = priceItem.price.toString();
    //       break;
    //     case AppConstants.call:
    //       callRate = priceItem.price.toString();
    //       break;
    //     case AppConstants.video:
    //       videoRate = priceItem.price.toString();
    //       break;
    //   }
    // });

    return Padding(
      padding: const EdgeInsets.only(right: 8.0,left: 2,top: 2,bottom: 4),
      child: GestureDetector(
        onTap: () {
          if (onPressed != null) {
            onPressed!();
          }
        },
        child: Container(
          width: 265,
          padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                )
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: ColorResources.colorPrimary,width: Dimensions.profileBorderWidth),
                ),
                child: CustomRoundNetworkImage(
                    imageUrl: chatChannels.astroImg.toString(),
                    height: 65,
                    width: 65
                ),
              ),
              const Gap(6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextMedium(chatChannels.displayName.toString(),
                        maxLines: 2,
                        fontSize: Dimensions.fontSizeLarge,
                        // color: ColorResources.colorPrimary
                    ),
                    // const Gap(Dimensions.gapExtraExtraSmall),
                    // CustomTextRegular(
                    //   CommonMethods().formatDateString(chatChannels.updatedAt.toString()),
                    //   color: ColorResources.black4,
                    //   fontSize: Dimensions.fontSizeSmall,
                    //   maxLines: 1,
                    // ),
                    // const Gap(Dimensions.gapExtraExtraSmall),

                    const Gap(Dimensions.gapExtraSmall),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomTextRegular(
                            CommonMethods().formatDateString(chatChannels.updatedAt.toString()),
                            color: ColorResources.black4,
                            fontSize: Dimensions.fontSizeSmall,
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                          decoration: BoxDecoration(
                              color: ColorResources.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: ColorResources.colorPrimary),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 0,
                                  blurRadius: 1,
                                  offset: const Offset(0, 1),
                                )
                              ]
                          ),
                          child: CustomTextRegular("View Chat",fontSize: Dimensions.fontSizeSmall,textAlign: TextAlign.center),
                        ),
                        const Gap(8),
                        // Expanded(
                        //   child: Container(
                        //     padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 4),
                        //     decoration: BoxDecoration(
                        //         color: ColorResources.white,
                        //         borderRadius: BorderRadius.circular(6),
                        //         border: Border.all(color: Colors.yellow.withOpacity(0.7)),
                        //         boxShadow: [
                        //           BoxShadow(
                        //             color: Colors.grey.withOpacity(0.3),
                        //             spreadRadius: 0,
                        //             blurRadius: 1,
                        //             offset: const Offset(0, 1),
                        //           )
                        //         ]
                        //     ),
                        //     child: CustomTextRegular("Chat Again",fontSize: Dimensions.fontSizeSmall,textAlign: TextAlign.center),
                        //   ),
                        // ),
                      ],
                    ),
                    // const Gap(Dimensions.gapSmall),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
