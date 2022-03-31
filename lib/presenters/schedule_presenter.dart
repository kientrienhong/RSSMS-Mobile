import 'dart:convert';

import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/schedule_model.dart';
import 'package:rssms/views/schedule_view.dart';
import 'package:rssms/constants/constants.dart' as constants;

class SchedulePresenter {
  late ScheduleView view;
  late ScheduleModel model;
  SchedulePresenter() {
    model = ScheduleModel.constructor();
  }

  Future<int?> getRequestId(String idToken, String idRequest) async {
    final response = await model.getRequestId(idToken, idRequest);
    if (response.statusCode == 200) {
      Invoice invoiceReponse = Invoice.fromRequest(json.decode(response.body));
      model.setModel(model.copyWith(invoiceDetail: invoiceReponse));
      return invoiceReponse.typeRequest;
    }
  }

  Future<bool> getInvoiceId(String idToken) async {
    final response =
        await model.getInvoiceId(idToken, model.invoiceDetail!.orderId!);
    if (response.statusCode == 200) {
      Invoice invoiceReponse = Invoice.fromMap(json.decode(response.body));
      model.setModel(model.copyWith(invoiceDetail: invoiceReponse));
      return true;
    }

    return false;
  }
}
