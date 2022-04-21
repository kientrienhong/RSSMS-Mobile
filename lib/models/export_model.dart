import 'package:rssms/api/api_services.dart';

class ExportModel {
  late bool isLoading;
  ExportModel() {
    isLoading = false;
  }


    Future<dynamic> exportOrder(String idToken, Map<String, dynamic> request) async {
    try {
      return await ApiServices.doneOrder(request, idToken);
    } catch (e) {
      throw Exception(e);
    }
  }
}
