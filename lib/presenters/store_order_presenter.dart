import 'dart:convert';

import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/shelf.dart';
import 'package:rssms/models/store_order_model.dart';
import 'package:rssms/views/store_order_view.dart';

class StoreOrderPresenter {
  StoreOrderModel? model;
  StoreOrderView? view;

  StoreOrderPresenter() {
    model = StoreOrderModel();
  }

  void loadShelf(String idToken) async {
    try {
      final response = await ApiServices.getShelf(idToken);
      final decodedReponse = jsonDecode(response.body);

      List<Shelf> listShelf =
          decodedReponse["data"]!.map<Shelf>((e) => Shelf.fromMap(e)).toList();
      model!.listShelf = listShelf;
    } catch (e) {
      print(e);
    }
  }
}
