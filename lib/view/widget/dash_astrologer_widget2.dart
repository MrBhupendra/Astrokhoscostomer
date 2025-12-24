import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../model/astrologer_model.dart';
import '../../utill/app_constants.dart';
import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';
import '../../utill/images.dart';
import 'custom_round_network_image.dart';
import 'custom_text_medium.dart';
import 'custom_text_regular.dart';
import 'dotted_widget.dart';


class DashAstrologerWidget2 extends StatelessWidget {
  AstrologerData astrologer;
  final Function? onActionPressed;

  DashAstrologerWidget2(this.astrologer, {this.onActionPressed, super.key});

  @override
  Widget build(BuildContext context) {
    String chatRate = '**', callRate = '**', videoRate = '**';
    astrologer.prices?.forEach((priceItem) {
      String type = priceItem.type.toString();
      switch (type) {
        case AppConstants.chat:
          chatRate = priceItem.price.toString();
          break;
        case AppConstants.call:
          callRate = priceItem.price.toString();
          break;
        case AppConstants.video:
          videoRate = priceItem.price.toString();
          break;
      }
    });

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () {
          if (onActionPressed != null) {
            onActionPressed!();
          }
        },
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(5.0),
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color:
                        const Color(0x00fb7d8a).withOpacity(.5),
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      )
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.orangeAccent, size: 15,),
                          CustomTextRegular(
                            astrologer.user!.avgRating.toString(),
                            maxLines: 1,
                            fontSize: Dimensions.fontSizeSmall,
                          ),
                        ],
                      ),
                    ),
                    const Gap(Dimensions.gapExtraLarge),
                    CustomTextMedium(astrologer.displayName.toString(),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        fontSize: Dimensions.fontSizeExtraLarge,
                        color: ColorResources.black
                    ),
                    const Gap(Dimensions.gapDefault),
                    Padding(
                      padding: const EdgeInsets.only(left:5,right: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Image.asset(Images.astroSkills, height: 20, width: 20,color: ColorResources.colorPrimaryDark,),
                                const Gap(5),
                                CustomTextRegular(
                                  astrologer.categoryNames.toString(),
                                  maxLines: 3,
                                  fontSize: Dimensions.fontSizeExtraSmall,
                                  color: ColorResources.black1,
                                ),
                              ],
                            ),
                          ),
                          const DottedWidget(
                            direction: Axis.vertical,
                            length: 30,
                            dashLength: 15,
                            dashColor: Colors.orangeAccent,
                          ),
                          const Gap(3),
                          Expanded(
                            child: Column(
                              children: [
                                Image.asset(Images.astroExperience, height: 20, width: 20,color: ColorResources.colorPrimaryDark,),
                                const Gap(5),
                                CustomTextRegular(
                                  "Experience",fontSize: 10,  textAlign: TextAlign.center,maxLines: 1,
                                ),
                                CustomTextRegular(
                                  astrologer.experience.toString(),
                                  maxLines: 1,
                                  fontSize: Dimensions.fontSizeSmall,
                                  textAlign: TextAlign.center,
                                ),

                              ],
                            ),
                          ),
                          const Gap(3),
                          const DottedWidget(
                            direction: Axis.vertical,
                            length: 30,
                            dashLength: 15,
                            dashColor: Colors.orangeAccent,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .center,
                              children: [
                                Image.asset(Images.language, height: 20, width: 20,color: ColorResources.colorPrimaryDark,),
                                const Gap(5),
                                CustomTextRegular(
                                  astrologer.languageName.toString(),
                                  maxLines: 2,
                                  fontSize:
                                  Dimensions.fontSizeExtraSmall,
                                  color: ColorResources.black1,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(Dimensions.gapDefault),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: ColorResources.colorPrimary
                      ),
                      child: CustomTextRegular("Connect",color: ColorResources.toolbarText,),
                    )
                  ],
                ),
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 37,
                    backgroundColor: Colors.transparent, // Optional: set a transparent background
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: const [
                            BoxShadow(
                              color: ColorResources.colorPrimary,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            )
                          ]
                      ),
                      child: CustomRoundNetworkImage(
                          imageUrl: astrologer.astroImg.toString(),
                          height: 75,
                          width: 75
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
