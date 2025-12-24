
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../model/menu_model.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../widget/custom_text_regular.dart';

class CustomBottomSheet extends StatelessWidget {
  final List<MenuModel> horoscopeListCo;
  final Function(int) onItemSelected;

  const CustomBottomSheet({super.key, required this.horoscopeListCo, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemCount: horoscopeListCo.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              horoscopeListCo[index].number;
              onItemSelected(index);
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left:Dimensions.paddingSizeDefault,right:Dimensions.paddingSizeDefault,top:Dimensions.paddingSizeExtraSmall),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorResources.colorPrimary,width: 0.5),
                    ),
                    child: Center(
                      child: Image.asset(horoscopeListCo[index].image,height: 35,width: 35,),
                    ),
                  ),
                  const Gap(10),
                  Expanded(child: CustomTextRegular(horoscopeListCo[index].title,))
                ],
              )
            ),
          );
        },
      ),
    );
  }
}
