import 'package:astro_brahmand/utill/app_strings.dart';
import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utill/images.dart';

class DailyTarotLoader extends StatelessWidget {
   DailyTarotLoader({super.key});

  final AudioPlayer _audioPlayer = AudioPlayer();



  @override
  Widget build(BuildContext context) {
    _audioPlayer.play(AssetSource(Images.loaderSound));
    return SafeArea(
      child: Scaffold(
        body:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/tarot_loader.gif',width: 300,height: 300,color: ColorResources.colorPrimary,),
              CustomTextMedium(AppStrings.preparingCard.tr)
            ],
          ),
        ),
      ),
    );
  }
}
