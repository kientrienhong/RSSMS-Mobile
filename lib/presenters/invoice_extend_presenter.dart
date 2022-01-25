import 'dart:convert';

import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/invoice_extends_model.dart';
import 'package:rssms/models/invoice_model.dart';
import 'package:rssms/views/extend_invoice_view.dart';
import 'package:rssms/views/invoice_view.dart';

class InvoiceExtendPresenter {
  InvoiceExtendsModel? model;
  ExtendInvoiceView? view;

  InvoiceExtendPresenter() {
    model = InvoiceExtendsModel();
  }



}
