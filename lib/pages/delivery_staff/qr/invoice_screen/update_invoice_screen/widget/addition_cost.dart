import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_text.dart';

class AddtionCost extends StatelessWidget {
  final Map<String, dynamic> additionCost;
  const AddtionCost({Key? key, required this.additionCost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,##0", "en_US");

    final deviceSize = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: (deviceSize.width - 48) / 4,
          child: CustomText(
              text: additionCost['id'].toString(),
              color: CustomColor.black[3]!,
              context: context,
              fontSize: 16),
        ),
        SizedBox(
          width: (deviceSize.width - 48) / 2.5,
          child: CustomText(
              text: additionCost['name'],
              color: CustomColor.black,
              context: context,
              fontSize: 16),
        ),
        SizedBox(
          width: (deviceSize.width - 48) / 3.5,
          child: CustomText(
              text: '${oCcy.format(additionCost['price'])} VND',
              color: CustomColor.blue,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.right,
              context: context,
              fontSize: 16),
        ),
      ],
    );
  }
}
