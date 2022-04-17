import 'dart:convert';

class Floor {
  final String id;
  final String name;
  final double usage;
  final double used;
  final int available;
  final double height;
  final double width;
  final double length;
  Floor({
    required this.id,
    required this.name,
    required this.usage,
    required this.used,
    required this.available,
    required this.height,
    required this.width,
    required this.length,
  });

  Floor copyWith({
    String? id,
    String? name,
    double? usage,
    double? used,
    int? available,
    double? height,
    double? width,
    double? length,
  }) {
    return Floor(
      id: id ?? this.id,
      name: name ?? this.name,
      usage: usage ?? this.usage,
      used: used ?? this.used,
      available: available ?? this.available,
      height: height ?? this.height,
      width: width ?? this.width,
      length: length ?? this.length,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'usage': usage,
      'used': used,
      'available': available,
      'height': height,
      'width': width,
      'length': length,
    };
  }

  factory Floor.fromMap(Map<String, dynamic> map) {
    return Floor(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      usage: map['usage']?.toDouble() ?? 0,
      used: map['used']?.toDouble() ?? 0,
      available: map['available']?.toInt() ?? 0,
      height: map['height']?.toDouble() ?? 0,
      width: map['width']?.toDouble() ?? 0,
      length: map['length']?.toDouble() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Floor.fromJson(String source) => Floor.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Floor(id: $id, name: $name, usage: $usage, used: $used, available: $available, height: $height, width: $width, length: $length)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Floor &&
        other.id == id &&
        other.name == name &&
        other.usage == usage &&
        other.used == used &&
        other.available == available &&
        other.height == height &&
        other.width == width &&
        other.length == length;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        usage.hashCode ^
        used.hashCode ^
        available.hashCode ^
        height.hashCode ^
        width.hashCode ^
        length.hashCode;
  }
}
