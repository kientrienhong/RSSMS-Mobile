import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/order_detail.dart';

class ItemRadioWidget extends StatelessWidget {
  final OrderDetail product;
  final Function onChangeRadio;
  final int currentChoicedProduct;
  const ItemRadioWidget(
      {Key? key,
      required this.currentChoicedProduct,
      required this.product,
      required this.onChangeRadio})
      : super(key: key);

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
                color: const Color(0x00000000).withOpacity(0.06),
                offset: const Offset(0, 6)),
          ]),
      child: Column(
        children: [
          SizedBox(
              height: deviceSize.height / 9,
              width: deviceSize.width / 9,
              child: Image.network(product.images[0].url!)),
          CustomText(
              text: '${product.productName} x ${product.amount}',
              color: CustomColor.black,
              context: context,
              fontSize: 16),
          Radio(
              value: product.id,
              groupValue: currentChoicedProduct,
              onChanged: (val) {
                onChangeRadio(val);
              })
        ],
      ),
    );
  }
}
