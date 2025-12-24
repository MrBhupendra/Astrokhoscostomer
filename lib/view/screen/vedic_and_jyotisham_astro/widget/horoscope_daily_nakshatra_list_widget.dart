import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import '../../../../model/menu_model.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';

class HoroscopeDailyNakshatraList extends StatelessWidget {
  final List<MenuModel> horoscopeDailyListCo;
  final Function(int) onItemSelected;

  const HoroscopeDailyNakshatraList({super.key, required this.horoscopeDailyListCo, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Container(
        decoration: const BoxDecoration(
          color: ColorResources.colorPrimaryLight, // Set the background color to red
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            for (int index = 0; index < horoscopeDailyListCo.length; index++)
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => onItemSelected(index),
                      child: Column(
                        children: [
                          const Gap(5),
                          Image.asset(
                            horoscopeDailyListCo[index].image,
                            height: 35,
                            width: 35,
                          ),
                          const Gap(7),
                          Expanded(
                            child: Text(
                              horoscopeDailyListCo[index].title,
                              style: const TextStyle(fontSize: Dimensions.fontSizeDefault, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(20),
                ],
              ),
          ],
        ),
      )
      ,
    );
  }
}