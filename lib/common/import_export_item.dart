import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/product.dart';

class ImportExportItem extends StatelessWidget {
  final OrderDetail orderDetail;
  const ImportExportItem({Key? key, required this.orderDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
 
                    child: CustomText(
                        text: orderDetail.productName,
                        color: CustomColor.black,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                        context: context,
                        fontSize: 16),
                  ),
                  CustomText(
                      text: orderDetail.note,
                      color: Colors.grey,
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                      context: context,
                      fontSize: 12),
                ],
              ),
              CustomText(
                  text: "x " + orderDetail.amount.toString(),
                  color: CustomColor.black,
                  textAlign: TextAlign.right,
                  context: context,
                  fontSize: 14),
            ],
          ),
        ]),
      ],
    );
  }
}
