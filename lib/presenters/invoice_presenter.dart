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
    print(searchValue);
    model!.listInvoice = model!.listInvoiceFull!
        .where((element) => element.id.toString().contains(searchValue))
        .toList();
    view!.refreshList(searchValue);
  }

  void loadInvoice(String idToken) async {
    view!.updateIsLoadingInvoice();
    try {
      final response = await ApiServices.getInvoice(idToken);
      final decodedReponse = jsonDecode(response.body);
      List<Invoice>? listInvoice;
      if (!decodedReponse['data'].isEmpty) {
        List<Invoice>? listTemp = decodedReponse['data']!
            .map<Invoice>((e) => Invoice.fromMap(e))
            .toList();
        listInvoice = listTemp!.reversed.toList();
        model!.listInvoiceFull = listInvoice.reversed.toList();
      } else {
        listInvoice = [];
        model!.listInvoiceFull = listInvoice;
      }
    } catch (e) {
      print(e);
    } finally {
      view!.updateIsLoadingInvoice();
      view!.setChangeList();
    }
  }
}
