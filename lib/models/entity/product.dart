import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'image_entity.dart';

class Product {
  final String name;
  final int price;
  final String size;
  final String description;
  final int type;
  final String unit;
  final String tooltip;
  final List<ImageEnitity> images;
  Product({
    required this.name,
    required this.price,
    required this.size,
    required this.description,
    required this.type,
    required this.unit,
    required this.tooltip,
    required this.images,
  });

  Product copyWith({
    String? name,
    int? price,
    String? size,
    String? description,
    int? type,
    String? unit,
    String? tooltip,
    List<ImageEnitity>? images,
  }) {
    return Product(
      name: name ?? this.name,
      price: price ?? this.price,
      size: size ?? this.size,
      description: description ?? this.description,
      type: type ?? this.type,
      unit: unit ?? this.unit,
      tooltip: tooltip ?? this.tooltip,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'size': size,
      'description': description,
      'type': type,
      'unit': unit,
      'tooltip': tooltip,
      'images': images.map((x) => x.toMap()).toList(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'],
      price: map['price']?.toInt(),
      size: map['size'],
      description: map['description'],
      type: map['type']?.toInt(),
      unit: map['unit'],
      tooltip: map['tooltip'],
      images: List<ImageEnitity>.from(
          map['images']?.map((x) => ImageEnitity.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(name: $name, price: $price, size: $size, description: $description, type: $type, unit: $unit, tooltip: $tooltip, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.name == name &&
        other.price == price &&
        other.size == size &&
        other.description == description &&
        other.type == type &&
        other.unit == unit &&
        other.tooltip == tooltip &&
        listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        price.hashCode ^
        size.hashCode ^
        description.hashCode ^
        type.hashCode ^
        unit.hashCode ^
        tooltip.hashCode ^
        images.hashCode;
  }
}
