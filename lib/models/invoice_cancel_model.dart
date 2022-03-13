import 'package:flutter/cupertino.dart';
import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/user.dart';

class InvoiceCancelModel {
  late TextEditingController _controllerReason;
  late bool isLoading;
  InvoiceCancelModel() {
    _controllerReason = TextEditingController();
    isLoading = false;
  }

  get controllerReason => _controllerReason;

  set controllerReason(value) => _controllerReason = value;

  Future<dynamic> createCancelRequest(
      Map<String, dynamic> cancelRequest, Users user, Invoice invoice) async {
    await await ApiServices.createCancelRequest(cancelRequest, user, invoice);
  }
}
