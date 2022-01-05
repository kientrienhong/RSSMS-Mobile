import 'package:flutter/cupertino.dart';
import 'package:rssms/models/entity/user.dart';

class InputInformationModel {
  late TextEditingController controllerEmail;
  late TextEditingController controllerFloor;
  late TextEditingController controllerPhone;
  late TextEditingController controllerName;
  late TextEditingController controllerAddress;
  late TextEditingController controllerNote;
  late TextEditingController controllerFloorReturn;
  late TextEditingController controllerAddressReturn;
  InputInformationModel(Users user) {
    controllerEmail = TextEditingController(text: user.email);
    controllerFloor = TextEditingController();
    controllerPhone = TextEditingController(text: user.phone);
    controllerName = TextEditingController(text: user.name);
    controllerAddress = TextEditingController(text: user.address);
    controllerNote = TextEditingController();
    controllerFloorReturn = TextEditingController();
    controllerAddressReturn = TextEditingController();
  }
}
