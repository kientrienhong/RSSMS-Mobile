import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/time_select.dart';
import '../constants/constants.dart' as constants;

class ListTimeSelect extends StatelessWidget {
  final int currentIndex;
  final Function(int) onChangeTab;
  const ListTimeSelect(
      {Key? key, required this.currentIndex, required this.onChangeTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 4,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: List.generate(
          constants.LIST_TIME_PICK_UP.length,
          (index) => TimeSelect(
                onChangeTime: onChangeTab,
                currentIdex: currentIndex,
                index: index,
                time: constants.LIST_TIME_PICK_UP[index],
                key: UniqueKey(),
              )),
    );
  }
}
