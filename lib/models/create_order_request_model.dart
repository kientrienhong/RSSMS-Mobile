import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/invoice.dart';

class CreateOrderRequestModel {
  late Invoice invoice;
  late bool isLoading;
  late String idRequest;
  CreateOrderRequestModel(String id) {
    invoice = Invoice.empty();
    isLoading = true;
    idRequest = id;
  }

  Future<dynamic> getDetailRequest(String id, String idToken) async {
    return await ApiServices.getRequestbyId(idToken, id);
  }
}
