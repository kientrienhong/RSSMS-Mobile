import 'dart:convert';

class Area {
  late String id;
  late String name;
  late int type;
  late String description;
  late double usage;
  late int status;
  late double width;
  late double height;
  late double length;
  Area({
    required this.id,
    required this.name,
    required this.width,
    required this.height,
    required this.length,
    required this.type,
    required this.description,
    required this.usage,
    required this.status,
  });

  Area.empty() {
    id = '';
    name = '';
    type = 0;
    description = '';
    usage = 0;
    status = 0;
    width = 0;
    height = 0;
    length = 0;
  }

  Area copyWith({
    String? id,
    String? name,
    int? type,
    String? description,
    double? usage,
    int? status,
    double? width,
    double? height,
    double? length,
  }) {
    return Area(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      usage: usage ?? this.usage,
      status: status ?? this.status,
      width: width ?? this.width,
      height: height ?? this.height,
      length: length ?? this.length,
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
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      type: map['type']?.toInt() ?? 0,
      description: map['description'] ?? '',
      usage: map['usage']?.toDouble() ?? 0,
      width: map['width']?.toDouble() ?? 0,
      length: map['length']?.toDouble() ?? 0,
      height: map['height']?.toDouble() ?? 0,
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
