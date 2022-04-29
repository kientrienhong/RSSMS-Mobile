import 'package:flutter/cupertino.dart';

class CustomConfirmDialogModel {
  late Function onSubmit;
  late TextEditingController controller;
  late bool isLoading;
  late FocusNode focusNode;
  late String errorMsg;
  CustomConfirmDialogModel(Function onSubmitArg) {
    controller = TextEditingController();
    isLoading = false;
    errorMsg = '';
    focusNode = FocusNode();
    onSubmit = onSubmitArg;
  }
}
