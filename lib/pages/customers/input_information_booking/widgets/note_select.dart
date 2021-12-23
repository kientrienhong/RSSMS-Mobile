import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';

class NoteSelect extends StatelessWidget {
  final String url;
  final String name;
  final int currentIndex;
  final int index;
  const NoteSelect(
      {Key? key,
      required this.url,
      required this.name,
      required this.currentIndex,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: CustomColor.white,
          boxShadow: [
            BoxShadow(
              color: CustomColor.black[3]!,
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(url),
          CustomSizedBox(
            context: context,
            height: 8,
          ),
          Flexible(
            child: CustomText(
                text: name,
                maxLines: 2,
                textAlign: TextAlign.center,
                color: CustomColor.black,
                context: context,
                fontSize: 18),
          )
        ],
      ),
    );
  }
}
