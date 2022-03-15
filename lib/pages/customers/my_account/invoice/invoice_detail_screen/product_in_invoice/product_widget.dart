import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/order_detail.dart';

class ProductInvoiceWidget extends StatelessWidget {
  OrderDetail? product;

  ProductInvoiceWidget({Key? key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final oCcy = NumberFormat("#,##0", "en_US");
    return SizedBox(
        child: Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      defaultColumnWidth: const FlexColumnWidth(1),
      children: [
        TableRow(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                
                  Image.network(
                    product!.serviceImageUrl,
                    errorBuilder:(context, error, stackTrace) => Image.asset("assets/images/noimage.jpg", height: 100, width: 100,),
                    height: 50,
                    width: 50,
                  ),
                  CustomSizedBox(
                    context: context,
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: deviceSize.width * 2 / 8,
                        child: CustomText(
                            text: product!.productName,
                            color: CustomColor.black,
                            fontWeight: FontWeight.bold,
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                            context: context,
                            fontSize: 14),
                      ),
                      CustomSizedBox(
                        context: context,
                        height: 6,
                      ),
                      CustomText(
                          text: oCcy.format(product!.price) + "đ/ tháng",
                          color: CustomColor.blue,
                          fontWeight: FontWeight.bold,
                          context: context,
                          fontSize: 14),
                    ],
                  ),
                ],
              ),
              CustomText(
                  text: "x " + product!.amount.toString(),
                  color: CustomColor.black,
                  textAlign: TextAlign.right,
                  context: context,
                  fontSize: 16),
            ],
          ),
        ])
      ],
    ));
  }
}
