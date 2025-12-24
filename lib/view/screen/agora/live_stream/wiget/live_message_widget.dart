import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../utill/color_resources.dart';
import '../../../../../utill/dimensions.dart';
import '../../../../widget/custom_round_network_image.dart';
import '../../../../widget/custom_text_medium.dart';
import '../../../../widget/custom_text_regular.dart';
import '../../../chat/model/chat_message_model.dart';

class LiveMessageWidget extends StatelessWidget {
  final ChatMessageModel message;
  const LiveMessageWidget(this.message,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Padding(
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextRegular(
                    message.name.toString(),
                    fontSize: Dimensions.fontSizeSmall,
                    color: ColorResources.white,
                  ),
                  const Gap(1),
                  CustomTextMedium(
                    message.text.toString(),
                    fontSize: Dimensions.fontSizeDefault,
                    color: ColorResources.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
