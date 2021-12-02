import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/pages/customers/cart/tabs/cart_tab.dart';
import 'package:rssms/pages/customers/cart/tabs/door_to_door_tab.dart';
import 'package:rssms/pages/customers/cart/tabs/self_storage_tab.dart';
import 'package:rssms/pages/customers/cart/widgets/product_widget.dart';
import 'package:rssms/pages/customers/cart/widgets/title_tab.dart';
import 'package:rssms/views/cart_screen_view.dart';
import '../../../constants/constants.dart' as constants;

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> implements CartScreenView {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  @override
  void onChangeTab(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        _index == 0 ? DoorToDoorTab() : SelfStorageTab(),
        CartTab(deviceSize: deviceSize, index: _index, tapTab: onChangeTab),
      ],
    );
  }
}
