import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_detail_screen.dart';

class InvoiceWidget extends StatelessWidget {
  Map<String, dynamic>? invoice;
  InvoiceWidget({Key? key, this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InvoiceDetailScreen(
                    invoice: invoice,
                    deviceSize: deviceSize,
                  )),
        );
      },
      child: Container(
        padding: EdgeInsets.only(
          top: deviceSize.height / 45,
          bottom: deviceSize.height / 45,
        ),
        margin: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: CustomColor.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 14,
                  color: Color(0x000000).withOpacity(0.06),
                  offset: const Offset(0, 6)),
            ]),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: (deviceSize.width - 32) / 4,
                  child: Image.asset(invoice!['url']!)),
              SizedBox(
                width: (deviceSize.width - 50) * 3 / 4,
                child: Container(
                  padding: EdgeInsets.only(right: deviceSize.height / 45),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                              text: "#" + invoice!['id']!,
                              color: CustomColor.black,
                              context: context,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          CustomText(
                              text: invoice!['status']!,
                              color: invoice!['statusCode']! == 1
                                  ? CustomColor.blue
                                  : invoice!['statusCode']! == 2
                                      ? const Color.fromRGBO(249, 168, 37, 1)
                                      : CustomColor.red,
                              context: context,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ],
                      ),
                      CustomSizedBox(
                        context: context,
                        height: 14,
                      ),
                      Row(
                        children: [
                          CustomText(
                              text: 'Ngày nhận hàng: ',
                              color: CustomColor.black,
                              context: context,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          CustomText(
                              text: invoice!["getDate"]!,
                              color: CustomColor.black,
                              fontWeight: FontWeight.w100,
                              context: context,
                              fontSize: 14),
                        ],
                      ),
                      CustomSizedBox(
                        context: context,
                        height: 14,
                      ),
                      Row(
                        children: [
                          CustomText(
                              text: 'Ngày trả hàng: ',
                              color: CustomColor.black,
                              context: context,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          CustomText(
                              text: invoice!["returnnDate"]!,
                              color: CustomColor.black[2]!,
                              context: context,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ],
                      ),
                      CustomSizedBox(
                        context: context,
                        height: 8,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
