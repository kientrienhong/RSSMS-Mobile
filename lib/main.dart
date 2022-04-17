import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rssms/models/entity/add_image.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/update_invoice_screen/update_invoice_screen.dart';

import '/pages/log_in/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

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

void onClickNotification(String? payload, BuildContext context) {
  try {
    Invoice invoice = Provider.of<Invoice>(context, listen: false);
    Invoice invoiceTemp = Invoice.fromJson(json.decode(payload!)['data']);
    invoice.setInvoice(invoice: invoiceTemp);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const UpdateInvoiceScreen(
                  isView: true,
                  isDone: false,
                )));
  } catch (e) {
    log(e.toString());
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Helvetica'),
      home: const LogInScreen(),
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
