import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_product_widget.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/update_invoice_screen/update_invoice_screen.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/widget/invoice_info_widget.dart';
import 'package:rssms/constants/constants.dart' as constants;

class InvoiceDetailsScreen extends StatelessWidget {
  final bool isScanQR;
  final bool isDone;
  InvoiceDetailsScreen({Key? key, required this.isScanQR, required this.isDone})
      : super(key: key);

  Invoice formatUIInvoice(Invoice invoice) {
    Invoice invoiceResult = invoice.copyWith(orderDetails: []);

    invoice.orderDetails.forEach((element) {
      element.listAdditionService!.forEach((ele) {
        int index = invoiceResult.orderDetails
            .indexWhere((ele1) => ele1.productId == ele.id);
        if (index == -1) {
          invoiceResult.orderDetails.add(OrderDetail(
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
          invoiceResult.orderDetails[index].amount += ele.quantity!;
        }
      });
    });
    return invoiceResult;
  }

  void formatInvoiceForUpdate(Invoice invoice) {
    Invoice invoiceResult = invoice.copyWith();

    invoice.orderDetails.forEach((element) {
      int quantity = 0;
      element.listAdditionService!.forEach((ele) {
        if (ele.id == element.productId) {
          quantity += ele.quantity!;
        }
      });

      element.listAdditionService = element.listAdditionService!
          .where((element) =>
              element.type == constants.ACCESSORY ||
              element.type == constants.SERVICES)
          .toList();

      element = element.copyWith(amount: quantity);
    });

    invoice.setInvoice(invoice: invoiceResult);
  }

  @override
  Widget build(BuildContext context) {
    Invoice invoice = Provider.of<Invoice>(context, listen: false);
    Invoice invoiceUI = invoice;
    final deviceSize = MediaQuery.of(context).size;
    if (isDone) Invoice invoiceUI = formatUIInvoice(invoice);
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
              InvoiceInfoWidget(deviceSize: deviceSize, invoice: invoiceUI),
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
                        deviceSize: deviceSize, invoice: invoiceUI),
                    CustomSizedBox(
                      context: context,
                      height: 16,
                    ),
                    CustomSizedBox(
                      context: context,
                      height: 16,
                    ),
                    if (isScanQR == true)
                      // if (invoice.status == constants.ASSIGNED)
                      Center(
                        child: CustomButton(
                            height: 24,
                            isLoading: false,
                            text: 'Cập nhật đơn',
                            textColor: CustomColor.white,
                            onPressFunction: () {
                              if (isDone) formatInvoiceForUpdate(invoice);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateInvoiceScreen(
                                          isView: false,
                                        )),
                              );
                            },
                            width: deviceSize.width / 2.5,
                            buttonColor: CustomColor.blue,
                            borderRadius: 6),
                      )
                    // else if (invoice.status == constants.DELIVERIED_RETURN)
                    //   Center(
                    //     child: CustomButton(
                    //         height: 24,
                    //         isLoading: false,
                    //         text: 'Trả đơn',
                    //         textColor: CustomColor.white,
                    //         onPressFunction: () {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => UpdateInvoiceScreen(
                    //                       isView: true,
                    //                       isScanQR: true,
                    //                     )),
                    //           );
                    //         },
                    //         width: deviceSize.width / 2.5,
                    //         buttonColor: CustomColor.blue,
                    //         borderRadius: 6),
                    //   )
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
