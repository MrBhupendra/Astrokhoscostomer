import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:astro_brahmand/utill/app_logger.dart';
class DeeplinkAstrologerDetail extends StatelessWidget {
  const DeeplinkAstrologerDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = Get.parameters['id'];
    AppLogger.d("AS1 Id $productId");

    return const Placeholder();
  }
}
