import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:astro_brahmand/utill/images.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double? width;
  final BoxFit? fit;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    required this.height,
    this.width,
    this.fit,
  });


  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => Image.asset(Images.placeholder),
      errorWidget: (context, url, error) => Image.asset(Images.placeholder),
      fit: fit ?? BoxFit.fill,
      height: height,
      width: width,
    );
  }
}
