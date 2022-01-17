import 'dart:convert';

import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/delivery_screen_model.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/views/delivery_screen_view.dart';

class DeliveryPresenter {
  late DeliveryScreenModel model;
  late DeliveryScreenView view;

  DeliveryPresenter() {
    model = DeliveryScreenModel();
  }

  void loadListShedule(
      String idToken, DateTime firstDayOfWeek, DateTime endDayOfWeek) async {
    try {
      final response = await ApiServices.getInvoiceInRangeTime(
          idToken, firstDayOfWeek, endDayOfWeek);
      final decodedReponse = jsonDecode(response.body);
      model.listInvoice =
          decodedReponse.map<Invoice>((e) => Invoice.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
  }
}
