import 'package:flutter/material.dart';
import 'package:rssms/models/entity/product.dart';
import 'package:rssms/pages/customers/cart/widgets/item_widget.dart';

class ServiceWidget extends ItemWidget {
  Product? product;
  ServiceWidget({Key? key, required this.product})
      : super(key: key, nameType: 'service', product: product);
}
