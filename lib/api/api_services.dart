import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/constants/constants.dart' as constants;

class ApiServices {
  ApiServices._();
  static const _domain = 'https://localhost:44304';

  static Future<dynamic> logInThirParty(String firebaseId, String deviceToken) {
    try {
      final url = Uri.parse(
          '$_domain/api/v1/users/thirdparty?firebaseID=$firebaseId&deviceToken=$deviceToken');
      return http.post(url);
    } catch (e) {
      throw Exception('Log In failed');
    }
  }

  static Future<dynamic> logInWithEmail(
      String email, String password, String deviceToken) {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};

      final url = Uri.parse('$_domain/api/v1/users/login');
      return http.post(url,
          headers: headers,
          body: jsonEncode({
            "email": email,
            "password": password,
            "deviceToken": deviceToken
          }));
    } catch (e) {
      throw Exception('Log In failed');
    }
  }

  static Future<dynamic> signUp(
      Users user, String password, String deviceToken) {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};

      final url = Uri.parse('$_domain/api/v1/users');
      return http.post(url,
          headers: headers,
          body: jsonEncode({
            "name": user.name,
            'deviceToken': deviceToken,
            "password": password,
            "email": user.email,
            "gender": user.gender,
            "birthdate": user.birthDate!.toIso8601String(),
            "address": user.address,
            "phone": user.phone,
            "roleId": 3,
          }));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> changePassword(String oldPassword,
      String confirmPassword, String newPassword, int userId, String idToken) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse('$_domain/api/v1/users/changepassword');
      return http.post(url,
          headers: headers,
          body: jsonEncode({
            "id": userId,
            "oldPassword": oldPassword,
            "password": newPassword,
            "confirmPassword": confirmPassword
          }));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> getProduct(String idToken) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse('$_domain/api/v1/products');
      return http.get(
        url,
        headers: headers,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> createOrder(List<Map<String, dynamic>> listProduct,
      OrderBooking orderBooking, Users user) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${user.idToken}'
      };

      final typeOrder = orderBooking.typeOrder == TypeOrder.selfStorage ? 0 : 1;

      final url = Uri.parse('$_domain/api/v1/orders');
      return http.post(
        url,
        body: jsonEncode({
          "customerId": user.userId,
          "deliveryAddress": orderBooking.addressDelivery,
          "addressReturn": orderBooking.addressReturn,
          "totalPrice": orderBooking.totalPrice,
          "typeOrder": typeOrder,
          "isPaid": orderBooking.isPaid,
          "isUserDelivery": orderBooking.isCustomerDelivery,
          "deliveryDate": orderBooking.dateTimeDelivery.toIso8601String(),
          "deliveryTime": orderBooking.currentSelectTime != -1
              ? constants.LIST_TIME_PICK_UP[orderBooking.currentSelectTime]
              : '',
          "duration": orderBooking.typeOrder == TypeOrder.selfStorage
              ? orderBooking.months
              : orderBooking.diffDay,
          "listProduct": listProduct
        }),
        headers: headers,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
