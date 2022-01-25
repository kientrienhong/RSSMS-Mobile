import 'dart:convert';

class OrderBoxDetail {
  final int id;
  final int shelfId;
  final String sizeType;
  final String shelfName;
  final String areaName;
  final int status;
  final bool isActive;
  final int productId;
  OrderBoxDetail({
    required this.id,
    required this.shelfId,
    required this.sizeType,
    required this.shelfName,
    required this.areaName,
    required this.status,
    required this.isActive,
    required this.productId,
  });

  OrderBoxDetail copyWith({
    int? id,
    int? shelfId,
    String? sizeType,
    String? shelfName,
    String? areaName,
    int? status,
    bool? isActive,
    int? productId,
  }) {
    return OrderBoxDetail(
      id: id ?? this.id,
      shelfId: shelfId ?? this.shelfId,
      sizeType: sizeType ?? this.sizeType,
      shelfName: shelfName ?? this.shelfName,
      areaName: areaName ?? this.areaName,
      status: status ?? this.status,
      isActive: isActive ?? this.isActive,
      productId: productId ?? this.productId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shelfId': shelfId,
      'sizeType': sizeType,
      'shelfName': shelfName,
      'areaName': areaName,
      'status': status,
      'isActive': isActive,
      'productId': productId,
    };
  }

  factory OrderBoxDetail.fromMap(Map<String, dynamic> map) {
    return OrderBoxDetail(
      id: map['id']?.toInt() ?? 0,
      shelfId: map['shelfId']?.toInt() ?? 0,
      sizeType: map['sizeType'] ?? '',
      shelfName: map['shelfName'] ?? '',
      areaName: map['areaName'] ?? '',
      status: map['status']?.toInt() ?? 0,
      isActive: map['isActive'] ?? false,
      productId: map['productId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderBoxDetail.fromJson(String source) => OrderBoxDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderBoxDetail(id: $id, shelfId: $shelfId, sizeType: $sizeType, shelfName: $shelfName, areaName: $areaName, status: $status, isActive: $isActive, productId: $productId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OrderBoxDetail &&
      other.id == id &&
      other.shelfId == shelfId &&
      other.sizeType == sizeType &&
      other.shelfName == shelfName &&
      other.areaName == areaName &&
      other.status == status &&
      other.isActive == isActive &&
      other.productId == productId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      shelfId.hashCode ^
      sizeType.hashCode ^
      shelfName.hashCode ^
      areaName.hashCode ^
      status.hashCode ^
      isActive.hashCode ^
      productId.hashCode;
  }
}