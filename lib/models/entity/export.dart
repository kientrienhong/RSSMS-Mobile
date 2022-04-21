import 'dart:convert';

class Export {

  late String storageName;
  late String storageAddress;
  late String exportStaff;
  late String exportDate;
  late String id;
  late String customerName;
  late String customerPhone;
  late String returnAddress;
  late String? exportDeliveryBy;
  Export({
    required this.storageName,
    required this.storageAddress,
    required this.exportStaff,
    required this.exportDate,
    required this.id,
    required this.customerName,
    required this.customerPhone,
    required this.returnAddress,
     this.exportDeliveryBy,
  });

  Export.empty() {
    storageName = '';
    storageAddress = '';
    exportStaff = '';
    exportDate = '';
    id = '';
    customerName = '';
    customerPhone = '';
    returnAddress = '';
    exportDeliveryBy = '';
  }

  Export copyWith({
    String? storageName,
    String? storageAddress,
    String? exportStaff,
    String? exportDate,
    String? id,
    String? customerName,
    String? customerPhone,
    String? returnAddress,
    String? exportDeliveryBy,
  }) {
    return Export(
      storageName: storageName ?? this.storageName,
      storageAddress: storageAddress ?? this.storageAddress,
      exportStaff: exportStaff ?? this.exportStaff,
      exportDate: exportDate ?? this.exportDate,
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      returnAddress: returnAddress ?? this.returnAddress,
      exportDeliveryBy: exportDeliveryBy ?? this.exportDeliveryBy,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'storageName': storageName});
    result.addAll({'storageAddress': storageAddress});
    result.addAll({'exportStaff': exportStaff});
    result.addAll({'exportDate': exportDate});
    result.addAll({'id': id});
    result.addAll({'customerName': customerName});
    result.addAll({'customerPhone': customerPhone});
    result.addAll({'returnAddress': returnAddress});
    result.addAll({'exportDeliveryBy': exportDeliveryBy});
  
    return result;
  }

  factory Export.fromMap(Map<String, dynamic> map) {
    return Export(
      storageName: map['storageName'] ?? '',
      storageAddress: map['storageAddress'] ?? '',
      exportStaff: map['exportStaff'] ?? '',
      exportDate: map['exportDay'] ?? '',
      id: map['name'] ?? '',
      customerName: map['customerName'] ?? '',
      customerPhone: map['customerPhone'] ?? '',
      returnAddress: map['exportReturnAddress'] ?? '',
      exportDeliveryBy: map['exportDeliveryBy'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Export.fromJson(String source) => Export.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Import(storageName: $storageName, storageAddress: $storageAddress, exportStaff: $exportStaff, exportDate: $exportDate, id: $id, customerName: $customerName, customerPhone: $customerPhone, returnAddress: $returnAddress, exportDeliveryBy: $exportDeliveryBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Export &&
      other.storageName == storageName &&
      other.storageAddress == storageAddress &&
      other.exportStaff == exportStaff &&
      other.exportDate == exportDate &&
      other.id == id &&
      other.customerName == customerName &&
      other.customerPhone == customerPhone &&
      other.returnAddress == returnAddress &&
      other.exportDeliveryBy == exportDeliveryBy;
  }

  @override
  int get hashCode {
    return storageName.hashCode ^
      storageAddress.hashCode ^
      exportStaff.hashCode ^
      exportDate.hashCode ^
      id.hashCode ^
      customerName.hashCode ^
      customerPhone.hashCode ^
      returnAddress.hashCode ^
      exportDeliveryBy.hashCode;
  }
}
