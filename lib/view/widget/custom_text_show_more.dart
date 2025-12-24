import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:astro_brahmand/utill/color_resources.dart';

class CustomTextShowMore extends StatefulWidget {
  final String fullText;
  const CustomTextShowMore({super.key, required this.fullText});
  @override
  CustomTextShowMoreState createState() => CustomTextShowMoreState();
}

class CustomTextShowMoreState extends State<CustomTextShowMore> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Text(
                widget.fullText,
                maxLines: isExpanded ? null : 2,
              ),
              const Gap(5.0),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isExpanded ? 'Show less' : 'Show more',
                      style: const TextStyle(color: ColorResources.colorPrimary),
                    ),
                    Icon(
                      isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded ,
                      color: Colors.green,
                    )
                  ],
                ),
              ),
              const Gap(5.0),
            ],
          ),
        ),
      ],
    );
  }
}