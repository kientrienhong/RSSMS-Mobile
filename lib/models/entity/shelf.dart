import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'box.dart';

class Shelf {
  final int id;
  final int areaId;
  final String name;
  final int type;
  final String note;
  final int boxesInWidth;
  final int boxesInHeight;
  final int productId;
  final String sizeType;
  final List<Box> boxes;
  Shelf({
    required this.id,
    required this.areaId,
    required this.name,
    required this.type,
    required this.note,
    required this.boxesInWidth,
    required this.boxesInHeight,
    required this.productId,
    required this.sizeType,
    required this.boxes,
  });

  Shelf copyWith({
    int? id,
    int? areaId,
    String? name,
    int? type,
    String? note,
    int? boxesInWidth,
    int? boxesInHeight,
    int? productId,
    String? sizeType,
    List<Box>? boxes,
  }) {
    return Shelf(
      id: id ?? this.id,
      areaId: areaId ?? this.areaId,
      name: name ?? this.name,
      type: type ?? this.type,
      note: note ?? this.note,
      boxesInWidth: boxesInWidth ?? this.boxesInWidth,
      boxesInHeight: boxesInHeight ?? this.boxesInHeight,
      productId: productId ?? this.productId,
      sizeType: sizeType ?? this.sizeType,
      boxes: boxes ?? this.boxes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'areaId': areaId,
      'name': name,
      'type': type,
      'note': note,
      'boxesInWidth': boxesInWidth,
      'boxesInHeight': boxesInHeight,
      'productId': productId,
      'sizeType': sizeType,
      'boxes': boxes.map((x) => x.toMap()).toList(),
    };
  }

  factory Shelf.fromMap(Map<String, dynamic> map) {
    return Shelf(
      id: map['id']?.toInt() ?? 0,
      areaId: map['areaId']?.toInt() ?? 0,
      name: map['name'] ?? '',
      type: map['type']?.toInt() ?? 0,
      note: map['note'] ?? '',
      boxesInWidth: map['boxesInWidth']?.toInt() ?? 0,
      boxesInHeight: map['boxesInHeight']?.toInt() ?? 0,
      productId: map['productId']?.toInt() ?? 0,
      sizeType: map['sizeType'] ?? '',
      boxes: List<Box>.from(map['boxes']?.map((x) => Box.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Shelf.fromJson(String source) => Shelf.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Shelf(id: $id, areaId: $areaId, name: $name, type: $type, note: $note, boxesInWidth: $boxesInWidth, boxesInHeight: $boxesInHeight, productId: $productId, sizeType: $sizeType, boxes: $boxes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Shelf &&
        other.id == id &&
        other.areaId == areaId &&
        other.name == name &&
        other.type == type &&
        other.note == note &&
        other.boxesInWidth == boxesInWidth &&
        other.boxesInHeight == boxesInHeight &&
        other.productId == productId &&
        other.sizeType == sizeType &&
        listEquals(other.boxes, boxes);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        areaId.hashCode ^
        name.hashCode ^
        type.hashCode ^
        note.hashCode ^
        boxesInWidth.hashCode ^
        boxesInHeight.hashCode ^
        productId.hashCode ^
        sizeType.hashCode ^
        boxes.hashCode;
  }
}
