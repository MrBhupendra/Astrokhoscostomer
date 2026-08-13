import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gap/gap.dart';
import 'package:astro_brahmand/utill/app_fonts.dart';
import 'package:astro_brahmand/utill/color_resources.dart';

class CustomHtmlTextExpanded extends StatefulWidget {
  final String fullText;
  final MainAxisAlignment mainAxisAlignment;
  final Color textColor;
  final Color iconColor;

  const CustomHtmlTextExpanded({
    super.key,
    required this.fullText,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.textColor = ColorResources.colorPrimary,
    this.iconColor = Colors.green,
  });

  @override
  CustomHtmlTextExpandedState createState() => CustomHtmlTextExpandedState();
}

class CustomHtmlTextExpandedState extends State<CustomHtmlTextExpanded> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Html(
          data: widget.fullText,
          style: {
            '*': Style(
              fontFamilyFallback: AppFonts.fallback,
            ),
            'body': Style(
              maxLines: isExpanded ? null : 2,
              color: ColorResources.black1,
              fontSize: FontSize.medium,
              fontFamily: AppFonts.euclidRegular,
              fontFamilyFallback: AppFonts.fallback,
            ),
          },
        ),
        // Text(
        //   widget.fullText,
        //   maxLines: isExpanded ? null : 2,
        // ),
        // const Gap(5.0),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Row(
            mainAxisAlignment: widget.mainAxisAlignment,
            children: [
              Text(
                isExpanded ? 'Show less' : 'Show more',
                style: TextStyle(color: widget.textColor),
              ),
              Icon(
                isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded ,
                color: widget.iconColor,
              )
            ],
          ),
        ),
        const Gap(5.0),
      ],
    );
  }
}