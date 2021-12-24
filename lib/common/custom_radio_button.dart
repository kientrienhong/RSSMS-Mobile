import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';

class CustomRadioButton extends StatelessWidget {
  VoidCallback function;
  String text;
  Color color;
  final state;
  final value;
  CustomRadioButton(
      {Key? key,
      required this.function,
      required this.text,
      required this.color,
      required this.state,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isCheck = state == value;

    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(0),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: isCheck ? CustomColor.blue : CustomColor.white,
                  border: Border.all(width: 1.5, color: CustomColor.blue)),
              child: const Center(
                child: Icon(
                  Icons.check,
                  size: 14,
                  color: CustomColor.white,
                ),
              ),
            ),
            CustomSizedBox(
              context: context,
              width: 8,
            ),
            Flexible(
              child: Text(
                text,
                maxLines: null,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isCheck ? CustomColor.blue : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
