import 'dart:developer';

import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/account.dart';

class PlacingItemsScreenModel {
  late bool isLoading;
  late String error;
  late Account deliveryStaff;
  PlacingItemsScreenModel() {
    isLoading = false;
    error = '';
    deliveryStaff = Account.empty();
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

  Future<dynamic> getStaffDetail(String idToken, String id) async {
    try {
      return await ApiServices.getAccountbyId(idToken, id);
    } catch (e) {
      log(e.toString());
    }
  }
}
