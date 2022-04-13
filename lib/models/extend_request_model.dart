import 'package:rssms/api/api_services.dart';
import 'package:rssms/constants/constants.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/request.dart';

class ExtendRequestModel {
  Invoice? invoice;
  Request? request;
  bool? isLoadingRequest;

  ExtendRequestModel() {
    isLoadingRequest = false;
  }

  Future<dynamic> getRequestById(String idToken, String id) async {
    try {
      return await ApiServices.getRequestbyId(idToken, id);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> getInvoiceById(String idToken, String id) async {
    try {
      return await ApiServices.getInvoicebyId(idToken, id);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> cancelRequest(String idToken, String id) async {
    try {
      return await ApiServices.updateRequest(
          id, idToken, STATUS_REQUEST.canceled.index);
    } catch (e) {
      throw Exception(e);
    }
  }
}
