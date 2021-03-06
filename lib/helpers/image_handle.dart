import 'dart:convert';
import 'dart:io';

import 'package:rssms/models/entity/imageEntity.dart';
import 'package:rssms/models/entity/order_detail.dart';

class ImageHandle {
  static Future<List<ImageEntity>> convertImageToBase64(
      OrderDetail orderDetail) async {
    return Future.wait(orderDetail.images.map((e) async {
      if (e.file == null) {
        return e;
      }
      List<int> imageBytes = await e.file!.readAsBytes();
      return e.copyWith(base64: base64Encode(imageBytes), id: '');
    }));
  }

  static Future<ImageEntity> convertImagePathToBase64(String path) async {
    List<int> imageBytes = await File(path).readAsBytes();

    return ImageEntity(base64: base64Encode(imageBytes), id: '');
  }
}
