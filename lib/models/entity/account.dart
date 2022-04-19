import 'dart:convert';

import 'package:collection/collection.dart';

import 'staff_assign_storage.dart';

class Account {
  late String id;
  late String name;
  late String email;
  late int gender;
  late String birthdate;
  late String address;
  late String phone;
  late String roleName;
  late String imageUrl;
  late List<StaffAssignStorage> staffAssignStorages;
  Account({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.birthdate,
    required this.address,
    required this.phone,
    required this.roleName,
    required this.imageUrl,
    required this.staffAssignStorages,
  });

   Account.empty() {
    id = '';
    name = '';
    email = '';
    gender = -1;
    birthdate = '';
    address = '';
    phone = '';
    roleName = '';
    address = '';
    roleName = '';
    phone = '';
    imageUrl = '';
  }


  Account copyWith({
    String? id,
    String? name,
    String? email,
    int? gender,
    String? birthdate,
    String? address,
    String? phone,
    String? roleName,
    String? imageUrl,
    List<StaffAssignStorage>? staffAssignStorages,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      birthdate: birthdate ?? this.birthdate,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      roleName: roleName ?? this.roleName,
      imageUrl: imageUrl ?? this.imageUrl,
      staffAssignStorages: staffAssignStorages ?? this.staffAssignStorages,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'gender': gender});
    result.addAll({'birthdate': birthdate});
    result.addAll({'address': address});
    result.addAll({'phone': phone});
    result.addAll({'roleName': roleName});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'staffAssignStorages': staffAssignStorages.map((x) => x.toMap()).toList()});
  
    return result;
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender']?.toInt() ?? 0,
      birthdate: map['birthdate'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      roleName: map['roleName'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      staffAssignStorages: List<StaffAssignStorage>.from(map['staffAssignStorages']?.map((x) => StaffAssignStorage.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) => Account.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Account(id: $id, name: $name, email: $email, gender: $gender, birthdate: $birthdate, address: $address, phone: $phone, roleName: $roleName, imageUrl: $imageUrl, staffAssignStorages: $staffAssignStorages)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return other is Account &&
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.gender == gender &&
      other.birthdate == birthdate &&
      other.address == address &&
      other.phone == phone &&
      other.roleName == roleName &&
      other.imageUrl == imageUrl &&
      listEquals(other.staffAssignStorages, staffAssignStorages);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      gender.hashCode ^
      birthdate.hashCode ^
      address.hashCode ^
      phone.hashCode ^
      roleName.hashCode ^
      imageUrl.hashCode ^
      staffAssignStorages.hashCode;
  }
}