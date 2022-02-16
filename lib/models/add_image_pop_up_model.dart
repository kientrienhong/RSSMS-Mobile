import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:rssms/models/entity/imageEntity.dart';

class AddImagePopUpModel {
  late TextEditingController name;
  late TextEditingController note;
  late bool isLoading;
  File? file;

  AddImagePopUpModel(Map<String, dynamic>? imageUpdate) {
    if (imageUpdate != null) {
      name = TextEditingController(text: imageUpdate['name']);
      note = TextEditingController(text: imageUpdate['note']);
      if (imageUpdate['file'] != null) {
        file = imageUpdate['file'];
      }
    } else {
      name = TextEditingController();
      note = TextEditingController();
      file = null;
    }

    isLoading = false;
  }
}
