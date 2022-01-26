import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_detail_screen.dart';
import '../../../../constants/constants.dart' as constants;

class InvoiceWidget extends StatelessWidget {
  Invoice? invoice;
  InvoiceWidget({Key? key, this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> icon = constants.ICON_INVOICE;
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
                  child: invoice!.typeOrder == 1
                      ? Image.asset(icon['box']!)
                      : Image.asset(icon['warehose']!)),
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
                              text: "#" + invoice!.id.toString(),
                              color: CustomColor.black,
                              context: context,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          CustomText(
                              text: constants.LIST_STATUS_ORDER[invoice!.status]
                                  ['name']! as String,
                              color:
                                  constants.LIST_STATUS_ORDER[invoice!.status]
                                      ['color'] as Color,
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
                              text: invoice!.deliveryDate.substring(
                                  0, invoice!.deliveryDate.indexOf("T")),
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
                              text: invoice!.returnDate.substring(
                                  0, invoice!.returnDate.indexOf("T")),
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
