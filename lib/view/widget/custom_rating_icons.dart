import 'package:flutter/material.dart';

import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';

class CustomRatingIcons extends StatelessWidget {
  final double rating;
  final double? iconSize;

  const CustomRatingIcons({super.key, required this.rating, this.iconSize});

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    double size = iconSize ?? Dimensions.iconSizeMediumSmall;

    List<Icon> stars = List.generate(
      5,
          (index) {
        if (index < fullStars) {
          return Icon(Icons.star_sharp,
              color: ColorResources.colorRatingIcon, size: size);
        } else if (index == fullStars && hasHalfStar) {
          return Icon(Icons.star_half_sharp,
              color: ColorResources.colorRatingIcon, size: size);
        } else {
          return Icon(Icons.star_border_sharp,
              color: ColorResources.colorRatingIcon, size: size);
        }
      },
    );

    return Row(children: stars);
  }
}
