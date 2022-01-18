import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/views/custom_bottom_navigation_view.dart';

class CustomBottomNavigation extends StatefulWidget {
  final List<dynamic>? listNavigator;
  final List<Widget>? listIndexStack;
  const CustomBottomNavigation(
      {Key? key, this.listNavigator, this.listIndexStack})
      : super(key: key);

  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation>
    implements CustomBottomNavigationView {
  int _index = 0;

  void onClickNotification(String? payload) {
    String tesyt = payload!;
    print(payload);
  }

  void init() async {
    try {
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
          'high_importance_channel', // id
          'High Importance Notifications', // title
          importance: Importance.max,
          description: 'This channel is used for important notifications.');
      // await flutterLocalNotificationsPlugin
      //     .resolvePlatformSpecificImplementation<
      //         AndroidFlutterLocalNotificationsPlugin>()
      //     ?.createNotificationChannel(channel);
      final AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('app_icon');
      await flutterLocalNotificationsPlugin.initialize(
          InitializationSettings(
            android: initializationSettingsAndroid,
          ),
          onSelectNotification: onClickNotification);
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification notification = message.notification!;
        // If `onMessage` is triggered with a notification, construct our own
        // local notification to show to users using the created channel.
        if (notification != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id, channel.name,
                  icon: "app_icon", channelDescription: channel.description,

                  // other properties...
                ),
              ),
              payload: json.encode(message.data));
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _index = 0;
    init();
  }

  @override
  void onChangeTab(int index) {
    setState(() {
      _index = index;
    });
  }

  List<BottomNavigationBarItem> mapListBottomNavigationBarItem() {
    return widget.listNavigator!.map((e) {
      return BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage(e['url']),
          ),
          label: e['label']);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.white,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: CustomColor.blue,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: mapListBottomNavigationBarItem(),
        currentIndex: _index,
        selectedItemColor: CustomColor.white,
        onTap: onChangeTab,
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: _index,
            children: widget.listIndexStack!,
          ),
        ],
      ),
    );
  }
}
