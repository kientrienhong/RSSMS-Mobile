import 'package:rssms/models/booking_pop_up_door_to_door_models.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/views/booking_pop_up_view_door_to_door.dart';

class BookingPopUpDoorToDoorPresenters {
  BookingPopUpDoorToDoorModel? _models;
  BookingPopUpViewDoorToDoor? _view;

  BookingPopUpDoorToDoorPresenters(OrderBooking orderBooking) {
    _models = BookingPopUpDoorToDoorModel(orderBooking);
  }

  get models => _models;

  set models(value) => _models = value;

  get view => _view;

  set view(value) => _view = value;
}
