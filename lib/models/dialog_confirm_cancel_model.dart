import 'package:flutter/cupertino.dart';

class DialogConfirmCancelModel {
  late bool isLoading;
  late TextEditingController note;

  DialogConfirmCancelModel() {
    note = TextEditingController();
    isLoading = false;
  }
}
