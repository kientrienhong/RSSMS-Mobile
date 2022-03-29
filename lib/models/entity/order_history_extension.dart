import 'dart:convert';

class OrderHistoryExtension {
  final String id;
  final String orderId;
  final String requestId;
  final String oldReturnDate;
  final String returnDate;
  final int status;
  final String note;
  final int totalPrice;
  final bool isActive;
  final String createDate;
  final String modifiedBy;
  final String paidDate;
  OrderHistoryExtension({
    required this.id,
    required this.orderId,
    required this.requestId,
    required this.oldReturnDate,
    required this.returnDate,
    required this.status,
    required this.note,
    required this.totalPrice,
    required this.isActive,
    required this.createDate,
    required this.modifiedBy,
    required this.paidDate,
  });

  OrderHistoryExtension copyWith({
    String? id,
    String? orderId,
    String? requestId,
    String? oldReturnDate,
    String? returnDate,
    int? status,
    String? note,
    int? totalPrice,
    bool? isActive,
    String? createDate,
    String? modifiedBy,
    String? paidDate,
  }) {
    return OrderHistoryExtension(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      requestId: requestId ?? this.requestId,
      oldReturnDate: oldReturnDate ?? this.oldReturnDate,
      returnDate: returnDate ?? this.returnDate,
      status: status ?? this.status,
      note: note ?? this.note,
      totalPrice: totalPrice ?? this.totalPrice,
      isActive: isActive ?? this.isActive,
      createDate: createDate ?? this.createDate,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      paidDate: paidDate ?? this.paidDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'requestId': requestId,
      'oldReturnDate': oldReturnDate,
      'returnDate': returnDate,
      'status': status,
      'note': note,
      'totalPrice': totalPrice,
      'isActive': isActive,
      'createDate': createDate,
      'modifiedBy': modifiedBy,
      'paidDate': paidDate,
    };
  }

  factory OrderHistoryExtension.fromMap(Map<String, dynamic> map) {
    return OrderHistoryExtension(
      id: map['id'] ?? '',
      orderId: map['orderId'] ?? '',
      requestId: map['requestId'] ?? '',
      oldReturnDate: map['oldReturnDate'] ?? '',
      returnDate: map['returnDate'] ?? '',
      status: map['status']?.toInt() ?? 0,
      note: map['note'] ?? '',
      totalPrice: map['totalPrice']?.toInt() ?? 0,
      isActive: map['isActive'] ?? false,
      createDate: map['createDate'] ?? '',
      modifiedBy: map['modifiedBy'] ?? '',
      paidDate: map['paidDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderHistoryExtension.fromJson(String source) => OrderHistoryExtension.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderHistoryExtension(id: $id, orderId: $orderId, requestId: $requestId, oldReturnDate: $oldReturnDate, returnDate: $returnDate, status: $status, note: $note, totalPrice: $totalPrice, isActive: $isActive, createDate: $createDate, modifiedBy: $modifiedBy, paidDate: $paidDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OrderHistoryExtension &&
      other.id == id &&
      other.orderId == orderId &&
      other.requestId == requestId &&
      other.oldReturnDate == oldReturnDate &&
      other.returnDate == returnDate &&
      other.status == status &&
      other.note == note &&
      other.totalPrice == totalPrice &&
      other.isActive == isActive &&
      other.createDate == createDate &&
      other.modifiedBy == modifiedBy &&
      other.paidDate == paidDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      orderId.hashCode ^
      requestId.hashCode ^
      oldReturnDate.hashCode ^
      returnDate.hashCode ^
      status.hashCode ^
      note.hashCode ^
      totalPrice.hashCode ^
      isActive.hashCode ^
      createDate.hashCode ^
      modifiedBy.hashCode ^
      paidDate.hashCode;
  }
}