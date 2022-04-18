import 'package:flutter/cupertino.dart';
import 'package:rssms/models/entity/order_booking.dart';

class BookingPopUpDoorToDoorModel {
  late TextEditingController dateDeliveryController;
  late TextEditingController dateReturnController;
  late String error;
  BookingPopUpDoorToDoorModel(OrderBooking orderBooking) {
    dateDeliveryController =
        TextEditingController(text: orderBooking.dateTimeDeliveryString);
    dateReturnController =
        TextEditingController(text: orderBooking.dateTimeReturnString);
    error = '';
  }
}
