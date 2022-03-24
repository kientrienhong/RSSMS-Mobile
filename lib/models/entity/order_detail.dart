import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rssms/models/entity/imageEntity.dart';
import 'package:rssms/models/entity/order_detail_service.dart';
import 'package:rssms/models/entity/product.dart';

import 'image.dart';

class OrderDetail {
  final String id;
  final String productId;
  final String productName;
  final int price;
  int amount;
  final int productType;
  final String note;
  final List<ImageEntity> images;
  final double? width;
  final double? height;
  final double? length;
  final String serviceImageUrl;
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

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      id: map['id'] ?? '',
      note: map['note'] ?? '',
      width: map['width']?.toInt() ?? 0,
      height: map['height']?.toInt() ?? 0,
      length: map['length']?.toInt() ?? 0,
      productId: map['serviceId'] ?? 0,
      productName: map['serviceName'] ?? '',
      price: map['price']?.toInt() ?? 0,
      amount: map['amount']?.toInt() ?? 0,
      serviceImageUrl: map['serviceImageUrl'] ?? '',
      listAdditionService: map['orderDetailServices'] != null
          ? map['orderDetailServices']?.map((x) => Product(
                id: map['serviceId'] ?? '',
                name: map['serviceName'] ?? '',
                price: map['totalPrice']?.toInt() ?? 0,
                size: map['size'] ?? '',
                description: map['description'] ?? '',
                type: map['serviceType']?.toInt() ?? 0,
                unit: map['unit'] ?? '',
                quantity: map['amount'].toInt() ?? 1,
                tooltip: map['tooltip'] ?? '',
                status: map['status'] ?? 1,
                imageUrl: map['serviceUrl'] ?? '',
              ))
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
