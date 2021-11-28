import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/pages/customers/cart/widgets/quantity_widget.dart';

class ProductWidget extends StatefulWidget {
  final Map<String, dynamic>? product;
  ProductWidget({Key? key, this.product}) : super(key: key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    print(widget.product);
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: deviceSize.height / 4.7,
      width: deviceSize.width,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: CustomColor.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 14,
                color: Color(0x000000).withOpacity(0.06),
                offset: const Offset(0, 6)),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(widget.product!['url']!),
          SizedBox(
            width: deviceSize.width / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: widget.product!['name']!,
                        color: CustomColor.black,
                        context: context,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    Image.asset('assets/images/info.png')
                  ],
                ),
                CustomSizedBox(
                  context: context,
                  height: 8,
                ),
                CustomText(
                    text: 'Trọng lượng cho phép < 25kg',
                    color: CustomColor.black[3]!,
                    context: context,
                    fontSize: 16),
                CustomSizedBox(
                  context: context,
                  height: 4,
                ),
                CustomText(
                    text: '100.000đ / tháng',
                    color: CustomColor.blue,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                SizedBox(
                  width: deviceSize.width / 8,
                  child: QuantityWidget(
                    product: widget.product,
                    width: deviceSize.width / 8,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
