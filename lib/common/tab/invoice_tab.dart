import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_cancelled_screen/invoice_cancelled_screen.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_info_widget.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_product_widget.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoive_update/send_request_screen.dart';

class InvoiceTab extends StatelessWidget {
  Invoice? invoice;
  final Size deviceSize;

  InvoiceTab({Key? key, required this.deviceSize, this.invoice})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Users user = Provider.of<Users>(context);
    return Column(
      children: [
        CustomSizedBox(
          context: context,
          height: 24,
        ),
        CustomText(
            text: "Chi tiết đơn hàng",
            color: Colors.black,
            context: context,
            fontWeight: FontWeight.bold,
            fontSize: 25),
        CustomSizedBox(
          context: context,
          height: 48,
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
              InvoiceProductWidget(deviceSize: deviceSize, invoice: invoice),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              CustomText(
                  text: "Mã QR",
                  color: CustomColor.blue,
                  context: context,
                  fontSize: 16,
                ),
                InvoiceProductWidget(
                    deviceSize: deviceSize, invoice: invoice),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                // if (invoice!.typeOrder== 0)
                //   CustomText(
                //       text: "Hình ảnh",
                //       color: CustomColor.blue,
                //       context: context,
                //       textAlign: TextAlign.right,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 16),
                // if (invoice!.typeOrder == 0)
                //   SingleChildScrollView(
                //     scrollDirection: Axis.horizontal,
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(vertical: 12.0),
                //       child: Row(
                //         children: mapImageWidget(listImage),
                //       ),
                //     ),
                //   ),
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
                      data: invoice!.requestId!,
                      size: 100,
                      version: QrVersions.auto,
                    ),
                  ),
                ),

              CustomSizedBox(
                context: context,
                height: 16,
              ),
              if (invoice!.status != 0 && user.roleName == 'Customer')
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
                ),
                if (invoice!.status == 0)
                  Center(
                    child: CustomButton(
                        height: 24,
                        isLoading: false,
                        text: 'Chi tiết đơn hủy',
                        textColor: CustomColor.white,
                        onPressFunction: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InvoiceCancelledScreen()),
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
      );
  }
}