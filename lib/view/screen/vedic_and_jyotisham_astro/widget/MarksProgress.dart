
import 'package:flutter/material.dart';

import '../../../../utill/color_resources.dart';

class MarksProgress extends StatelessWidget {
  final num totalMarks;
  final num obtainedMarks;

  const MarksProgress({super.key, required this.totalMarks, required this.obtainedMarks});

  @override
  Widget build(BuildContext context) {
    double percentage = obtainedMarks / totalMarks;
    return Padding(
      padding: const EdgeInsets.only(left: 0,top:5,bottom: 3),
      child: Container(
        height: 7.0,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          gradient: LinearGradient(
            colors: [
              ColorResources.colorPrimary, // Color for obtained marks
              Colors.grey.withOpacity(0.5), // Light color for remaining marks
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [percentage, percentage],
          ),
        ),
      ),
    );
  }
}
