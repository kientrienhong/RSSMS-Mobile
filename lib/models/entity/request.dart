import 'dart:convert';

class Request {
  late String id;
  late String orderId;
  late String orderName;
  late String userId;
  late int type;
  late int typeOrder;
  late int status;
  late bool isCustomerDelivery;
  late String deliveryStaffName;
  late String deliveryStaffPhone;
  late String customerName;
  late String customerPhone;
  late String storageId;
  late String storageName;
  late String deliveryDate;
  late String deliveryTime;
  late String deliveryAddress;
  late String returnAddress;
  late String returnDate;
  late String returnTime;
  late String cancelReason;
  late String fromDate;
  late String toDate;
  late String note;
  late String createdDate;
  late double totalPrice;
  late double deliveryFee;
  late double advanceMoney;
  late String oldReturnDate;
  Request(
      {required this.id,
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
      required this.advanceMoney,
      required this.deliveryFee,
      required this.oldReturnDate});

  Request.empty() {
    id = '';
    totalPrice = 0;
    orderId = '';
    orderName = '';
    userId = '';
    type = 0;
    typeOrder = 0;
    status = 0;
    isCustomerDelivery = false;
    deliveryStaffName = '';
    deliveryStaffPhone = '';
    customerName = '';
    customerPhone = '';
    storageId = '';
    storageName = '';
    deliveryDate = '';
    deliveryTime = '';
    deliveryAddress = '';
    returnAddress = '';
    returnDate = '';
    returnTime = '';
    cancelReason = '';
    fromDate = '';
    toDate = '';
    note = '';
    createdDate = '';
    deliveryFee = 0;
    advanceMoney = 0;
    oldReturnDate = '';
  }

  Request copyWith(
      {String? id,
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
      double? advanceMoney,
      double? deliveryFee,
      String? oldReturnDate}) {
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
        advanceMoney: advanceMoney ?? this.advanceMoney,
        deliveryFee: deliveryFee ?? this.deliveryFee,
        oldReturnDate: oldReturnDate ?? this.oldReturnDate);
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
      'deliveryFee': deliveryFee,
      'advanceMoney': advanceMoney,
      'oldReturnDate': oldReturnDate
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
        advanceMoney: map['advanceMoney'] ?? 0,
        deliveryFee: map['deliveryFee'] ?? 0,
        oldReturnDate: map['oldReturnDate'] ?? '');
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
