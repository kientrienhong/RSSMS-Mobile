import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/product_in_invoice/accessory_widget.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/product_in_invoice/product_widget.dart';
import 'package:rssms/constants/constants.dart' as constants;

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
    List<OrderDetail> listProduct = listTemp
        .where((element) =>
            element.productType == constants.HANDY ||
            element.productType == constants.UNWEILDY)
        .toList();
    if (listProduct.isEmpty) {
      listProduct =
          listTemp.where((element) => element.productType == 0).toList();
    }
    List<OrderDetail> listAccessory =
        listTemp.where((element) => element.productType == 1).toList();
    List<OrderDetail> listPackaging =
        listTemp.where((element) => element.productType == 3).toList();
    int totalProduct = 0;
    int totalAccessory = 0;
    int totalPackaging = 0;
    listAccessory.forEach((element) {
      totalAccessory += (element.price * element.amount);
    });
    listProduct.forEach((element) {
      totalProduct += (element.price * element.amount);
    });
    listPackaging.forEach((element) {
      totalPackaging += element.amount * element.price;
    });
    DateTime deliveryDate = DateTime.parse(invoice!.deliveryDate);
    DateTime returnDate = DateTime.parse(invoice!.returnDate);
    String additionalDescription = '';
    int additionalFee = 0;

    if (invoice!.additionFeeDescription != null) {
      additionalDescription = invoice!.additionFeeDescription!;
    }

    if (invoice!.additionFee != null) {
      additionalFee = invoice!.additionFee!;
    }
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: CustomColor.blue, width: 2)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: invoice!.typeOrder == constants.SELF_STORAGE_TYPE_ORDER
                    ? "Kho"
                    : "Dịch vụ",
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
            if (invoice!.typeOrder == 0)
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
            if (invoice!.typeOrder == 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: "Số ngày",
                      color: Colors.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  CustomText(
                      text: "x" +
                          returnDate.difference(deliveryDate).inDays.toString(),
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
                    text:
                        invoice!.typeOrder == constants.SELF_STORAGE_TYPE_ORDER
                            ? "Tổng tiền thuê kho"
                            : "Tổng tiền thuê dịch vụ",
                    color: Colors.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                CustomText(
                    text: oCcy.format(totalProduct *
                            (returnDate.difference(deliveryDate).inDays / 30)
                                .ceil()) +
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
            if (listAccessory.isNotEmpty)
              Column(
                children: mapAccessoryWidget(listAccessory),
              ),
            if (listAccessory.isEmpty)
              Center(
                  child: CustomText(
                      text: "(Trống)",
                      color: Colors.black45,
                      context: context,
                      fontSize: 14)),
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
                    text: oCcy.format(totalProduct *
                                (returnDate.difference(deliveryDate).inDays /
                                        30)
                                    .ceil() +
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
                    text: "Chi phí đóng gói: ",
                    color: Colors.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                CustomText(
                    text: oCcy.format(totalPackaging) + " đ",
                    color: CustomColor.blue,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ],
            ),
            if (additionalFee > 0)
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomSizedBox(
                  context: context,
                  height: 10,
                ),
                CustomText(
                    text: "Chi phí thêm: ",
                    color: Colors.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
                CustomSizedBox(
                  context: context,
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: additionalDescription,
                        color: CustomColor.blue,
                        context: context,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    CustomText(
                        text: oCcy.format(additionalFee) + " đ",
                        color: CustomColor.blue,
                        context: context,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ],
                ),
              ]),
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
                    text: oCcy.format(totalProduct *
                                (returnDate.difference(deliveryDate).inDays /
                                        30)
                                    .ceil() +
                            totalAccessory +
                            totalPackaging +
                            invoice!.additionFee! as num) +
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
