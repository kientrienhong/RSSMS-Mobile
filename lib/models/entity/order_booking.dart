import 'package:flutter/cupertino.dart';
import 'package:rssms/models/entity/product.dart';

class OrderBooking with ChangeNotifier {
  List<Product>? listProduct;
  OrderBooking({required this.listProduct});

  OrderBooking.empty() {
    listProduct = [];
  }

  OrderBooking copyWith({
    List<Product>? listProduct,
  }) {
    return OrderBooking(
      listProduct: listProduct ?? this.listProduct,
    );
  }

  void setOrderBooking({required OrderBooking orderBooking}) {
    listProduct = orderBooking.listProduct ?? listProduct;
    notifyListeners();
  }
}
