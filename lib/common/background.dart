import 'package:flutter/material.dart';
import './circle_background.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        CircleBackground(
            positionLeft: -deviceSize.width / 2,
            positionTop: -deviceSize.height / 4,
            size: deviceSize.width * 0.9),
        CircleBackground(
            positionLeft: deviceSize.width / 1.5,
            positionTop: deviceSize.height / 10,
            size: deviceSize.width * 0.2),
        CircleBackground(
            positionLeft: -deviceSize.width / 3,
            positionTop: deviceSize.height / 1.3,
            size: deviceSize.width * 0.8),
        CircleBackground(
            positionLeft: deviceSize.width / 1.17,
            positionTop: deviceSize.height / 3,
            size: deviceSize.width * 0.25),
      ],
    );
  }
}
