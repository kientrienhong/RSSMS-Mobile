import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rssms/models/entity/invoice.dart';

class InvoiceModel {
  List<Invoice>? _listInvoiceFull;
  List<Invoice>? _listInvoice;
  TextEditingController? _searchValue;
  Invoice? searchInvoice;
  String? filterIndex = "10";
  bool? isLoadingInvoice;

  Stream<List<Invoice>>? stream;
  StreamController<List<Map>>? _controller;
  bool? hasMore;
  List<Map>? _data;
  Map<String, dynamic>? metadata;

  int? page;
  int? totalPage;

  InvoiceModel() {
    listInvoice = [];
    _listInvoiceFull = [];
    _searchValue = TextEditingController();
    isLoadingInvoice = false;

    page = 1;
    _data = [];
    _controller = StreamController<List<Map>>.broadcast();
    stream = _controller!.stream.map((event) {
      return event
          .map<Invoice>((e) => Invoice.fromMap(e as Map<String, dynamic>))
          .toList();
    });

    hasMore = true;
  }

  set filterBy(value) {
    _listInvoice = _listInvoiceFull!
        .where((element) => element.typeOrder == int.parse(value!))
        .toList();
  }

  List<Invoice>? getListInvoice() {
    if (filterIndex == "10") {
      return _listInvoiceFull;
    } else {
      _listInvoice = _listInvoiceFull!
          .where((element) => element.typeOrder == int.parse(filterIndex!))
          .toList();
      return _listInvoice;
    }
  }

  List<Invoice>? get listInvoiceFull => _listInvoiceFull;

  set listInvoiceFull(value) => _listInvoiceFull = value;

  set listInvoice(List<Invoice>? value) => _listInvoice = value;

  get searchValue => _searchValue;

  set searchValue(value) => _searchValue = value;

  get getSearchInvoice => searchInvoice;

  set setSearchInvoice(searchInvoice) => searchInvoice = searchInvoice;

  get getFilterIndex => filterIndex;

  set setFilterIndex(filterIndex) => filterIndex = filterIndex;

  get getStream => stream;

  set setStream(stream) => stream = stream;

  get controller => _controller;

  set controller(value) => _controller = value;

  get getHasMore => hasMore;

  set setHasMore(hasMore) => hasMore = hasMore;

  get data => _data;

  set data(value) => _data = value;

  get getMetadata => metadata;

  set setMetadata(metadata) => metadata = metadata;
}
