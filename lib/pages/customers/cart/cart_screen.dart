import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/pages/customers/cart/widgets/cart_tab.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  void tapTab(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColor.white,
      body: Stack(
        children: [
          CartTab(deviceSize: deviceSize, index: _index, tapTab: tapTab)
        ],
      ),
    );
  }
}
