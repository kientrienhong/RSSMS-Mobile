import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_product_widget.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/update_invoice_screen/update_invoice_screen.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/widget/invoice_info_widget.dart';
import 'package:rssms/pages/delivery_staff/store_order/store_order_screen.dart';

class InvoiceDetailsScreen extends StatelessWidget {
  final Size deviceSize;

  InvoiceDetailsScreen({Key? key, required this.deviceSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Invoice invoice = Provider.of<Invoice>(context, listen: false);
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
              InvoiceInfoWidget(deviceSize: deviceSize, invoice: invoice),
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
                        deviceSize: deviceSize, invoice: invoice),
                    CustomSizedBox(
                      context: context,
                      height: 16,
                    ),
                    CustomSizedBox(
                      context: context,
                      height: 16,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                              height: 24,
                              isLoading: false,
                              text: 'Cập nhật đơn',
                              textColor: CustomColor.white,
                              onPressFunction: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateInvoiceScreen()),
                                );
                              },
                              width: deviceSize.width / 2.5,
                              buttonColor: CustomColor.blue,
                              borderRadius: 6),
                          CustomButton(
                              height: 24,
                              isLoading: false,
                              text: 'Đem đơn về kho',
                              textColor: CustomColor.white,
                              onPressFunction: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          StoreOrderScreen(invoice: invoice)),
                                );
                              },
                              width: deviceSize.width / 2.5,
                              buttonColor: CustomColor.green,
                              borderRadius: 6),
                        ])
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
