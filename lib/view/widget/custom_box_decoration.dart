import 'package:flutter/material.dart';

import '../../utill/color_resources.dart';

class CustomBoxDecoration {
  static BoxDecoration getDecoration() {
    return BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: ColorResources.colorPrimaryVariant, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2),
          )
        ]
    );
  }

  static BoxDecoration getServiceDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
              offset: Offset(1, 1),
              blurRadius: 3,
              color: Colors.grey
          ),
        ],
        border: Border.all(
          color: ColorResources.colorPrimary,
          width: 0.5,
        )
    );

  }

  static BoxDecoration getBorderDecoration() {
    return BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                offset: Offset(1, 1),
                blurRadius: 3,
                color: Colors.grey
            ),
          ],
          border: Border.all(color: ColorResources.colorPrimary, width: 0.6)
    );

  }
}
