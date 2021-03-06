import 'package:flutter/material.dart';
import 'package:rssms/models/entity/product.dart';
import 'package:rssms/pages/customers/cart/widgets/main_product_widget.dart';

class SelfStorageWidget extends MainProductWidget {
  Product? product;

  SelfStorageWidget({
    Key? key,
    required this.product,
  }) : super(key: key, nameType: 'product', product: product);
}
