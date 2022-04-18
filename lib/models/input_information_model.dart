import 'package:flutter/cupertino.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/user.dart';

class InputInformationModel {
  late Invoice invoiceDisplay;
  late TextEditingController controllerEmail;
  late TextEditingController controllerPhone;
  late TextEditingController controllerName;
  late TextEditingController controllerAddress;
  late TextEditingController controllerNote;

  late FocusNode focusNodeEmail;
  late FocusNode focusNodePhone;
  late FocusNode focusNodeName;
  late FocusNode focusNodeAddress;
  late FocusNode focusNodeNote;
  InputInformationModel(Users user) {
    controllerEmail = TextEditingController(text: user.email);
    controllerPhone = TextEditingController(text: user.phone);
    controllerName = TextEditingController(text: user.name);
    controllerAddress = TextEditingController(text: user.address);
    controllerNote = TextEditingController();
    invoiceDisplay = Invoice.empty();
    focusNodeAddress = FocusNode();
    focusNodeEmail = FocusNode();
    focusNodePhone = FocusNode();
    focusNodeName = FocusNode();
    focusNodeNote = FocusNode();
  }
}
