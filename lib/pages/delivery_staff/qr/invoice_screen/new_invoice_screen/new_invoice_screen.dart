import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_info_widget.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_product_widget.dart';
import 'package:rssms/constants/constants.dart' as constants;

class NewInvoiceScreen extends StatelessWidget {
  Invoice invoice;
  NewInvoiceScreen({Key? key, required this.invoice}) : super(key: key);
  Invoice formatNewInvoice() {
    Invoice invoiceTemp = invoice.copyWith();

    List<OrderDetail> orderDetails = [];

    invoiceTemp.orderDetails.forEach((element) {
      int indexFound =
          orderDetails.indexWhere((ele) => ele.productId == element.productId);

      if (indexFound == -1) {
        orderDetails.add(element.copyWith());
      } else {
        orderDetails[indexFound].amount += element.amount;
      }

      if (element.productType != constants.ACCESSORY) {
        element.listAdditionService!.forEach((ele) {
          int indexFound1 =
              orderDetails.indexWhere((ele1) => ele1.productId == ele.id);
          if (indexFound1 == -1) {
            orderDetails.add(OrderDetail(
                id: '0',
                productId: ele.id,
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
        });
      }
    });

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
                      child: Image.asset('assets/images/arrowLeft.png'),
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
              InvoiceInfoWidget(deviceSize: deviceSize, invoice: newInvoice),
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
