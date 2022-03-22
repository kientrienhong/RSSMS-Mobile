import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rssms/models/entity/invoice.dart';
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
      print(e.toString());
      throw Exception('Log In failed');
    }
  }

  static Future<dynamic> logInWithEmail(
      String email, String password, String deviceToken) {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};

      final url = Uri.parse('$_domain/api/v1/accounts/login');
      return http.post(url,
          headers: headers,
          body: jsonEncode({
            "email": email,
            "password": password,
            "deviceToken": deviceToken
          }));
    } catch (e) {
      print(e.toString());
      throw Exception('Log In failedd');
    }
  }

  static Future<dynamic> signUp(
      Users user, String password, String deviceToken) {
    try {
      Map<String, String> headers = {"Content-type": "application/json"};

      final url = Uri.parse('$_domain/api/v1/accounts');
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

  static Future<dynamic> changePassword(
      String oldPassword,
      String confirmPassword,
      String newPassword,
      String userId,
      String idToken) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse('$_domain/api/v1/accounts/changepassword');
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

  static Future<dynamic> getService(String idToken) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse('$_domain/api/v1/services');
      return http.get(
        url,
        headers: headers,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> getShelf(String idToken) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse('$_domain/api/v1/shelves?page=1&size=250');
      return http.get(
        url,
        headers: headers,
      );
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> getInvoice(String idToken, String page, String total) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url =
          Uri.parse('$_domain/api/v1/orders?page=' + page + '&size=' + total);
      return http.get(
        url,
        headers: headers,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> getRequest(String idToken) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse('$_domain/api/v1/requests?page=1&size=10');
      return http.get(
        url,
        headers: headers,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> getInvoiceInRangeTime(
      String idToken, DateTime startOfWeek, DateTime endOfWeek) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse(
          '$_domain/api/v1/orders?dateFrom=${startOfWeek.toIso8601String()}dateTo=${endOfWeek.toIso8601String()}&page=1&size=250');
      return http.get(
        url,
        headers: headers,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> getInvoicebyId(String idToken, String id) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse('$_domain/api/v1/orders/' + id.toString());
      return http.get(
        url,
        headers: headers,
      );
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  // static Future<dynamic> createOrder(List<Map<String, dynamic>> listProduct,
  //     OrderBooking orderBooking, Users user) {
  //   try {
  //     Map<String, String> headers = {
  //       "Content-type": "application/json",
  //       'Authorization': 'Bearer ${user.idToken}'
  //     };

  //     final typeOrder = orderBooking.typeOrder == TypeOrder.selfStorage ? 0 : 1;
  //     final url = Uri.parse('$_domain/api/v1/orders');
  //     return http.post(
  //       url,
  //       body: jsonEncode({
  //         "customerId": user.userId,
  //         "deliveryAddress": orderBooking.addressDelivery,
  //         "addressReturn": orderBooking.addressReturn,
  //         "totalPrice": orderBooking.totalPrice,
  //         "typeOrder": typeOrder,
  //         "isPaid": orderBooking.isPaid,
  //         "isUserDelivery": orderBooking.isCustomerDelivery,
  //         "deliveryDate": orderBooking.dateTimeDelivery.toIso8601String(),
  //         "deliveryTime": orderBooking.currentSelectTime != -1
  //             ? constants.LIST_TIME_PICK_UP[orderBooking.currentSelectTime]
  //             : '',
  //         "duration": orderBooking.typeOrder == TypeOrder.selfStorage
  //             ? orderBooking.months
  //             : orderBooking.diffDay,
  //         "listService": listProduct,
  //         'status': 1
  //       }),
  //       headers: headers,
  //     );
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }
  static Future<dynamic> createOrder(dataRequest, String idToken) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${idToken}'
      };

      final url = Uri.parse('$_domain/api/v1/orders');
      return http.post(
        url,
        body: jsonEncode(dataRequest),
        headers: headers,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> getRequestbyId(String idToken, String id) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse('$_domain/api/v1/requests/' + id.toString());
      return http.get(
        url,
        headers: headers,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> createExtendRequest(
      Map<String, dynamic> extendInvoice, Users user) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${user.idToken}'
      };

      final url = Uri.parse('$_domain/api/v1/requests');
      return http.post(
        url,
        body: jsonEncode({
          "orderId": extendInvoice["orderId"],
          "totalPrice": extendInvoice["totalProduct"],
          "oldReturnDate": extendInvoice["oldReturnDate"].toIso8601String(),
          "returnDate": extendInvoice["newReturnDate"].toIso8601String(),
          "cancelDay": extendInvoice["oldReturnDate"].toIso8601String(),
          "type": extendInvoice["type"],
          "status": extendInvoice["status"],
          "note": extendInvoice["note"],
        }),
        headers: headers,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> createOrderRequest(
      List<Map<String, dynamic>> listProduct,
      OrderBooking orderBooking,
      Users user) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${user.idToken}'
      };

      final url = Uri.parse('$_domain/api/v1/requests');
      return http.post(
        url,
        body: jsonEncode({
          "isPaid": orderBooking.isPaid,
          "isCustomerDelivery": orderBooking.isCustomerDelivery,
          "orderId": null,
          "totalPrice": 0,
          "deliveryAddress": orderBooking.addressDelivery,
          "returnDate": orderBooking.dateTimeReturn.toIso8601String(),
          "returnAddress": orderBooking.addressReturn,
          "deliveryTime": orderBooking.currentSelectTime != -1
              ? constants.LIST_TIME_PICK_UP[orderBooking.currentSelectTime]
              : '',
          "deliveryDate": orderBooking.dateTimeDelivery.toIso8601String(),
          "type": 1,
          "typeOrder": orderBooking.typeOrder == TypeOrder.selfStorage
              ? constants.SELF_STORAGE_TYPE_ORDER
              : constants.DOOR_TO_DOOR_TYPE_ORDER,
          "note": orderBooking.note,
          "requestDetails": listProduct
        }),
        headers: headers,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> createCancelRequest(
      Map<String, dynamic> cancelRequest, Users user, Invoice invoice) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${user.idToken}'
      };

      final url = Uri.parse('$_domain/api/v1/requests');
      return http.post(
        url,
        body: jsonEncode({
          "orderId": invoice.id,
          "note": cancelRequest["reason"],
          "type": cancelRequest["type"]
        }),
        headers: headers,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> createGetInvoicedRequest(
      Map<String, dynamic> request, Users user) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${user.idToken}'
      };

      final url = Uri.parse('$_domain/api/v1/requests');
      return http.post(
        url,
        body: jsonEncode({
          "orderId": request["orderId"],
          "returnAddress": request["returnAddress"],
          "returnTime": request["returnTime"],
          "returnDate": request["returnDate"].toIso8601String(),
          "type": request["type"],
        }),
        headers: headers,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> updateProfile(
      String fullname,
      String phone,
      DateTime birthday,
      int gender,
      String address,
      String idToken,
      String userId) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse('$_domain/api/v1/accounts/$userId');
      return http.put(url,
          headers: headers,
          body: jsonEncode({
            "id": userId,
            "name": fullname,
            "gender": gender,
            "birthdate": birthday.toIso8601String(),
            "address": address,
            "phone": phone
          }));
    } catch (e) {
      print(e.toString());
      throw Exception('Update Failed');
    }
  }

  static Future<dynamic> getScheduleOrder(
      String idToken, DateTime firstDay, DateTime endDay) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse(
          '$_domain/api/v1/schedules?DateFrom=${firstDay.toIso8601String()}&DateTo=${endDay.toIso8601String()}&page=1&size=-1');
      return http.get(
        url,
        headers: headers,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> sendNotification(Invoice invoice, String idToken) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };
      var test = jsonEncode(invoice.toMap());
      final url = Uri.parse('$_domain/api/v1/orders/${invoice.id}');
      return http.post(url,
          headers: headers, body: jsonEncode(invoice.toMap()));
    } catch (e) {
      print(e.toString());
      throw Exception('Log In failed');
    }
  }

  static Future<dynamic> updateOrder(Invoice invoice, String idToken) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };
      final test = invoice.toMap();
      final url = Uri.parse('$_domain/api/v1/orders/${invoice.id}');
      return http.put(url, headers: headers, body: jsonEncode(invoice.toMap()));
    } catch (e) {
      print(e.toString());
      throw Exception('Update Failed');
    }
  }

  static Future<dynamic> doneOrder(Invoice invoice, String idToken) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse('$_domain/api/v1/orders/done/${invoice.id}');
      return http.put(url, headers: headers);
    } catch (e) {
      print(e.toString());
      throw Exception('Update Failed');
    }
  }

  //cancel schedule cancel type = 0

  static Future<dynamic> requestCancel(
      String note, int type, String dateCancel, String idToken) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse('$_domain/api/v1/requests');
      return http.post(url,
          headers: headers,
          body: jsonEncode(
              {"cancelDay": dateCancel, "type": type, "note": note}));
    } catch (e) {
      print(e.toString());
      throw Exception('Request Failed');
    }
  }

  static Future<dynamic> loadListNotification(String idToken, String userId) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse(
          '$_domain/api/v1/notifications?userId=$userId&page=1&size=-1');
      return http.get(
        url,
        headers: headers,
      );
    } catch (e) {
      print(e.toString());
      throw Exception('Get Notification Failed');
    }
  }

  static Future<dynamic> updateListNotification(
      String idToken, List<String> listNoti) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse('$_domain/api/v1/notifications');
      return http.put(url,
          headers: headers, body: jsonEncode({"ids": listNoti}));
    } catch (e) {
      print(e.toString());
      throw Exception('Update Failed');
    }
  }

  static Future<dynamic> updateListOrders(
      String idToken, List<Map<dynamic, dynamic>> listOrderStatus) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse('$_domain/api/v1/orders');
      return http.put(url, headers: headers, body: jsonEncode(listOrderStatus));
    } catch (e) {
      print(e.toString());
      throw Exception('Update Failed');
    }
  }
}
