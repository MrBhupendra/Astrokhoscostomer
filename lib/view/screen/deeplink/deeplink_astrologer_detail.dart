import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeeplinkAstrologerDetail extends StatelessWidget {
  const DeeplinkAstrologerDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = Get.parameters['id'];
    debugPrint("AS1 Id $productId");

    return const Placeholder();
  }
}
