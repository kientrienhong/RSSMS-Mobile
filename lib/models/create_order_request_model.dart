import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/request.dart';

class CreateOrderRequestModel {
  late Invoice invoice;
  late bool isLoading;
  late String idRequest;
  late bool isValidToCancel;
  late Request request;
  CreateOrderRequestModel(String id) {
    invoice = Invoice.empty();
    isLoading = true;
    idRequest = id;
    isValidToCancel = true;
    request = Request.empty();
  }

  Future<dynamic> getDetailRequest(String id, String idToken) async {
    return await ApiServices.getRequestbyId(idToken, id);
  }
}
