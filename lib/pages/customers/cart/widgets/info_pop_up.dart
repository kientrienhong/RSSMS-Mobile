import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_text.dart';

class InfoPopUp extends StatelessWidget {
  final Map<String, dynamic>? product;
  const InfoPopUp({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: CustomText(
          text: 'Thông tin chi tiết',
          color: CustomColor.black,
          context: context,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        content: CustomText(
            text:
                'Weight < 10kg \n\nWidth < 40cm \n\n1 person carry \n\nType Item: Small carton box / Small vali / Guitar',
            color: CustomColor.black,
            context: context,
            maxLines: 80,
            fontSize: 16));
  }
}
