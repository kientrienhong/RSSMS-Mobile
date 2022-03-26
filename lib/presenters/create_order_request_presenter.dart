import 'dart:convert';

import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/create_order_request_model.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/views/create_order_request_view.dart';

class CreateOrderRequestPresenter {
  late CreateOrderRequestModel model;
  late CreateOrderRequestView view;
  CreateOrderRequestPresenter(String id) {
    model = CreateOrderRequestModel(id);
  }

  void getDetailRequest(String idToken) async {
    try {
      final response = await model.getDetailRequest(model.idRequest, idToken);
      if (response.statusCode == 200) {
        final decodedReponse = jsonDecode(response.body);
        Invoice invoice = formatInvoice(decodedReponse);
        view.updateView(invoice);
      }
      view.updateLoading();
    } catch (e) {
      print(e);
      view.updateLoading();
    }
  }

  Invoice formatInvoice(Map<String, dynamic> map) {
    return Invoice(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      additionFee: 0,
      additionFeeDescription: '',
      customerName: map['customerName'] ?? '',
      customerPhone: map['customerPhone'] ?? '',
      deliveryAddress: map['deliveryAddress'] ?? '',
      addressReturn: map['addressReturn'] ?? '',
      totalPrice: map['totalPrice']?.toInt() ?? 0,
      rejectedReason: map['rejectedReason'] ?? '',
      typeOrder: map['typeOrder']?.toInt() ?? 0,
      isUserDelivery: map['isUserDelivery'] ?? false,
      deliveryDate: map['deliveryDate'] ?? '',
      deliveryTime: map['deliveryTime'] ?? '',
      returnDate: map['returnDate'] ?? '',
      returnTime: map['returnTime'] ?? '',
      paymentMethod: map['paymentMethod']?.toInt() ?? 0,
      durationDays: map['durationDays']?.toInt() ?? 0,
      durationMonths: map['durationMonths']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      isPaid: map['isPaid'] ?? false,
      orderDetails: map['requestDetails'] != null
          ? List<OrderDetail>.from(
              map['requestDetails']?.map((x) => OrderDetail.fromMap(x)))
          : [],
    );
  }
}
