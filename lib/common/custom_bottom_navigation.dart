import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:rssms/api/api_services.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/notification.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/views/custom_bottom_navigation_view.dart';
import 'package:rssms/constants/constants.dart' as constants;

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

  Invoice formatInvoiceForUpdate(Invoice invoice) {
    Invoice invoiceResult = invoice.copyWith();

    for (var element in invoice.orderDetails) {
      int quantity = 0;
      for (var ele in element.listAdditionService!) {
        if (ele.id == element.productId) {
          quantity += ele.quantity!;
        }
      }

      element.listAdditionService = element.listAdditionService!
          .where((element) =>
              element.type == constants.typeProduct.accessory.index ||
              element.type == constants.typeProduct.services.index)
          .toList();

      element = element.copyWith(amount: quantity);
    }

    return invoiceResult;
  }

  void onClickNotification(String? payload) {}

  void init() async {
    try {
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
          'high_importance_channel', // id
          'High Importance Notifications', // title
          importance: Importance.max,
          description: 'This channel is used for important notifications.');
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('app_icon');
      await flutterLocalNotificationsPlugin.initialize(
          const InitializationSettings(
            android: initializationSettingsAndroid,
          ),
          onSelectNotification: onClickNotification);
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
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
      log(e.toString());
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
      if (e['label'] != 'Notification') {
        return BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(e['url']),
            ),
            label: e['label']);
      } else {
        return BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Users user = Provider.of<Users>(context, listen: false);
                if (user.listUnreadNoti!.isNotEmpty) {
                  final listNewReadNoti = user.listNoti!
                      .map<NotificationEntity>((e) => e.copyWith(isRead: true))
                      .toList();
                  List<String> listIdsUnread =
                      user.listUnreadNoti!.map((e) => e.id).toList();
                  ApiServices.updateListNotification(
                      user.idToken!, listIdsUnread);
                  user.setUser(
                      user: user.copyWith(
                          listUnreadNoti: [], listNoti: listNewReadNoti));
                }
              },
              child: Consumer<Users>(builder: (_, user, child) {
                return Stack(children: [
                  ImageIcon(
                    AssetImage(e['url']),
                  ),
                  if (user.listUnreadNoti!.isNotEmpty)
                    Positioned(
                      right: 0,
                      bottom: 1,
                      child: Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                            color: CustomColor.red,
                            borderRadius: BorderRadius.circular(7)),
                        child: Center(
                          child: CustomText(
                            text: user.listUnreadNoti!.length.toString(),
                            color: CustomColor.white,
                            context: context,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                ]);
              }),
            ),
            label: e['label']);
      }
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
