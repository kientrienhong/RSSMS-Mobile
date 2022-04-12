import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:collection/collection.dart';
import 'package:rssms/models/entity/timeline.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class TimeLine extends StatelessWidget {
  final List<Timeline> listTimeLine;
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: mapListTimeLine(),
      ),
    );
  }
}

class TimeLineElement extends StatelessWidget {
  final Timeline timeLine;
  final List<Timeline> listTimeLine;
  final int currentIndex;
  const TimeLineElement(
      {Key? key,
      required this.timeLine,
      required this.listTimeLine,
      required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    Intl.defaultLocale = "vi";
    initializeDateFormatting('vi', null);

    var dateCreate =
        DateFormat('yyyy-MM-ddTHH:mm:ss', 'vi').parse(timeLine.datetime);

    Color color = currentIndex == 0 ? CustomColor.blue : CustomColor.black[3]!;
    FontWeight fontWeight =
        currentIndex == 0 ? FontWeight.bold : FontWeight.normal;
    return Container(
      width: deviceSize.width,
      margin: EdgeInsets.only(bottom: deviceSize.height / 12),
      child: Row(
        children: [
          Column(
            children: [
              CustomText(
                  text: DateFormat('dd / MM').format(dateCreate),
                  color: color,
                  context: context,
                  fontWeight: fontWeight,
                  fontSize: 16),
              CustomText(
                  text: DateFormat('HH : mm').format(dateCreate),
                  color: color,
                  context: context,
                  fontWeight: fontWeight,
                  fontSize: 16)
            ],
          ),
          CustomSizedBox(
            context: context,
            width: 16,
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
                        height: deviceSize.height / 7.9,
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
          Flexible(
            child: CustomText(
                text: timeLine.name,
                color: color,
                context: context,
                fontWeight: fontWeight,
                maxLines: 2,
                fontSize: 16),
          ),
        ],
      ),
    );
  }
}
