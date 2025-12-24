import 'package:flutter/material.dart';

import '../../utill/color_resources.dart';

class CustomDefaultProgressIndicator extends StatelessWidget {
  const CustomDefaultProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorResources.colorPrimaryDark,
      ),
    );
  }
}
