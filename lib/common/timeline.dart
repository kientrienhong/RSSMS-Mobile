import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:collection/collection.dart';

class TimeLine extends StatelessWidget {
  final List<Map<String, dynamic>> listTimeLine;
  const TimeLine({Key? key, required this.listTimeLine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> mapListTimeLine() {
      return listTimeLine
          .mapIndexed((index, element) => TimeLineElement(
                timeLine: element,
                currentIndex: index,
                listTimeLine: listTimeLine,
              ))
          .toList();
    }

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: mapListTimeLine(),
    );
  }
}

class TimeLineElement extends StatelessWidget {
  Map<String, dynamic> timeLine;
  List<Map<String, dynamic>> listTimeLine;
  int currentIndex;
  TimeLineElement(
      {Key? key,
      required this.timeLine,
      required this.listTimeLine,
      required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    Color color = currentIndex == listTimeLine.length - 1
        ? CustomColor.blue
        : CustomColor.black[3]!;

    return Container(
      width: deviceSize.width,
      margin: EdgeInsets.only(bottom: deviceSize.height / 12),
      child: Row(
        children: [
          Column(
            children: [
              CustomText(
                  text: '10/08',
                  color: color,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              CustomText(
                  text: '12:42',
                  color: color,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)
            ],
          ),
          CustomSizedBox(
            context: context,
            width: 8,
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              currentIndex == listTimeLine.length - 1
                  ? Container()
                  : Positioned(
                      left: 6,
                      child: Container(
                        width: 1,
                        color: CustomColor.black[3],
                        height: deviceSize.height / 7,
                      ),
                    ),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(6)),
              ),
            ],
          ),
          CustomSizedBox(
            context: context,
            width: 8,
          ),
          CustomText(
              text: timeLine['name'],
              color: color,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ],
      ),
    );
  }
}
