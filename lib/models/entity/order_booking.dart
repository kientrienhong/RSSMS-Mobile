import 'package:flutter/cupertino.dart';

enum TypeOrder { selfStorage, doorToDoor }

class OrderBooking with ChangeNotifier {
  Map<String, List<dynamic>>? _productOrder;
  DateTime? _dateTimeDelivery;
  DateTime? _dateTimeReturn;
  String? _dateTimeDeliveryString;
  String? _dateTimeReturnString;
  TypeOrder? _typeOrder;

  int? _months;
  int? _diffDay;
  int? _currentSelectTime;
  bool? _isCustomerDelivery;

  OrderBooking({
    Map<String, List<dynamic>>? productOrder,
    DateTime? dateTimeDelivery,
    DateTime? dateTimeReturn,
    String? dateTimeDeliveryString,
    String? dateTimeReturnString,
    TypeOrder? typeOrder,
    int? months,
    int? diffDay,
    int? currentSelectTime,
    bool? isCustomerDelivery,
  }) {
    _typeOrder = typeOrder;
    _productOrder = productOrder;
    _dateTimeDelivery = dateTimeDelivery;
    _dateTimeReturn = dateTimeReturn;
    _dateTimeDeliveryString = dateTimeDeliveryString;
    _dateTimeReturnString = dateTimeReturnString;
    _months = months;
    _diffDay = diffDay;
    _currentSelectTime = currentSelectTime;
    _isCustomerDelivery = isCustomerDelivery;
    notifyListeners();
  }

  OrderBooking.empty(TypeOrder typeOrder) {
    _productOrder = {
      'product': [],
      'accessory': [],
      'service': [],
    };
    _typeOrder = typeOrder;
    _dateTimeDeliveryString = '';
    _dateTimeReturnString = '';
    _dateTimeDelivery = DateTime.now().add(const Duration(days: 1));
    _dateTimeReturn = DateTime.now().add(const Duration(days: 1));
    _currentSelectTime = -1;
    _isCustomerDelivery = false;
    _diffDay = 0;
    _months = (_diffDay! / 30).ceil();
    notifyListeners();
  }

  OrderBooking copyWith({
    Map<String, List<dynamic>>? productOrder,
    DateTime? dateTimeDelivery,
    DateTime? dateTimeReturn,
    int? months,
    TypeOrder? typeOrder,
    int? diffDay,
    int? currentSelectTime,
    bool? isCustomerDelivery,
    String? dateTimeDeliveryString,
    String? dateTimeReturnString,
  }) {
    return OrderBooking(
      productOrder: productOrder ?? _productOrder,
      dateTimeDelivery: dateTimeDelivery ?? _dateTimeDelivery,
      dateTimeReturn: dateTimeReturn ?? _dateTimeReturn,
      months: months ?? _months,
      diffDay: diffDay ?? _diffDay,
      typeOrder: typeOrder ?? _typeOrder,
      currentSelectTime: currentSelectTime ?? _currentSelectTime,
      isCustomerDelivery: isCustomerDelivery ?? _isCustomerDelivery,
      dateTimeDeliveryString: dateTimeDeliveryString ?? _dateTimeDeliveryString,
      dateTimeReturnString: dateTimeReturnString ?? _dateTimeReturnString,
    );
  }

  void setOrderBooking({required OrderBooking orderBooking}) {
    _productOrder = orderBooking.productOrder;
    _dateTimeDelivery = orderBooking.dateTimeDelivery;
    _dateTimeReturn = orderBooking.dateTimeReturn;
    _months = orderBooking.months;
    _diffDay = orderBooking.diffDay;
    _currentSelectTime = orderBooking.currentSelectTime;
    _isCustomerDelivery = orderBooking.isCustomerDelivery;
    _dateTimeDeliveryString = orderBooking.dateTimeDeliveryString;
    _dateTimeReturnString = orderBooking.dateTimeReturnString;
    _typeOrder = orderBooking.typeOrder;
    notifyListeners();
  }

  get typeOrder => _typeOrder;

  set typeOrder(value) => _typeOrder = value;

  get dateTimeDeliveryString => _dateTimeDeliveryString;

  set dateTimeDeliveryString(value) => _dateTimeDeliveryString = value;

  get dateTimeReturnString => _dateTimeReturnString;

  set dateTimeReturnString(value) => _dateTimeReturnString = value;

  get isCustomerDelivery => _isCustomerDelivery;

  set isCustomerDelivery(value) => _isCustomerDelivery = value;

  get currentSelectTime => _currentSelectTime;

  set currentSelectTime(value) => _currentSelectTime = value;

  get productOrder => _productOrder;

  set productOrder(value) => _productOrder = value;

  get dateTimeDelivery => _dateTimeDelivery;

  set dateTimeDelivery(value) => _dateTimeDelivery = value;

  get dateTimeReturn => _dateTimeReturn;

  set dateTimeReturn(value) => _dateTimeReturn = value;

  get months => _months;

  set months(value) => _months = value;

  get diffDay => _diffDay;

  set diffDay(value) => _diffDay = value;
}
