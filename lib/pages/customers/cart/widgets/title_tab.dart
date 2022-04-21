import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';

class TitleTab extends StatefulWidget {
  final int index;
  final int currentIndex;
  final Map<String, String> title;
  final void Function(int) onChangeTab;
  final Size deviceSize;
  const TitleTab(
      {Key? key,
      required this.deviceSize,
      required this.title,
      required this.onChangeTab,
      required this.index,
      required this.currentIndex})
      : super(key: key);

  @override
  State<TitleTab> createState() => _TitleTabState();
}

class _TitleTabState extends State<TitleTab> {
  @override
  Widget build(BuildContext context) {
    Color color = widget.index != widget.currentIndex
        ? CustomColor.black[3]!
        : CustomColor.blue;

    return GestureDetector(
      onTap: () {
        widget.onChangeTab(widget.index);
      },
      child: Column(children: [
        CustomText(
            text: widget.title['name']!,
            color: color,
            context: context,
            fontSize: 16),
        CustomSizedBox(context: context, height: 4),
        widget.index == widget.currentIndex
            ? Container(
                width: widget.deviceSize.width / 6,
                height: 4,
                color: CustomColor.blue,
              )
            : Container()
      ]),
    );
  }
}
