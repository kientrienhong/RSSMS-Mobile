import 'package:rssms/api/api_services.dart';

class DialogCheckInModel {
  late bool isLoading;
  DialogCheckInModel() {
    isLoading = false;
  }

  Future<dynamic> checkInDelivery(String idRequest, String idToken) async {
    return await ApiServices.updateRequest(idRequest, idToken, 4);
  }
}
