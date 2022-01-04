import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

enum UserRole {
  admin,
  manager,
  customer,
  deliveryStaff,
  officeStaff,
}

class Users with ChangeNotifier {
  String? idToken;
  String? refreshToken;
  double? expiresIn;
  String? tokenType;
  int? userId;
  int? storageId;
  String? name;
  String? email;
  String? address;
  String? roleName;
  int? gender;
  DateTime? birthDate;
  String? phone;
  List<dynamic>? images;
  List<dynamic>? staffManageStorages;

  Users.register({
    required this.address,
    required this.birthDate,
    required this.email,
    required this.gender,
    required this.name,
    required this.phone,
  });

  Users({
    required this.idToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.tokenType,
    required this.userId,
    required this.storageId,
    required this.name,
    required this.email,
    required this.address,
    required this.roleName,
    required this.phone,
    required this.images,
    required this.birthDate,
    required this.gender,
    required this.staffManageStorages,
  });

  Users.empty() {
    idToken = '';
    refreshToken = '';
    expiresIn = -1;
    tokenType = '';
    userId = -1;
    storageId = -1;
    name = '';
    email = '';
    address = '';
    roleName = '';
    phone = '';
    images = [];
    gender = 0;
    birthDate = DateTime.now();
    staffManageStorages = [];
  }

  Users copyWith({
    String? idToken,
    String? refreshToken,
    double? expiresIn,
    String? tokenType,
    int? userId,
    int? storageId,
    String? name,
    String? email,
    String? address,
    String? roleName,
    String? phone,
    int? gender,
    DateTime? birthDate,
    List<dynamic>? images,
    List<dynamic>? staffManageStorages,
  }) {
    return Users(
      idToken: idToken ?? this.idToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresIn: expiresIn ?? this.expiresIn,
      tokenType: tokenType ?? this.tokenType,
      userId: userId ?? this.userId,
      storageId: storageId ?? this.storageId,
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      roleName: roleName ?? this.roleName,
      phone: phone ?? this.phone,
      images: images ?? this.images,
      staffManageStorages: staffManageStorages ?? this.staffManageStorages,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idToken': idToken,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
      'tokenType': tokenType,
      'userId': userId,
      'storageId': storageId,
      'name': name,
      'email': email,
      'address': address,
      'roleName': roleName,
      'gender': gender,
      'birthDate': birthDate,
      'phone': phone,
      'images': images,
      'staffManageStorages': staffManageStorages,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      idToken: map['idToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
      expiresIn: map['expiresIn']?.toDouble() ?? 0.0,
      tokenType: map['tokenType'] ?? '',
      userId: map['userId']?.toInt() ?? 0,
      storageId: map['storageId']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      roleName: map['roleName'] ?? '',
      birthDate:
          DateFormat('yyyy-MM-dd').parse(map['birthdate'].split('T')[0]) ??
              DateTime.now(),
      gender: map['gender'] ?? 0,
      phone: map['phone'] ?? '',
      images: List<dynamic>.from(map['images']),
      staffManageStorages: List<dynamic>.from(map['staffManageStorages']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Users &&
        other.idToken == idToken &&
        other.refreshToken == refreshToken &&
        other.expiresIn == expiresIn &&
        other.gender == gender &&
        other.birthDate == birthDate &&
        other.tokenType == tokenType &&
        other.userId == userId &&
        other.storageId == storageId &&
        other.name == name &&
        other.email == email &&
        other.address == address &&
        other.roleName == roleName &&
        other.phone == phone &&
        listEquals(other.images, images) &&
        listEquals(other.staffManageStorages, staffManageStorages);
  }

  @override
  int get hashCode {
    return idToken.hashCode ^
        refreshToken.hashCode ^
        expiresIn.hashCode ^
        tokenType.hashCode ^
        userId.hashCode ^
        storageId.hashCode ^
        name.hashCode ^
        email.hashCode ^
        birthDate.hashCode ^
        gender.hashCode ^
        address.hashCode ^
        roleName.hashCode ^
        phone.hashCode ^
        images.hashCode ^
        staffManageStorages.hashCode;
  }

  void setUser({required Users user}) {
    address = user.address;
    email = user.email;
    idToken = user.idToken;
    refreshToken = user.refreshToken;
    expiresIn = user.expiresIn;
    tokenType = user.tokenType;
    userId = user.userId;
    storageId = user.storageId;
    name = user.name;
    roleName = user.roleName;
    gender = user.gender;
    birthDate = user.birthDate;
    phone = user.phone;
    images = user.images;
    staffManageStorages = user.staffManageStorages;
    notifyListeners();
  }
}
