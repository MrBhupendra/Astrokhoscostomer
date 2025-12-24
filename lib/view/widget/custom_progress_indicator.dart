import 'package:flutter/material.dart';

import '../../utill/color_resources.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ModalBarrier(
            color: Colors.black.withOpacity(0.3),
            dismissible: false,
          ),
        ),
        const Center(
          child: CircularProgressIndicator(
            color: ColorResources.colorPrimaryDark,
          ),
        ),
      ],
    );
  }
}
