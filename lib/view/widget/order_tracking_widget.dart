import 'package:astro_brahmand/utill/color_resources.dart';
import 'package:astro_brahmand/view/widget/custom_text_medium.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OrderTrackingWidget extends StatefulWidget {
  final String currentStatus;

  OrderTrackingWidget({required this.currentStatus});

  @override
  _OrderTrackingWidgetState createState() => _OrderTrackingWidgetState();
}

class _OrderTrackingWidgetState extends State<OrderTrackingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statuses = [
      "PENDING",
      "CONFIRM",
      "DISPATCH",
      "DELIVERED",
    ];

    if (widget.currentStatus == "CANCEL") {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: ColorResources.red.withOpacity(0.4 * _controller.value),
                              spreadRadius: 8.0 * _controller.value,
                              blurRadius: 12.0 * _controller.value,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Transform.scale(
                          scale: 1.0,
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: ColorResources.red,
                            child: Icon(
                              Icons.cancel,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(4),
                  CustomTextMedium(
                    "ORDER CANCELLED",
                    color: ColorResources.red,
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    }

    return Column(
      children: statuses.asMap().entries.map((entry) {
        final index = entry.key;
        final status = entry.value;
        final isCurrent = statuses[index] == widget.currentStatus;
        final isCompleted = statuses.indexOf(widget.currentStatus) > index;

        final color = isCompleted || isCurrent ? ColorResources.green : ColorResources.black5;


        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Container(
                      decoration: isCurrent
                          ? BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: ColorResources.green.withOpacity(
                                0.4 * _controller.value),
                            spreadRadius: 8.0 * _controller.value,
                            blurRadius: 12.0 * _controller.value,
                            offset: Offset(0, 0),
                          ),
                        ],
                      )
                          : null,
                      child: Transform.scale(
                        scale: 1.0,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: color,
                          child: Visibility(
                            visible: isCompleted||isCurrent,
                            child: Icon(
                              Icons.check,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                if (index != statuses.length - 1)
                  Container(
                    height: 60,
                    child: VerticalDivider(
                      thickness: 1.0,
                      color: isCompleted ? ColorResources.green : ColorResources.black5,
                    ),
                  ),
              ],
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(4),
                CustomTextMedium(
                  status.toUpperCase(),
                  color: color,
                ),
                SizedBox(height: index != statuses.length - 1 ? 60 : 0),
              ],
            ),
          ],
        );
      }).toList(),
    );
  }
}
