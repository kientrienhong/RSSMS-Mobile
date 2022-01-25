import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rssms/models/entity/imageEntity.dart';

import 'image.dart';

class OrderDetail {
  final int id;
  final int productId;
  final String productName;
  final int price;
  final int amount;
  final int productType;
  final String note;
  final List<ImageEntity> images;
  OrderDetail({
    required this.id,
    required this.productId,
    required this.productName,
    required this.price,
    required this.amount,
    required this.productType,
    required this.note,
    required this.images,
  });

  OrderDetail copyWith({
    int? id,
    int? productId,
    String? productName,
    int? price,
    int? amount,
    int? productType,
    String? note,
    List<ImageEntity>? images,
  }) {
    return OrderDetail(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      amount: amount ?? this.amount,
      productType: productType ?? this.productType,
      note: note ?? this.note,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'price': price,
      'amount': amount,
      'productType': productType,
      'note': note,
      'images': images.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      id: map['id']?.toInt() ?? 0,
      productId: map['productId']?.toInt() ?? 0,
      productName: map['productName'] ?? '',
      price: map['price']?.toInt() ?? 0,
      amount: map['amount']?.toInt() ?? 0,
      productType: map['productType']?.toInt() ?? 0,
      note: map['note'] ?? '',
      images: List<ImageEntity>.from(map['images']?.map((x) => ImageEntity.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetail.fromJson(String source) => OrderDetail.fromMap(json.decode(source));

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