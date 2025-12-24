import 'package:astro_brahmand/utill/app_constants.dart';
import 'package:astro_brahmand/utill/common_methods.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../../utill/color_resources.dart';
import '../../../../../utill/dimensions.dart';
import '../../../../widget/custom_round_network_image.dart';
import '../../../../widget/custom_text_regular.dart';
import '../model/live_request_model.dart';

class LiveRequestWidget extends StatelessWidget {
  final LiveRequestModel requestModel;
  const LiveRequestWidget(this.requestModel, {super.key});

  @override
  Widget build(BuildContext context) {
    String type = "";
    if (requestModel.callType == AppConstants.liveVideoCall) {
      type = "Video Call";
    }else if (requestModel.callType == AppConstants.liveAudioCall) {
      type = "Audio Call";
    }else if (requestModel.callType == AppConstants.privateLiveAudioCall) {
      type = "Private Audio Call";
    } else {
      type = "Private Video Call";
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomRoundNetworkImage(
                    imageUrl: requestModel.profileImageUrl.toString(),
                    height:
                    35,
                    width:
                    35
                ),
                const Gap(Dimensions.gapExtraSmall),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextRegular(
                        requestModel.name.toString(),
                        fontSize: Dimensions.fontSizeFifteen,
                        color: ColorResources.black,
                      ),
                      const Gap(Dimensions.gapExtraExtraSmall),
                      CustomTextRegular(
                        type.toString(),
                        fontSize: Dimensions.fontSizeDefault,
                        color: ColorResources.colorPrimaryDark,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextRegular(
                      CommonMethods().getFormattedTimeFromSecLive(requestModel.duration!.toInt()),
                      fontSize: Dimensions.fontSizeDefault,
                      color: ColorResources.colorPrimaryDark,
                    ),
                  ],
                )

              ],
            ),
          ),
        ],
      ),
    );
  }
}
