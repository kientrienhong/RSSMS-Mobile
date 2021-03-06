import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/notifcation_widget.dart';
import 'package:rssms/models/entity/notification.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/presenters/notification_screen_presenter.dart';
import 'package:rssms/views/notification_screen_view.dart';

class NotificationDeliveryScreen extends StatefulWidget {
  const NotificationDeliveryScreen({Key? key}) : super(key: key);

  @override
  State<NotificationDeliveryScreen> createState() =>
      _NotificationDeliveryScreenState();
}

class _NotificationDeliveryScreenState extends State<NotificationDeliveryScreen>
    implements NotificationScreenView {
  late NotificationScreenPresenter _presenter;

  List<Widget> mapNotifcationWidget(
          List<NotificationEntity> listNotification) =>
      listNotification
          .map<NotificationWidget>((p) => NotificationWidget(
                notification: p,
              ))
          .toList();

  @override
  void initState() {
    _presenter = NotificationScreenPresenter();
    _presenter.view = this;
    Users user = Provider.of<Users>(context, listen: false);
    _presenter.loadListNotification(user);
    super.initState();
  }

  @override
  void updateView() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Users user = Provider.of<Users>(context, listen: false);

    return Scaffold(
      backgroundColor: CustomColor.white,
      body: Container(
        margin: const EdgeInsets.all(16),
        child: ListView(
          padding: const EdgeInsets.all(8),
          shrinkWrap: true,
          children: mapNotifcationWidget(user.listNoti!),
        ),
      ),
    );
  }
}
