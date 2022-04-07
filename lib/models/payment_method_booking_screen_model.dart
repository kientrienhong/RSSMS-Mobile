import 'package:flutter/cupertino.dart';
import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/pages/customers/payment_method_booking/payment_method_booking_screen.dart';

class PaymentMethodBookingScreenModel {
  late PAYMENT_METHOD currentIndexPaymentMethod;
  late TextEditingController controllerNote;
  late bool isLoading;
  late String error;
  PaymentMethodBookingScreenModel() {
    currentIndexPaymentMethod = PAYMENT_METHOD.cash;
    controllerNote = TextEditingController();
    isLoading = false;
    error = '';
  }

  Future<dynamic> createOrder(List<Map<String, dynamic>> listProduct,
      OrderBooking orderBooking, Users user) async {
    return await ApiServices.createOrderRequest(
        listProduct, orderBooking, user);
  }
}
