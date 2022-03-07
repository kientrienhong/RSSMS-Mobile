import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';

class ButtonIcon extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? buttonColor;
  final VoidCallback? onPressFunction;
  final Color? textColor;
  final String? text;
  final bool isLoading;
  final String? url;
  const ButtonIcon(
      {required this.height,
      required this.url,
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
    // final deviceSize = MediaQuery.of(context).size;
    // const heightMockUp = 896;
    const widthMockUp = 414;

    return GestureDetector(
        onTap: onPressFunction,
        child: Container(
          height: MediaQuery.of(context).size.height * (height! / widthMockUp),
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius!),
              color: buttonColor),
          child: isLoading == true
              ? const Center(
                  child: SizedBox(
                    height: 12,
                    width: 12,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      url!,
                      fit: BoxFit.cover,
                    ),
                    CustomSizedBox(context: context, width: 8),
                    CustomText(
                        text: text!,
                        color: CustomColor.white,
                        context: context,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)
                  ],
                ),
        ));
  }
}
