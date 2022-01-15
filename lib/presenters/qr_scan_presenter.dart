import 'dart:convert';

import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/qr_invoice_model.dart';
import 'package:rssms/views/qr_invoice_view.dart';

class QRScanPresenter {
  QRInvoiceModel? model;
  QRInvoiceView? view;

  QRScanPresenter() {
    model = QRInvoiceModel();
  }

  Future<bool> loadInvoice(String idToken, String id) async {
    try {
      final response = await ApiServices.getInvoicebyId(idToken, id);
      if (response.statusCode == 200) {
        Invoice invoice = Invoice.fromJson(response.body);
        model!.invoice = invoice;
      } else {
        throw Exception();
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
