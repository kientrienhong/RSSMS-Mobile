import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:rssms/models/entity/notification.dart';

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
  String? userId;
  int? storageId;
  String? name;
  String? email;
  String? address;
  String? roleName;
  int? gender;
  DateTime? birthDate;
  String? phone;
  String? imageUrl;
  List<dynamic>? staffManageStorages;
  List<NotificationEntity>? listUnreadNoti;
  List<NotificationEntity>? listNoti;
  Users.register({
    required this.address,
    required this.birthDate,
    required this.email,
    required this.gender,
    required this.name,
    required this.phone,
  });

  Users({
    required this.listUnreadNoti,
    required this.idToken,
    required this.refreshToken,
    required this.listNoti,
    required this.expiresIn,
    required this.tokenType,
    required this.userId,
    required this.storageId,
    required this.name,
    required this.email,
    required this.address,
    required this.roleName,
    required this.phone,
    required this.imageUrl,
    required this.birthDate,
    required this.gender,
    required this.staffManageStorages,
  });

  Users.empty() {
    idToken = '';
    refreshToken = '';
    expiresIn = -1;
    tokenType = '';
    userId = '';
    storageId = -1;
    name = '';
    email = '';
    address = '';
    roleName = '';
    phone = '';
    imageUrl = '';
    gender = 0;
    birthDate = DateTime.now();
    staffManageStorages = [];
    listUnreadNoti = [];
    listNoti = [];
  }

  Users copyWith(
      {String? idToken,
      String? refreshToken,
      double? expiresIn,
      String? tokenType,
      String? userId,
      int? storageId,
      String? name,
      String? email,
      String? address,
      String? roleName,
      String? phone,
      int? gender,
      DateTime? birthDate,
      String? imageUrl,
      List<dynamic>? staffManageStorages,
      List<NotificationEntity>? listNoti,
      List<NotificationEntity>? listUnreadNoti}) {
    return Users(
      listUnreadNoti: listUnreadNoti ?? this.listUnreadNoti,
      idToken: idToken ?? this.idToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresIn: expiresIn ?? this.expiresIn,
      tokenType: tokenType ?? this.tokenType,
      userId: userId ?? this.userId,
      storageId: storageId ?? this.storageId,
      listNoti: listNoti ?? this.listNoti,
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      roleName: roleName ?? this.roleName,
      phone: phone ?? this.phone,
      imageUrl: imageUrl ?? this.imageUrl,
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
      'imageUrl': imageUrl,
      'staffManageStorages': staffManageStorages,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      listUnreadNoti: [],
      listNoti: [],
      idToken: map['idToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
      expiresIn: map['expiresIn']?.toDouble() ?? 0.0,
      tokenType: map['tokenType'] ?? '',
      userId: map['userId'] ?? '',
      storageId: map['storageId']?.toInt() ?? 0,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
      roleName: map['roleName'] ?? '',
      birthDate: map['birthdate'] == null
          ? DateTime.now()
          : DateFormat('yyyy-MM-dd').parse(map['birthdate'].split('T')[0]),
      gender: map['gender'] ?? 0,
      phone: map['phone'] ?? '',
      imageUrl: map['imageUrl'],
      staffManageStorages: List<dynamic>.from(map['staffManageStorages'] ?? []),
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
        other.imageUrl == imageUrl &&
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
        imageUrl.hashCode ^
        staffManageStorages.hashCode;
  }

  void setUser({required Users user}) {
    address = user.address;
    email = user.email;
    idToken = user.idToken;
    refreshToken = user.refreshToken;
    expiresIn = user.expiresIn;
    tokenType = user.tokenType;
    listUnreadNoti = user.listUnreadNoti;
    listNoti = user.listNoti;
    userId = user.userId;
    storageId = user.storageId;
    name = user.name;
    roleName = user.roleName;
    gender = user.gender;
    birthDate = user.birthDate;
    phone = user.phone;
    imageUrl = user.imageUrl;
    staffManageStorages = user.staffManageStorages;
    notifyListeners();
  }
}
