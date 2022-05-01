import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/product_in_invoice/accessory_widget.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/product_in_invoice/product_widget.dart';
import 'package:rssms/constants/constants.dart' as constants;

class InvoiceProductWidget extends StatelessWidget {
  final Invoice invoice;
  final Size deviceSize;
  final bool isInvoice;
  final oCcy = NumberFormat("#,##0", "en_US");

  InvoiceProductWidget(
      {Key? key,
      required this.invoice,
      required this.deviceSize,
      required this.isInvoice})
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
    List<OrderDetail> listTemp = invoice.orderDetails;
    List<OrderDetail> listProduct = listTemp
        .where((element) =>
            element.productType == constants.typeProduct.handy.index ||
            element.productType == constants.typeProduct.unweildy.index)
        .toList();
    if (listProduct.isEmpty) {
      listProduct =
          listTemp.where((element) => element.productType == 0).toList();
    }
    List<OrderDetail> listAccessory =
        listTemp.where((element) => element.productType == 1).toList();
    int totalProduct = 0;
    int totalAccessory = 0;

    for (var element in listAccessory) {
      totalAccessory += (element.price * element.amount);
    }
    for (var element in listProduct) {
      totalProduct += (element.price * element.amount);
    }
    DateTime deliveryDate = DateTime.parse(invoice.deliveryDate);
    DateTime returnDate = DateTime.parse(invoice.returnDate);
    String takingAdditionalDescription = '';
    double takingAdditionalFee = 0;
    String returningAdditionalDescription = '';
    double returningAdditionalFee = 0;
    String composationDescription = '';
    double composationFee = 0;
    String deliveryFeeDescription = '';
    double deliveryFee = 0;
    for (var e in invoice.orderAdditionalFees) {
      if (e.type == constants.ADDITION_FEE_TYPE.compensationFee.index) {
        composationDescription = e.description;
        composationFee = e.price;
      } else if (e.type ==
          constants.ADDITION_FEE_TYPE.returningAdditionFee.index) {
        returningAdditionalDescription = e.description;
        returningAdditionalFee = e.price;
      } else if (e.type ==
          constants.ADDITION_FEE_TYPE.takingAdditionFee.index) {
        takingAdditionalDescription = e.description;
        takingAdditionalFee = e.price;
      } else if (e.type == constants.ADDITION_FEE_TYPE.deliveryFee.index) {
        deliveryFeeDescription = e.description;
        deliveryFee = e.price;
      }
    }
    if (deliveryFeeDescription == '') {
      if (invoice.deliveryFee != 0) {
        deliveryFeeDescription = 'Phí vận chuyển';
        deliveryFee = invoice.deliveryFee;
      }
    }
    double totalPriceDoorToDoor = totalProduct *
            (returnDate.difference(deliveryDate).inDays / 30).ceil() +
        totalAccessory +
        takingAdditionalFee +
        invoice.deliveryFee;
    double totalPriceSelfStorage = totalProduct * invoice.durationMonths +
        totalAccessory +
        takingAdditionalFee;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: CustomColor.blue, width: 2),
          color: CustomColor.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: invoice.typeOrder == constants.selfStorageTypeOrder
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
                    text: oCcy.format(totalProduct) + ' đ',
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
            if (invoice.typeOrder == 0)
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
                      text: "x" + invoice.durationMonths.toString(),
                      color: Colors.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ],
              ),
            if (invoice.typeOrder == 1)
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
                    text: invoice.typeOrder == constants.selfStorageTypeOrder
                        ? "Tổng tiền thuê kho"
                        : "Tổng tiền thuê dịch vụ",
                    color: Colors.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                CustomText(
                    text: invoice.typeOrder == TypeOrder.doorToDoor.index
                        ? oCcy.format(totalProduct *
                                (returnDate.difference(deliveryDate).inDays /
                                        30)
                                    .ceil()) +
                            " đ"
                        : oCcy.format(totalProduct * invoice.durationMonths) +
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
            if (takingAdditionalFee > 0)
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomSizedBox(
                  context: context,
                  height: 10,
                ),
                CustomText(
                    text: "Chi phí thêm khi lấy hàng: ",
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
                        text: takingAdditionalDescription,
                        color: CustomColor.black,
                        context: context,
                        fontSize: 16),
                    CustomText(
                        text: oCcy.format(takingAdditionalFee) + " đ",
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
            if (invoice.typeOrder == 1)
              CustomSizedBox(
                context: context,
                height: 10,
              ),
            if (invoice.typeOrder == 1 && deliveryFeeDescription.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: deliveryFeeDescription,
                      color: Colors.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  CustomText(
                      text: oCcy.format(deliveryFee) + " đ",
                      color: CustomColor.blue,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
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
                    text: "Tổng Cộng: ",
                    color: Colors.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
                CustomText(
                    text: oCcy.format(invoice.totalPrice).toString() + " đ",
                    color: CustomColor.blue,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 19),
              ],
            ),
            CustomSizedBox(
              context: context,
              height: 10,
            ),
            if (!isInvoice)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: "Tạm ứng : ",
                      color: Colors.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                  CustomText(
                      text: oCcy.format(invoice.advanceMoney) + " đ",
                      color: CustomColor.blue,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 17)
                ],
              ),
            if (returningAdditionalFee > 0)
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomSizedBox(
                  context: context,
                  height: 24,
                ),
                CustomText(
                    text: "Chi phí thêm khi trả hàng: ",
                    color: Colors.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                CustomSizedBox(
                  context: context,
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: returningAdditionalDescription,
                        color: CustomColor.black,
                        context: context,
                        fontSize: 16),
                    CustomText(
                        text: oCcy.format(returningAdditionalFee) + " đ",
                        color: CustomColor.blue,
                        context: context,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ],
                ),
              ]),
            if (composationFee > 0)
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomSizedBox(
                  context: context,
                  height: 24,
                ),
                CustomText(
                    text: "Bồi thường",
                    color: Colors.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                CustomSizedBox(
                  context: context,
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: composationDescription,
                        color: CustomColor.black,
                        context: context,
                        fontSize: 16),
                    CustomText(
                        text: oCcy.format(composationFee) + " đ",
                        color: CustomColor.blue,
                        context: context,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ],
                ),
              ]),
          ],
        ),
      ),
    );
  }
}
