import 'dart:convert';
import 'dart:developer';

import 'package:rssms/models/create_order_request_model.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/views/create_order_request_view.dart';

class CreateOrderRequestPresenter {
  late CreateOrderRequestModel model;
  late CreateOrderRequestView view;
  CreateOrderRequestPresenter(String id) {
    model = CreateOrderRequestModel(id);
  }

  void getDetailRequest(String idToken) async {
    try {
      final response = await model.getDetailRequest(model.idRequest, idToken);
      if (response.statusCode == 200) {
        final decodedReponse = jsonDecode(response.body);
        Invoice invoice = Invoice.fromRequest(decodedReponse);
        DateTime deliveryDate = DateTime.parse(invoice.deliveryDate);
        if(DateTime.now().compareTo(deliveryDate) != -1){
          model.isValidToCancel = false;
        }
        view.updateView(invoice);
      }
      view.updateLoading();
    } catch (e) {
      log(e.toString());
      view.updateLoading();
    }
  }
}
