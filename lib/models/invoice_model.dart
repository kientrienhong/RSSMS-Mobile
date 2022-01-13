import 'package:flutter/cupertino.dart';
import 'package:rssms/models/entity/invoice.dart';

class InvoiceModel {
  List<Invoice>? _listInvoice;
  TextEditingController? _searchValue;
  Invoice? searchInvoice;

  InvoiceModel() {
    listInvoice = [];
    _searchValue = TextEditingController();
  }

  List<Invoice>? get listInvoice => _listInvoice;

  set listInvoice(List<Invoice>? value) => _listInvoice = value;

  get searchValue => _searchValue;

  set searchValue(value) => _searchValue = value;

    get getSearchInvoice => searchInvoice;

 set setSearchInvoice( searchInvoice) => searchInvoice = searchInvoice;
}
