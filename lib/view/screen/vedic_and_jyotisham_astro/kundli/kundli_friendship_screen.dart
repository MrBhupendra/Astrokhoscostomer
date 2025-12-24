import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../utill/app_strings.dart';
import '../../../../utill/color_resources.dart';
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
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
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
                       CustomTextBold(AppStrings.permanentFriendShip.tr,fontSize: 16,),

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
                             borderRadius: BorderRadius.circular(10)
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
                                       child: CustomTextMedium("${controller.friendshipModel.response?.permanentTable?.sun?.friends?.toString()}",fontSize: 12,)
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
                                       child: CustomTextMedium("${controller.friendshipModel.response?.permanentTable?.sun?.neutral?.toString()}",fontSize: 12,)
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
                                       child: CustomTextMedium("${controller.friendshipModel.response?.permanentTable?.sun?.enemies?.toString()}",fontSize: 12,)
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
                             borderRadius: BorderRadius.circular(10)
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
                                       child: CustomTextMedium("${controller.friendshipModel.response?.permanentTable?.moon?.friends?.toString()}",fontSize: 12,)
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
                                       child: CustomTextMedium("${controller.friendshipModel.response?.permanentTable?.moon?.neutral?.toString()}",fontSize: 12,)
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
                                       child: CustomTextMedium("${controller.friendshipModel.response?.permanentTable?.moon?.enemies?.toString()}",fontSize: 12,)
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
                             borderRadius: BorderRadius.circular(10)
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
                                       child: CustomTextMedium("${controller.friendshipModel.response?.permanentTable?.mars?.friends?.toString()}",fontSize: 12,)
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
                                       child: CustomTextMedium("${controller.friendshipModel.response?.permanentTable?.mars?.neutral?.toString()}",fontSize: 12,)
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
                                       child: CustomTextMedium("${controller.friendshipModel.response?.permanentTable?.mars?.enemies?.toString()}",fontSize: 12,)
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
                             borderRadius: BorderRadius.circular(10)
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
                                       child: CustomTextMedium("${controller.friendshipModel.response?.permanentTable?.mercury?.friends?.toString()}",fontSize: 12,)
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
                                       child: CustomTextMedium("${controller.friendshipModel.response?.permanentTable?.mercury?.neutral?.toString()}",fontSize: 12,)
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
                                       child: CustomTextMedium("${controller.friendshipModel.response?.permanentTable?.mercury?.enemies?.toString()}",fontSize: 12,)
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
                             borderRadius: BorderRadius.circular(10)
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
                                       child: CustomTextMedium("${controller.friendshipModel.response?.permanentTable?.jupiter?.friends?.toString()}",fontSize: 12,)
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
                                       child: CustomTextMedium("${controller.friendshipModel.response?.permanentTable?.jupiter?.neutral?.toString()}",fontSize: 12,)
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
                                       child: CustomTextMedium("${controller.friendshipModel.response?.permanentTable?.jupiter?.enemies?.toString()}",fontSize: 12,)
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
                             borderRadius: BorderRadius.circular(10)
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
                                       child: CustomTextMedium("${controller.friendshipModel.response?.permanentTable?.venus?.friends?.toString()}",fontSize: 12,)
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
                                       child: CustomTextMedium("${controller.friendshipModel.response?.permanentTable?.venus?.neutral?.toString()}",fontSize: 12,)
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
                                       child: CustomTextMedium("${controller.friendshipModel.response?.permanentTable?.venus?.enemies?.toString()}",fontSize: 12,)
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
                             borderRadius: BorderRadius.circular(10)
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
                                       child: CustomTextMedium("${controller.friendshipModel.response?.permanentTable?.saturn?.friends?.toString()}",fontSize: 12,)
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
                                       child: CustomTextMedium("${controller.friendshipModel.response?.permanentTable?.saturn?.neutral?.toString()}",fontSize: 12,)
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
                                       child: CustomTextMedium("${controller.friendshipModel.response?.permanentTable?.saturn?.enemies?.toString()}",fontSize: 12,)
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
                        CustomTextBold(AppStrings.temporaryFriendShip.tr,fontSize: 16,),
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
                              borderRadius: BorderRadius.circular(10)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.temporaryTable?.sun?.friends?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.temporaryTable?.sun?.enemies?.toString()}",fontSize: 12,)
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
                              borderRadius: BorderRadius.circular(10)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.temporaryTable?.moon?.friends?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.temporaryTable?.moon?.enemies?.toString()}",fontSize: 12,)
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
                              borderRadius: BorderRadius.circular(10)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.temporaryTable?.mars?.friends?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.temporaryTable?.mars?.enemies?.toString()}",fontSize: 12,)
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
                              borderRadius: BorderRadius.circular(10)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.temporaryTable?.mercury?.friends?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.temporaryTable?.mercury?.enemies?.toString()}",fontSize: 12,)
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
                              borderRadius: BorderRadius.circular(10)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.temporaryTable?.jupiter?.friends?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.temporaryTable?.jupiter?.enemies?.toString()}",fontSize: 12,)
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
                              borderRadius: BorderRadius.circular(10)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.temporaryTable?.venus?.friends?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.temporaryTable?.venus?.enemies?.toString()}",fontSize: 12,)
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
                              borderRadius: BorderRadius.circular(10)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.temporaryTable?.saturn?.friends?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.temporaryTable?.saturn?.enemies?.toString()}",fontSize: 12,)
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
                        CustomTextBold(AppStrings.fiveFoldFriendShip.tr,fontSize: 16,),
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
                              borderRadius: BorderRadius.circular(10)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.sun?.intimateFriend?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.sun?.friends?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.sun?.neutral?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.sun?.enemies?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.sun?.bitterEnemy?.toString()}",fontSize: 12,)
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
                              borderRadius: BorderRadius.circular(10)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.moon?.intimateFriend?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.moon?.friends?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.moon?.neutral?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.moon?.enemies?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.moon?.bitterEnemy?.toString()}",fontSize: 12,)
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
                              borderRadius: BorderRadius.circular(10)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.mars?.intimateFriend?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.mars?.friends?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.mars?.neutral?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.mars?.enemies?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.mars?.bitterEnemy?.toString()}",fontSize: 12,)
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
                              borderRadius: BorderRadius.circular(10)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.mercury?.intimateFriend?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.mercury?.friends?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.mercury?.neutral?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.mercury?.enemies?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.mercury?.bitterEnemy?.toString()}",fontSize: 12,)
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
                              borderRadius: BorderRadius.circular(10)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.jupiter?.intimateFriend?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.jupiter?.friends?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.jupiter?.neutral?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.jupiter?.enemies?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.jupiter?.bitterEnemy?.toString()}",fontSize: 12,)
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
                              borderRadius: BorderRadius.circular(10)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.venus?.intimateFriend?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.venus?.friends?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.venus?.neutral?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.venus?.enemies?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.venus?.bitterEnemy?.toString()}",fontSize: 12,)
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
                              borderRadius: BorderRadius.circular(10)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.saturn?.intimateFriend?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.saturn?.friends?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.saturn?.neutral?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.saturn?.enemies?.toString()}",fontSize: 12,)
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
                                        child: CustomTextMedium("${controller.friendshipModel.response?.fiveFoldTable?.saturn?.bitterEnemy?.toString()}",fontSize: 12,)
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
