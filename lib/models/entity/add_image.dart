import 'dart:io';

import 'package:flutter/cupertino.dart';

class AddedImage with ChangeNotifier {
  late List<AddedImage> listImage;
  File? image;
  String? name;
  String? description;

  AddedImage.empty() {
    listImage = [];
    image = File('');
    name = '';
    description = '';
  }

  AddedImage({
    this.image,
    this.name,
    this.description,
  });

  AddedImage.copyWith({
    String? image,
    String? name,
    String? description,
  }) {
    name = name;
    description = description;
    image = image;
  }

  void setImage({required AddedImage aimage}) {
    name = aimage.name ?? name;
    image = aimage.image ?? image;
    description = aimage.description ?? description;
    listImage.add(aimage);
    notifyListeners();
  }
}
