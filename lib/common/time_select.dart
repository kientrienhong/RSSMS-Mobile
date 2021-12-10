import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_text.dart';

class TimeSelect extends StatefulWidget {
  final String time;
  final int currentIdex;
  final int index;
  final Function(int) onChangeTime;
  const TimeSelect(
      {Key? key,
      required this.time,
      required this.currentIdex,
      required this.onChangeTime,
      required this.index})
      : super(key: key);

  @override
  _TimeSelectState createState() => _TimeSelectState();
}

class _TimeSelectState extends State<TimeSelect> {
  @override
  Widget build(BuildContext context) {
    Color colorBorder = widget.currentIdex == widget.index
        ? CustomColor.blue
        : CustomColor.black[3]!;
    Color colorBackground = widget.currentIdex == widget.index
        ? CustomColor.blue
        : CustomColor.white;
    Color colorText = widget.currentIdex == widget.index
        ? CustomColor.white
        : CustomColor.black[3]!;
    final deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => {widget.onChangeTime(widget.index)},
      child: Container(
          width: deviceSize.width / 2,
          decoration: BoxDecoration(
            color: colorBackground,
            border: Border.all(
              color: colorBorder,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: CustomText(
                text: widget.time,
                color: colorText,
                context: context,
                fontSize: 16),
          )),
    );
  }
}
