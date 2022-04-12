import 'dart:convert';

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
}
