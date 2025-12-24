import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:astro_brahmand/model/services_model.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';

import '../../utill/images.dart';

class ServicesWidget extends StatelessWidget {
  final ServicesData servicesData;
  final Function? onPressed;

  const ServicesWidget(this.servicesData, {super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed?.call();
      },
      child: Container(
        // height: Get.height,
        // width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            fit: StackFit.expand,
            children: [
              FadeInImage(
                placeholder: const AssetImage(Images.placeholder), // Path to your placeholder image
                image: NetworkImage(servicesData.serviceImage.toString()),
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(Images.placeholder, fit: BoxFit.cover);
                },
                fadeInDuration: const Duration(milliseconds: 300),
              ),
              Container(
                color: Colors.black.withOpacity(0.4),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, left: 4, right: 4),
                  child: CustomTextMedium(
                    servicesData.serviceName.toString(),
                    textAlign: TextAlign.center,
                    color: ColorResources.black8,
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
