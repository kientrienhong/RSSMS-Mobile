import 'dart:convert';

class Import {
  late String storageName;
  late String storageAddress;
  late String importStaff;
  late String deliveryDate;
  late String id;
  late String customerName;
  late String customerPhone;
  late String deliveryAddress;
  late String importDeliveryBy;
  Import({
    required this.storageName,
    required this.storageAddress,
    required this.importStaff,
    required this.deliveryDate,
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.deliveryAddress,
    required this.importDeliveryBy,
  });

  Import.empty() {
    storageName = '';
    storageAddress = '';
    importStaff = '';
    deliveryDate = '';
    id = '';
    customerName = '';
    customerPhone = '';
    deliveryAddress = '';
    importDeliveryBy = '';
  }

  Import copyWith({
    String? storageName,
    String? storageAddress,
    String? importStaff,
    String? deliveryDate,
    String? id,
    String? customerName,
    String? customerPhone,
    String? deliveryAddress,
    String? importDeliveryBy,
  }) {
    return Import(
      storageName: storageName ?? this.storageName,
      storageAddress: storageAddress ?? this.storageAddress,
      importStaff: importStaff ?? this.importStaff,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      importDeliveryBy: importDeliveryBy ?? this.importDeliveryBy,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'storageName': storageName});
    result.addAll({'storageAddress': storageAddress});
    result.addAll({'importStaff': importStaff});
    result.addAll({'deliveryDate': deliveryDate});
    result.addAll({'id': id});
    result.addAll({'customerName': customerName});
    result.addAll({'customerPhone': customerPhone});
    result.addAll({'deliveryAddress': deliveryAddress});
    result.addAll({'importDeliveryBy': importDeliveryBy});

    return result;
  }

  factory Import.fromMap(Map<String, dynamic> map) {
    return Import(
      storageName: map['storageName'] ?? '',
      storageAddress: map['storageAddress'] ?? '',
      importStaff: map['importStaff'] ?? '',
      deliveryDate: map['deliveryDate'] ?? '',
      id: map['name'] ?? '',
      customerName: map['customerName'] ?? '',
      customerPhone: map['customerPhone'] ?? '',
      deliveryAddress: map['deliveryAddress'] ?? '',
      importDeliveryBy: map['importDeliveryBy'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Import.fromJson(String source) => Import.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Import(storageName: $storageName, storageAddress: $storageAddress, importStaff: $importStaff, deliveryDate: $deliveryDate, id: $id, customerName: $customerName, customerPhone: $customerPhone, deliveryAddress: $deliveryAddress, importDeliveryBy: $importDeliveryBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Import &&
        other.storageName == storageName &&
        other.storageAddress == storageAddress &&
        other.importStaff == importStaff &&
        other.deliveryDate == deliveryDate &&
        other.id == id &&
        other.customerName == customerName &&
        other.customerPhone == customerPhone &&
        other.deliveryAddress == deliveryAddress &&
        other.importDeliveryBy == importDeliveryBy;
  }

  @override
  int get hashCode {
    return storageName.hashCode ^
        storageAddress.hashCode ^
        importStaff.hashCode ^
        deliveryDate.hashCode ^
        id.hashCode ^
        customerName.hashCode ^
        customerPhone.hashCode ^
        deliveryAddress.hashCode ^
        importDeliveryBy.hashCode;
  }
}
