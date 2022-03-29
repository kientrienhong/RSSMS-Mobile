import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rssms/models/entity/imageEntity.dart';
import 'package:rssms/models/entity/order_detail_service.dart';
import 'package:rssms/models/entity/product.dart';

import 'image.dart';

class OrderDetail {
  final String id;
  String productId;
  String productName;
  int price;
  int amount;
  int productType;
  final String note;
  final List<ImageEntity> images;
  final double? width;
  final double? height;
  final double? length;
  String serviceImageUrl;
  List<Product>? listAdditionService;
  OrderDetail(
      {required this.id,
      required this.productId,
      this.width,
      this.height,
      this.length,
      required this.productName,
      required this.price,
      required this.amount,
      required this.serviceImageUrl,
      required this.productType,
      required this.note,
      required this.images,
      this.listAdditionService = const []});

  OrderDetail copyWith({
    String? id,
    String? productId,
    String? productName,
    int? price,
    String? serviceImageUrl,
    int? amount,
    int? productType,
    double? height,
    double? length,
    double? width,
    String? note,
    List<ImageEntity>? images,
    List<ImageEntity>? imageProduct,
    List<Product>? listAdditionService,
  }) {
    return OrderDetail(
        id: id ?? this.id,
        height: height ?? this.height,
        length: length ?? this.length,
        width: width ?? this.width,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        price: price ?? this.price,
        serviceImageUrl: serviceImageUrl ?? this.serviceImageUrl,
        amount: amount ?? this.amount,
        productType: productType ?? this.productType,
        note: note ?? this.note,
        listAdditionService: listAdditionService ?? this.listAdditionService,
        images: images ?? this.images);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'serviceId': productId,
      'serviceName': productName,
      'price': price,
      'amount': amount,
      'serviceImageUrl': serviceImageUrl,
      'serviceType': productType,
      'note': note,
      'images': images.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderDetail.formRequest(Map<String, dynamic> map) {
    return OrderDetail(
      id: map['id'] ?? '',
      note: map['note'] ?? '',
      width: map['width']?.toDouble() ?? 0,
      height: map['height']?.toDouble() ?? 0,
      length: map['length']?.toDouble() ?? 0,
      productId: map['serviceId'] ?? '',
      productName: map['serviceName'] ?? '',
      price: map['price']?.toInt() ?? 0,
      amount: map['amount']?.toInt() ?? 0,
      serviceImageUrl: map['serviceImageUrl'] ?? '',
      listAdditionService: map['orderDetailServices'] != null
          ? map['orderDetailServices']?.map<Product>((x) {
              return Product(
                id: x['serviceId'] ?? '',
                name: x['serviceName'] ?? '',
                price: x['totalPrice']?.toInt() ?? 0,
                size: x['size'] ?? '',
                description: x['description'] ?? '',
                type: x['serviceType']?.toInt() ?? 0,
                unit: x['unit'] ?? '',
                quantity: x['amount']?.toInt() ?? 1,
                tooltip: x['tooltip'] ?? '',
                status: x['status'] ?? 1,
                imageUrl: x['serviceUrl'] ?? '',
              );
            }).toList()
          : [],
      productType: map['serviceType']?.toInt() ?? 0,
      images: map['images'] != null
          ? List<ImageEntity>.from(
              map['images']?.map((x) => ImageEntity.fromMap(x)))
          : [],
    );
  }

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      id: map['id'] ?? '',
      note: map['note'] ?? '',
      width: map['width']?.toDouble() ?? 0,
      height: map['height']?.toDouble() ?? 0,
      length: map['length']?.toDouble() ?? 0,
      productId: map['serviceId'] ?? '',
      productName: map['serviceName'] ?? '',
      // price: map['price']?.toInt() ?? 0,
      price: map['servicePrice']?.toInt() ?? 0,

      amount: map['amount']?.toInt() ?? 0,
      serviceImageUrl: map['serviceImageUrl'] ?? '',
      listAdditionService: map['orderDetailServices'] != null
          ? map['orderDetailServices']?.map<Product>((x) {
              return Product(
                id: x['serviceId'] ?? '',
                name: x['serviceName'] ?? '',
                price: x['totalPrice']?.toInt() ?? 0,
                size: x['size'] ?? '',
                description: x['description'] ?? '',
                type: x['serviceType']?.toInt() ?? 0,
                unit: x['unit'] ?? '',
                quantity: x['amount']?.toInt() ?? 1,
                tooltip: x['tooltip'] ?? '',
                status: x['status'] ?? 1,
                imageUrl: x['serviceUrl'] ?? '',
              );
            }).toList()
          : [],
      productType: map['serviceType']?.toInt() ?? 0,
      images: map['images'] != null
          ? List<ImageEntity>.from(
              map['images']?.map((x) => ImageEntity.fromMap(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetail.fromJson(String source) =>
      OrderDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderDetail(id: $id, productId: $productId, productName: $productName, price: $price, amount: $amount, productType: $productType, note: $note, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderDetail &&
        other.id == id &&
        other.productId == productId &&
        other.productName == productName &&
        other.price == price &&
        other.amount == amount &&
        other.productType == productType &&
        other.note == note &&
        listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productId.hashCode ^
        productName.hashCode ^
        price.hashCode ^
        amount.hashCode ^
        productType.hashCode ^
        note.hashCode ^
        images.hashCode;
  }
}
