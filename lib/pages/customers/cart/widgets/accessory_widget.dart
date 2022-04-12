import 'package:flutter/material.dart';
import 'package:rssms/models/entity/product.dart';
import 'package:rssms/pages/customers/cart/widgets/item_widget.dart';

class AccessoryWidget extends ItemWidget {
  @override
  final Product? product;
  AccessoryWidget({Key? key, required this.product})
      : super(key: key, nameType: 'accessory', product: product);
}
