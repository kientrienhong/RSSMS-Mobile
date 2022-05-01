import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
import 'package:rssms/utils/ui_utils.dart';

class QRInvoiceDetailsScreen extends StatefulWidget {
  final bool isScanQR;
  final bool isDone;
  const QRInvoiceDetailsScreen(
      {Key? key, required this.isScanQR, required this.isDone})
      : super(key: key);

  @override
  State<QRInvoiceDetailsScreen> createState() => _QRInvoiceDetailsScreenState();
}

class _QRInvoiceDetailsScreenState extends State<QRInvoiceDetailsScreen> {
  String error = '';

  Invoice formatUIInvoice(Invoice invoice) {
    Invoice invoiceResult = invoice.copyWith(orderDetails: []);
    for (var element in invoice.orderDetails) {
      for (var ele in element.listAdditionService!) {
        int index = invoiceResult.orderDetails
            .indexWhere((ele1) => ele1.productId == ele.id);
        if (index == -1) {
          invoiceResult.orderDetails.add(OrderDetail(
              id: '0',
              productId: ele.id,
              productName: ele.name,
              price: ele.price,
              status: -1,
              amount: ele.quantity!,
              serviceImageUrl: ele.imageUrl,
              productType: ele.type,
              note: '',
              images: []));
        } else {
          invoiceResult.orderDetails[index].amount += ele.quantity!;
        }
      }
    }
    return invoiceResult;
  }

  Invoice formatInvoiceForUpdate(Invoice invoice) {
    Invoice invoiceResult = invoice.copyWith();
    int index = 0;
    for (var element in invoiceResult.orderDetails) {
      int quantity = 0;
      for (var ele in element.listAdditionService!) {
        if (ele.id == element.productId) {
          quantity += ele.quantity!;
        }
      }

      element.listAdditionService = element.listAdditionService!
          .where((element) =>
              element.type == constants.typeProduct.accessory.index ||
              element.type == constants.typeProduct.services.index)
          .toList();
      element = element.copyWith(amount: quantity, status: -1);
      invoiceResult.orderDetails[index++] =
          element.copyWith(amount: quantity, status: -1);
    }

    return invoiceResult;
  }

  @override
  Widget build(BuildContext context) {
    Invoice invoice = Provider.of<Invoice>(context, listen: false);
    Invoice invoiceUI = invoice;  
    bool isAllowCreateOrder = invoice.deliveryDate.split("T")[0] == DateFormat("yyyy-MM-dd").format(DateTime.now());
    if(invoice.isUserDelivery){
      if(!isAllowCreateOrder){
        
      }
    }
    final deviceSize = MediaQuery.of(context).size;
    if (widget.isDone) invoiceUI = formatUIInvoice(invoice);
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
                          height: 24,
                          width: 24,
                          child: Image.asset(
                            'assets/images/arrowLeft.png',
                            fit: BoxFit.contain,
                          )),
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
                        isInvoice: true,
                        deviceSize: deviceSize,
                        invoice: invoiceUI),
                    CustomSizedBox(
                      context: context,
                      height: 16,
                    ),
                    CustomSizedBox(
                      context: context,
                      height: 16,
                    ),
                    UIUtils.buildErrorUI(error: error, context: context),
                    if (widget.isScanQR == true && isAllowCreateOrder)
                      // if (invoice.status == constants.ASSIGNED)
                      Center(
                        child: CustomButton(
                            height: 24,
                            isLoading: false,
                            text: widget.isDone ? 'Trả đơn' : 'Tạo đơn',
                            textColor: CustomColor.white,
                            onPressFunction: () {
                              if (invoice.status == 7) {
                                setState(() {
                                  error = 'Đơn đã thanh lý không để trả đơn';
                                  return;
                                });
                              }

                              if (widget.isDone) {
                                Invoice invoiceTemp =
                                    formatInvoiceForUpdate(invoice);
                                invoice.setInvoice(invoice: invoiceTemp);
                              }

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateInvoiceScreen(
                                          isView: false,
                                          isDone: widget.isDone,
                                        )),
                              );
                            },
                            width: deviceSize.width / 2.5,
                            buttonColor: CustomColor.blue,
                            borderRadius: 6),
                      )
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
