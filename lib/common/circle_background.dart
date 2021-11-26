import '/common/custom_color.dart';
import 'package:flutter/material.dart';

class CircleBackground extends StatelessWidget {
  final double size;
  final double positionTop;
  final double positionLeft;

  CircleBackground(
      {required this.size,
      required this.positionLeft,
      required this.positionTop});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: positionTop,
        left: positionLeft,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              color: CustomColor.lightBlue,
              borderRadius: BorderRadius.circular(size / 2)),
        ));
  }
}
