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
  StreamController<List<Invoice>>? _controller;
  bool? hasMore;
  List<Invoice>? _data;
  Map<String, dynamic>? metadata;


  bool? onRefresh;
  int? page;
  int? totalPage;

  InvoiceModel() {
    listInvoice = List<Invoice>.empty(growable: true);
    _listInvoiceFull = List<Invoice>.empty(growable: true);
    _searchValue = TextEditingController();
    isLoadingInvoice = false;
    onRefresh = false;

    page = 1;
    _data = [];
    _controller = StreamController<List<Invoice>>.broadcast();
    stream = _controller!.stream.map((event) {
      return event;
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

  set listInvoice(value) => _listInvoice = value;
  get listInvoice => _listInvoice;

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

  List<Invoice>? get data => _data;

  set data(value) => _data = value;

  get getMetadata => metadata;

  set setMetadata(metadata) => metadata = metadata;
}
