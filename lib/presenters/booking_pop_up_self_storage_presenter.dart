import 'package:rssms/models/booking_pop_up_self_storage_model.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/views/booking_pop_up_view_self_storage.dart';

class BookingPopUpSelfStoragePresenter {
  BookingPopUpSelfStorageModel? model;
  BookingPopUpViewSelfStorage? view;

  BookingPopUpSelfStoragePresenter(OrderBooking orderBooking) {
    model = BookingPopUpSelfStorageModel(orderBooking);
  }
  set setView(view) => this.view = view;
}
