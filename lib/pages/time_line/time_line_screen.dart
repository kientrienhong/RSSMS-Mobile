import 'package:flutter/material.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/timeline.dart';
import 'package:rssms/constants/constants.dart' as constants;

class TimeLineScreen extends StatelessWidget {
  const TimeLineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: const [CustomAppBar(
              isHome: false,
              name: 'Thông tin vận chuyển',
            ),
             TimeLine(listTimeLine: constants.LIST_TIME_LINE_MODIFY)
          ],
        ),
      ),
    );
  }
}
