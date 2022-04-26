import 'package:flutter/material.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/history_extend_widget.dart';

import 'package:rssms/models/entity/order_history_extension.dart';

class HistoryExtendScreen extends StatefulWidget {
  late List<OrderHistoryExtension>? listHistory;
  HistoryExtendScreen({Key? key, this.listHistory}) : super(key: key);

  @override
  State<HistoryExtendScreen> createState() => _HistoryExtendScreenState();
}

class _HistoryExtendScreenState extends State<HistoryExtendScreen> {
  List<Widget> mapProductWidget(listHistory) => listHistory
      .map<HistoryExtendWidget>((h) => HistoryExtendWidget(
            history: h,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(children: [
          const CustomAppBar(
            isHome: false,
            name: "Lịch sử gia hạn đơn",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomText(
                  text: "Ngày trả cũ",
                  color: CustomColor.black,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              CustomText(
                  text: "Ngày trả mới",
                  color: CustomColor.black,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              CustomText(
                  text: "Tổng tiền",
                  color: CustomColor.black,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ],
          ),
          CustomSizedBox(
            context: context,
            height: 24,
          ),
          Column(
            children: mapProductWidget(widget.listHistory),
          ),
        ]),
      ),
    );
  }
}
