import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/invoice_image_widget.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_info_widget.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_product_widget.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoive_update/send_request_screen.dart';

class InvoiceDetailScreen extends StatelessWidget {
  Map<String, dynamic>? invoice;
  final Size deviceSize;

  InvoiceDetailScreen({Key? key, this.invoice, required this.deviceSize})
      : super(key: key);

  List<Widget> mapImageWidget(listImage) => listImage
      .map<InvoiceImageWidget>((i) => InvoiceImageWidget(
            image: i,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listImage = invoice!["image"];

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          width: deviceSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: GestureDetector(
                  onTap: () => {Navigator.of(context).pop()},
                  child: Image.asset('assets/images/arrowLeft.png'),
                ),
              ),
              CustomText(
                  text: "Chi tiết đơn hàng",
                  color: Colors.black,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
              CustomSizedBox(
                context: context,
                height: 32,
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
                    if (invoice!["type"] == 0)
                      CustomText(
                          text: "Hình ảnh",
                          color: CustomColor.blue,
                          context: context,
                          textAlign: TextAlign.right,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    if (invoice!["type"] == 0)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            children: mapImageWidget(listImage),
                          ),
                        ),
                      ),
                    CustomText(
                        text: "QR code",
                        color: CustomColor.blue,
                        context: context,
                        textAlign: TextAlign.right,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: QrImage(
                          data: '1',
                          size: 88.0,
                          version: 2,
                        ),
                      ),
                    ),
                    CustomSizedBox(
                      context: context,
                      height: 16,
                    ),
                    Center(
                      child: CustomButton(
                          height: 24,
                          isLoading: false,
                          text: 'Gửi yêu cầu',
                          textColor: CustomColor.white,
                          onPressFunction: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SendRequestScreen(
                                        invoice: invoice,
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
