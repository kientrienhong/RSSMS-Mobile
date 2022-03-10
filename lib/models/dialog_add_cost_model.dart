import 'package:flutter/cupertino.dart';
import 'package:rssms/models/entity/order_detail.dart';

class DialogAddCostModel {
  late TextEditingController nameController;
  late TextEditingController priceController;

  DialogAddCostModel(Map<String, dynamic>? orderDetail) {
    nameController = TextEditingController(text: orderDetail?['name'] ?? '');
    priceController =
        TextEditingController(text: orderDetail?['price'].toString() ?? '');
  }
}
