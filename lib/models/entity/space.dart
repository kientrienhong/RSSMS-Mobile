import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'floor.dart';

class Space {
  final String id;
  final String areaId;
  final String name;
  final int type;
  final List<Floor> floors;
  Space({
    required this.id,
    required this.areaId,
    required this.name,
    required this.type,
    required this.floors,
  });

  Space copyWith({
    String? id,
    String? areaId,
    String? name,
    int? type,
    List<Floor>? floors,
  }) {
    return Space(
      id: id ?? this.id,
      areaId: areaId ?? this.areaId,
      name: name ?? this.name,
      type: type ?? this.type,
      floors: floors ?? this.floors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'areaId': areaId,
      'name': name,
      'type': type,
      'floors': floors.map((x) => x.toMap()).toList(),
    };
  }

  factory Space.fromMap(Map<String, dynamic> map) {
    return Space(
      id: map['id'] ?? '',
      areaId: map['areaId'] ?? '',
      name: map['name'] ?? '',
      type: map['type']?.toInt() ?? 0,
      floors: List<Floor>.from(map['floors']?.map((x) => Floor.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Space.fromJson(String source) => Space.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Space(id: $id, areaId: $areaId, name: $name, type: $type, floors: $floors)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Space &&
        other.id == id &&
        other.areaId == areaId &&
        other.name == name &&
        other.type == type &&
        listEquals(other.floors, floors);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        areaId.hashCode ^
        name.hashCode ^
        type.hashCode ^
        floors.hashCode;
  }
}
