import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_text.dart';

class TabButton extends StatelessWidget {
  final String text;
  final int? selectedPage;
  final int? pageNumber;
  final Function() onPressed;

  const TabButton(
      {Key? key,
      required this.text,
      this.selectedPage,
      this.pageNumber,
      required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastLinearToSlowEaseIn,
   
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: CustomText(text: text, color: CustomColor.black, context: context, fontSize: 16),
      ),
    );
  }
}
