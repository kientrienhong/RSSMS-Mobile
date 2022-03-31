import 'dart:convert';

class Request {
  final String id;
  final String orderId;
  final String orderName;
  final String userId;
  final int type;
  final int typeOrder;
  final int status;
  final bool isCustomerDelivery;
  final String deliveryStaffName;
  final String deliveryStaffPhone;
  final String customerName;
  final String customerPhone;
  final String storageId;
  final String storageName;
  final String deliveryDate;
  final String deliveryTime;
  final String deliveryAddress;
  final String returnAddress;
  final String returnDate;
  final String returnTime;
  final String cancelReason;
  final String fromDate;
  final String toDate;
  final String note;
  final String createdDate;
  final double totalPrice;
  Request({
    required this.id,
    required this.totalPrice,
    required this.orderId,
    required this.orderName,
    required this.userId,
    required this.type,
    required this.typeOrder,
    required this.status,
    required this.isCustomerDelivery,
    required this.deliveryStaffName,
    required this.deliveryStaffPhone,
    required this.customerName,
    required this.customerPhone,
    required this.storageId,
    required this.storageName,
    required this.deliveryDate,
    required this.deliveryTime,
    required this.deliveryAddress,
    required this.returnAddress,
    required this.returnDate,
    required this.returnTime,
    required this.cancelReason,
    required this.fromDate,
    required this.toDate,
    required this.note,
    required this.createdDate,
  });

  Request copyWith({
    String? id,
    String? orderId,
    String? orderName,
    String? userId,
    int? type,
    int? typeOrder,
    int? status,
    bool? isCustomerDelivery,
    String? deliveryStaffName,
    String? deliveryStaffPhone,
    String? customerName,
    String? customerPhone,
    String? storageId,
    String? storageName,
    String? deliveryDate,
    String? deliveryTime,
    String? deliveryAddress,
    String? returnAddress,
    String? returnDate,
    String? returnTime,
    String? cancelReason,
    String? fromDate,
    String? toDate,
    String? note,
    String? createdDate,
    double? totalPrice,
  }) {
    return Request(
      id: id ?? this.id,
      totalPrice: totalPrice ?? this.totalPrice,
      orderId: orderId ?? this.orderId,
      orderName: orderName ?? this.orderName,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      typeOrder: typeOrder ?? this.typeOrder,
      status: status ?? this.status,
      isCustomerDelivery: isCustomerDelivery ?? this.isCustomerDelivery,
      deliveryStaffName: deliveryStaffName ?? this.deliveryStaffName,
      deliveryStaffPhone: deliveryStaffPhone ?? this.deliveryStaffPhone,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      storageId: storageId ?? this.storageId,
      storageName: storageName ?? this.storageName,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      returnAddress: returnAddress ?? this.returnAddress,
      returnDate: returnDate ?? this.returnDate,
      returnTime: returnTime ?? this.returnTime,
      cancelReason: cancelReason ?? this.cancelReason,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      note: note ?? this.note,
      createdDate: createdDate ?? this.createdDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'orderName': orderName,
      'userId': userId,
      'type': type,
      'typeOrder': typeOrder,
      'status': status,
      'isCustomerDelivery': isCustomerDelivery,
      'deliveryStaffName': deliveryStaffName,
      'deliveryStaffPhone': deliveryStaffPhone,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'storageId': storageId,
      'storageName': storageName,
      'deliveryDate': deliveryDate,
      'totalPrice': totalPrice,
      'deliveryTime': deliveryTime,
      'deliveryAddress': deliveryAddress,
      'returnAddress': returnAddress,
      'returnDate': returnDate,
      'returnTime': returnTime,
      'cancelReason': cancelReason,
      'fromDate': fromDate,
      'toDate': toDate,
      'note': note,
      'createdDate': createdDate,
    };
  }

  factory Request.fromMap(Map<String, dynamic> map) {
    return Request(
      id: map['id'] ?? '',
      orderId: map['orderId'] ?? '',
      orderName: map['orderName'] ?? '',
      totalPrice: map['totalPrice']?.toDouble() ?? 0,
      userId: map['userId'] ?? '',
      type: map['type']?.toInt() ?? 0,
      typeOrder: map['typeOrder']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      isCustomerDelivery: map['isCustomerDelivery'] ?? false,
      deliveryStaffName: map['deliveryStaffName'] ?? '',
      deliveryStaffPhone: map['deliveryStaffPhone'] ?? '',
      customerName: map['customerName'] ?? '',
      customerPhone: map['customerPhone'] ?? '',
      storageId: map['storageId'] ?? '',
      storageName: map['storageName'] ?? '',
      deliveryDate: map['deliveryDate'] ?? '',
      deliveryTime: map['deliveryTime'] ?? '',
      deliveryAddress: map['deliveryAddress'] ?? '',
      returnAddress: map['returnAddress'] ?? '',
      returnDate: map['returnDate'] ?? '',
      returnTime: map['returnTime'] ?? '',
      cancelReason: map['cancelReason'] ?? '',
      fromDate: map['fromDate'] ?? '',
      toDate: map['toDate'] ?? '',
      note: map['note'] ?? '',
      createdDate: map['createdDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Request.fromJson(String source) =>
      Request.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Request(id: $id, orderId: $orderId, orderName: $orderName, userId: $userId, type: $type, typeOrder: $typeOrder, status: $status, isCustomerDelivery: $isCustomerDelivery, deliveryStaffName: $deliveryStaffName, deliveryStaffPhone: $deliveryStaffPhone, customerName: $customerName, customerPhone: $customerPhone, storageId: $storageId, storageName: $storageName, deliveryDate: $deliveryDate, deliveryTime: $deliveryTime, deliveryAddress: $deliveryAddress, returnAddress: $returnAddress, returnDate: $returnDate, returnTime: $returnTime, cancelReason: $cancelReason, fromDate: $fromDate, toDate: $toDate, note: $note, createdDate: $createdDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Request &&
        other.id == id &&
        other.orderId == orderId &&
        other.orderName == orderName &&
        other.userId == userId &&
        other.type == type &&
        other.typeOrder == typeOrder &&
        other.status == status &&
        other.isCustomerDelivery == isCustomerDelivery &&
        other.deliveryStaffName == deliveryStaffName &&
        other.deliveryStaffPhone == deliveryStaffPhone &&
        other.customerName == customerName &&
        other.customerPhone == customerPhone &&
        other.storageId == storageId &&
        other.storageName == storageName &&
        other.deliveryDate == deliveryDate &&
        other.deliveryTime == deliveryTime &&
        other.deliveryAddress == deliveryAddress &&
        other.returnAddress == returnAddress &&
        other.returnDate == returnDate &&
        other.returnTime == returnTime &&
        other.cancelReason == cancelReason &&
        other.fromDate == fromDate &&
        other.toDate == toDate &&
        other.note == note &&
        other.createdDate == createdDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        orderId.hashCode ^
        orderName.hashCode ^
        userId.hashCode ^
        type.hashCode ^
        typeOrder.hashCode ^
        status.hashCode ^
        isCustomerDelivery.hashCode ^
        deliveryStaffName.hashCode ^
        deliveryStaffPhone.hashCode ^
        customerName.hashCode ^
        customerPhone.hashCode ^
        storageId.hashCode ^
        storageName.hashCode ^
        deliveryDate.hashCode ^
        deliveryTime.hashCode ^
        deliveryAddress.hashCode ^
        returnAddress.hashCode ^
        returnDate.hashCode ^
        returnTime.hashCode ^
        cancelReason.hashCode ^
        fromDate.hashCode ^
        toDate.hashCode ^
        note.hashCode ^
        createdDate.hashCode;
  }
}
