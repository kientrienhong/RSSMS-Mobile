import 'dart:convert';

import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/request.dart';
import 'package:rssms/models/extend_request_model.dart';
import 'package:rssms/views/extend_request_view.dart';

class ExtendRequestPresenter {
  ExtendRequestView? view;
  ExtendRequestModel? model;

  ExtendRequestPresenter() {
    model = ExtendRequestModel();
  }

  Future<void> getRequest(String id, String idToken) async {
    view!.changeLoadingStatus();
    try {
      final responseRequest = await ApiServices.getRequestbyId(idToken, id);
      if (responseRequest.statusCode == 200) {
        final decodedReponse = jsonDecode(responseRequest.body);
        Request? request = Request.fromMap(decodedReponse);
        model!.request = request;
      } else if (responseRequest.statusCode >= 500) {
        throw Exception("Máy chủ bị lỗi vui lòng thử lại sau");
      }
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    } finally {
      view!.setChangeViewRequest();
      view!.changeLoadingStatus();
    }
  }

  Future<void> loadInvoice(String idToken, String id) async {
    view!.changeLoadingStatus();
    try {
      final responseInvoice = await ApiServices.getInvoicebyId(idToken, id);
      if (responseInvoice.statusCode == 200) {
        Invoice invoice = Invoice.fromJson(responseInvoice.body);
        model!.invoice = invoice;
      }
    } catch (e) {
      print(e);
    } finally {
      view!.setChangeView();
      view!.changeLoadingStatus();
    }
  }
}
