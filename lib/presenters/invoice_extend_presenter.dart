import 'dart:convert';

import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/user.dart';
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

  Future<bool> createRequest(
      Map<String, dynamic> extendInvoice, Users user, Invoice invoice) async {
    // view!.updateLoading();
    try {
      final response =
          await ApiServices.createExtendRequest(extendInvoice, user);

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      // view!.updateLoading();
    }
  }
}
