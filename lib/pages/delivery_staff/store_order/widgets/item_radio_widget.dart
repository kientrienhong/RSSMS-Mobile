import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_text.dart';

class ItemRadioWidget extends StatelessWidget {
  final Map<String, dynamic> product;

  const ItemRadioWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: CustomColor.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                blurRadius: 14,
                color: Color(0x000000).withOpacity(0.06),
                offset: const Offset(0, 6)),
          ]),
      child: Column(
        children: [
          SizedBox(
              height: deviceSize.height / 9,
              width: deviceSize.width / 9,
              child: Image.asset(product['url'])),
          CustomText(
              text: '${product['name']} x ${product['quantity']}',
              color: CustomColor.black,
              context: context,
              fontSize: 16),
          Radio(value: '${product['name']}', groupValue: 1, onChanged: (val) {})
        ],
      ),
    );
  }
}
