import 'package:flutter/cupertino.dart';

enum UserRole { owner, customer }

class Users with ChangeNotifier {
  String? name;
  String? email;
  String? phone;
  String? address;
  UserRole? role;
  String? jwtToken;
  String? avatar;
  String? idTokenFirebase;
  Users.empty() {
    name = '';
    email = '';
    phone = '';
    idTokenFirebase = '';
    address = '';
    role = UserRole.customer;
    jwtToken = '';
    avatar = '';
  }

  Users(
      {this.name,
      this.email,
      this.idTokenFirebase,
      this.phone,
      this.address,
      this.role,
      this.avatar,
      this.jwtToken});

  Users.copyWith(
      {String? name,
      String? email,
      String? phone,
      String? address,
      UserRole? role,
      String? idTokenFirebase,
      String? jwtToken,
      String? avatar}) {
    name = name;
    email = email;
    phone = phone;
    idTokenFirebase = idTokenFirebase;
    address = address;
    role = role;
    jwtToken = jwtToken;
    avatar = avatar;
  }

  void setUser({required Users user}) {
    name = user.name ?? name;
    email = user.email ?? email;
    phone = user.phone ?? phone;
    idTokenFirebase = user.idTokenFirebase ?? idTokenFirebase;
    address = user.address ?? address;
    role = user.role ?? role;
    jwtToken = user.jwtToken ?? jwtToken;
    avatar = user.avatar ?? avatar;
    notifyListeners();
  }

  Users copyWith(
      {String? name,
      String? email,
      String? phone,
      String? address,
      UserRole? role,
      String? idTokenFirebase,
      String? jwtToken,
      String? avatar}) {
    return Users(
        address: address ?? this.address,
        email: email ?? this.email,
        idTokenFirebase: idTokenFirebase ?? this.idTokenFirebase,
        jwtToken: jwtToken ?? this.jwtToken,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        avatar: avatar ?? this.avatar,
        role: role ?? this.role);
  }

  factory Users.fromJson(Map<String, dynamic> json) {
    String roleString = json['roleName'];
    UserRole userRole =
        roleString == 'Owner' ? UserRole.owner : UserRole.customer;
    return Users(
        avatar: json['avatar'],
        address: json['address'],
        email: json['email'],
        jwtToken: json['idToken'],
        name: json['displayName'],
        phone: json['phone'],
        role: userRole);
  }
}
