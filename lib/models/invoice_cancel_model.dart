import 'package:flutter/cupertino.dart';

class InvoiceCancelModel {
  late TextEditingController _controllerReason;
  late bool isLoading;
  InvoiceCancelModel() {
    _controllerReason = TextEditingController();
    isLoading = false;
  }

  get controllerReason => _controllerReason;

  set controllerReason(value) => _controllerReason = value;
}
