import 'dart:convert';
import 'dart:developer';

import 'package:rssms/models/entity/export.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/export_model.dart';
import 'package:rssms/views/export_view.dart';

class ExportPresenter {
  late ExportModel model;
  late ExportView view;
  ExportPresenter() {
    model = ExportModel();
  }

  Map<String, dynamic> formatUpdateOrder(Export export, Invoice invoice) {
    return {
      "orderId": invoice.id,
      "requestId": invoice.requestId,
      "status": 8,
      "deliveryBy": export.exportDeliveryBy,
      "returnAddress": export.returnAddress
    };
  }

  Future<bool> updateOrder(
      Export export, Invoice invoice, String idToken) async {
    try {
      // view.updateIsLoading;
      final dataRequest = formatUpdateOrder(export, invoice);
      log(jsonEncode(dataRequest));
      var response = await model.exportOrder(idToken, dataRequest);
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      // view.updateIsLoading();
    }

    return false;
  }
}
