import 'dart:convert';

class Request {
  final int id;
  final int orderId;
  final int userId;
  final double totalPrice;
  final String returnAddress;
  final String returnTime;
  final String oldReturnDate;
  final String returnDate;
  final int type;
  final int status;
  final String deliveryStaffName;
  final String deliveryStaffPhone;
  final String note;
  final String cancelBy;
  final String cancelByPhone;
  Request({
    required this.id,
    required this.orderId,
    required this.userId,
    required this.totalPrice,
    required this.returnAddress,
    required this.returnTime,
    required this.oldReturnDate,
    required this.returnDate,
    required this.type,
    required this.status,
    required this.deliveryStaffName,
    required this.deliveryStaffPhone,
    required this.note,
    required this.cancelBy,
    required this.cancelByPhone,
  });

  Request copyWith({
    int? id,
    int? orderId,
    int? userId,
    double? totalPrice,
    String? returnAddress,
    String? returnTime,
    String? oldReturnDate,
    String? returnDate,
    int? type,
    int? status,
    String? deliveryStaffName,
    String? deliveryStaffPhone,
    String? note,
    String? cancelBy,
    String? cancelByPhone,
  }) {
    return Request(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      totalPrice: totalPrice ?? this.totalPrice,
      returnAddress: returnAddress ?? this.returnAddress,
      returnTime: returnTime ?? this.returnTime,
      oldReturnDate: oldReturnDate ?? this.oldReturnDate,
      returnDate: returnDate ?? this.returnDate,
      type: type ?? this.type,
      status: status ?? this.status,
      deliveryStaffName: deliveryStaffName ?? this.deliveryStaffName,
      deliveryStaffPhone: deliveryStaffPhone ?? this.deliveryStaffPhone,
      note: note ?? this.note,
      cancelBy: cancelBy ?? this.cancelBy,
      cancelByPhone: cancelByPhone ?? this.cancelByPhone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'userId': userId,
      'totalPrice': totalPrice,
      'returnAddress': returnAddress,
      'returnTime': returnTime,
      'oldReturnDate': oldReturnDate,
      'returnDate': returnDate,
      'type': type,
      'status': status,
      'deliveryStaffName': deliveryStaffName,
      'deliveryStaffPhone': deliveryStaffPhone,
      'note': note,
      'cancelBy': cancelBy,
      'cancelByPhone': cancelByPhone,
    };
  }

  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      id: map['id']?.toInt() ?? 0,
      orderId: map['orderId']?.toInt() ?? 0,
      userId: map['userId']?.toInt() ?? 0,
      totalPrice: map['totalPrice'] ?? 0,
      returnAddress: map['returnAddress'] ?? '',
      returnTime: map['returnTime'] ?? '',
      oldReturnDate: map['oldReturnDate'] ?? '',
      returnDate: map['returnDate'] ?? '',
      type: map['type']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      deliveryStaffName: map['deliveryStaffName'] ?? '',
      deliveryStaffPhone: map['deliveryStaffPhone'] ?? '',
      note: map['note'] ?? '',
      cancelBy: map['cancelBy'] ?? '',
      cancelByPhone: map['cancelByPhone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Request.fromJson(String source) =>
      Request.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Request(id: $id, orderId: $orderId, userId: $userId, totalPrice: $totalPrice, returnAddress: $returnAddress, returnTime: $returnTime, oldReturnDate: $oldReturnDate, returnDate: $returnDate, type: $type, status: $status, deliveryStaffName: $deliveryStaffName, deliveryStaffPhone: $deliveryStaffPhone, note: $note, cancelBy: $cancelBy, cancelByPhone: $cancelByPhone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Request &&
        other.id == id &&
        other.orderId == orderId &&
        other.userId == userId &&
        other.totalPrice == totalPrice &&
        other.returnAddress == returnAddress &&
        other.returnTime == returnTime &&
        other.oldReturnDate == oldReturnDate &&
        other.returnDate == returnDate &&
        other.type == type &&
        other.status == status &&
        other.deliveryStaffName == deliveryStaffName &&
        other.deliveryStaffPhone == deliveryStaffPhone &&
        other.note == note &&
        other.cancelBy == cancelBy &&
        other.cancelByPhone == cancelByPhone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        orderId.hashCode ^
        userId.hashCode ^
        totalPrice.hashCode ^
        returnAddress.hashCode ^
        returnTime.hashCode ^
        oldReturnDate.hashCode ^
        returnDate.hashCode ^
        type.hashCode ^
        status.hashCode ^
        deliveryStaffName.hashCode ^
        deliveryStaffPhone.hashCode ^
        note.hashCode ^
        cancelBy.hashCode ^
        cancelByPhone.hashCode;
  }
}
