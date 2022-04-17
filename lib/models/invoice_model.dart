import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rssms/models/entity/invoice.dart';

class InvoiceModel {
  late List<Invoice> listInvoiceFull;
  late List<Invoice> listInvoice;
  late ScrollController scrollController;

  late TextEditingController searchValue;
  late Invoice searchInvoice;
  late String filterIndex;
  late bool isLoadingInvoice;

  late Stream<List<Invoice>> stream;
  late StreamController<List<Invoice>> controller;
  late bool hasMore;
  late List<Invoice> data;
  Map<String, dynamic>? metadata;

  late bool onRefresh;
  late int page;
  int? totalPage;

  InvoiceModel() {
    listInvoice = List<Invoice>.empty(growable: true);
    listInvoiceFull = List<Invoice>.empty(growable: true);
    searchValue = TextEditingController();
    isLoadingInvoice = false;
    onRefresh = false;
    filterIndex = '10';
    scrollController = ScrollController();
    page = 1;
    data = [];
    controller = StreamController<List<Invoice>>.broadcast();
    stream = controller.stream.map((event) {
      return event;
    });

    hasMore = true;
  }

  set filterBy(value) {
    listInvoice = listInvoiceFull
        .where((element) => element.typeOrder == int.parse(value!))
        .toList();
  }

  List<Invoice>? getListInvoice() {
    if (filterIndex == "10") {
      return listInvoiceFull;
    } else {
      listInvoice = listInvoiceFull
          .where((element) => element.typeOrder == int.parse(filterIndex))
          .toList();
      return listInvoice;
    }
  }
}
