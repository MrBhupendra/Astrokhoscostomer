import 'package:flutter/material.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/utill/dimensions.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:get/get.dart';
import '../../../../utill/images.dart';
import '../model/ai_profile_model.dart';

class QuestionProfileWidget extends StatelessWidget {
  AiProfileListData item;
  Function onEditSelected;
  QuestionProfileWidget({super.key, required this.item,required this.onEditSelected});

  @override
  Widget build(BuildContext context) {
    List<String> nameParts = item.name.toString().split(' ');
    String initials = (nameParts.isNotEmpty ? nameParts[0][0] : '') + (nameParts.length > 1 ? nameParts[1][0] : '');
    return  Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Column(
        children: [
          Obx((){
            return Stack(
              children: [
                Container(
                    width: 35,
                    height: 35,
                    padding: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: item.isSelected?.value == 1 ? ColorResources.white : Colors.grey),
                      borderRadius: BorderRadius.circular(50),
                      color:  item.isSelected?.value == 1 ? ColorResources.orange : Colors.grey,
                    ),
                    child: Center(child: CustomTextMedium(initials,color: Colors.white,fontSize: Dimensions.fontSizeLarge))
                ),
                if(item.isSelected?.value == 1)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                        onTap: (){
                          onEditSelected.call();
                        },
                        child: Container(
                            width: 15,
                            height: 15,
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color:  ColorResources.red,
                            ),
                            child: Image.asset(Images.edit,color: ColorResources.toolbarText,))),
                  ),
              ],
            );
          }),
          SizedBox(
            width: 55,
            child: CustomTextMedium(
                item.name.toString(),
              textAlign: TextAlign.center,
                color: ColorResources.toolbarText,
              fontSize: Dimensions.fontSizeSmall,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
