import 'package:rssms/models/entity/invoice.dart';

class InvoiceModel {
  List<Invoice>? _listInvoice;

  InvoiceModel() {
    listInvoice = [];
  }

  List<Invoice>? get listInvoice => _listInvoice;

  set listInvoice(List<Invoice>? value) => _listInvoice = value;
}
