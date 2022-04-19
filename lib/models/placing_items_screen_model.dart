import 'dart:developer';

import 'package:rssms/api/api_services.dart';

class PlacingItemsScreenModel {
  late bool isLoading;
  late String error;
  PlacingItemsScreenModel() {
    isLoading = false;
    error = '';
  }

  Future<dynamic> assignOrderToFloor(String idToken, listAssigned) async {
    try {
      return await ApiServices.assignOrderToFloor(listAssigned, idToken);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> moveOrderToAnotherFloor(String idToken, listAssigned) async {
    try {
      return await ApiServices.assignOrderToAnotherFloor(listAssigned, idToken);
    } catch (e) {
      log(e.toString());
    }
  }
}
