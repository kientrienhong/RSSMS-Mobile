import 'dart:io';

import 'package:rssms/models/entity/add_image.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/user.dart';

import '/config/http_overrides.dart';
import '/pages/log_in/log_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Users>(
        create: (_) => Users.empty(),
      ),
      ChangeNotifierProvider<OrderBooking>(
        create: (_) => OrderBooking.empty(),
      ),
      ChangeNotifierProvider<AddedImage>(
        create: (_) => AddedImage.empty(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Helvetica'),
      home: LogInScreen(),
    );
  }
}
