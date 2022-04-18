import 'package:flutter/cupertino.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/user.dart';

enum TypeOrder { selfStorage, doorToDoor }

class OrderBooking with ChangeNotifier {
  late Map<String, List<dynamic>> productOrder;
  late DateTime dateTimeDelivery;
  late DateTime dateTimeReturn;
  late String dateTimeDeliveryString;
  late String dateTimeReturnString;
  late String nameCustomer;
  late String addressDelivery;
  late String storageId;
  late String phoneCustomer;
  late String emailCustomer;
  late TypeOrder typeOrder;
  late bool isPaid;
  late double totalPrice;
  late String note;

  late int months;
  late int diffDay;
  late int currentSelectTime;
  late bool isCustomerDelivery;

  OrderBooking(
      {required this.addressDelivery,
      required this.currentSelectTime,
      required this.dateTimeDelivery,
      required this.dateTimeDeliveryString,
      required this.dateTimeReturn,
      required this.dateTimeReturnString,
      required this.diffDay,
      required this.emailCustomer,
      required this.isCustomerDelivery,
      required this.isPaid,
      required this.months,
      required this.storageId,
      required this.nameCustomer,
      required this.note,
      required this.phoneCustomer,
      required this.productOrder,
      required this.totalPrice,
      required this.typeOrder});
  OrderBooking.empty(TypeOrder newTypeOrder) {
    productOrder = {
      'product': [],
      'accessory': [],
      'service': [],
    };
    storageId = '';
    typeOrder = newTypeOrder;
    dateTimeDeliveryString = '';
    dateTimeReturnString = '';
    dateTimeDelivery = DateTime.now().add(const Duration(days: 1));
    dateTimeReturn = DateTime.now().add(const Duration(days: 1));
    currentSelectTime = -1;
    isCustomerDelivery = false;
    diffDay = 0;
    months = (diffDay / 30).ceil();
    nameCustomer = '';
    addressDelivery = '';
    phoneCustomer = '';
    emailCustomer = '';
    isPaid = false;
    totalPrice = 0;
    note = '';
    notifyListeners();
  }

  OrderBooking copyWith(
      {Map<String, List<dynamic>>? productOrder,
      DateTime? dateTimeDelivery,
      DateTime? dateTimeReturn,
      int? months,
      TypeOrder? typeOrder,
      int? diffDay,
      int? currentSelectTime,
      bool? isCustomerDelivery,
      String? dateTimeDeliveryString,
      String? dateTimeReturnString,
      String? nameCustomer,
      String? addressDelivery,
      String? addressReturn,
      String? floorAddressDelivery,
      String? floorAddressReturn,
      String? phoneCustomer,
      double? totalPrice,
      String? emailCustomer,
      String? storageId,
      String? note,
      bool? isPaid}) {
    return OrderBooking(
      productOrder: productOrder ?? this.productOrder,
      storageId: storageId ?? this.storageId,
      dateTimeDelivery: dateTimeDelivery ?? this.dateTimeDelivery,
      dateTimeReturn: dateTimeReturn ?? this.dateTimeReturn,
      months: months ?? this.months,
      diffDay: diffDay ?? this.diffDay,
      note: note ?? this.note,
      typeOrder: typeOrder ?? this.typeOrder,
      isPaid: isPaid ?? this.isPaid,
      currentSelectTime: currentSelectTime ?? this.currentSelectTime,
      isCustomerDelivery: isCustomerDelivery ?? this.isCustomerDelivery,
      dateTimeDeliveryString:
          dateTimeDeliveryString ?? this.dateTimeDeliveryString,
      dateTimeReturnString: dateTimeReturnString ?? this.dateTimeReturnString,
      nameCustomer: nameCustomer ?? this.nameCustomer,
      addressDelivery: addressDelivery ?? this.addressDelivery,
      phoneCustomer: phoneCustomer ?? this.phoneCustomer,
      emailCustomer: emailCustomer ?? this.emailCustomer,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  OrderBooking fromInvoice(
      {required Invoice invoice,
      required DateTime returnDateTimeNew,
      required int durationMonth,
      required Users user,
      required bool isPaid,
      required int totalPrice}) {
    DateTime returnDateOld = DateTime.parse(
        invoice.returnDate.substring(0, invoice.returnDate.indexOf("T")));
    return OrderBooking(
      productOrder: productOrder,
      storageId: invoice.storageId,
      dateTimeDelivery: DateTime.parse(invoice.returnDate),
      dateTimeReturn: returnDateTimeNew,
      months: durationMonth,
      diffDay: returnDateTimeNew.difference(returnDateOld).inDays,
      typeOrder:
          invoice.typeOrder == 0 ? TypeOrder.selfStorage : TypeOrder.doorToDoor,
      isPaid: isPaid,
      note: '',
      currentSelectTime: currentSelectTime,
      isCustomerDelivery: invoice.isUserDelivery,
      dateTimeDeliveryString: invoice.deliveryTime,
      dateTimeReturnString: invoice.returnTime,
      nameCustomer: invoice.customerName,
      addressDelivery: invoice.deliveryAddress,
      phoneCustomer: user.phone!,
      emailCustomer: user.email!,
      totalPrice: double.parse(totalPrice.toString()),
    );
  }

  void setOrderBooking({required OrderBooking orderBooking}) {
    productOrder = orderBooking.productOrder;
    dateTimeDelivery = orderBooking.dateTimeDelivery;
    dateTimeReturn = orderBooking.dateTimeReturn;
    months = orderBooking.months;
    diffDay = orderBooking.diffDay;
    currentSelectTime = orderBooking.currentSelectTime;
    isCustomerDelivery = orderBooking.isCustomerDelivery;
    dateTimeDeliveryString = orderBooking.dateTimeDeliveryString;
    dateTimeReturnString = orderBooking.dateTimeReturnString;
    nameCustomer = orderBooking.nameCustomer;
    addressDelivery = orderBooking.addressDelivery;
    phoneCustomer = orderBooking.phoneCustomer;
    emailCustomer = orderBooking.emailCustomer;
    typeOrder = orderBooking.typeOrder;
    isPaid = orderBooking.isPaid;
    totalPrice = orderBooking.totalPrice;
    note = orderBooking.note;
    notifyListeners();
  }
}
