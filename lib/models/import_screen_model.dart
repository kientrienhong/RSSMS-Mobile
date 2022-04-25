import 'dart:developer';

import 'package:rssms/api/api_services.dart';

class ImportScreenModel {
  late bool isLoading;
  late String errorMessage;
  ImportScreenModel() {
    isLoading = false;
    errorMessage = '';
  }

  Future<dynamic> assignOrderToFloor(String idToken, listAssigned) async {
    try {
      return await ApiServices.assignOrderToFloor(listAssigned, idToken);
    } catch (e) {
      log(e.toString());
    }
  }
}
