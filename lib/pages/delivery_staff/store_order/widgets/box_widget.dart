import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/constants/constants.dart' as constants;
import 'package:rssms/models/entity/boxe.dart';

class BoxWidget extends StatelessWidget {
  final Boxe box;
  final int index;
  final int currentIndex;
  final Function onTap;
  const BoxWidget(
      {Key? key,
      required this.box,
      required this.currentIndex,
      required this.onTap,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Color currentColor =
    //     constants.LIST_NOTE_STATUS_BOX[box['status'] as int]['color'] as Color;

    return GestureDetector(
      onTap: () {
        onTap(index, box.orderId);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: currentIndex != index
              ? (box.orderId != null
                  ? CustomColor.brightBlue
                  : CustomColor.blue)
              : CustomColor.green,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: CustomText(
              text: box.sizeType + " " + box.id.toString(),
              color: CustomColor.black,
              fontWeight: FontWeight.bold,
              context: context,
              fontSize: 16),
        ),
      ),
    );
  }
}
