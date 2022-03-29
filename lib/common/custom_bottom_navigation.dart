import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/update_invoice_screen/update_invoice_screen.dart';
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

    invoice.orderDetails.forEach((element) {
      int quantity = 0;
      element.listAdditionService!.forEach((ele) {
        if (ele.id == element.productId) {
          quantity += ele.quantity!;
        }
      });

      element.listAdditionService = element.listAdditionService!
          .where((element) =>
              element.type == constants.ACCESSORY ||
              element.type == constants.SERVICES)
          .toList();

      element = element.copyWith(amount: quantity);
    });
    return invoiceResult;
  }

  void onClickNotification(String? payload) {
    try {
      Invoice invoice = Provider.of<Invoice>(context, listen: false);
      // print(json.decode(payload!));
      final test = json.decode(payload!);

      // String data =
      //     'H4sIAAAAAAAACu1Y227cNhD9lYWA9Mm0SYoX0UBQNHCDFG1So3Ge2jwMyeGu7F1pK2nduIGf+tAP6Ofka/InHcna9fqWOEXaFEGEXUm8zJAzc+aQ4uusjNl+tZrPd7Kwart6gc13VJOF3HsReGKcS8GUkYpB0IJ5TDyCcwohZTtZg7+usO0GkQJiUlAYprUCpsAq5pwRjKcQg5Te51xkl8M8gwWS1JO3b/6qppPvy7dv/qwmRw09/6i2uh3O6qrvx621SlvNFTVWg+zFtCPOy1Nszr6JscG2pa5CkrrFxJfYK2qwWzXVXa1d3cH8sCkD6bMFp2uX72QQY9mVdQXzx0gNQt5Wf4BtaMplXya1i5Pyl4vhjjF0GH9CaIeGfpCzZa9lJyvbFy02B+OMs/0E8xYvTTiArjdVcikZz1kujjjfH37ZZaejcvBbAYsJmwgOi42NV8Q142Zb/KLLKEzlJZwtsOqeYjerKXpkXFw10BtzAGftxrlj3dO66mab2raDbtWOFh1CD6GuWZEhFLIGptjDYd1zqLiI9QizBmmecZwsOZYQ0v+2Jzv2eXS2FhpxtplB3cTejx2Uc6r7+fUA417ZcBFob9zWF2lP87oeUH6ha4bldNaRC/oI/1bGbja+z7GabgoUt1NCyYB0dEFbYQ1zwmhKDudYUQTPRFLGKpkbEfJsI3K0jv5YHoF/BFS9qRwhKPWANL414IL896KZk8Ss65bt/t5eKhv00OLo3N1pXU/nCMuy3Q31Yu+U7/m9pm0XLdMphGIXlst2WXdDY70HbYtd+0A+HgfoX6UAkZLlTHIbmBLCM69UYDEmYwr0RZECdYNT6KDZPV5Ov4Z593CBsYSvuvoEq4e5jS4E4xgIkEwlYZnTRjHldFApeKtCJGvL3po+Yi+vxPD5OJUhlP/c07d69rPx3XU4waJeVd3wus1iI4TOX57vfKS0yLfSIt9OCypsB0uHQooAjsnc0+yTt6ywdLMx8UL7YHJQ1+2Q14P3vPwdJ09vJMZAwZ8gM2wIuTPaMVMkWgdTD8VI62DKDUoJ3CMX745uQhNEipI5rjxpKAoGaDizHnMN0RqtrmTGBwatnG+YdfVv+OLHyyx9IHlZ0W2ooie13meWayUkETd6emvpyegvbnWbcAUmzIEVGCNTPDe0AYmOYYToDIAzVvc7gXpYRhYnx5ttQTaMNrkYazKM1K+U2fk9OefDYHwHbD8bXF7P1jtYZ52fPel8IfD/GYGbuwhcXyVwazHm0njaeQqkpUwSJKIDQhYG4S3meSHfS+CP6nl9k771p6Fvr5GownOmNBGIkk4wKKJiApMDI5DbyN+dJpKnPAhtmERBEaWcYWC8ZsGExMFr47j7Qt833EbI50rkjnmBtCvyPYk6JVkK2svIcxtyc0nfoXp1Eo/jR6PwDwPys9uA+9kg874EPmboFwL/aDvwa0thdBZ5INWC5/QtYwWnQcAzAgFGOtkAY/QNUP5Qh5P/DpQCQEvDFeOq3xOQI1iRFGcodEg216mI79lVGHIb14Vn4GLBVKFTv6vQLAf6wElRiEAHKvf2JH30rdfCdeY/KXtzz7591WHV0snEeCRw/jcNIHl6yhIAAA==';
      String data =
          'wOTXoa0qLF6KFxftXBYMwBnPUb5060p22TFhtqnyCt+smiQxgglLoVGoIh62AeBjisR46Ei1hPMOsCztNPk0XHIkKG3/ZkpzGPztZME842M2g7P/gxQVkh7ZfXI4wHYeOFoL1xW18oPVZtO6L8QtYilPNFQhcMEX5Z+rSY3qvQzDcNjNspomREejBOaqYVMUxJTA5jSFE4S1gUSgueK+bybMNytI7+1J6AfwRI3hAnCHI5Io1uKazRf8+7CjkWKS37/b29WHbBQh8m5+7O23ZeBViW/a5r671Tumf3ur6veyKjc8UuLJf9sk1jZ7sHfR9S/4A/nhQMr5wBi1FTwql2RDBmiRXCEe+jUkWwRREdDoNTSNDtHi/nX0OVHtbBl/BVak9C8zDX3jinDAEGnIjINDFSCSKMdCI6q4XzaG05WDNE7MWVGD6bpjKG8p97+lbPfja+uw4nqNtVk8bX7So2Qej8xfnOR0qLfCst8u20wMZ2sKQrOHNgCM8tzj5aTQqNN+0jLaR1Kgdx3Q5+PXjPyt/D7OmNxBhL8CfIDO1cbpQ0RBUR18E4QNHjOhhzFTgHagNl745uDMqx6DkxVFiUUBQEgqJE25BL8FpJcSUzPjBoZbWprKt/wxc/XWbpA07LBm8jCZ/Ye59ZroUgh9/IGazFJ8E/u9VtWnpvXeGIkyoS4YucgLQGVzUIeS4oum/YgDTtuIzUJ8ebbUE2aptd6JqNmoaVMju/Z835MBjfAdvPBpfXs/WOqrPOz6HofCng/7MCru4q4PJqAdc6+JwriztPFnAp4wgJbwCRFRyzGvOu4O8t4I/aqr1ZvuWnKd9WBgBjKREyV0RwwwgUXhAWogHFAtWevjtNOI25Y1IRHhhGFHOGgLKSOOUiBSuVoeZL+b7hNum4sF4CHhgVOt5aRSw3nHilNTeIJCbkZfl2zasTf+w/Wgn/MCDfCtzPBpn3LeBThn4p4B9tB35tKfRGB+pQNKM5nmU0o6gELEEQBI9fNkApeQOUP7Tu5L8DJQOQXFFBqBj2BOgIUkRBSWDSRZ3LWPj37CoUuo3KwhIwviCikHHYVUiSAx5womfM4QeVe3sSD33rtXCd+U/Kwdyzb1+l0PT4ZWL6JHD+NwAAAP//AwA3qiriyhIAAA==';
      // String data = test['data'];

      var compressedString = base64.decode(data);
      // var gzipBytes = gzip.decoder.convert(compressedString);
      // var gzipBytes = GZipCodec().decode(compressedString);
      var stringBytes = utf8.decode(compressedString);
      final cxz = json.decode(stringBytes);

      // Outcome
      print('dasd');
      // Invoice invoiceTemp = formatInvoiceForUpdate(Invoice.fromMap(cxz));
      // invoice.setInvoice(invoice: invoiceTemp);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => UpdateInvoiceScreen(
      //               isView: true,
      //             )));
    } catch (e) {
      print(e);
    }
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
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('app_icon');
      await flutterLocalNotificationsPlugin.initialize(
          const InitializationSettings(
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
