import '/common/custom_color.dart';
import '/common/custom_text.dart';
import 'package:flutter/material.dart';

class CustomMsgInput extends StatelessWidget {
  final String msg;
  final bool isError;
  final int maxLines;
  CustomMsgInput(
      {required this.msg, required this.isError, required this.maxLines});

  @override
  Widget build(BuildContext context) {
    if (isError) {
      if (msg.length > 0) {
        return CustomText(
            text: msg,
            color: CustomColor.red,
            textAlign: TextAlign.center,
            maxLines: maxLines,
            context: context,
            fontSize: 16);
      }
    } else {
      return CustomText(
          text: msg,
          color: CustomColor.green,
          maxLines: 1,
          context: context,
          fontSize: 16);
    }

    return Container();
  }
}
