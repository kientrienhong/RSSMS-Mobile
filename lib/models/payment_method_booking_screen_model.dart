import 'package:flutter/cupertino.dart';
import 'package:rssms/pages/customers/payment_method_booking/payment_method_booking_screen.dart';

class PaymentMethodBookingScreenModel {
  late PAYMENT_METHOD currentIndexPaymentMethod;
  late TextEditingController controllerNote;
  late bool isLoading;
  PaymentMethodBookingScreenModel() {
    currentIndexPaymentMethod = PAYMENT_METHOD.cash;
    controllerNote = TextEditingController();
    isLoading = false;
  }
}
