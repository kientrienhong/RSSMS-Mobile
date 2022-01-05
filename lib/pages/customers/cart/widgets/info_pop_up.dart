import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/product.dart';

class InfoPopUp extends StatelessWidget {
  final Product? product;
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
            text: product!.tooltip,
            color: CustomColor.black,
            context: context,
            maxLines: 80,
            fontSize: 16));
  }
}
