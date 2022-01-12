import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/product_in_invoice/accessory_widget.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/product_in_invoice/product_widget.dart';

class InvoiceProductWidget extends StatelessWidget {
  Invoice? invoice;
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
    List<OrderDetail> listTemp = invoice!.orderDetails;
    List<OrderDetail> listProduct =
        listTemp.where((element) => element.productType == 2).toList();
    List<OrderDetail> listAccessory =
        listTemp.where((element) => element.productType == 1).toList();
    if (listProduct.isEmpty) {
      listProduct =
          listTemp.where((element) => element.productType == 0).toList();
    }
    int totalProduct = 0;
    int totalAccessory = 0;
    listAccessory.forEach((element) {
      totalAccessory += (element.price * element.amount);
    });
    listProduct.forEach((element) {
      totalProduct += (element.price * element.amount);
    });
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
                      textAlign: TextAlign.right,
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
                    text: oCcy.format(totalProduct),
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
                    text: "x" + invoice!.durationMonths.toString(),
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
                    text: oCcy.format(totalProduct * invoice!.durationMonths) +
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
              children: [
                TableRow(children: [
                  CustomText(
                      text: "Sản phẩm",
                      color: CustomColor.black,
                      fontWeight: FontWeight.bold,
                      context: context,
                      fontSize: 14),
                  // CustomText(
                  //     text: "Số lượng",
                  //     color: CustomColor.black,
                  //     fontWeight: FontWeight.bold,
                  //     context: context,
                  //     fontSize: 14),
                  CustomText(
                      text: "Số lượng",
                      color: CustomColor.black,
                      textAlign: TextAlign.right,
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
                    text: oCcy.format(totalAccessory) + " đ",
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
                    fontSize: 15),
                CustomText(
                    text: oCcy.format(totalProduct * invoice!.durationMonths +
                            totalAccessory) +
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: "Giảm Giá: ",
                    color: Colors.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
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
                    text: oCcy.format(totalProduct * invoice!.durationMonths +
                            totalAccessory) +
                        " đ",
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
