import 'package:flutter/cupertino.dart';

class OrderBooking with ChangeNotifier {
  Map<String, List<dynamic>>? productOrder;
  OrderBooking({required this.productOrder});

  OrderBooking.empty() {
    productOrder = {
      'product': [],
      'accessory': [],
      'service': [],
    };
  }

  OrderBooking copyWith({
    Map<String, List<dynamic>>? productOrder,
  }) {
    return OrderBooking(
      productOrder: productOrder ?? this.productOrder,
    );
  }

  void setOrderBooking({required OrderBooking orderBooking}) {
    productOrder = orderBooking.productOrder ?? productOrder;
    notifyListeners();
  }
}
