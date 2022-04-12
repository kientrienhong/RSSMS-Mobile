import 'package:rssms/common/custom_color.dart';

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
  final bool? isCancelButton;
  final int? textSize;
  const CustomButton(
      {required this.height,
      required this.text,
      required this.width,
      required this.onPressFunction,
      required this.isLoading,
      required this.textColor,
      required this.buttonColor,
      required this.borderRadius,
      this.textSize,
      this.isCancelButton = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const widthMockUp = 414;

    return GestureDetector(
      onTap: isLoading == false ? onPressFunction : () {},
      child: Container(
        height: MediaQuery.of(context).size.height * (height! / widthMockUp),
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius!),
            border: isCancelButton == true
                ? Border.all(color: CustomColor.red, width: 1)
                : Border.all(width: 0, color: CustomColor.white),
            color: buttonColor),
        child: Center(
          child: CustomTextButton(
            context: context,
            text: text!,
            isLoading: isLoading,
            textColor: textColor!,
            fontSize: textSize ?? 16,
          ),
        ),
      ),
    );
  }
}
