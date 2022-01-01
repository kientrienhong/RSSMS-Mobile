import 'package:flutter/material.dart';
import 'package:rssms/common/custom_sizebox.dart';

class TabButton extends StatelessWidget {
  final String text;
  final int? selectedPage;
  final int? pageNumber;
  final Function() onPressed;

  TabButton(
      {required this.text,
      this.selectedPage,
      this.pageNumber,
      required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastLinearToSlowEaseIn,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
        ),
      ),
    );
  }
}
