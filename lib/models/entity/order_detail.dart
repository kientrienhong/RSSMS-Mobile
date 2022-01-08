import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'image.dart';

class OrderDetail {
  final int productId;
  final String productName;
  final int price;
  final int amount;
  final int productType;
  final List<Image> images;
  OrderDetail({
    required this.productId,
    required this.productName,
    required this.price,
    required this.amount,
    required this.productType,
    required this.images,
  });

  OrderDetail copyWith({
    int? productId,
    String? productName,
    int? price,
    int? amount,
    int? productType,
    List<Image>? images,
  }) {
    return OrderDetail(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      amount: amount ?? this.amount,
      productType: productType ?? this.productType,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'amount': amount,
      'productType': productType,
      'images': images.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      productId: map['productId']?.toInt() ?? 0,
      productName: map['productName'] ?? '',
      price: map['price']?.toInt() ?? 0,
      amount: map['amount']?.toInt() ?? 0,
      productType: map['productType']?.toInt() ?? 0,
      images: List<Image>.from(map['images']?.map((x) => Image.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetail.fromJson(String source) => OrderDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderDetail(productId: $productId, productName: $productName, price: $price, amount: $amount, productType: $productType, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OrderDetail &&
      other.productId == productId &&
      other.productName == productName &&
      other.price == price &&
      other.amount == amount &&
      other.productType == productType &&
      listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return productId.hashCode ^
      productName.hashCode ^
      price.hashCode ^
      amount.hashCode ^
      productType.hashCode ^
      images.hashCode;
  }
}