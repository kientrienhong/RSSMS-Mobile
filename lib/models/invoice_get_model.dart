import 'package:flutter/cupertino.dart';
import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/user.dart';

class InvoiceGetModel {
  late bool isLoadingButton;
  late TextEditingController _controllerBirthDate;
  late TextEditingController _controllerStreet;
  late String _error;

  InvoiceGetModel() {
    isLoadingButton = false;
    _controllerBirthDate = TextEditingController();
    _controllerStreet = TextEditingController();
    _error = '';
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
}
