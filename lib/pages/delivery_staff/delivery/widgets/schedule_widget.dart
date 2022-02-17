import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/constants/constants.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/invoice_screen.dart';

class ScheduleWidget extends StatelessWidget {
  final Invoice invoice;
  final Map<String, dynamic> schedule;
  final int listLength;
  final int currentIndex;
  final DateTime? firstDayOfWeek;
  final DateTime? endDayOfWeek;
  const ScheduleWidget(
      {Key? key,
      required this.firstDayOfWeek,
      required this.invoice,
      required this.endDayOfWeek,
      required this.schedule,
      required this.currentIndex,
      required this.listLength})
      : super(key: key);

  Widget buildInfo(String title, String content, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          color: CustomColor.black,
          context: context,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        CustomSizedBox(
          context: context,
          height: 8,
        ),
        Flexible(
          child: CustomText(
              maxLines: 4,
              text: content,
              color: CustomColor.black,
              context: context,
              fontSize: 16),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    Color status = CustomColor.black[3]!;
    final test = schedule;
    DateTime deliveryDateTime = DateTime.parse(schedule['deliveryDate']);
    bool isDelivery = deliveryDateTime.isAfter(firstDayOfWeek!) &&
        deliveryDateTime.isBefore(endDayOfWeek!);
    String statusString = '';

    return Container(
      width: deviceSize.width,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Stack(clipBehavior: Clip.none, children: [
              currentIndex == listLength - 1
                  ? Container()
                  : Positioned(
                      left: 8,
                      child: Container(
                        width: 1,
                        color: CustomColor.black[3],
                        height: deviceSize.height / 3,
                      ),
                    ),
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: CustomColor.blue),
              ),
            ]),
          ),
          CustomSizedBox(
            context: context,
            width: 8,
          ),
          GestureDetector(
            onTap: () {
              Invoice invoiceProvider =
                  Provider.of<Invoice>(context, listen: false);
              var test = invoice;
              invoiceProvider.setInvoice(invoice: invoice);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InvoiceDetailsScreen(
                    deviceSize: deviceSize,
                    isScanQR: false,
                  ),
                ),
              );
            },
            child: SizedBox(
              height: deviceSize.height / 3,
              width: deviceSize.width * 3 / 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      // text: schedule['time'],
                      text: schedule['deliveryTime'],
                      color: CustomColor.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                  CustomSizedBox(
                    context: context,
                    height: 40,
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: CustomColor.white,
                        boxShadow: [
                          BoxShadow(
                            color: CustomColor.black[3]!,
                            spreadRadius: 3,
                            blurRadius: 16,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ]),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CustomText(
                                    text: 'Mã đơn: #${schedule['id']}',
                                    color: CustomColor.black,
                                    fontWeight: FontWeight.bold,
                                    context: context,
                                    fontSize: 18),
                              ],
                            ),
                            Flexible(
                              child: CustomText(
                                  text:
                                      '${LIST_STATUS_ORDER[schedule['status']]['name']}',
                                  color: LIST_STATUS_ORDER[schedule['status']]
                                      ['color'] as Color,
                                  fontWeight: FontWeight.bold,
                                  maxLines: 2,
                                  textAlign: TextAlign.right,
                                  context: context,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        CustomSizedBox(
                          context: context,
                          height: 8,
                        ),
                        buildInfo(
                            'Địa chỉ: ',
                            isDelivery
                                ? schedule['deliveryAddress']
                                : schedule['addressReturn'],
                            context),
                        CustomSizedBox(
                          context: context,
                          height: 8,
                        ),
                        buildInfo('Tên khách hàng: ', schedule['customerName'],
                            context),
                        CustomSizedBox(
                          context: context,
                          height: 8,
                        ),
                        buildInfo('SĐT khách hàng: ', schedule['customerPhone'],
                            context),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
