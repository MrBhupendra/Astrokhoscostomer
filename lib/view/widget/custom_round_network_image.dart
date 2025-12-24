import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../utill/dimensions.dart';
import '../../utill/images.dart';

class CustomRoundNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;

  const CustomRoundNetworkImage({super.key, required this.imageUrl, required this.height, required this.width});


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimensions.imageHeightExtraLarge / 2.0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => Image.asset(Images.placeholder),
        errorWidget: (context, url, error) => Image.asset(Images.placeholder),
        fit: BoxFit.cover,
        height: height,
        width: width,
      ),
    );
  }
}
