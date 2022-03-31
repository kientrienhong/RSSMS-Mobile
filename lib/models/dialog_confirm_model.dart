import 'package:flutter/cupertino.dart';
import 'package:rssms/api/api_services.dart';

class DialogConfirmModel {
  late bool isLoading;
  late TextEditingController note;

  DialogConfirmModel() {
    note = TextEditingController();
    isLoading = false;
  }

  Future<dynamic> requestCancel(
      String note, String dateCancel, String idToken) async {
    return await ApiServices.requestCancel(note, 0, dateCancel, idToken);
  }

  Future<dynamic> updateRequest(
      String note, int status, String idToken, String idRequest) async {
    return await ApiServices.updateRequest(idRequest, idToken, status);
  }
}
