import 'package:flutter/cupertino.dart';
import 'package:rssms/models/entity/order_booking.dart';

class BookingPopUpDoorToDoorModel {
  TextEditingController? _dateDeliveryController;
  TextEditingController? _dateReturnController;

  BookingPopUpDoorToDoorModel(OrderBooking orderBooking) {
    _dateDeliveryController =
        TextEditingController(text: orderBooking.dateTimeDeliveryString ?? '');
    _dateReturnController =
        TextEditingController(text: orderBooking.dateTimeReturnString ?? '');
  }

  get dateDeliveryController => _dateDeliveryController;

  set dateDeliveryController(value) => _dateDeliveryController = value;

  get dateReturnController => _dateReturnController;

  set dateReturnController(value) => _dateReturnController = value;
}
