import 'package:flutter/cupertino.dart';
import 'package:rssms/models/entity/order_booking.dart';

class BookingPopUpSelfStorageModel {
  late String error;
  late TextEditingController dateDeliveryController;
  late TextEditingController monthController;
  var dateReturn;
  BookingPopUpSelfStorageModel(OrderBooking orderBooking) {
    error = '';
    dateDeliveryController =
        TextEditingController(text: orderBooking.dateTimeDeliveryString);
    monthController =
        TextEditingController(text: orderBooking.months.toString());

    dateReturn = orderBooking.dateTimeReturn.toString().split(' ')[0] !=
            DateTime.now().add(const Duration(days: 1)).toString().split(' ')[0]
        ? orderBooking.dateTimeReturn
        : '';
  }
}
