import 'package:flutter/material.dart';
class DottedWidget extends StatelessWidget {
  final Axis direction;
  final double length;
  final double dashLength;
  final Color dashColor;
  const DottedWidget({
    super.key,
    required this.direction,
    required this.length,
    required this.dashLength,
    required this.dashColor,
  });
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: direction,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate((length / dashLength).floor(), (index) {
        return SizedBox(
          width: direction == Axis.horizontal ? dashLength : 1,
          height: direction == Axis.vertical ? dashLength : 1,
          child: DecoratedBox(
            decoration: BoxDecoration(color: dashColor),
          ),
        );
      }),
    );
  }
}