import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/order_detail.dart';

class AccessoryInvoiceWidget extends StatelessWidget {
  OrderDetail? product;

  AccessoryInvoiceWidget({Key? key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final oCcy = NumberFormat("#,##0", "en_US");

    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.network(
                product!.images[0].url,
                height: 50,
                width: 50,
              ),
              CustomSizedBox(
                context: context,
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: product!.productName,
                      color: CustomColor.black,
                      fontWeight: FontWeight.bold,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                      context: context,
                      fontSize: 14),
                  CustomSizedBox(
                    context: context,
                    height: 6,
                  ),
                  CustomText(
                      text: oCcy.format(product!.price) + "đ",
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
    );
  }
}
