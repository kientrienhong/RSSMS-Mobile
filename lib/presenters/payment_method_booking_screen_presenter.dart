import 'package:rssms/helpers/response_handle.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/payment_method_booking_screen_model.dart';
import 'package:rssms/views/payment_method_booking_screen_view.dart';

class PaymentMethodBookingScreenPresenter {
  late PaymentMethodBookingScreenModel model;
  late PaymentMethodBookingScreenView view;

  PaymentMethodBookingScreenPresenter() {
    model = PaymentMethodBookingScreenModel();
  }

  void formatDisplayInvoice(OrderBooking orderBooking) {
    orderBooking.productOrder.keys.forEach((key) {
      orderBooking.productOrder[key]!.forEach((e) {
        int indexFound = model.invoiceDisplay.orderDetails
            .indexWhere((element) => element.productId == e['id']);
        if (indexFound != -1) {
          model.invoiceDisplay.orderDetails[indexFound].amount++;
        } else {
          model.invoiceDisplay.orderDetails.add(OrderDetail(
              id: '0',
              productId: e['id'],
              productName: e['name'],
              price: e['price'],
              amount: e['quantity'],
              serviceImageUrl: e['imageUrl'],
              productType: e['type'],
              note: e['note'] ?? '',
              images: []));
        }
      });
    });

    model.invoiceDisplay = model.invoiceDisplay.copyWith(
      deliveryAddress: orderBooking.addressDelivery,
      deliveryDate: orderBooking.dateTimeDeliveryString,
      returnDate: orderBooking.dateTimeReturnString,
      durationMonths: orderBooking.months,
      isOrder: false,
      typeOrder: orderBooking.typeOrder.index,
    );
  }

  Future<bool> createOrder(OrderBooking orderBooking, Users user) async {
    try {
      view.updateLoading();
      List<Map<String, dynamic>> listProduct = [];

      List listKeys = orderBooking.productOrder.keys.toList();

      for (var element in listKeys) {
        for (var ele in orderBooking.productOrder[element]!) {
          listProduct.add({
            "serviceId": ele['id'],
            "price": ele['price'],
            "amount": ele['quantity'],
            'note': ele['note']
          });
        }
      }
      final response = await model.createOrder(listProduct, orderBooking, user);
      final handledResponse = ResponseHandle.handle(response);
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
