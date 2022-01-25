import 'dart:convert';

class Area {
  final int id;
  final String name;
  final int type;
  final String description;
  final int usage;
  final int status;
  Area({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.usage,
    required this.status,
  });

  Area copyWith({
    int? id,
    String? name,
    int? type,
    String? description,
    int? usage,
    int? status,
  }) {
    return Area(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      usage: usage ?? this.usage,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'description': description,
      'usage': usage,
      'status': status,
    };
  }

  factory Area.fromMap(Map<String, dynamic> map) {
    return Area(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      type: map['type']?.toInt() ?? 0,
      description: map['description'] ?? '',
      usage: map['usage']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Area.fromJson(String source) => Area.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Area(id: $id, name: $name, type: $type, description: $description, usage: $usage, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Area &&
        other.id == id &&
        other.name == name &&
        other.type == type &&
        other.description == description &&
        other.usage == usage &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        type.hashCode ^
        description.hashCode ^
        usage.hashCode ^
        status.hashCode;
  }
}
