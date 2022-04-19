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

  void removePlacing(int idPlacing) {
    final index =
        placingItems['floors'].indexWhere((e) => e['idPlacing'] == idPlacing);

    final placingOrderDetail = placingItems['floors'][index];
    if (index != -1) {
      placingItems['floors'].removeAt(index);
      storedItems['totalQuantity']++;
      storedItems['items'].add(OrderDetail.fromMap(placingOrderDetail));
      notifyListeners();
    }
  }

  void placeItems(String idFloor, String orderDetailId,
      Map<String, String> currentPosition) {
    final orderDetailFound =
        storedItems['items'].firstWhere((e) => e.id == orderDetailId);
    Map<String, dynamic> placingOrderTemp = orderDetailFound.toMap();
    placingOrderTemp['idPlacing'] = placingItems['floors'].length;
    placingOrderTemp['areaName'] = currentPosition['areaName'];
    placingOrderTemp['floorName'] = currentPosition['floorName'];
    placingOrderTemp['floorId'] = currentPosition['floorId'];

    placingItems['floors'].add(placingOrderTemp);
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
        .toList()
        .map((e) {
      final listAdditionServiceTemp = e.listAdditionService!
          .where((addService) =>
              addService.type == constants.typeProduct.accessory.index)
          .toList();
      return e.copyWith(listAdditionService: listAdditionServiceTemp);
    }).toList();

    storedItems = {
      'orderId': invoice.id,
      'items': listStoredItems,
      'totalQuantity': listStoredItems.length
    };
    notifyListeners();
  }
}
