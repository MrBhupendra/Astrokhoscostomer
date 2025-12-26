import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_empty_screen.dart';
import '../../../widget/custom_text_bold.dart';
import '../../../widget/custom_text_medium.dart';
import '../../../widget/simmer_widget/simmer_list_view.dart';
import '../controller/kundli_controller.dart';
import '../model/vedic_data.dart';

class KundliFriendshipScreen extends StatelessWidget {
  final KundliData data;
  KundliFriendshipScreen(this.data, {super.key});

  final KundliController controller = Get.find();

  // Helper function to format list without brackets and handle empty lists
  String _formatList(List<String>? list) {
    if (list == null || list.isEmpty) {
      return "None";
    }
    return list.join(", ");
  }

  @override
  Widget build(BuildContext context) {
    controller.getFriendship(data);

    return SingleChildScrollView(
      child: Obx((){
        if(controller.isFriendshipLoading.isTrue){
          return ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const SimmerListView();
            },
          );
        } else if(controller.isFriendshipSuccess.isTrue){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: Dimensions.paddingSizeDefault),
            child: Column(
              children: [
               Container(
                 decoration: BoxDecoration(
                     color: ColorResources.white,
                     boxShadow: [
                       BoxShadow(
                         color: Colors.grey.withOpacity(0.2),
                         spreadRadius: 1,
                         blurRadius: 4,
                         offset: const Offset(0, 2),
                       )
                     ],
                     borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                     border: Border.all(
                       color: Colors.grey.withOpacity(0.3),
                       width: 1,
                     ),
                 ),

                 child:Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column(
                     children: [
                       CustomTextBold(
                         AppStrings.permanentFriendShip.tr,
                         fontSize: Dimensions.fontSizeLarge,
                       ),

                       const Gap(10),
                       Container(
                         decoration: BoxDecoration(
                             color: ColorResources.white,
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey.withOpacity(0.2),
                                 spreadRadius: 1,
                                 blurRadius: 4,
                                 offset: const Offset(0, 2),
                               )
                             ],
                             borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                             border: Border.all(
                               color: Colors.grey.withOpacity(0.3),
                               width: 1,
                             ),
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(12.0),
                           child: Column(
                             children: [
                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextMedium(AppStrings.sun2.tr,color: ColorResources.colorSecondary,),
                                     ],
                                   ),
                                 ],
                               ),
                               const Gap(10),
                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextBold(AppStrings.friend.tr),
                                     ],
                                   ),
                                    const Gap(5),
                                   Expanded(
                                       child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.permanentTable?.sun?.friends),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                   )
                                 ],
                               ),
                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextBold(AppStrings.neutral.tr),
                                     ],
                                   ),
                                   const Gap(5),
                                   Expanded(
                                       child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.permanentTable?.sun?.neutral),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                   )
                                 ],
                               ),
                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextBold(AppStrings.enemies.tr,),
                                     ],
                                   ),
                                   const Gap(5),
                                   Expanded(
                                       child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.permanentTable?.sun?.enemies),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                   )
                                 ],
                               ),
                             ],
                           ),
                         ),
                       ),

                       const Gap(10),
                       Container(
                         decoration: BoxDecoration(
                             color: ColorResources.white,
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey.withOpacity(0.2),
                                 spreadRadius: 1,
                                 blurRadius: 4,
                                 offset: const Offset(0, 2),
                               )
                             ],
                             borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                             border: Border.all(
                               color: Colors.grey.withOpacity(0.3),
                               width: 1,
                             ),
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(12.0),
                           child: Column(
                             children: [
                               Row(
                                 children: [
                                   CustomTextMedium("${AppStrings.moon.tr}:",color: ColorResources.colorSecondary,),
                                 ],
                               ),
                               const Gap(10),
                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextBold(AppStrings.friend.tr),
                                     ],
                                   ),
                                   const Gap(5),
                                   Expanded(
                                       child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.permanentTable?.moon?.friends),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                   )
                                 ],
                               ),
                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextBold(AppStrings.neutral.tr),
                                     ],
                                   ),
                                   const Gap(5),
                                   Expanded(
                                       child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.permanentTable?.moon?.neutral),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                   )
                                 ],
                               ),
                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextBold(AppStrings.enemies.tr),
                                     ],
                                   ),
                                   const Gap(5),
                                   Expanded(
                                       child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.permanentTable?.moon?.enemies),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                   )
                                 ],
                               ),
                             ],
                           ),
                         ),
                       ),

                       const Gap(10),
                       Container(
                         decoration: BoxDecoration(
                             color: ColorResources.white,
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey.withOpacity(0.2),
                                 spreadRadius: 1,
                                 blurRadius: 4,
                                 offset: const Offset(0, 2),
                               )
                             ],
                             borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                             border: Border.all(
                               color: Colors.grey.withOpacity(0.3),
                               width: 1,
                             ),
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(12.0),
                           child: Column(
                             children: [
                               Row(
                                 children: [
                                   CustomTextMedium("${AppStrings.mars.tr}:",color: ColorResources.colorSecondary,),
                                 ],
                               ),
                               const Gap(10),
                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextBold(AppStrings.friend.tr),
                                     ],
                                   ),
                                   const Gap(5),
                                   Expanded(
                                       child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.permanentTable?.mars?.friends),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                   )
                                 ],
                               ),
                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextBold(AppStrings.neutral.tr),
                                     ],
                                   ),
                                   const Gap(5),
                                   Expanded(
                                       child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.permanentTable?.mars?.neutral),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                   )
                                 ],
                               ),
                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextBold(AppStrings.enemies.tr),
                                     ],
                                   ),
                                   const Gap(5),
                                   Expanded(
                                       child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.permanentTable?.mars?.enemies),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                   )
                                 ],
                               ),
                             ],
                           ),
                         ),
                       ),

                       const Gap(10),
                       Container(
                         decoration: BoxDecoration(
                             color: ColorResources.white,
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey.withOpacity(0.2),
                                 spreadRadius: 1,
                                 blurRadius: 4,
                                 offset: const Offset(0, 2),
                               )
                             ],
                             borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                             border: Border.all(
                               color: Colors.grey.withOpacity(0.3),
                               width: 1,
                             ),
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(12.0),
                           child: Column(
                             children: [
                               Row(
                                 children: [
                                   CustomTextMedium(AppStrings.mercury.tr,color: ColorResources.colorSecondary,),
                                 ],
                               ),
                               const Gap(10),
                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextBold(AppStrings.friend.tr),
                                     ],
                                   ),
                                   const Gap(5),
                                   Expanded(
                                       child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.permanentTable?.mercury?.friends),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                   )
                                 ],
                               ),
                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextBold(AppStrings.neutral.tr),
                                     ],
                                   ),
                                   const Gap(5),
                                   Expanded(
                                       child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.permanentTable?.mercury?.neutral),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                   )
                                 ],
                               ),
                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextBold(AppStrings.enemies.tr),
                                     ],
                                   ),
                                   const Gap(5),
                                   Expanded(
                                       child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.permanentTable?.mercury?.enemies),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                   )
                                 ],
                               ),
                             ],
                           ),
                         ),
                       ),

                       const Gap(10),
                       Container(
                         decoration: BoxDecoration(
                             color: ColorResources.white,
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey.withOpacity(0.2),
                                 spreadRadius: 1,
                                 blurRadius: 4,
                                 offset: const Offset(0, 2),
                               )
                             ],
                             borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                             border: Border.all(
                               color: Colors.grey.withOpacity(0.3),
                               width: 1,
                             ),
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(12.0),
                           child: Column(
                             children: [
                               Row(
                                 children: [
                                   CustomTextMedium(AppStrings.jupiter.tr,color: ColorResources.colorSecondary,),
                                 ],
                               ),
                               const Gap(10),

                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextBold(AppStrings.friend.tr),
                                     ],
                                   ),
                                   const Gap(5),
                                   Expanded(
                                       child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.permanentTable?.jupiter?.friends),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                   )
                                 ],
                               ),
                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextBold(AppStrings.neutral.tr),
                                     ],
                                   ),
                                   const Gap(5),
                                   Expanded(
                                       child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.permanentTable?.jupiter?.neutral),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                   )
                                 ],
                               ),
                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextBold(AppStrings.enemies.tr),
                                     ],
                                   ),
                                   const Gap(5),
                                   Expanded(
                                       child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.permanentTable?.jupiter?.enemies),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                   )
                                 ],
                               ),
                             ],
                           ),
                         ),
                       ),

                       const Gap(10),
                       Container(
                         decoration: BoxDecoration(
                             color: ColorResources.white,
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey.withOpacity(0.2),
                                 spreadRadius: 1,
                                 blurRadius: 4,
                                 offset: const Offset(0, 2),
                               )
                             ],
                             borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                             border: Border.all(
                               color: Colors.grey.withOpacity(0.3),
                               width: 1,
                             ),
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(12.0),
                           child: Column(
                             children: [
                               Row(
                                 children: [
                                   CustomTextMedium("${AppStrings.venus.tr}:",color: ColorResources.colorSecondary,),
                                 ],
                               ),
                               const Gap(10),
                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextBold(AppStrings.friend.tr),
                                     ],
                                   ),
                                   const Gap(5),
                                   Expanded(
                                       child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.permanentTable?.venus?.friends),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                   )
                                 ],
                               ),
                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextBold(AppStrings.neutral.tr),
                                     ],
                                   ),
                                   const Gap(5),
                                   Expanded(
                                       child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.permanentTable?.venus?.neutral),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                   )
                                 ],
                               ),
                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextBold(AppStrings.enemies.tr),
                                     ],
                                   ),
                                   const Gap(5),
                                   Expanded(
                                       child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.permanentTable?.venus?.enemies),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                   )
                                 ],
                               ),
                             ],
                           ),
                         ),
                       ),

                       const Gap(10),
                       Container(
                         decoration: BoxDecoration(
                             color: ColorResources.white,
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey.withOpacity(0.2),
                                 spreadRadius: 1,
                                 blurRadius: 4,
                                 offset: const Offset(0, 2),
                               )
                             ],
                             borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                             border: Border.all(
                               color: Colors.grey.withOpacity(0.3),
                               width: 1,
                             ),
                         ),
                         child: Padding(
                           padding: const EdgeInsets.all(12.0),
                           child: Column(
                             children: [
                               Row(
                                 children: [
                                   CustomTextMedium("${AppStrings.saturn.tr}:",color: ColorResources.colorSecondary,),
                                 ],
                               ),
                               const Gap(10),

                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextBold(AppStrings.friend.tr),
                                     ],
                                   ),
                                   const Gap(5),
                                   Expanded(
                                       child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.permanentTable?.saturn?.friends),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                   )
                                 ],
                               ),
                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextBold(AppStrings.neutral.tr),
                                     ],
                                   ),
                                   const Gap(5),
                                   Expanded(
                                       child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.permanentTable?.saturn?.neutral),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                   )
                                 ],
                               ),
                               Row(
                                 children: [
                                   Row(
                                     children: [
                                       CustomTextBold(AppStrings.enemies.tr),
                                     ],
                                   ),
                                   const Gap(5),
                                   Expanded(
                                       child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.permanentTable?.saturn?.enemies),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                   )
                                 ],
                               ),
                             ],
                           ),
                         ),
                       ),

                     ],
                   ),
                 ),
               ),
                const Gap(20),
                Container(
                  decoration: BoxDecoration(
                      color: ColorResources.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(10)
                  ),

                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CustomTextBold(
                          AppStrings.temporaryFriendShip.tr,
                          fontSize: Dimensions.fontSizeLarge,
                        ),
                        const Gap(10),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorResources.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                             border: Border.all(
                               color: Colors.grey.withOpacity(0.3),
                               width: 1,
                             ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextMedium(AppStrings.sun2.tr,color: ColorResources.colorSecondary,),
                                      ],
                                    ),
                                  ],
                                ),
                                const Gap(10),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.friend.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.temporaryTable?.sun?.friends),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.enemies.tr,),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.temporaryTable?.sun?.enemies),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Gap(10),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorResources.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                             border: Border.all(
                               color: Colors.grey.withOpacity(0.3),
                               width: 1,
                             ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CustomTextMedium("${AppStrings.moon.tr}:",color: ColorResources.colorSecondary,),
                                  ],
                                ),
                                const Gap(10),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.friend.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.temporaryTable?.moon?.friends),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.enemies.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.temporaryTable?.moon?.enemies),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Gap(10),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorResources.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                             border: Border.all(
                               color: Colors.grey.withOpacity(0.3),
                               width: 1,
                             ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CustomTextMedium("${AppStrings.mars.tr}:",color: ColorResources.colorSecondary,),
                                  ],
                                ),
                                const Gap(10),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.friend.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.temporaryTable?.mars?.friends),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.enemies.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.temporaryTable?.mars?.enemies),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Gap(10),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorResources.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                             border: Border.all(
                               color: Colors.grey.withOpacity(0.3),
                               width: 1,
                             ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CustomTextMedium(AppStrings.mercury.tr,color: ColorResources.colorSecondary,),
                                  ],
                                ),
                                const Gap(10),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.friend.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.temporaryTable?.mercury?.friends),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.enemies.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.temporaryTable?.mercury?.enemies),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Gap(10),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorResources.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                             border: Border.all(
                               color: Colors.grey.withOpacity(0.3),
                               width: 1,
                             ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CustomTextMedium(AppStrings.jupiter.tr,color: ColorResources.colorSecondary,),
                                  ],
                                ),
                                const Gap(10),

                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.friend.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.temporaryTable?.jupiter?.friends),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.enemies.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.temporaryTable?.jupiter?.enemies),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Gap(10),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorResources.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                             border: Border.all(
                               color: Colors.grey.withOpacity(0.3),
                               width: 1,
                             ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CustomTextMedium("${AppStrings.venus.tr}:",color: ColorResources.colorSecondary,),
                                  ],
                                ),
                                const Gap(10),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.friends.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.temporaryTable?.venus?.friends),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.enemies.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.temporaryTable?.venus?.enemies),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Gap(10),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorResources.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                             border: Border.all(
                               color: Colors.grey.withOpacity(0.3),
                               width: 1,
                             ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CustomTextMedium("${AppStrings.saturn.tr}:",color: ColorResources.colorSecondary,),
                                  ],
                                ),
                                const Gap(10),

                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.friends.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.temporaryTable?.saturn?.friends),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.enemies.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.temporaryTable?.saturn?.enemies),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                const Gap(20),
                Container(
                  decoration: BoxDecoration(
                      color: ColorResources.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(10)
                  ),

                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CustomTextBold(
                          AppStrings.fiveFoldFriendShip.tr,
                          fontSize: Dimensions.fontSizeLarge,
                        ),
                        const Gap(10),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorResources.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                             border: Border.all(
                               color: Colors.grey.withOpacity(0.3),
                               width: 1,
                             ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextMedium(AppStrings.sun2.tr,color: ColorResources.colorSecondary,),
                                      ],
                                    ),
                                  ],
                                ),
                                const Gap(10),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.intimateFriendShip.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.sun?.intimateFriend),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.friend.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.sun?.friends),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.neutral.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.sun?.neutral),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.enemies.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.sun?.enemies),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.bitterEnemy.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.sun?.bitterEnemy),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Gap(10),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorResources.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                             border: Border.all(
                               color: Colors.grey.withOpacity(0.3),
                               width: 1,
                             ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CustomTextMedium("${AppStrings.moon.tr}:",color: ColorResources.colorSecondary,),
                                  ],
                                ),
                                const Gap(10),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.intimateFriendShip.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.moon?.intimateFriend),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.friend.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.moon?.friends),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.neutral.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.moon?.neutral),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.enemies.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.moon?.enemies),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.bitterEnemy.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.moon?.bitterEnemy),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Gap(10),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorResources.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                             border: Border.all(
                               color: Colors.grey.withOpacity(0.3),
                               width: 1,
                             ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CustomTextMedium("${AppStrings.mars.tr}:",color: ColorResources.colorSecondary,),
                                  ],
                                ),
                                const Gap(10),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.intimateFriendShip.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.mars?.intimateFriend),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.friend.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.mars?.friends),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.neutral.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.mars?.neutral),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.enemies.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.mars?.enemies),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.bitterEnemy.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.mars?.bitterEnemy),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Gap(10),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorResources.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                             border: Border.all(
                               color: Colors.grey.withOpacity(0.3),
                               width: 1,
                             ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CustomTextMedium(AppStrings.mercury.tr,color: ColorResources.colorSecondary,),
                                  ],
                                ),
                                const Gap(10),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.intimateFriendShip.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.mercury?.intimateFriend),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.friends.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.mercury?.friends),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.neutral.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.mercury?.neutral),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.enemies.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.mercury?.enemies),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.bitterEnemy.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.mercury?.bitterEnemy),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Gap(10),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorResources.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                             border: Border.all(
                               color: Colors.grey.withOpacity(0.3),
                               width: 1,
                             ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CustomTextMedium(AppStrings.jupiter.tr,color: ColorResources.colorSecondary,),
                                  ],
                                ),
                                const Gap(10),

                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.intimateFriendShip.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.jupiter?.intimateFriend),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.friend.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.jupiter?.friends),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.neutral.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.jupiter?.neutral),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.enemies.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.jupiter?.enemies),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.bitterEnemy.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.jupiter?.bitterEnemy),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Gap(10),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorResources.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                             border: Border.all(
                               color: Colors.grey.withOpacity(0.3),
                               width: 1,
                             ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CustomTextMedium("${AppStrings.venus.tr}:",color: ColorResources.colorSecondary,),
                                  ],
                                ),
                                const Gap(10),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.intimateFriendShip.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.venus?.intimateFriend),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.friend.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.venus?.friends),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.neutral.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.venus?.neutral),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.enemies.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.venus?.enemies),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.bitterEnemy.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.venus?.bitterEnemy),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Gap(10),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorResources.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(Dimensions.borderRadiusDefault),
                             border: Border.all(
                               color: Colors.grey.withOpacity(0.3),
                               width: 1,
                             ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CustomTextMedium("${AppStrings.saturn.tr}:",color: ColorResources.colorSecondary,),
                                  ],
                                ),
                                const Gap(10),

                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.intimateFriendShip.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.saturn?.intimateFriend),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.friend.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.saturn?.friends),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.neutral.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.saturn?.neutral),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.enemies.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.saturn?.enemies),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextBold(AppStrings.bitterEnemy.tr),
                                      ],
                                    ),
                                    const Gap(5),
                                    Expanded(
                                        child: CustomTextMedium(
                                         _formatList(controller.friendshipModel.response?.fiveFoldTable?.saturn?.bitterEnemy),
                                         fontSize: Dimensions.fontSizeDefault,
                                       )
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }else{
          return const EmptyScreen();
        }
      }),
    );
  }
}
