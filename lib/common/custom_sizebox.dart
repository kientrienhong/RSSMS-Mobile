import 'package:flutter/cupertino.dart';

class CustomSizedBox extends SizedBox {
  static const heightMockUp = 896;
  static const widthMockUp = 414;
  final height;
  final width;
  CustomSizedBox(
      {Key? key,
      required BuildContext context,
      this.height = 0,
      this.width = 0})
      : super(
            key: key,
            height:
                MediaQuery.of(context).size.height / (heightMockUp / height!),
            width: MediaQuery.of(context).size.width / (widthMockUp / width!));
}
