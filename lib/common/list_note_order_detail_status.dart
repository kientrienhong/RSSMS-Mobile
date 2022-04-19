import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/constants/constants.dart' as constants;

class ListNoteOrderDetailStatus extends StatelessWidget {
  const ListNoteOrderDetailStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: constants.listStatusOfOrderDetail.length,
      itemBuilder: (_, index) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                  color: constants.listStatusOfOrderDetail[index]['color']
                      as Color,
                  borderRadius: BorderRadius.circular(8)),
            ),
            CustomSizedBox(
              context: context,
              width: 8,
            ),
            CustomText(
                text:
                    constants.listStatusOfOrderDetail[index]['name'] as String,
                color: CustomColor.black,
                context: context,
                fontSize: 16)
          ],
        ),
      ),
      shrinkWrap: true,
    );
  }
}
