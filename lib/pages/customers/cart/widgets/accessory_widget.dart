import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/pages/customers/cart/widgets/info_pop_up.dart';
import 'package:rssms/pages/customers/cart/widgets/quantity_widget.dart';
import 'package:rssms/views/product_view.dart';

class AccessoryWidget extends StatefulWidget {
  Map<String, dynamic>? product;

  AccessoryWidget({Key? key, required this.product}) : super(key: key);

  @override
  State<AccessoryWidget> createState() => _AccessoryWidgetState();
}

class _AccessoryWidgetState extends State<AccessoryWidget>
    implements ProductView {
  @override
  void onAddQuantity() {
    Map<String, dynamic> tempProduct = {...widget.product!};
    tempProduct['quantity'] += 1;
    setState(() {
      widget.product = tempProduct;
    });
  }

  @override
  void onMinusQuantity() {
    Map<String, dynamic> tempProduct = {...widget.product!};
    if (tempProduct['quantity'] == 0) {
      return;
    }
    tempProduct['quantity'] -= 1;
    setState(() {
      widget.product = tempProduct;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: CustomColor.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 14,
                color: Color(0x000000).withOpacity(0.06),
                offset: const Offset(0, 6)),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return InfoPopUp(
                          product: widget.product,
                        );
                      });
                },
                child: Container(
                    margin: const EdgeInsets.only(right: 8, top: 8),
                    child: Image.asset('assets/images/info.png')),
              ),
            ],
          ),
          SizedBox(
              height: deviceSize.width / 8,
              width: deviceSize.width / 8,
              child: Image.asset(widget.product!['url']!)),
          CustomSizedBox(
            context: context,
            height: 8,
          ),
          CustomText(
              text: widget.product!['name']!,
              color: CustomColor.black,
              context: context,
              fontWeight: FontWeight.bold,
              maxLines: 2,
              textAlign: TextAlign.center,
              fontSize: 20),
          CustomSizedBox(
            context: context,
            height: 8,
          ),
          CustomText(
              text: 'Trọng lượng cho phép < 25kg',
              color: CustomColor.black[3]!,
              context: context,
              maxLines: 2,
              textAlign: TextAlign.center,
              fontSize: 16),
          CustomSizedBox(
            context: context,
            height: 8,
          ),
          CustomText(
              text: '100.000đ / tháng',
              color: CustomColor.blue,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 20),
          CustomSizedBox(
            context: context,
            height: 16,
          ),
          QuantityWidget(
            product: widget.product,
            width: deviceSize.width / 10,
            minusQuantity: onMinusQuantity,
            addQuantity: onAddQuantity,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
