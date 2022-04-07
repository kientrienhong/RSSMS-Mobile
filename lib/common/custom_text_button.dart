import '/common/custom_text.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends Container {
  final String text;
  final Color textColor;
  final BuildContext context;
  final int fontSize;
  final bool isLoading;
  CustomTextButton(
      {Key? key,
      required this.text,
      required this.isLoading,
      required this.textColor,
      required this.context,
      required this.fontSize})
      : super(
          key: key,
          child: isLoading == true
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: CustomText(
                      text: text,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      context: context,
                      fontSize: fontSize),
                ),
        );
}
