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
  final bool isLoading;
  const CustomButton(
      {required this.height,
      required this.text,
      required this.width,
      required this.onPressFunction,
      required this.isLoading,
      required this.textColor,
      required this.buttonColor,
      required this.borderRadius,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heightMockUp = 896;
    final widthMockUp = 414;

    return GestureDetector(
      onTap: null ?? onPressFunction,
      child: Container(
        height: MediaQuery.of(context).size.height * (height! / widthMockUp),
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius!),
            color: buttonColor),
        child: Center(
          child: CustomTextButton(
            context: context,
            text: text!,
            isLoading: isLoading,
            textColor: textColor!,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
