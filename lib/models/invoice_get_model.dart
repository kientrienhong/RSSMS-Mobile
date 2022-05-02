import 'package:flutter/cupertino.dart';
import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/user.dart';

class InvoiceGetModel {
  late bool isLoadingButton;
  late TextEditingController _controllerBirthDate;
  late TextEditingController _controllerStreet;
  late String _error;
  late double deliveryFee;
  late bool isAfter;
  InvoiceGetModel() {
    isLoadingButton = false;
    _controllerBirthDate = TextEditingController();
    _controllerStreet = TextEditingController();
    _error = '';
    isAfter = false;
    deliveryFee = 0;
  }

  get error => _error;

  set error(value) => _error = value;

  get getIsLoadingButton => isLoadingButton;

  set setIsLoadingButton(isLoadingButton) => isLoadingButton = isLoadingButton;

  get controllerBirthDate => _controllerBirthDate;

  set controllerBirthDate(value) => _controllerBirthDate = value;

  get controllerStreet => _controllerStreet;

  set controllerStreet(value) => _controllerStreet = value;

  Future<dynamic> createGetInvoicedRequest(
      Map<String, dynamic> request, Users user) async {
    return await ApiServices.createGetInvoicedRequest(request, user);
  }

  Future<dynamic> checkAddress(List<Map<String, dynamic>> listProduct,
      Invoice invoice, Users user, String returnAddress) async {
    return await ApiServices.checkAddress(
        listProduct, invoice, user, returnAddress);
  }
}
