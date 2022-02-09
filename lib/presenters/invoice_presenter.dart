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

  Future<void> loadInvoice({idToken = "", clearCachedDate = false}) async {
    try {
      if (clearCachedDate) {
        model!.data = List<Map>.empty(growable: true);
        model!.hasMore = true;
        model!.listInvoiceFull!.clear();
        model!.page = 1;
      }
      if (model!.isLoadingInvoice! || !model!.hasMore!) {
        return Future.value();
      }
      view!.updateIsLoadingInvoice();
      final response =
          await ApiServices.getInvoice(idToken, model!.page.toString(), "10");
      final decodedReponse = jsonDecode(response.body);
      List<Invoice>? listInvoice;
      model!.metadata = decodedReponse["metadata"];
      if (!decodedReponse['data'].isEmpty) {
        List<Invoice>? listTemp = decodedReponse['data']!
            .map<Invoice>((e) => Invoice.fromMap(e))
            .toList();
        model!.listInvoiceFull!.addAll(listTemp!);
      } else {
        listInvoice = [];
        model!.listInvoiceFull!.addAll(listInvoice);
      }
      List<Map> listInvoiceTemp = (decodedReponse['data']! as List)
          .map((e) => e as Map<dynamic, dynamic>)
          .toList();
         model!.data.addAll(listInvoiceTemp);


      model!.hasMore = !(model!.page == model!.metadata!["totalPage"]);
      model!.controller.add(model!.data);
    } catch (e) {
      print(e);
    } finally {
      view!.updateIsLoadingInvoice();
      view!.setChangeList();
    }
  }
}
