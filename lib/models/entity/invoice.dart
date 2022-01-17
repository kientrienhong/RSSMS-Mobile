import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'order_detail.dart';

class Invoice with ChangeNotifier {
  late int id;
  late String customerName;
  late String customerPhone;
  late String deliveryAddress;
  late String addressReturn;
  late int totalPrice;
  late String rejectedReason;
  late int typeOrder;
  late bool isUserDelivery;
  late String deliveryDate;
  late String deliveryTime;
  late String returnDate;
  late String returnTime;
  late int paymentMethod;
  late int durationDays;
  late int durationMonths;
  late int status;
  late bool isPaid;
  late List<OrderDetail> orderDetails;
  Invoice({
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.deliveryAddress,
    required this.addressReturn,
    required this.totalPrice,
    required this.rejectedReason,
    required this.typeOrder,
    required this.isUserDelivery,
    required this.deliveryDate,
    required this.deliveryTime,
    required this.returnDate,
    required this.returnTime,
    required this.paymentMethod,
    required this.durationDays,
    required this.durationMonths,
    required this.status,
    required this.isPaid,
    required this.orderDetails,
  });

  Invoice.empty() {
    id = -1;
    customerName = '';
    customerPhone = '';
    deliveryAddress = '';
    addressReturn = '';
    totalPrice = -1;
    rejectedReason = '';
    typeOrder = -1;
    isUserDelivery = false;
    deliveryDate = '';
    deliveryTime = '';
    returnDate = '';
    returnTime = '';
    paymentMethod = -1;
    durationDays = -1;
    durationMonths = -1;
    status = -1;
    isPaid = false;
    orderDetails = [];
  }

  Invoice copyWith({
    int? id,
    String? customerName,
    String? customerPhone,
    String? deliveryAddress,
    String? addressReturn,
    int? totalPrice,
    String? rejectedReason,
    int? typeOrder,
    bool? isUserDelivery,
    String? deliveryDate,
    String? deliveryTime,
    String? returnDate,
    String? returnTime,
    int? paymentMethod,
    int? durationDays,
    int? durationMonths,
    int? status,
    bool? isPaid,
    List<OrderDetail>? orderDetails,
  }) {
    return Invoice(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      addressReturn: addressReturn ?? this.addressReturn,
      totalPrice: totalPrice ?? this.totalPrice,
      rejectedReason: rejectedReason ?? this.rejectedReason,
      typeOrder: typeOrder ?? this.typeOrder,
      isUserDelivery: isUserDelivery ?? this.isUserDelivery,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      returnDate: returnDate ?? this.returnDate,
      returnTime: returnTime ?? this.returnTime,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      durationDays: durationDays ?? this.durationDays,
      durationMonths: durationMonths ?? this.durationMonths,
      status: status ?? this.status,
      isPaid: isPaid ?? this.isPaid,
      orderDetails: orderDetails ?? this.orderDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'deliveryAddress': deliveryAddress,
      'addressReturn': addressReturn,
      'totalPrice': totalPrice,
      'rejectedReason': rejectedReason,
      'typeOrder': typeOrder,
      'isUserDelivery': isUserDelivery,
      'deliveryDate': deliveryDate,
      'deliveryTime': deliveryTime,
      'returnDate': returnDate,
      'returnTime': returnTime,
      'paymentMethod': paymentMethod,
      'durationDays': durationDays,
      'durationMonths': durationMonths,
      'status': status,
      'isPaid': isPaid,
      'orderDetails': orderDetails.map((x) => x.toMap()).toList(),
    };
  }

  factory Invoice.fromMap(Map<String, dynamic> map) {
    return Invoice(
      id: map['id']?.toInt() ?? 0,
      customerName: map['customerName'] ?? '',
      customerPhone: map['customerPhone'] ?? '',
      deliveryAddress: map['deliveryAddress'] ?? '',
      addressReturn: map['addressReturn'] ?? '',
      totalPrice: map['totalPrice']?.toInt() ?? 0,
      rejectedReason: map['rejectedReason'] ?? '',
      typeOrder: map['typeOrder']?.toInt() ?? 0,
      isUserDelivery: map['isUserDelivery'] ?? false,
      deliveryDate: map['deliveryDate'] ?? '',
      deliveryTime: map['deliveryTime'] ?? '',
      returnDate: map['returnDate'] ?? '',
      returnTime: map['returnTime'] ?? '',
      paymentMethod: map['paymentMethod']?.toInt() ?? 0,
      durationDays: map['durationDays']?.toInt() ?? 0,
      durationMonths: map['durationMonths']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      isPaid: map['isPaid'] ?? false,
      orderDetails: List<OrderDetail>.from(
          map['orderDetails']?.map((x) => OrderDetail.fromMap(x))),
    );
  }

  void setInvoice({required Invoice invoice}) {
    id = invoice.id;
    customerName = invoice.customerName;
    customerPhone = invoice.customerPhone;
    deliveryAddress = invoice.deliveryAddress;
    addressReturn = invoice.addressReturn;
    totalPrice = invoice.totalPrice;
    rejectedReason = invoice.rejectedReason;
    typeOrder = invoice.typeOrder;
    isUserDelivery = invoice.isUserDelivery;
    deliveryDate = invoice.deliveryDate;
    deliveryTime = invoice.deliveryTime;
    returnDate = invoice.returnDate;
    returnTime = invoice.returnTime;
    paymentMethod = invoice.paymentMethod;
    durationDays = invoice.durationDays;
    durationMonths = invoice.durationMonths;
    status = invoice.status;
    isPaid = invoice.isPaid;
    orderDetails = invoice.orderDetails;
    notifyListeners();
  }

  void updateOrderDetail(OrderDetail orderDetail) {
    int indexFoundOrderDetail =
        orderDetails.indexWhere((e) => e.id == orderDetail.id);
    orderDetails[indexFoundOrderDetail] = orderDetail;
    notifyListeners();
  }

  String toJson() => json.encode(toMap());

  factory Invoice.fromJson(String source) =>
      Invoice.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Invoice(id: $id, customerName: $customerName, customerPhone: $customerPhone, deliveryAddress: $deliveryAddress, addressReturn: $addressReturn, totalPrice: $totalPrice, rejectedReason: $rejectedReason, typeOrder: $typeOrder, isUserDelivery: $isUserDelivery, deliveryDate: $deliveryDate, deliveryTime: $deliveryTime, returnDate: $returnDate, returnTime: $returnTime, paymentMethod: $paymentMethod, durationDays: $durationDays, durationMonths: $durationMonths, status: $status, isPaid: $isPaid, orderDetails: $orderDetails)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Invoice &&
        other.id == id &&
        other.customerName == customerName &&
        other.customerPhone == customerPhone &&
        other.deliveryAddress == deliveryAddress &&
        other.addressReturn == addressReturn &&
        other.totalPrice == totalPrice &&
        other.rejectedReason == rejectedReason &&
        other.typeOrder == typeOrder &&
        other.isUserDelivery == isUserDelivery &&
        other.deliveryDate == deliveryDate &&
        other.deliveryTime == deliveryTime &&
        other.returnDate == returnDate &&
        other.returnTime == returnTime &&
        other.paymentMethod == paymentMethod &&
        other.durationDays == durationDays &&
        other.durationMonths == durationMonths &&
        other.status == status &&
        other.isPaid == isPaid &&
        listEquals(other.orderDetails, orderDetails);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customerName.hashCode ^
        customerPhone.hashCode ^
        deliveryAddress.hashCode ^
        addressReturn.hashCode ^
        totalPrice.hashCode ^
        rejectedReason.hashCode ^
        typeOrder.hashCode ^
        isUserDelivery.hashCode ^
        deliveryDate.hashCode ^
        deliveryTime.hashCode ^
        returnDate.hashCode ^
        returnTime.hashCode ^
        paymentMethod.hashCode ^
        durationDays.hashCode ^
        durationMonths.hashCode ^
        status.hashCode ^
        isPaid.hashCode ^
        orderDetails.hashCode;
  }
}