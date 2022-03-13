import 'package:flutter/cupertino.dart';
import 'package:rssms/api/api_services.dart';

class DialogConfirmCancelModel {
  late bool isLoading;
  late TextEditingController note;

  DialogConfirmCancelModel() {
    note = TextEditingController();
    isLoading = false;
  }

  Future<dynamic> requestCancel(
      String note, String dateCancel, String idToken) async {
    return await ApiServices.requestCancel(note, 0, dateCancel, idToken);
  }
}
