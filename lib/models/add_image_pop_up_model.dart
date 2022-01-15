import 'dart:io';

import 'package:flutter/cupertino.dart';

class AddImagePopUpModel {
  late TextEditingController name;
  late TextEditingController note;
  late bool isLoading;
  File? file;

  AddImagePopUpModel() {
    name = TextEditingController();
    note = TextEditingController();
    isLoading = false;
    file = null;
  }
}
