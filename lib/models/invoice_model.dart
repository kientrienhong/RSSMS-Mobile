import 'package:flutter/cupertino.dart';
import 'package:rssms/models/entity/invoice.dart';

class InvoiceModel {
  List<Invoice>? _listInvoiceFull;
  List<Invoice>? _listInvoice;
  TextEditingController? _searchValue;
  Invoice? searchInvoice;
  String? filterIndex = "10";
  bool? isLoadingInvoice;

  InvoiceModel() {
    listInvoice = [];
    _listInvoiceFull = [];
    _searchValue = TextEditingController();
    isLoadingInvoice = false;
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
}
