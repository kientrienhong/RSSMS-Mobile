import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';

class NoteSelect extends StatelessWidget {
  final String url;
  final String name;
  final List<int> currentIndex;
  final int index;
  final Function onTapChoice;
  const NoteSelect(
      {Key? key,
      required this.url,
      required this.onTapChoice,
      required this.name,
      required this.currentIndex,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int indexFound = currentIndex.indexOf(index);
    return GestureDetector(
      onTap: () {
        onTapChoice(index, indexFound);
      },
      child: Container(
        decoration: BoxDecoration(
            color: CustomColor.white,
            boxShadow: [
              indexFound == -1
                  ? BoxShadow(
                      color: CustomColor.black[3]!,
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 0), // changes position of shadow
                    )
                  : BoxShadow(),
            ],
            border: indexFound == -1
                ? Border.all(width: 0)
                : Border.all(width: 3, color: CustomColor.blue),
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
      ),
    );
  }
}
