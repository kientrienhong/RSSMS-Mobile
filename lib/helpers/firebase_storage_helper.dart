import 'package:rssms/models/entity/order_detail.dart';

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

  static Future<List<Map<String, dynamic>>?> uploadImage(
      List<OrderDetail> listOrderDetail, int orderId) async {
    // return Future.wait(image.map((element) async {
    //   if (element['file'] != null) {
    //     String location = locations[index].toString();
    //     index++;
    //     String destination =
    //         '$email/${orderId.toString()}/$type/$location.png';
    //     task = FirebaseServices.uploadFile(destination, element['file']);
    //     if (task == null) return null;
    //     final snapshot = await task!.whenComplete(() {});
    //     final urlDownload = await snapshot.ref.getDownloadURL();
    //     return {
    //       'imageUrl': urlDownload,
    //       'id': element['id'],
    //       'type': typeInt,
    //       'location': location
    //     };
    //   }
    //   return element;
    // }));
    return null;
  }
}
