import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/notifcation_widget.dart';
import 'package:rssms/constants/constants.dart' as constants;

class NotificationDeliveryScreen extends StatelessWidget {
  const NotificationDeliveryScreen({Key? key}) : super(key: key);

  List<Widget> mapNotifcationWidget(listNotification) => listNotification
      .map<NotificationWidget>((p) => NotificationWidget(
            notification: p,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: Container(
        margin: const EdgeInsets.all(16),
        child: ListView(
          padding: const EdgeInsets.all(8),
          shrinkWrap: true,
          children: mapNotifcationWidget(constants.LIST_NOTIFICATION_DELIVERY),
        ),
      ),
    );
  }
}
