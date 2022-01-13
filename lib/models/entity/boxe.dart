import 'dart:convert';

class Boxe {
  final int id;
  final int orderId;
  final int shelfId;
  final String sizeType;
  Boxe({
    required this.id,
    required this.orderId,
    required this.shelfId,
    required this.sizeType,
  });

  Boxe copyWith({
    int? id,
    int? orderId,
    int? shelfId,
    String? sizeType,
  }) {
    return Boxe(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      shelfId: shelfId ?? this.shelfId,
      sizeType: sizeType ?? this.sizeType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'shelfId': shelfId,
      'sizeType': sizeType,
    };
  }

  factory Boxe.fromMap(Map<String, dynamic> map) {
    return Boxe(
      id: map['id']?.toInt() ?? 0,
      orderId: map['orderId']?.toInt() ?? 0,
      shelfId: map['shelfId']?.toInt() ?? 0,
      sizeType: map['sizeType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Boxe.fromJson(String source) => Boxe.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Boxe(id: $id, orderId: $orderId, shelfId: $shelfId, sizeType: $sizeType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Boxe &&
      other.id == id &&
      other.orderId == orderId &&
      other.shelfId == shelfId &&
      other.sizeType == sizeType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      orderId.hashCode ^
      shelfId.hashCode ^
      sizeType.hashCode;
  }
}