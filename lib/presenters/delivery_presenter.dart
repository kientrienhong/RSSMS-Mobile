import 'dart:convert';

import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/delivery_screen_model.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/views/delivery_screen_view.dart';

class DeliveryPresenter {
  late DeliveryScreenModel model;
  late DeliveryScreenView view;

  DeliveryPresenter() {
    model = DeliveryScreenModel();
  }

  void init(Users user) {
    DateTime now = DateTime.now();
    // String nowString = now.toIso8601String().split('T')[0];
    // now = DateTime.parse(nowString);
    var firstDay = now.subtract(Duration(days: now.weekday));
    var firstDayOfWeek = firstDay;
    var endDayOfWeek;
    for (int i = 0; i < 7; i++) {
      endDayOfWeek = firstDay;
      model.listDateTime.add(firstDay);
      if (firstDay.isAtSameMomentAs(now)) {
        model.currentIndex = i;
      }
      firstDay = firstDay.add(const Duration(days: 1));
    }
    model.firstDayOfWeek = firstDayOfWeek;
    model.endDayOfWeek = endDayOfWeek;
  }

  Future<void> loadListShedule(
      String idToken, DateTime firstDayOfWeek, DateTime endDayOfWeek) async {
    try {
      final response = await ApiServices.getScheduleOrder(
          idToken, firstDayOfWeek, endDayOfWeek);
      if (response.statusCode == 200) {
        final decodedReponse = jsonDecode(response.body);
        model.listDateTime.forEach((e) {
          String date = e.toIso8601String().split('T')[0];
          model.listInvoice.putIfAbsent(date, () => []);
        });
        decodedReponse['data'].forEach((e) {
          String scheduleDay = e['scheduleDay'].split('T')[0];
          for (int i = 0; i < e['orders'].length; i++) {
            Invoice invoice = Invoice.fromMap(e['orders'][i]);
            model.listInvoice[scheduleDay]!.add(invoice);
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
