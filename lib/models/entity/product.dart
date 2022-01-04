import 'dart:convert';

import 'package:flutter/foundation.dart';

class Product {
  final int id;
  int? quantity;
  final String name;
  final int price;
  final String size;
  final String description;
  final int type;
  final String unit;
  final String tooltip;
  final int status;
  final List<dynamic> images;
  Product({
    int? this.quantity,
    required this.id,
    required this.name,
    required this.price,
    required this.size,
    required this.description,
    required this.type,
    required this.unit,
    required this.tooltip,
    required this.status,
    required this.images,
  });

  Product copyWith({
    int? quantity,
    int? id,
    String? name,
    int? price,
    String? size,
    String? description,
    int? type,
    String? unit,
    String? tooltip,
    int? status,
    List<Map<String, dynamic>>? images,
  }) {
    return Product(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      name: name ?? this.name,
      price: price ?? this.price,
      size: size ?? this.size,
      description: description ?? this.description,
      type: type ?? this.type,
      unit: unit ?? this.unit,
      tooltip: tooltip ?? this.tooltip,
      status: status ?? this.status,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'size': size,
      'description': description,
      'type': type,
      'unit': unit,
      'tooltip': tooltip,
      'status': status,
      'images': images.toList(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      price: map['price']?.toInt() ?? 0,
      size: map['size'] ?? '',
      description: map['description'] ?? '',
      type: map['type']?.toInt() ?? 0,
      unit: map['unit'] ?? '',
      tooltip: map['tooltip'] ?? '',
      status: map['status'] ?? 0,
      images: map['images']?.map((x) => x).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, size: $size, description: $description, type: $type, unit: $unit, tooltip: $tooltip, status: $status, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.size == size &&
        other.description == description &&
        other.type == type &&
        other.unit == unit &&
        other.tooltip == tooltip &&
        other.status == status &&
        listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        size.hashCode ^
        description.hashCode ^
        type.hashCode ^
        unit.hashCode ^
        tooltip.hashCode ^
        status.hashCode ^
        images.hashCode;
  }
}
