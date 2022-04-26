import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rssms/models/entity/order_additional_fee.dart';

import 'order_detail.dart';

class Invoice with ChangeNotifier {
  late String id;
  late String customerName;
  late String customerPhone;
  late String deliveryAddress;
  late String addressReturn;
  late String storageId;
  late String storageName;
  late String storageAddress;
  late String? orderId;
  late double totalPrice;
  late String rejectedReason;
  String? requestId;
  late int typeOrder;
  late int? typeRequest;
  late String? customerId;
  late String name;
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
  late String importDeliveryBy;
  late String importDay;
  late String importStaff;
  late String importCode;
  late List<OrderDetail> orderDetails;
  late bool? isOrder;
  late String? exportAddress;
  late double deliveryFee;
  late String deliveryDistance;
  late double advanceMoney;
  late List<OrderAdditionalFee> orderAdditionalFees;
  Invoice(
      {required this.id,
      required this.customerName,
      required this.customerPhone,
      required this.orderAdditionalFees,
      required this.deliveryAddress,
      required this.addressReturn,
      required this.totalPrice,
      required this.rejectedReason,
      required this.customerId,
      required this.typeOrder,
      required this.isUserDelivery,
      this.orderId,
      required this.deliveryDate,
      this.typeRequest,
      required this.deliveryTime,
      required this.returnDate,
      required this.returnTime,
      required this.paymentMethod,
      required this.durationDays,
      required this.durationMonths,
      required this.name,
      this.requestId,
      this.exportAddress,
      required this.status,
      required this.isPaid,
      required this.orderDetails,
      required this.isOrder,
      required this.storageAddress,
      required this.storageId,
      required this.storageName,
      required this.importCode,
      required this.importDay,
      required this.importDeliveryBy,
      required this.importStaff,
      required this.deliveryDistance,
      required this.advanceMoney,
      required this.deliveryFee});

  Invoice.empty() {
    id = '';
    customerName = '';
    customerPhone = '';
    deliveryAddress = '';
    name = '';
    addressReturn = '';
    totalPrice = -1;
    rejectedReason = '';
    typeOrder = 0;
    orderId = '';
    isUserDelivery = false;
    deliveryDate = '2000-12-12';
    deliveryTime = '';
    returnDate = '2000-12-12';
    returnTime = '';
    customerId = '';
    requestId = '';
    paymentMethod = -1;
    durationDays = -1;
    durationMonths = -1;
    status = 0;
    orderAdditionalFees = [];
    isPaid = false;
    orderDetails = [];
    isOrder = false;
    typeRequest = -1;
    storageId = '';
    storageName = '';
    storageAddress = '';
    importCode = '';
    importDay = '';
    importDeliveryBy = '';
    importStaff = '';
    exportAddress = '';
    deliveryDistance = '';
    deliveryFee = 0;
    advanceMoney = 0;
  }

  Invoice copyWith(
      {String? id,
      String? customerName,
      String? customerPhone,
      String? deliveryAddress,
      String? addressReturn,
      double? totalPrice,
      String? rejectedReason,
      int? typeOrder,
      bool? isUserDelivery,
      String? deliveryDate,
      String? deliveryTime,
      List<OrderAdditionalFee>? orderAdditionalFees,
      String? returnDate,
      String? returnTime,
      int? typeRequest,
      int? paymentMethod,
      int? durationDays,
      String? orderId,
      int? durationMonths,
      String? name,
      String? customerId,
      String? requestId,
      int? status,
      bool? isPaid,
      List<OrderDetail>? orderDetails,
      List<Map<String, dynamic>>? listRequests,
      bool? isOrder,
      String? storageName,
      String? storageId,
      String? storageAddress,
      String? importDeliveryBy,
      String? importDay,
      String? importStaff,
      String? importCode,
      String? exportAddress,
      String? deliveryDistance,
      double? deliveryFee,
      double? advanceMoney}) {
    return Invoice(
        isOrder: isOrder ?? this.isOrder,
        id: id ?? this.id,
        orderAdditionalFees: orderAdditionalFees ?? this.orderAdditionalFees,
        name: name ?? this.name,
        customerId: customerId ?? this.customerId,
        customerName: customerName ?? this.customerName,
        customerPhone: customerPhone ?? this.customerPhone,
        deliveryAddress: deliveryAddress ?? this.deliveryAddress,
        addressReturn: addressReturn ?? this.addressReturn,
        totalPrice: totalPrice ?? this.totalPrice,
        rejectedReason: rejectedReason ?? this.rejectedReason,
        typeOrder: typeOrder ?? this.typeOrder,
        requestId: requestId ?? this.requestId,
        orderId: orderId ?? this.orderId,
        typeRequest: typeRequest ?? this.typeRequest,
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
        storageName: storageName ?? this.storageName,
        storageId: storageId ?? this.storageId,
        storageAddress: storageAddress ?? this.storageAddress,
        importCode: importCode ?? this.importCode,
        importDay: importDay ?? this.importDay,
        importDeliveryBy: importDeliveryBy ?? this.importDeliveryBy,
        importStaff: importStaff ?? this.importStaff,
        exportAddress: exportAddress ?? this.exportAddress,
        deliveryDistance: deliveryDistance ?? this.deliveryDistance,
        deliveryFee: deliveryFee ?? this.deliveryFee,
        advanceMoney: advanceMoney ?? this.advanceMoney);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'deliveryAddress': deliveryAddress,
      'addressReturn': addressReturn,
      'totalPrice': totalPrice.toDouble(),
      'rejectedReason': rejectedReason,
      'typeOrder': typeOrder,
      'isUserDelivery': isUserDelivery,
      'isOrder': isOrder,
      'deliveryDate': deliveryDate,
      'deliveryTime': deliveryTime,
      'returnDate': returnDate,
      'returnTime': returnTime,
      'requestId': requestId,
      'orderAdditionalFees': orderAdditionalFees.map((x) => x.toMap()).toList(),
      'orderId': orderId,
      'Name': name,
      'paymentMethod': paymentMethod,
      'durationDays': durationDays,
      'durationMonths': durationMonths,
      'status': status,
      'isPaid': isPaid,
      'orderDetails': orderDetails.map((x) => x.toMap()).toList(),
      'exportAddress': 'exportAddress'
    };
  }

  factory Invoice.fromMap(Map<String, dynamic> map) {
    String requestIdFound = '';
    String exportAddressRequest = '';
    if (map['requests'] != null) {
      if (map['requests'].length > 0) {
        map['requests'].forEach((e) {
          if (e['type'] == 1) {
            requestIdFound = e['id'];
          }
          if (e['type'] == 4) {
            exportAddressRequest = e['deliveryAddress'];
          }
        });
      }
    }

    return Invoice(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        customerId: map['customerId'] ?? '',
        customerName: map['customerName'] ?? '',
        customerPhone: map['customerPhone'] ?? '',
        deliveryAddress: map['deliveryAddress'] ?? '',
        orderId: map['id'] ?? '',
        storageAddress: map['storageAddress'] ?? '',
        storageId: map['storageId'] ?? '',
        storageName: map['storageName'] ?? '',
        isOrder: true,
        addressReturn: map['addressReturn'] ?? '',
        totalPrice: map['totalPrice']?.toDouble() ?? 0,
        requestId: requestIdFound,
        rejectedReason: map['rejectedReason'] ?? '',
        typeOrder: map['type']?.toInt() ?? 0,
        isUserDelivery: map['isUserDelivery'] ?? false,
        deliveryDate: map['deliveryDate'] ?? '',
        deliveryTime: map['deliveryTime'] ?? '',
        returnDate: map['returnDate'] ?? '',
        typeRequest: -1,
        returnTime: map['returnTime'] ?? '',
        paymentMethod: map['paymentMethod']?.toInt() ?? 0,
        durationDays: map['durationDays']?.toInt() ?? 0,
        durationMonths: map['durationMonths']?.toInt() ?? 0,
        status: map['status']?.toInt() ?? 0,
        isPaid: map['isPaid'] ?? false,
        orderAdditionalFees: List<OrderAdditionalFee>.from(
            map['orderAdditionalFees']
                ?.map((x) => OrderAdditionalFee.fromMap(x))),
        orderDetails: map['orderDetails'] != null
            ? List<OrderDetail>.from(
                map['orderDetails']?.map((x) => OrderDetail.fromMap(x)))
            : [],
        importCode: map['importCode'] ?? '',
        importDay: map['importDay'] ?? '',
        importDeliveryBy: map['importDeliveryBy'] ?? '',
        exportAddress: exportAddressRequest,
        importStaff: map['importStaff'] ?? '',
        deliveryDistance: map['deliveryDistance'] ?? '',
        deliveryFee: map['deliveryFee'] ?? 0,
        advanceMoney: map['advanceMoney'] ?? 0);
  }

  factory Invoice.fromRequest(Map<String, dynamic> map) {
    return Invoice(
        id: map['id'] ?? '',
        customerId: map['customerId'] ?? '',
        name: map['name'] ?? '',
        customerName: map['customerName'] ?? '',
        customerPhone: map['customerPhone'] ?? '',
        deliveryAddress: map['deliveryAddress'] ?? '',
        isOrder: false,
        addressReturn: map['returnAddress'] ?? '',
        totalPrice: map['totalPrice']?.toDouble() ?? 0,
        rejectedReason: map['rejectedReason'] ?? '',
        orderAdditionalFees: [],
        orderId: map['orderId'] ?? '',
        storageAddress: map['storageAddress'] ?? '',
        storageId: map['storageId'] ?? '',
        storageName: map['storageName'] ?? '',
        typeOrder: map['typeOrder']?.toInt() ?? 0,
        isUserDelivery: map['isUserDelivery'] ?? false,
        deliveryDate: map['deliveryDate'] ?? '',
        requestId: map['id'] ?? '',
        typeRequest: map['type']?.toInt() ?? -1,
        deliveryTime: map['deliveryTime'] ?? '',
        returnDate: map['returnDate'] ?? '',
        returnTime: map['returnTime'] ?? '',
        paymentMethod: map['paymentMethod']?.toInt() ?? 0,
        durationDays: map['durationDays']?.toInt() ?? 0,
        durationMonths: map['durationMonths']?.toInt() ?? 0,
        status: map['status']?.toInt() ?? 0,
        isPaid: map['isPaid'] ?? false,
        orderDetails: map['requestDetails'] != null
            ? List<OrderDetail>.from(
                map['requestDetails']?.map((x) => OrderDetail.formRequest(x)))
            : [],
        importCode: map['importCode'] ?? '',
        importDay: map['importDay'] ?? '',
        importDeliveryBy: map['importDeliveryBy'] ?? '',
        importStaff: map['importStaff'] ?? '',
        deliveryDistance: map['deliveryDistance'] ?? '',
        deliveryFee: map['deliveryFee'] ?? 0,
        advanceMoney: map['advanceMoney'] ?? 0);
  }

  void setInvoice({required Invoice invoice}) {
    id = invoice.id;
    name = invoice.name;
    customerName = invoice.customerName;
    customerPhone = invoice.customerPhone;
    deliveryAddress = invoice.deliveryAddress;
    addressReturn = invoice.addressReturn;
    totalPrice = invoice.totalPrice;
    rejectedReason = invoice.rejectedReason;
    typeOrder = invoice.typeOrder;
    isUserDelivery = invoice.isUserDelivery;
    deliveryDate = invoice.deliveryDate;
    requestId = invoice.requestId;
    orderId = invoice.orderId;
    deliveryTime = invoice.deliveryTime;
    returnDate = invoice.returnDate;
    returnTime = invoice.returnTime;
    paymentMethod = invoice.paymentMethod;
    durationDays = invoice.durationDays;
    durationMonths = invoice.durationMonths;
    status = invoice.status;
    isPaid = invoice.isPaid;
    orderDetails = invoice.orderDetails;
    isOrder = invoice.isOrder;
    customerId = invoice.customerId;
    orderAdditionalFees = invoice.orderAdditionalFees;
    storageAddress = invoice.storageAddress;
    storageId = invoice.storageId;
    storageName = invoice.storageName;
    importCode = invoice.importCode;
    importDay = invoice.importDay;
    importDeliveryBy = invoice.importDeliveryBy;
    importStaff = invoice.importStaff;
    deliveryFee = invoice.deliveryFee;
    advanceMoney = invoice.advanceMoney;
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
