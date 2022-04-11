import 'dart:convert';

import 'package:rssms/helpers/handle_reponse.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/payment_method_booking_screen_model.dart';
import 'package:rssms/views/payment_method_booking_screen_view.dart';

class PaymentMethodBookingScreenPresenter {
  late PaymentMethodBookingScreenModel model;
  late PaymentMethodBookingScreenView view;

  PaymentMethodBookingScreenPresenter() {
    model = PaymentMethodBookingScreenModel();
  }

  Future<bool> createOrder(OrderBooking orderBooking, Users user) async {
    try {
      view.updateLoading();
      List<Map<String, dynamic>> listProduct = [];

      List listKeys = orderBooking.productOrder!.keys.toList();

      for (var element in listKeys) {
        for (var ele in orderBooking.productOrder![element]!) {
          listProduct.add({
            "serviceId": ele['id'],
            "price": ele['price'],
            "amount": ele['quantity'],
            'note': ele['note']
          });
        }
      }
      final response = await model.createOrder(listProduct, orderBooking, user);
      final handledResponse = HandleResponse.handle(response);
      if (handledResponse['status'] == 'success') {
        return true;
      } else {
        view.updateError(handledResponse['data']);
        return false;
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      view.updateLoading();
    }
  }
}
