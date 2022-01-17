import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'imageEntity.dart';

class OrderDetail {
  final int id;
  final int productId;
  final String productName;
  final int price;
  final int amount;
  final int productType;
  final String note;
  final List<ImageEntity> images;
  List<Map<String, dynamic>>? listImageUpdate = [];
  OrderDetail({
    required this.id,
    required this.productId,
    required this.productName,
    required this.price,
    required this.amount,
    required this.note,
    required this.productType,
    required this.images,
    this.listImageUpdate,
  });

  OrderDetail copyWith({
    int? productId,
    String? productName,
    int? price,
    int? amount,
    int? productType,
    List<ImageEntity>? images,
    String? note,
    int? id,
    List<Map<String, dynamic>>? listImageUpdate,
  }) {
    return OrderDetail(
      id: id ?? this.id,
      note: note ?? this.note,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      amount: amount ?? this.amount,
      productType: productType ?? this.productType,
      images: images ?? this.images,
      listImageUpdate: listImageUpdate ?? this.listImageUpdate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'price': price,
      'amount': amount,
      'note': note,
      'productType': productType,
      'images': images.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
        id: map['id']?.toInt() ?? 0,
        note: map['note'] ?? '',
        productId: map['productId']?.toInt() ?? 0,
        productName: map['productName'] ?? '',
        price: map['price']?.toInt() ?? 0,
        amount: map['amount']?.toInt() ?? 0,
        productType: map['productType']?.toInt() ?? 0,
        images: List<ImageEntity>.from(
            map['images']?.map((x) => ImageEntity.fromMap(x))),
        listImageUpdate: map['listImageUpdate'] ?? []);
  }

  String toJson() => json.encode(toMap());

  factory OrderDetail.fromJson(String source) =>
      OrderDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderDetail(productId: $productId, productName: $productName, price: $price, amount: $amount, productType: $productType, images: $images, listUpdate: $listImageUpdate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderDetail &&
        other.productId == productId &&
        other.id == id &&
        other.productName == productName &&
        other.price == price &&
        other.amount == amount &&
        other.note == note &&
        other.productType == productType &&
        listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        productName.hashCode ^
        price.hashCode ^
        id.hashCode ^
        amount.hashCode ^
        note.hashCode ^
        productType.hashCode ^
        images.hashCode;
  }
}
