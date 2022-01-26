import 'package:flutter/cupertino.dart';

class InvoiceGetModel {
  late bool isLoadingButton;
  late TextEditingController _controllerBirthDate;
  late TextEditingController _controllerStreet;

  InvoiceGetModel() {
    isLoadingButton = false;
    _controllerBirthDate = TextEditingController();
    _controllerStreet = TextEditingController();
  }

  get getIsLoadingButton => isLoadingButton;

  set setIsLoadingButton(isLoadingButton) =>
      isLoadingButton = isLoadingButton;

  get controllerBirthDate => _controllerBirthDate;

  set controllerBirthDate(value) => _controllerBirthDate = value;

  get controllerStreet => _controllerStreet;

  set controllerStreet(value) => _controllerStreet = value;
}
