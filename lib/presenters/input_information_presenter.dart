import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/input_information_model.dart';
import 'package:rssms/views/input_information_view.dart';

class InputInformationPresenter {
  late InputInformationModel model;
  late InputInformationView view;

  InputInformationPresenter(Users user) {
    model = InputInformationModel(user);
  }

  void onPressContinue(OrderBooking orderBooking, bool isSelfStorageOrder) {
    orderBooking.setOrderBooking(
        orderBooking: orderBooking.copyWith(
      typeOrder:
          isSelfStorageOrder ? TypeOrder.selfStorage : TypeOrder.doorToDoor,
      addressDelivery: model.controllerAddress.text,
      nameCustomer: model.controllerName.text,
      phoneCustomer: model.controllerPhone.text,
      note: model.controllerNote.text,
      emailCustomer: model.controllerEmail.text,
      addressReturn: model.controllerAddress.text,
    ));
  }

  void dispose() {
    model.controllerAddress.dispose();
    model.controllerEmail.dispose();
    model.controllerName.dispose();
    model.controllerNote.dispose();
    model.controllerPhone.dispose();
    model.focusNodeAddress.dispose();
    model.focusNodeEmail.dispose();
    model.focusNodeName.dispose();
    model.focusNodeNote.dispose();
    model.focusNodePhone.dispose();
  }
}
