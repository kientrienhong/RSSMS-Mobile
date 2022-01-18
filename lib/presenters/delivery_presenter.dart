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
    var firstDay = now.subtract(Duration(days: now.weekday - 1));
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
    loadListShedule(user.idToken!, firstDayOfWeek, endDayOfWeek);
  }

  void loadListShedule(
      String idToken, DateTime firstDayOfWeek, DateTime endDayOfWeek) async {
    try {
      final response = await ApiServices.getScheduleOrder(
          idToken, firstDayOfWeek, endDayOfWeek);
      if (response.statusCode == 200) {
        final decodedReponse = jsonDecode(response.body);
        model.listDateTime.forEach((e) {
          model.listInvoice.putIfAbsent(e, () => []);
        });
        List<Invoice> listInvoice = decodedReponse['data']
            .map<Invoice>((e) => Invoice.fromMap(e['order']))
            .toList();

        print(listInvoice);
      }
      // model.listInvoice =
      //     decodedReponse.map<Invoice>((e) => Invoice.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
  }
}
