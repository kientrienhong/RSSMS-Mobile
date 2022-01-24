import 'dart:convert';

import 'package:rssms/models/entity/imageEntity.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/user.dart';

import '../api/firebase_services.dart';
import 'package:firebase_storage/firebase_storage.dart' as FirebaseStorage;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FirebaseStorageHelper {
  static Future<File> urlToFile(String imageUrl) async {
    var bytes = await rootBundle.load(imageUrl);
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/profile.png');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));

    return file;
  }

  static Future<List<String>> listExample(
      String email, int idStorage, String type) async {
    FirebaseStorage.ListResult result = await FirebaseStorage
        .FirebaseStorage.instance
        .ref()
        .child(email)
        .child(idStorage.toString())
        .child(type)
        .listAll();
    List<String> listFile = [];
    result.items.forEach((FirebaseStorage.Reference ref) {
      listFile.add(ref.name);
    });

    return listFile;
  }

  static Future<void> deleteFolder(int idStorage, String email) async {
    FirebaseStorage.ListResult listImage = await FirebaseStorage
        .FirebaseStorage.instance
        .ref()
        .child(email)
        .child(idStorage.toString())
        .child('paperworker')
        .listAll();
    listImage.items.forEach((FirebaseStorage.Reference ref) {
      ref.delete();
    });

    listImage = await FirebaseStorage.FirebaseStorage.instance
        .ref()
        .child(email)
        .child(idStorage.toString())
        .child('imageStorage')
        .listAll();
    listImage.items.forEach((FirebaseStorage.Reference ref) {
      ref.delete();
    });
  }

  static Future<List<ImageEntity>> convertImageToBase64(
      OrderDetail orderDetail) async {
    return Future.wait(orderDetail.images.map((e) async {
      if (e.file == null) {
        return e;
      }
      List<int> imageBytes = await e.file!.readAsBytes();
      return e.copyWith(base64: base64Encode(imageBytes), id: 0);
    }));
  }

  static Future<List<ImageEntity>> uploadImage(
      OrderDetail orderDetail, int orderId, Users user) async {
    return Future.wait(orderDetail.images.map((ele) async {
      int i = 0;

      if (ele.file != null) {
        String destination =
            '${user.email}/${orderId.toString()}/${orderDetail.id}/${i++}.png';
        FirebaseStorage.UploadTask? task =
            FirebaseServices.uploadFile(destination, ele.file!);
        if (task == null) return throw Exception('Can not upload image');
        final snapshot = await task.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();
        return ImageEntity(
            url: urlDownload, id: ele.id, name: ele.name, note: ele.note);
      } else {
        return ImageEntity(
            url: ele.url, id: ele.id, name: ele.name, note: ele.note);
      }
    }));
  }
}
