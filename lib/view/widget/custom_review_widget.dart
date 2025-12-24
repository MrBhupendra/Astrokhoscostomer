import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:astro_brahmand/view/widget/custom_rating_icons.dart';

import '../../model/review_model.dart';
import '../../utill/color_resources.dart';
import '../../utill/common_methods.dart';
import '../../utill/dimensions.dart';
import 'custom_text_regular.dart';

class CustomReviewWidget extends StatelessWidget {

  ReviewsData reviews;
  CustomReviewWidget(this.reviews, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "${reviews.reviewByUser!.name.toString()} , "
                    "${CommonMethods().formatDateString(reviews.createdAt.toString())}",
                style: const TextStyle(fontSize: Dimensions.fontSizeDefault),
                overflow: TextOverflow.fade,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorResources.colorPrimaryLight.withOpacity(0.5),
                borderRadius: BorderRadius.circular(Dimensions.borderRadiusRounded),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    CustomRatingIcons(
                      rating: reviews.reviewRating!.toDouble(),
                      iconSize: Dimensions.iconSizeOverSmall,
                    ),
                    CustomTextRegular(double.parse(reviews.reviewRating!.toString()).toString(),
                      maxLines: 1,
                      fontSize: Dimensions.fontSizeSmall,),
                  ],
                ),
              ),
            ),
          ],
        ),
        const Gap(Dimensions.gapExtraSmall),
        CustomTextRegular(
          reviews.reviewComment.toString(),
          fontSize: Dimensions.fontSizeSmall,
          color: ColorResources.black1,
        ),
        const Gap(Dimensions.gapSmall),
        const Divider(
          thickness: 1.0,
        ),
      ],
    );
  }
}
