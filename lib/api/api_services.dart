import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/constants/constants.dart' as constants;

class ApiServices {
  ApiServices._();

//  static const _domain = 'https://rssmsapi20220426221036.azurewebsites.net';
  // static const _domain = 'https://rssmsapi20220426221036.azurewebsites.net';

  static const _domain = 'https://localhost:44304';

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
      log(e.toString());
      throw Exception(e);
    }
  }

  static Future<dynamic> signUp(Users user, String password, String role,
      String image, String deviceToken) {
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
            "roleId": role,
            "gender": user.gender,
            "birthdate": user.birthDate!.toIso8601String(),
            "address": user.address,
            "phone": user.phone,
            "image": {"file": image}
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
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> getArea(String idToken, String storageId) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };
      final url = Uri.parse(
          '$_domain/api/v1/areas?storageid=$storageId&page=1&size=-1');
      return http.get(
        url,
        headers: headers,
      );
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> getListSpaces(
      String idToken, String areaId, String name) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };
      final url = Uri.parse(
          '$_domain/api/v1/spaces?AreaId=$areaId&Name=$name&page=1&size=-1');
      return http.get(
        url,
        headers: headers,
      );
    } catch (e) {
      log(e.toString());
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

  static Future<dynamic> getTimeline(String idToken, String idInvoice) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse(
          '$_domain/api/v1/ordertimelines?OrderId=$idInvoice&page=1&size=-1');
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
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> createOrder(dataRequest, String idToken) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
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

  static Future<dynamic> assignOrderToFloor(dataRequest, String idToken) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      log(jsonEncode(dataRequest));

      final url = Uri.parse('$_domain/api/v1/orders/assign to floor');
      return http.post(
        url,
        body: jsonEncode(dataRequest),
        headers: headers,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> assignOrderToAnotherFloor(
      dataRequest, String idToken) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse('$_domain/api/v1/orders/assign to another floor');
      return http.put(
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
          "totalPrice": extendInvoice["totalPrice"],
          "oldReturnDate": extendInvoice["oldReturnDate"].toIso8601String(),
          "returnDate": extendInvoice["newReturnDate"].toIso8601String(),
          "isPaid": extendInvoice['isPaid'],
          // "cancelDay": extendInvoice["oldReturnDate"].toIso8601String(),
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
      log(jsonEncode({
        "isPaid": orderBooking.isPaid,
        "isCustomerDelivery": orderBooking.isCustomerDelivery,
        "orderId": null,
        "totalPrice": orderBooking.deliveryFee + orderBooking.totalPrice,
        "customerId": user.userId,
        "deliveryAddress": orderBooking.addressDelivery,
        "returnDate": orderBooking.dateTimeReturn.toIso8601String(),
        "returnAddress": '',
        "deliveryTime": orderBooking.currentSelectTime != -1
            ? constants.listPickUpTime[orderBooking.currentSelectTime]
            : '',
        "deliveryDate": orderBooking.dateTimeDelivery.toIso8601String(),
        "type": 1,
        "typeOrder": orderBooking.typeOrder == TypeOrder.selfStorage
            ? constants.selfStorageTypeOrder
            : constants.doorToDoorTypeOrder,
        "note": orderBooking.distants,
        "requestDetails": listProduct,
        "deliveryFee": orderBooking.deliveryFee,
        "distance": orderBooking.distants,
        "advanceMoney": orderBooking.totalPrice * 50 / 100
      }));
      final url = Uri.parse('$_domain/api/v1/requests');
      bool isCustomerDelivery = orderBooking.typeOrder.index == 0
          ? true
          : orderBooking.isCustomerDelivery;
      return http.post(
        url,
        body: jsonEncode({
          "isPaid": orderBooking.isPaid,
          "isCustomerDelivery": isCustomerDelivery,
          "orderId": null,
          "storageId": orderBooking.storageId,
          "totalPrice": orderBooking.totalPrice,
          "customerId": user.userId,
          "deliveryAddress": orderBooking.addressDelivery,
          "returnDate": orderBooking.dateTimeReturn.toIso8601String(),
          "returnAddress": '',
          "deliveryTime": orderBooking.currentSelectTime != -1
              ? constants.listPickUpTime[orderBooking.currentSelectTime]
              : '',
          "deliveryDate": orderBooking.dateTimeDelivery.toIso8601String(),
          "type": 1,
          "typeOrder": orderBooking.typeOrder.index,
          "note": orderBooking.distants,
          "requestDetails": listProduct,
          "advanceMoney": orderBooking.totalPrice * 50 / 100
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
          "deliveryAddress": request["deliveryAddress"],
          "deliveryTime": request["deliveryTime"],
          "deliveryDate": request["deliveryDate"].toIso8601String(),
          "type": request["type"],
        }),
        headers: headers,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> updateRequest(
      String idRequest, String idToken, int status) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse('$_domain/api/v1/requests/$idRequest');
      return http.put(url,
          headers: headers,
          body: jsonEncode(
              {'id': idRequest, 'status': status, 'description': ''}));
    } catch (e) {
      log(e.toString());
      throw Exception('Update Failed');
    }
  }

  static Future<dynamic> updateProfileDeliveryStaff(
      String fullname,
      String phone,
      DateTime birthday,
      int gender,
      String address,
      String idToken,
      String userId,
      Map<String, dynamic> image) {
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
            "phone": phone,
            "image": image
          }));
    } catch (e) {
      log(e.toString());
      throw Exception('Update Failed');
    }
  }

  static Future<dynamic> updateProfile(
    String fullname,
    String phone,
    DateTime birthday,
    int gender,
    String address,
    String idToken,
    String userId,
  ) {
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
            "phone": phone,
          }));
    } catch (e) {
      log(e.toString());
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
          '$_domain/api/v1/schedules?DateFrom=${DateFormat('yyyy-MM-dd').format(firstDay)}&DateTo=${DateFormat('yyyy-MM-dd').format(endDay)}&page=1&size=-1');
      return http.get(
        url,
        headers: headers,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> sendNotification(dataRequest, String idToken) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };
      final url = Uri.parse('$_domain/api/v1/orders/send_noti_to_customer');
      return http.post(url, headers: headers, body: jsonEncode(dataRequest));
    } catch (e) {
      log(e.toString());
      throw Exception('Log In failed');
    }
  }

  static Future<dynamic> getRoles() {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
      };
      final url = Uri.parse('$_domain/api/v1/roles?page=1&size=250');
      return http.get(url, headers: headers);
    } catch (e) {
      log(e.toString());
      throw Exception('Update Failed');
    }
  }

  static Future<dynamic> updateOrder(Invoice invoice, String idToken) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };
      final url = Uri.parse('$_domain/api/v1/orders/${invoice.id}');
      return http.put(url, headers: headers, body: jsonEncode(invoice.toMap()));
    } catch (e) {
      log(e.toString());
      throw Exception('Update Failed');
    }
  }

  static Future<dynamic> doneOrder(dataRequest, String idToken) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };
      final url = Uri.parse(
          '$_domain/api/v1/orders/done/order/${dataRequest['orderId']}/request/${dataRequest['requestId']}');
      return http.put(url, body: jsonEncode(dataRequest), headers: headers);
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
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
      log(e.toString());
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
      log(e.toString());
      throw Exception('Get Notification Failed');
    }
  }

  static Future<dynamic> checkAddress(List<Map<String, dynamic>> listProduct,
      Invoice invoice, Users user, String returnAddress) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${user.idToken}'
      };
      final url = Uri.parse('$_domain/api/v1/requests/get-storage-available');

      return http.post(
        url,
        body: jsonEncode({
          "isCustomerDelivery": invoice.isUserDelivery,
          "orderId": invoice.id,
          "returnAddress": returnAddress,
          "requestDetails": listProduct,
          'type': constants.REQUEST_TYPE.returnOrder.index
        }),
        headers: headers,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> loadListAvailableStorages(
      List<Map<String, dynamic>> listProduct,
      OrderBooking orderBooking,
      Users user) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer ${user.idToken}'
      };
      log(jsonEncode({
        "isPaid": orderBooking.isPaid,
        "isCustomerDelivery": orderBooking.isCustomerDelivery,
        "orderId": null,
        "totalPrice": 0,
        "customerId": user.userId,
        "deliveryAddress": orderBooking.addressDelivery,
        "returnDate": orderBooking.dateTimeReturn.toIso8601String(),
        "returnAddress": '',
        "deliveryTime": orderBooking.currentSelectTime != -1
            ? constants.listPickUpTime[orderBooking.currentSelectTime]
            : '',
        "deliveryDate": orderBooking.dateTimeDelivery.toIso8601String(),
        "type": 1,
        "typeOrder": orderBooking.typeOrder == TypeOrder.selfStorage
            ? constants.selfStorageTypeOrder
            : constants.doorToDoorTypeOrder,
        "note": orderBooking.note,
        "requestDetails": listProduct
      }));
      final url = Uri.parse('$_domain/api/v1/requests/get-storage-available');
      bool isCustomerDelivery = orderBooking.typeOrder.index == 0
          ? true
          : orderBooking.isCustomerDelivery;
      return http.post(
        url,
        body: jsonEncode({
          "isPaid": orderBooking.isPaid,
          "isCustomerDelivery": isCustomerDelivery,
          "orderId": null,
          "totalPrice": 0,
          "customerId": user.userId,
          "deliveryAddress": orderBooking.addressDelivery,
          "returnDate": orderBooking.dateTimeReturn.toIso8601String(),
          "returnAddress": '',
          "deliveryTime": orderBooking.currentSelectTime != -1
              ? constants.listPickUpTime[orderBooking.currentSelectTime]
              : '',
          "deliveryDate": orderBooking.dateTimeDelivery.toIso8601String(),
          "type": 1,
          "typeOrder": orderBooking.typeOrder == TypeOrder.selfStorage
              ? constants.selfStorageTypeOrder
              : constants.doorToDoorTypeOrder,
          "note": orderBooking.note,
          "requestDetails": listProduct
        }),
        headers: headers,
      );
    } catch (e) {
      throw Exception(e.toString());
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
      log(e.toString());
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
      log(e.toString());
      throw Exception('Update Failed');
    }
  }

  static Future<dynamic> sendNotiCheckInToCustomer(
      String idToken, String idRequest) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url =
          Uri.parse('$_domain/api/v1/requests/deliver request/$idRequest');
      return http.put(url, headers: headers);
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> sendNotiRequestToStaff(
      String idToken, String message, String idRequest) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse(
          '$_domain/api/v1/requests/send request notification/$idRequest');
      return http.post(url,
          body: jsonEncode({"message": message}), headers: headers);
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> cancelInvoice(
      String idToken, Map<dynamic, dynamic> cancelOrder) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url =
          Uri.parse('$_domain/api/v1/orders/cancel/${cancelOrder['id']}');
      return http.put(url, headers: headers, body: jsonEncode(cancelOrder));
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> cancelOrder(
      String idToken, Map<dynamic, dynamic> cancelOrder) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse(
          '$_domain/api/v1/requests/cancel request to order/${cancelOrder['id']}');
      return http.put(url, headers: headers, body: jsonEncode(cancelOrder));
    } catch (e) {
      log(e.toString());
      throw Exception('Update Failed');
    }
  }

  static Future<dynamic> getFloorbyId(String idToken, String id) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse('$_domain/api/v1/floors/' + id.toString());
      return http.get(
        url,
        headers: headers,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> getAccountbyId(String idToken, String id) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse('$_domain/api/v1/accounts/' + id.toString());
      return http.get(
        url,
        headers: headers,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<dynamic> cancelCreateRequest(
      String requestId, String idToken, String reason) {
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        'Authorization': 'Bearer $idToken'
      };

      final url = Uri.parse(
          '$_domain/api/v1/requests/cancel request to order/' +
              requestId.toString());
      return http.put(url,
          headers: headers,
          body: jsonEncode({"id": requestId, "cancelReason": reason}));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
