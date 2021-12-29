import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/invoice_product_widget/product_in_invoice/accessory_widget.dart';
import 'package:rssms/common/invoice_product_widget/product_in_invoice/product_widget.dart';

class InvoiceProductWidget extends StatelessWidget {
  Map<String, dynamic>? invoice;
  final Size deviceSize;
  final oCcy = NumberFormat("#,##0", "en_US");

  InvoiceProductWidget(
      {Key? key, required this.invoice, required this.deviceSize})
      : super(key: key);

  List<Widget> mapProductWidget(listProduct) => listProduct
      .map<ProductInvoiceWidget>((p) => ProductInvoiceWidget(
            product: p,
          ))
      .toList();
  List<Widget> mapAccessoryWidget(listProduct) => listProduct
      .map<AccessoryInvoiceWidget>((p) => AccessoryInvoiceWidget(
            product: p,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listProduct = invoice!["item"];
    List<Map<String, dynamic>> listAccessory = invoice!["accessory"];
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: CustomColor.blue, width: 2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: "Kho",
                color: CustomColor.blue,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 20),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            Table(
              columnWidths: {0: FractionColumnWidth(.55)},
              children: [
                TableRow(children: [
                  CustomText(
                      text: "Sản phẩm",
                      color: CustomColor.black,
                      fontWeight: FontWeight.bold,
                      context: context,
                      fontSize: 14),
                  CustomText(
                      text: "Số lượng",
                      color: CustomColor.black,
                      fontWeight: FontWeight.bold,
                      context: context,
                      fontSize: 14),
                  CustomText(
                      text: "Tổng tiền",
                      color: CustomColor.black,
                      fontWeight: FontWeight.bold,
                      context: context,
                      fontSize: 14)
                ])
              ],
            ),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            Column(
              children: mapProductWidget(listProduct),
            ),
            Container(
              color: CustomColor.white,
              child: const Divider(
                thickness: 0.6,
                color: Color(0xFF8D8D8D),
              ),
            ),
            CustomSizedBox(
              context: context,
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: "Tạm tính",
                    color: Colors.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                CustomText(
                    text: oCcy.format(invoice!["totalItem"]),
                    color: Colors.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ],
            ),
            CustomSizedBox(
              context: context,
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: "Tháng",
                    color: Colors.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                CustomText(
                    text: "x" + invoice!["month"].toString(),
                    color: Colors.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ],
            ),
            CustomSizedBox(
              context: context,
              height: 10,
            ),
            Container(
              color: CustomColor.white,
              child: const Divider(
                thickness: 0.6,
                color: Color(0xFF8D8D8D),
              ),
            ),
            CustomSizedBox(
              context: context,
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: "Tổng tiền thuê kho",
                    color: Colors.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                CustomText(
                    text:
                        oCcy.format(invoice!["month"] * invoice!["totalItem"]) +
                            " đ",
                    color: CustomColor.blue,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ],
            ),
            CustomSizedBox(
              context: context,
              height: 24,
            ),
            CustomText(
                text: "Phụ kiện đóng gói",
                color: CustomColor.blue,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 20),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            Table(
              columnWidths: {0: FractionColumnWidth(.57)},
              children: [
                TableRow(children: [
                  CustomText(
                      text: "Sản phẩm",
                      color: CustomColor.black,
                      fontWeight: FontWeight.bold,
                      context: context,
                      fontSize: 14),
                  CustomText(
                      text: "Số lượng",
                      color: CustomColor.black,
                      fontWeight: FontWeight.bold,
                      context: context,
                      fontSize: 14),
                  CustomText(
                      text: "Tổng tiền",
                      color: CustomColor.black,
                      fontWeight: FontWeight.bold,
                      context: context,
                      fontSize: 14)
                ])
              ],
            ),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            Column(
              children: mapAccessoryWidget(listAccessory),
            ),
            Container(
              color: CustomColor.white,
              child: const Divider(
                thickness: 0.6,
                color: Color(0xFF8D8D8D),
              ),
            ),
            CustomSizedBox(
              context: context,
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: "Tổng tiền phụ kiện",
                    color: Colors.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                CustomText(
                    text: oCcy.format(
                            invoice!["totalPrice"] - invoice!["totalItem"]) +
                        " đ",
                    color: CustomColor.blue,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ],
            ),
            CustomSizedBox(
              context: context,
              height: 10,
            ),
            Container(
              color: CustomColor.white,
              child: const Divider(
                thickness: 0.6,
                color: Color(0xFF8D8D8D),
              ),
            ),
            CustomSizedBox(
              context: context,
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: "Tổng cộng (tạm tính): ",
                    color: Colors.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                CustomText(
                    text: oCcy.format(invoice!["totalPrice"]) + " đ",
                    color: CustomColor.blue,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ],
            ),
            CustomSizedBox(
              context: context,
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: "Giảm Giá: ",
                    color: Colors.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                CustomText(
                    text: "0 đ",
                    color: CustomColor.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ],
            ),
            CustomSizedBox(
              context: context,
              height: 10,
            ),
            Container(
              color: CustomColor.white,
              child: const Divider(
                thickness: 0.6,
                color: Color(0xFF8D8D8D),
              ),
            ),
            CustomSizedBox(
              context: context,
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: "Tổng Cộng: ",
                    color: Colors.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
                CustomText(
                    text: oCcy.format(invoice!["totalPrice"]) + " đ",
                    color: CustomColor.blue,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
