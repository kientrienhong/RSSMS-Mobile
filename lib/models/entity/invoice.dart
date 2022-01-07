import 'package:rssms/models/entity/product.dart';

class Invoice {
  final int id;
  final String customerName;
  final String customerPhone;
  final String deliveryAddress;
  final String addressReturn;
  final double totalPrice;
  final String rejectedReason;
  final int typeOrder;
  final bool isUserDelivery;
  final String deliveryDate;
  final String deliveryTime;
  final String returnDate;
  final String returnTime;
  final int paymentMethod;
  final int durationDays;
  final int durationMonths;
  final bool isPaid;
  final int status;
  final List<Product> listProduct;

  Invoice(
      {required this.id,
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
      required this.isPaid,
      required this.status,
      required this.listProduct});

  factory Invoice.fromMap(Map<String, dynamic> map) {
    return Invoice(
      id: map['id']?.toInt() ?? 0,
      customerName: map['customerName']?.toInt() ?? 0,
      customerPhone: map['customerPhone']?.toInt() ?? 0,
      deliveryAddress: map['customerPhone']?.toInt() ?? 0,
      addressReturn: map['addressReturn']?.toInt() ?? 0,
      totalPrice: map['addressReturn']?.toInt() ?? 0,
      rejectedReason: map['addressReturn']?.toInt() ?? 0,
      typeOrder: map['addressReturn']?.toInt() ?? 0,
      isUserDelivery: map['isUserDelivery']?.toInt() ?? 0,
      deliveryDate: map['deliveryDate']?.toInt() ?? 0,
      deliveryTime: map['deliveryDate']?.toInt() ?? 0,
      returnDate: map['deliveryTime']?.toInt() ?? 0,
      returnTime: map['returnTime']?.toInt() ?? 0,
      paymentMethod: map['paymentMethod']?.toInt() ?? 0,
      durationDays: map['durationDays']?.toInt() ?? 0,
      durationMonths: map['durationMonths']?.toInt() ?? 0,
      isPaid: map['isPaid']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      listProduct: map['orderDetails']?.map((x) => x).toList(),
    );
  }

  
}
