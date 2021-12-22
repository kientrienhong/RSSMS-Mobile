import 'package:flutter/material.dart';
import 'package:rssms/pages/customers/cart/widgets/item_widget.dart';

class ServiceWidget extends ItemWidget {
  Map<String, dynamic>? product;
  String nameType;
  ServiceWidget({Key? key, required this.product, required this.nameType})
      : super(key: key, nameType: nameType, product: product);
}
