import 'package:flutter/material.dart';

class NotificationDeliveryScreen extends StatefulWidget {
  const NotificationDeliveryScreen({Key? key}) : super(key: key);

  @override
  _NotificationDeliveryScreenState createState() =>
      _NotificationDeliveryScreenState();
}

class _NotificationDeliveryScreenState
    extends State<NotificationDeliveryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Notification screen'),
      ),
    );
  }
}
