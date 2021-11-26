import '/common/custom_text_button.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? buttonColor;
  final VoidCallback? onPressFunction;
  final Color? textColor;
  final String? text;
  final bool? isLoading;
  const CustomButton(
      {required this.height,
      required this.text,
      required this.width,
      required this.onPressFunction,
      required this.isLoading,
      required this.textColor,
      required this.buttonColor,
      required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius!),
          color: buttonColor),
      child: CustomTextButton(
        context: context,
        text: text!,
        isLoading: isLoading,
        textColor: textColor!,
        fontSize: 16,
        onPressFunction: null ?? onPressFunction,
      ),
    );
  }
}
