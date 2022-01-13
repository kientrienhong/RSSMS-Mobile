import 'dart:convert';

import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/invoice_model.dart';
import 'package:rssms/views/invoice_view.dart';

class InvoicePresenter {
  InvoiceModel? model;
  InvoiceView? view;

  InvoicePresenter() {
    model = InvoiceModel();
  }

  void handleOnChangeInput(String searchValue) {
    view!.refreshList(searchValue);
  }

  void loadInvoice(String idToken) async {
    final response = await ApiServices.getInvoice(idToken);
    final decodedReponse = jsonDecode(response.body);
    List<Invoice>? listTemp = decodedReponse['data']!
        .map<Invoice>((e) => Invoice.fromMap(e))
        .toList();
    List<Invoice>? listInvoice = listTemp!.reversed.toList();
    model!.listInvoiceFull = listInvoice;
    view!.setChangeList();
  }
}
