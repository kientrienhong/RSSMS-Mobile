import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/order_history_extension.dart';

class HistoryExtendWidget extends StatefulWidget {
  final OrderHistoryExtension history;

  const HistoryExtendWidget({Key? key, required this.history})
      : super(key: key);

  @override
  State<HistoryExtendWidget> createState() => _HistoryExtendWidgetState();
}

class _HistoryExtendWidgetState extends State<HistoryExtendWidget> {
  final oCcy = NumberFormat("#,##0", "en_US");

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomText(
              text: widget.history.oldReturnDate.split("T")[0],
              color: CustomColor.black,
              context: context,
              fontSize: 16),
          CustomText(
              text: widget.history.returnDate.split("T")[0],
              color: CustomColor.black,
              context: context,
              fontSize: 16),
          CustomText(
              text: oCcy.format(widget.history.totalPrice).toString() + "đ",
              color: CustomColor.black,
              context: context,
              fontSize: 16)
        ],
      ),
    );
  }
}
