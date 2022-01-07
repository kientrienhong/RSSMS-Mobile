import 'dart:convert';

import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/invoice_model.dart';
import 'package:rssms/views/invoice_view.dart';

class InvoicePresenter {
  InvoiceModel? model;
  InvoiceView? view;

  InvoicePresenter() {
    model = InvoiceModel();
  }

  void loadInvoice(String idToken) async {
    final response = await ApiServices.getInvoice(idToken);
    final decodedReponse = jsonDecode(response.body);
    


    view!.setChangeList();
  }
}
