import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';

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
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(0),
        child: Row(
          children: [
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.resolveWith((states) => color),
                shape: MaterialStateProperty.all(const CircleBorder()),
                side: MaterialStateProperty.all(
                  const BorderSide(color: CustomColor.blue, width: 1.5),
                ),
                maximumSize: MaterialStateProperty.all(
                  const Size(50, 50),
                ),
                minimumSize: MaterialStateProperty.all(
                  const Size(25, 25),
                ),
              ),
              onPressed: () {
                function();
              },
              child: const Icon(
                Icons.check,
                size: 15,
                color: CustomColor.white,
              ),
            ),
            Flexible(
              child: Text(
                text,
                maxLines: null,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: (state == value) ? CustomColor.blue : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
