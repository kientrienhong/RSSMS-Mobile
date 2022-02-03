import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/notification.dart';
import 'package:rssms/constants/constants.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationEntity notification;

  const NotificationWidget({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(
                  text: '1m',
                  color: CustomColor.black[3]!,
                  fontWeight: FontWeight.bold,
                  context: context,
                  fontSize: 14)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset(LIST_URL_NOTFICATION[notification.type])),
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
        ],
      ),
    );
  }
}
