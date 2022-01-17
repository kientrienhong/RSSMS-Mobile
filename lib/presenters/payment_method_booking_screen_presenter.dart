import 'package:rssms/api/api_services.dart';
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
            "productId": ele['id'],
            "productName": ele['name'],
            "price": ele['price'],
            "type": ele['type'],
            "amount": ele['quantity'],
            'note': ele['note']
          });
        }
      }

      final response =
          await ApiServices.createOrder(listProduct, orderBooking, user);

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      view.updateLoading();
    }
  }
}