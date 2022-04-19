import 'package:flutter/cupertino.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/constants/constants.dart' as constants;

class PlacingItems with ChangeNotifier {
  late Map<String, dynamic> storedItems;
  late Map<String, dynamic> placingItems;

  PlacingItems.empty() {
    storedItems = {'orderId': '', 'items': [], 'totalQuantity': 0};
    placingItems = {
      'typeOrder': '',
      'orderId': '',
      'floors': [],
    };
    notifyListeners();
  }

  void placeItems(String idFloor, String orderDetailId,
      Map<String, String> currentPosition) {
    final orderDetailFound =
        storedItems['items'].find((e) => e.id == orderDetailId);

    placingItems['floors'].push({
      ...orderDetailFound.toMap(),
      'idPlacing': placingItems['floors'].length,
      'areaName': currentPosition['areaName'],
      'floorName': currentPosition['floorName'],
      'storageName': currentPosition['storageName'],
    });
    storedItems['items'] =
        storedItems['items'].where((e) => e.id != orderDetailId).toList();
    storedItems['totalQuantity']--;
    notifyListeners();
  }

  void emptyPlacing() {
    storedItems = {'orderId': '', 'items': [], 'totalQuantity': 0};
    placingItems = {
      'typeOrder': '',
      'orderId': '',
      'floors': [],
    };
    notifyListeners();
  }

  void setUpStoredOrder(Invoice invoice) {
    List<OrderDetail> listStoredItems = invoice.orderDetails
        .where((element) =>
            element.productType == constants.typeProduct.handy.index ||
            element.productType == constants.typeProduct.unweildy.index ||
            element.productType == constants.typeProduct.selfStorage.index)
        .toList();

    storedItems = {
      'orderId': invoice.id,
      'items': listStoredItems,
      'totalQuantity': listStoredItems.length
    };
    notifyListeners();
  }
}
