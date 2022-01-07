import 'package:flutter/cupertino.dart';
import 'package:rssms/pages/customers/input_information_booking/input_information.dart';

enum TypeOrder { selfStorage, doorToDoor }

class OrderBooking with ChangeNotifier {
  Map<String, List<dynamic>>? _productOrder;
  DateTime? _dateTimeDelivery;
  DateTime? _dateTimeReturn;
  String? _dateTimeDeliveryString;
  String? _dateTimeReturnString;
  String? _nameCustomer;
  String? _addressDelivery;
  String? _addressReturn;
  String? _floorAddressDelivery;
  String? _floorAddressReturn;
  String? _phoneCustomer;
  String? _emailCustomer;
  SelectDistrict? _selectDistrict;
  TypeOrder? _typeOrder;
  bool? _isPaid;
  double? _totalPrice;

  int? _months;
  int? _diffDay;
  int? _currentSelectTime;
  bool? _isCustomerDelivery;

  OrderBooking(
      {Map<String, List<dynamic>>? productOrder,
      DateTime? dateTimeDelivery,
      DateTime? dateTimeReturn,
      String? dateTimeDeliveryString,
      String? dateTimeReturnString,
      TypeOrder? typeOrder,
      int? months,
      int? diffDay,
      int? currentSelectTime,
      bool? isCustomerDelivery,
      String? nameCustomer,
      String? addressDelivery,
      String? addressReturn,
      double? totalPrice,
      bool? isPaid,
      String? floorAddressDelivery,
      String? floorAddressReturn,
      String? phoneCustomer,
      String? emailCustomer,
      SelectDistrict? selectDistrict}) {
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
    _nameCustomer = nameCustomer;
    _addressDelivery = addressDelivery;
    _addressReturn = addressReturn;
    _floorAddressDelivery = floorAddressDelivery;
    _floorAddressReturn = floorAddressReturn;
    _phoneCustomer = phoneCustomer;
    _emailCustomer = emailCustomer;
    _selectDistrict = selectDistrict;
    _isPaid = isPaid;
    _totalPrice = totalPrice;
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
    _nameCustomer = '';
    _addressDelivery = '';
    _addressReturn = '';
    _floorAddressDelivery = '';
    _floorAddressReturn = '';
    _phoneCustomer = '';
    _emailCustomer = '';
    _selectDistrict = SelectDistrict.same;
    _isPaid = false;
    _totalPrice = 0;
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
      bool? isPaid,
      SelectDistrict? selectDistrict}) {
    return OrderBooking(
        productOrder: productOrder ?? _productOrder,
        dateTimeDelivery: dateTimeDelivery ?? _dateTimeDelivery,
        dateTimeReturn: dateTimeReturn ?? _dateTimeReturn,
        months: months ?? _months,
        diffDay: diffDay ?? _diffDay,
        typeOrder: typeOrder ?? _typeOrder,
        isPaid: isPaid ?? _isPaid,
        currentSelectTime: currentSelectTime ?? _currentSelectTime,
        isCustomerDelivery: isCustomerDelivery ?? _isCustomerDelivery,
        dateTimeDeliveryString:
            dateTimeDeliveryString ?? _dateTimeDeliveryString,
        dateTimeReturnString: dateTimeReturnString ?? _dateTimeReturnString,
        nameCustomer: nameCustomer ?? _nameCustomer,
        addressDelivery: addressDelivery ?? _addressDelivery,
        addressReturn: addressReturn ?? _addressReturn,
        floorAddressDelivery: floorAddressDelivery ?? _floorAddressDelivery,
        floorAddressReturn: floorAddressReturn ?? _floorAddressReturn,
        phoneCustomer: phoneCustomer ?? _phoneCustomer,
        emailCustomer: emailCustomer ?? _emailCustomer,
        totalPrice: totalPrice ?? _totalPrice,
        selectDistrict: selectDistrict ?? _selectDistrict);
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
    _nameCustomer = orderBooking.nameCustomer;
    _addressDelivery = orderBooking.addressDelivery;
    _addressReturn = orderBooking.addressReturn;
    _floorAddressDelivery = orderBooking.floorAddressDelivery;
    _floorAddressReturn = orderBooking.floorAddressReturn;
    _phoneCustomer = orderBooking.phoneCustomer;
    _emailCustomer = orderBooking.emailCustomer;
    _typeOrder = orderBooking.typeOrder;
    _selectDistrict = orderBooking.selectDistrict;
    _isPaid = orderBooking.isPaid;
    _totalPrice = orderBooking.totalPrice;

    notifyListeners();
  }

  get totalPrice => _totalPrice;

  set totalPrice(value) => _totalPrice = value;

  get isPaid => _isPaid;

  set isPaid(value) => _isPaid = value;

  get selectDistrict => _selectDistrict;

  set selectDistrict(value) => _selectDistrict = value;

  get nameCustomer => _nameCustomer;

  set nameCustomer(value) => _nameCustomer = value;

  get addressDelivery => _addressDelivery;

  set addressDelivery(value) => _addressDelivery = value;

  get addressReturn => _addressReturn;

  set addressReturn(value) => _addressReturn = value;

  get floorAddressDelivery => _floorAddressDelivery;

  set floorAddressDelivery(value) => _floorAddressDelivery = value;

  get floorAddressReturn => _floorAddressReturn;

  set floorAddressReturn(value) => _floorAddressReturn = value;

  get phoneCustomer => _phoneCustomer;

  set phoneCustomer(value) => _phoneCustomer = value;

  get emailCustomer => _emailCustomer;

  set emailCustomer(value) => _emailCustomer = value;

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
