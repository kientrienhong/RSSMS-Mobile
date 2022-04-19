import 'dart:convert';

class StorageEntity {
  final String id;
  final String name;
  final int type;
  final int status;
  final String address;
  final String description;
  final String imageUrl;
  final double height;
  final double width;
  final double length;
  final int usage;
  final String managerName;
  final double deliveryFee;
  final String deliveryDistance;
  StorageEntity(
      {required this.id,
      required this.name,
      required this.type,
      required this.status,
      required this.address,
      required this.description,
      required this.imageUrl,
      required this.height,
      required this.width,
      required this.length,
      required this.usage,
      required this.managerName,
      required this.deliveryFee,
      required this.deliveryDistance});

  StorageEntity copyWith(
      {String? id,
      String? name,
      int? type,
      int? status,
      String? address,
      String? description,
      String? imageUrl,
      double? height,
      double? width,
      double? length,
      int? usage,
      String? managerName,
      double? deliveryFee,
      String? deliveryDistance}) {
    return StorageEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        status: status ?? this.status,
        address: address ?? this.address,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        height: height ?? this.height,
        width: width ?? this.width,
        length: length ?? this.length,
        usage: usage ?? this.usage,
        managerName: managerName ?? this.managerName,
        deliveryFee: deliveryFee ?? this.deliveryFee,
        deliveryDistance: deliveryDistance ?? this.deliveryDistance);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'status': status,
      'address': address,
      'description': description,
      'imageUrl': imageUrl,
      'height': height,
      'width': width,
      'length': length,
      'usage': usage,
      'managerName': managerName,
      'deliveryFee': deliveryFee,
      'deliveryDistance': deliveryDistance
    };
  }

  factory StorageEntity.fromMap(Map<String, dynamic> map) {
    return StorageEntity(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        type: map['type']?.toInt() ?? 0,
        status: map['status']?.toInt() ?? 0,
        address: map['address'] ?? '',
        description: map['description'] ?? '',
        imageUrl: map['imageUrl'] ?? '',
        height: map['height']?.toDouble() ?? 0,
        width: map['width']?.toDouble() ?? 0,
        length: map['length']?.toDouble() ?? 0,
        usage: map['usage']?.toInt() ?? 0,
        managerName: map['managerName'] ?? '',
        deliveryFee: map['deliveryFee']?.toDouble() ?? 0,
        deliveryDistance: map['deliveryDistance'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory StorageEntity.fromJson(String source) =>
      StorageEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StorageEntity(id: $id, name: $name, type: $type, status: $status, address: $address, description: $description, imageUrl: $imageUrl, height: $height, width: $width, length: $length, usage: $usage, managerName: $managerName, deliveryFee: $deliveryFee)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StorageEntity &&
        other.id == id &&
        other.name == name &&
        other.type == type &&
        other.status == status &&
        other.address == address &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        other.height == height &&
        other.width == width &&
        other.length == length &&
        other.usage == usage &&
        other.managerName == managerName &&
        other.deliveryFee == deliveryFee;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        type.hashCode ^
        status.hashCode ^
        address.hashCode ^
        description.hashCode ^
        imageUrl.hashCode ^
        height.hashCode ^
        width.hashCode ^
        length.hashCode ^
        usage.hashCode ^
        managerName.hashCode ^
        deliveryFee.hashCode;
  }
}
