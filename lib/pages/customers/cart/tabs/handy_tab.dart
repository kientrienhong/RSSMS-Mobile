import 'package:flutter/material.dart';
import 'package:rssms/pages/customers/cart/widgets/product_widget.dart';
import '../../../../constants/constants.dart' as constants;

class HandyTab extends StatefulWidget {
  const HandyTab({Key? key}) : super(key: key);

  @override
  _HandyTabState createState() => _HandyTabState();
}

class _HandyTabState extends State<HandyTab> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> mapProductWidget(listProduct) => listProduct
      .map<ProductWidget>((e) => ProductWidget(
            product: e,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic?>> listProduct = constants.LIST_PRODUCT
        .map<Map<String, dynamic>>((e) => {...e, 'quanitty': 0})
        .toList();
    print(listProduct);
    print(constants.LIST_PRODUCT);
    // return Expanded(
    //   child: ListView(
    //     shrinkWrap: true,
    //     physics: const NeverScrollableScrollPhysics(),
    //     children: mapProductWidget(listProduct),
    //   ),
    // );
    return ProductWidget(
      product: listProduct[0],
    );
  }
}
