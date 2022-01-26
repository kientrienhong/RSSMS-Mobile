import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rssms/models/entity/add_image.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/user.dart';

import '/config/http_overrides.dart';
import '/pages/log_in/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

// Future firebaseCloudMessaging_Listeners(BuildContext context) async {
//   final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//   _fcm.getToken().then((token) async {
//     log('Got Firebase Token!');
//   });
//   FirebaseMessaging.onMessage.listen((RemoteMessage evt) {
//     doNotiAction(evt);
//   });
//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage evt) {
//     doNotiAction(evt);
//   });
//   //
// }

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Users>(
        create: (_) => Users.empty(),
      ),
      ChangeNotifierProvider<OrderBooking>(
        create: (_) => OrderBooking.empty(TypeOrder.doorToDoor),
      ),
      ChangeNotifierProvider<AddedImage>(
        create: (_) => AddedImage.empty(),
      ),
      ChangeNotifierProvider<Invoice>(
        create: (_) => Invoice.empty(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Helvetica'),
      home: LogInScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
