import 'package:flutter/material.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/helpers/date_format.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_product_widget.dart';
import 'package:rssms/constants/constants.dart' as constants;
import 'package:rssms/pages/time_line/time_line_screen.dart';

class NewInvoiceScreen extends StatelessWidget {
  final Invoice invoice;
  const NewInvoiceScreen({Key? key, required this.invoice}) : super(key: key);
  Invoice formatNewInvoice() {
    Invoice invoiceTemp = invoice.copyWith();

    List<OrderDetail> orderDetails = [];
    for (var element in invoiceTemp.orderDetails) {
      int indexFound =
          orderDetails.indexWhere((ele) => ele.productId == element.productId);

      if (indexFound == -1) {
        orderDetails.add(element.copyWith());
      } else {
        orderDetails[indexFound].amount += element.amount;
      }

      if (element.productType != constants.typeProduct.accessory.index) {
        for (var ele in element.listAdditionService!) {
          int indexFound1 =
              orderDetails.indexWhere((ele1) => ele1.productId == ele.id);
          if (indexFound1 == -1) {
            orderDetails.add(OrderDetail(
                id: '0',
                productId: ele.id,
                status: -1,
                productName: ele.name,
                price: ele.price,
                amount: ele.quantity!,
                serviceImageUrl: ele.imageUrl,
                productType: ele.type,
                note: '',
                images: []));
          } else {
            orderDetails[indexFound1].amount += ele.quantity!;
          }
        }
      }
    }
    return invoiceTemp.copyWith(orderDetails: orderDetails);
  }

  @override
  Widget build(BuildContext context) {
    Invoice newInvoice = formatNewInvoice();
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: CustomColor.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          width: deviceSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSizedBox(
                context: context,
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: GestureDetector(
                      onTap: () => {Navigator.of(context).pop()},
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset(
                          'assets/images/arrowLeft.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  CustomText(
                      text: "Đơn hàng hiện tại",
                      color: Colors.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                  CustomSizedBox(
                    context: context,
                    height: 0,
                  ),
                ],
              ),
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: "Ngày nhận hàng:",
                        color: Colors.black,
                        context: context,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    CustomText(
                        text: DateFormatHelper.formatToVNDay(
                            invoice.deliveryDate),
                        color: Colors.black,
                        context: context,
                        fontSize: 16),
                  ],
                ),
                CustomSizedBox(
                  context: context,
                  height: 24,
                ),
                if (invoice.typeOrder == constants.doorToDoorTypeOrder)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                              text: "Khung giờ lấy hàng:",
                              color: Colors.black,
                              context: context,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                          CustomText(
                              text: invoice.deliveryTime.isEmpty
                                  ? 'Khách tự vận chuyển'
                                  : invoice.deliveryTime,
                              color: Colors.black,
                              context: context,
                              fontSize: 16),
                        ],
                      ),
                      CustomSizedBox(
                        context: context,
                        height: 24,
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: "Ngày trả hàng:",
                        color: Colors.black,
                        context: context,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    CustomText(
                        text:
                            DateFormatHelper.formatToVNDay(invoice.returnDate),
                        color: Colors.black,
                        context: context,
                        fontSize: 16),
                  ],
                ),
                CustomSizedBox(
                  context: context,
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: "Địa chỉ:",
                        color: Colors.black,
                        context: context,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    SizedBox(
                      width: deviceSize.width * 1.5 / 3,
                      child: CustomText(
                        text: invoice.deliveryAddress,
                        color: CustomColor.black,
                        textAlign: TextAlign.right,
                        context: context,
                        maxLines: 2,
                        fontSize: 16,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                CustomSizedBox(
                  context: context,
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: "Thông tin vận chuyển:",
                        color: Colors.black,
                        context: context,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    CustomButton(
                        height: 24,
                        isLoading: false,
                        text: 'Xem thêm',
                        textColor: CustomColor.white,
                        onPressFunction: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TimeLineScreen(
                                        invoiceId: invoice.id,
                                      )));
                        },
                        width: deviceSize.width / 3,
                        buttonColor: CustomColor.blue,
                        borderRadius: 6),
                  ],
                ),
              ]),
              SizedBox(
                width: deviceSize.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSizedBox(
                      context: context,
                      height: 16,
                    ),
                    InvoiceProductWidget(
                        deviceSize: deviceSize, invoice: newInvoice),
                    CustomSizedBox(
                      context: context,
                      height: 16,
                    ),
                    CustomSizedBox(
                      context: context,
                      height: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
