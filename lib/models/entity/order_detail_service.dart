import 'dart:convert';

class OrderDetailService {
  final String serviceId;
  final String serviceName;
  final String serviceUrl;
  final int serviceType;
  final int amount;
  final int totalPrice;
  OrderDetailService({
    required this.serviceId,
    required this.serviceName,
    required this.serviceUrl,
    required this.serviceType,
    required this.amount,
    required this.totalPrice,
  });

  OrderDetailService copyWith({
    String? serviceId,
    String? serviceName,
    String? serviceUrl,
    int? serviceType,
    int? amount,
    int? totalPrice,
  }) {
    return OrderDetailService(
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      serviceUrl: serviceUrl ?? this.serviceUrl,
      serviceType: serviceType ?? this.serviceType,
      amount: amount ?? this.amount,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'serviceId': serviceId,
      'serviceName': serviceName,
      'serviceUrl': serviceUrl,
      'serviceType': serviceType,
      'amount': amount,
      'totalPrice': totalPrice,
    };
  }

  factory OrderDetailService.fromMap(Map<String, dynamic> map) {
    return OrderDetailService(
      serviceId: map['serviceId'] ?? '',
      serviceName: map['serviceName'] ?? '',
      serviceUrl: map['serviceUrl'] ?? '',
      serviceType: map['serviceType']?.toInt() ?? 0,
      amount: map['amount']?.toInt() ?? 0,
      totalPrice: map['totalPrice']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetailService.fromJson(String source) => OrderDetailService.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderDetailService(serviceId: $serviceId, serviceName: $serviceName, serviceUrl: $serviceUrl, serviceType: $serviceType, amount: $amount, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OrderDetailService &&
      other.serviceId == serviceId &&
      other.serviceName == serviceName &&
      other.serviceUrl == serviceUrl &&
      other.serviceType == serviceType &&
      other.amount == amount &&
      other.totalPrice == totalPrice;
  }

  @override
  int get hashCode {
    return serviceId.hashCode ^
      serviceName.hashCode ^
      serviceUrl.hashCode ^
      serviceType.hashCode ^
      amount.hashCode ^
      totalPrice.hashCode;
  }
}