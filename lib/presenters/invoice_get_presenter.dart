import 'dart:developer';

import 'package:rssms/helpers/response_handle.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/invoice_get_model.dart';
import 'package:rssms/views/invoice_get_view.dart';

class InvoiceGetPresenter {
  late InvoiceGetModel model;
  late InvoiceGetView view;

  InvoiceGetPresenter() {
    model = InvoiceGetModel();
  }
  Future<bool> createRequest(Map<String, dynamic> request, Users user) async {
    view.updateStatusButton();
    try {
      final response = await model.createGetInvoicedRequest(request, user);

      final handledResponse = ResponseHandle.handle(response);
      if (handledResponse['status'] == 'success') {
        return true;
      } else {
        view.updateError(handledResponse['data']);
        return false;
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      view.updateStatusButton();
    }
  }

  Future<bool> onClickCheckAddress(Invoice invoice, Users user) async {
    view.updateStatusButton();
    try {
      List<Map<String, dynamic>> listServices = [];
      for (var element in invoice.orderDetails) {
        listServices.add({
          "serviceId": element.productId,
          "price": element.price,
          "amount": element.amount,
          'note': element.note
        });
      }
      final response = await model.checkAddress(
          listServices, invoice, user, model.controllerStreet.text);
      final result = ResponseHandle.handle(response);
      if (result['status'] == 'success') {
        model.deliveryFee = result['data'][0]['deliveryFee'];
        model.street = model.controllerStreet.text;
        return true;
      } else {
        view.updateError(result['data']);
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    } finally {
      view.updateStatusButton();
    }
  }
}
