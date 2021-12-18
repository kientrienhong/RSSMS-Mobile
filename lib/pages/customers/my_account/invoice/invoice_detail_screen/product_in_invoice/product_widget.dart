import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';

class ProductInvoiceWidget extends StatelessWidget {
  Map<String, dynamic>? product;

  ProductInvoiceWidget({Key? key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {0: FractionColumnWidth(.55)},
      defaultColumnWidth: const FlexColumnWidth(1),
      children: [
        TableRow(children: [
          Row(
            children: [
              Image.asset(
                product!["url"],
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: product!["name"],
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      context: context,
                      fontSize: 14),
                  CustomSizedBox(
                    context: context,
                    height: 6,
                  ),
                  CustomText(
                      text: product!["price"].toString() + "đ / tháng",
                      color: CustomColor.blue,
                      fontWeight: FontWeight.bold,
                      context: context,
                      fontSize: 14),
                ],
              ),
            ],
          ),
          CustomText(
              text: "x " + product!["quantity"].toString(),
              color: CustomColor.black,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
              context: context,
              fontSize: 20),
          CustomText(
              text:
                  (product!["quantity"] * product!["price"]).toString() + " đ",
              color: CustomColor.blue,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.bold,
              context: context,
              fontSize: 16),
        ])
      ],
    ));
  }
}
