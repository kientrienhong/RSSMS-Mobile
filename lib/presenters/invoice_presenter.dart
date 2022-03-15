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
    try {
      if (searchValue.isNotEmpty) {
        print(searchValue);
        model!.listInvoice = model!.listInvoiceFull!
            .where((element) => element.id.toString().contains(searchValue))
            .toList();

        model!.data = List<Invoice>.empty(growable: true);
        model!.data!.addAll(model!.listInvoice);
        model!.controller.add(model!.data);
      } else {
        model!.data!.clear();
        model!.data!.addAll(model!.listInvoiceFull!);
        model!.controller.add(model!.data);
      }
    } catch (e) {
      print(e);
    }

    view!.refreshList(searchValue);
  }

  Future<void> loadInvoiceByID(String idToken, String id) async {
    model!.loadInvoiceByID(idToken, id);
  }

  Future<void> loadInvoice({idToken = "", clearCachedDate = false}) async {
    try {
      model!.loadInvoice(idToken: idToken, clearCachedDate: clearCachedDate );
      view!.updateIsLoadingInvoice();
    } catch (e) {
      print(e);
    } finally {
      view!.updateIsLoadingInvoice();
      view!.setChangeList();
    }
  }
}
