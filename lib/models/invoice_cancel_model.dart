import 'package:flutter/cupertino.dart';

class InvoiceCancelModel {
  late TextEditingController _controllerReason;
  InvoiceCancelModel() {
    _controllerReason = TextEditingController();
  }
  
  get controllerReason => _controllerReason;

  set controllerReason(value) => _controllerReason = value;
}
