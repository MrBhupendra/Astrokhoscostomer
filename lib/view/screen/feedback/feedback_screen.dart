import 'package:astro_brahmand/view/screen/feedback/controller/feedback_controller.dart';
import 'package:astro_brahmand/view/widget/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../utill/app_strings.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../widget/custom_app_bar.dart';
import '../../widget/custom_elevated_button.dart';
import '../../widget/custom_round_network_image.dart';
import '../../widget/custom_text_medium.dart';
import '../../widget/custom_text_regular.dart';

class FeedbackScreen extends StatelessWidget {
  final String astrologerId, astrologerName, astrologerImage, uniqueId;

  FeedbackScreen(this.astrologerId, this.astrologerName, this.astrologerImage,
      this.uniqueId,
      {super.key});

  final feedbackTextController = TextEditingController();
  final FeedbackController controller = Get.put(FeedbackController());
  double _currentRating = 5.0;

  @override
  Widget build(BuildContext context) {
    feedbackTextController.text = '';
    return PopScope(
      onPopInvoked: (bool isPopGesture) {
        if (!isPopGesture) {
          Get.offAllNamed('/dashboard');
        }
      },
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            title: "Feedback",
            onBackPressed: () {
              Get.offAllNamed('/dashboard');
            },
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
              child: Column(
                children: [
                  const Gap(Dimensions.gapDefault),
                  CustomRoundNetworkImage(
                      imageUrl: astrologerImage,
                      height: Dimensions.imageHeightLarge,
                      width: Dimensions.imageHeightLarge),
                  const Gap(Dimensions.gapDefault),
                  CustomTextMedium(
                    astrologerName,
                    fontSize: Dimensions.fontSizeExtraLarge,
                  ),
                  const Gap(Dimensions.gapExtraLarge),
                  CustomTextRegular("Please rate this service",
                      color: ColorResources.colorPrimaryMedium),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: RatingBar.builder(
                      initialRating: _currentRating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: ColorResources.colorRatingIcon,
                      ),
                      unratedColor: ColorResources.black6,
                      // glowColor: ColorResources.ratingIcon,
                      glow: false,
                      onRatingUpdate: (rating) {
                        _currentRating = rating;
                      },
                    ),
                  ),
                  const Gap(Dimensions.gapDefault),
                  Row(
                    children: [
                      Expanded(
                          child: CustomTextRegular(
                              "Tell us your valuable review!")),
                    ],
                  ),
                  const Gap(Dimensions.gapExtraSmall),
                  TextFormField(
                    controller: feedbackTextController,
                    decoration: const InputDecoration(
                      hintText: 'Describe your experience',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorResources.colorPrimary,
                          width: 1,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorResources.colorPrimary,
                          width: 1,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeSmall,
                        horizontal: Dimensions.paddingSizeMediumSmall,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.formError.tr;
                      }
                      return null;
                    },
                    minLines: 4,
                    maxLines: 5,
                  ),
                  const Gap(12),
                  CustomElevatedButton(
                      onPressed: () {
                        if (feedbackTextController.text.toString().isNotEmpty) {
                          controller.submitReview(
                              astrologerId,
                              uniqueId,
                              _currentRating.toString(),
                              feedbackTextController.text.toString());
                        } else {
                          CustomSnackBar.showBottom(
                              "Please describe your experience");
                        }
                      },
                      text: "SUBMIT",
                      textColor: ColorResources.toolbarText,
                      backgroundColor: ColorResources.colorPrimary),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
