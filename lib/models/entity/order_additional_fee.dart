import 'dart:convert';

class OrderAdditionalFee {
  final int type;
  final String description;
  final double price;
  OrderAdditionalFee({
    required this.type,
    required this.description,
    required this.price,
  });

  OrderAdditionalFee copyWith({
    int? type,
    String? description,
    double? price,
  }) {
    return OrderAdditionalFee(
      type: type ?? this.type,
      description: description ?? this.description,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'description': description,
      'price': price,
    };
  }

  factory OrderAdditionalFee.fromMap(Map<String, dynamic> map) {
    return OrderAdditionalFee(
      type: map['type']?.toInt() ?? 0,
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderAdditionalFee.fromJson(String source) =>
      OrderAdditionalFee.fromMap(json.decode(source));

  @override
  String toString() =>
      'OrderAdditionalFee(type: $type, description: $description, price: $price)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderAdditionalFee &&
        other.type == type &&
        other.description == description &&
        other.price == price;
  }

  @override
  int get hashCode => type.hashCode ^ description.hashCode ^ price.hashCode;
}
