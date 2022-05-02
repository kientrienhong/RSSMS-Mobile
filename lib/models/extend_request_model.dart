import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/request.dart';
import 'package:rssms/models/entity/user.dart';

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

  Future<dynamic> cancelRequest(
      Map<String, dynamic> dataRequest, Users user) async {
    try {
      return await ApiServices.cancelOrder(user.idToken!, dataRequest);
    } catch (e) {
      throw Exception(e);
    }
  }
}
