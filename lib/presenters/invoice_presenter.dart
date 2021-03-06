import 'dart:convert';
import 'dart:developer';

import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/invoice_model.dart';
import 'package:rssms/views/invoice_view.dart';

class InvoicePresenter {
  late InvoiceModel model;
  late InvoiceView view;

  InvoicePresenter() {
    model = InvoiceModel();
  }

  void init(String idToken) {
    loadInvoice(idToken: idToken);
    model.searchValue.addListener(view.onHandleChangeInput);

    model.scrollController.addListener(() {
      if (model.scrollController.position.maxScrollExtent ==
          model.scrollController.offset) {
        if (model.hasMore) {
          model.page = model.page + 1;
          loadInvoice(idToken: idToken);
        }
      }
    });
  }

  void handleOnChangeInput(String searchValue) {
    try {
      if (searchValue.isNotEmpty) {
        model.listInvoice = model.listInvoiceFull
            .where((element) => element.id.toString().contains(searchValue))
            .toList();

        model.data = List<Invoice>.empty(growable: true);
        model.data.addAll(model.listInvoice);
        model.controller.add(model.data);
      } else {
        model.data.clear();
        model.data.addAll(model.listInvoiceFull);
        model.controller.add(model.data);
      }
    } catch (e) {
      log(e.toString());
    }

    view.refreshList(searchValue);
  }

  Future<void> loadInvoice({idToken = "", clearCachedDate = false}) async {
    try {
      if (clearCachedDate) {
        model.data = List<Invoice>.empty(growable: true);
        model.hasMore = true;
        model.listInvoiceFull.clear();
        model.page = 1;
      }
      if (model.isLoadingInvoice || !model.hasMore) {
        return Future.value();
      }
      view.updateIsLoadingInvoice();
      final response =
          await ApiServices.getInvoice(idToken, model.page.toString(), "10");
      List<Invoice>? listInvoice;
      if (response.statusCode == 200) {
        final decodedReponse = jsonDecode(response.body);
        model.metadata = decodedReponse["metadata"];
        if (decodedReponse['data'].isNotEmpty) {
          List<Invoice>? listTemp = decodedReponse['data']
              .map<Invoice>((e) => Invoice.fromMap(e))
              .toList();
          model.listInvoiceFull.addAll(listTemp!);
          model.listInvoice = model.listInvoiceFull;
          model.data.addAll(listTemp);
          model.hasMore = !(model.page == model.metadata!["totalPage"]);
          model.controller.add(model.data);
        }
      } else if (response.statusCode >= 500) {
        throw Exception("M??y ch??? b??? l???i vui l??ng th??? l???i sau");
      } else if (response.statusCode == 404) {
        listInvoice = [];
        model.listInvoiceFull.addAll(listInvoice);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      view.updateIsLoadingInvoice();
      view.setChangeList();
    }
  }
}
