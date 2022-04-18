import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/order_detail.dart';
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
