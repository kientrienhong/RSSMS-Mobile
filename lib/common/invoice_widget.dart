import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/common/invoice_detail_screen.dart';
import '../constants/constants.dart' as constants;

class InvoiceWidget extends StatelessWidget {
  final Invoice invoice;
  const InvoiceWidget({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Map<String, String> icon = constants.invoiceIcons;
    final deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InvoiceDetailScreen(
                    invoice: invoice,
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
                  color: const Color(0x00000000).withOpacity(0.06),
                  offset: const Offset(0, 6)),
            ]),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: (deviceSize.width - 32) / 4,
                  child: invoice.typeOrder == 1
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
                              text: "#" + invoice.name,
                              color: CustomColor.black,
                              context: context,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          Flexible(
                            child: CustomText(
                                textAlign: TextAlign.right,
                                text: constants.listStatusOrder[
                                        invoice.typeOrder]![invoice.status]
                                    ['name']! as String,
                                color: constants.listStatusOrder[
                                        invoice.typeOrder]![invoice.status]
                                    ['color'] as Color,
                                context: context,
                                maxLines: 2,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
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
                              text: invoice.deliveryDate.substring(
                                  0, invoice.deliveryDate.indexOf("T")),
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
                              text: invoice.returnDate.substring(
                                  0, invoice.returnDate.indexOf("T")),
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
