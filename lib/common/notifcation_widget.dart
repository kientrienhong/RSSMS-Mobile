import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/notification.dart';
import 'package:rssms/constants/constants.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_detail_screen.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationEntity notification;

  const NotificationWidget({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InvoiceDetailScreen(
                    invoiceID: notification.orderId,
                    deviceSize: deviceSize,
                  )),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
            color: CustomColor.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  blurRadius: 14,
                  color: Color(0x000000).withOpacity(0.06),
                  offset: const Offset(0, 6))
            ]),
        child: Row(children: [
          SizedBox(
              width: 24,
              height: 24,
              child: Image.asset(LIST_URL_NOTFICATION[notification.type]!)),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: deviceSize.width / 1.5,
                    child: Row(
                      children: [
                        CustomSizedBox(
                          context: context,
                          width: 8,
                        ),
                        Flexible(
                          child: CustomText(
                              text: notification.description,
                              color: CustomColor.black[2]!,
                              maxLines: 3,
                              context: context,
                              fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  if (notification.isRead == false)
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: CustomColor.blue),
                    )
                ],
              ),
              CustomSizedBox(
                context: context,
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomSizedBox(
                    context: context,
                    width: 8,
                  ),
                  CustomText(
                      text: '1m',
                      color: CustomColor.black[3]!,
                      fontWeight: FontWeight.bold,
                      context: context,
                      fontSize: 14)
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
