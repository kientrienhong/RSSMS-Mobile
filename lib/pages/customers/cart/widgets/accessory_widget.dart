import 'package:flutter/material.dart';
import 'package:rssms/pages/customers/cart/widgets/item_widget.dart';

class AccessoryWidget extends ItemWidget {
  Map<String, dynamic>? product;
  AccessoryWidget({Key? key, required this.product})
      : super(key: key, nameType: 'accessory', product: product);
}
