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
    final List<Map<String, dynamic?>> listProduct = constants.LIST_PRODUCT
        .map<Map<String, dynamic>>((e) => {...e, 'quanitty': 0})
        .toList();
    List<TitleTab> mapListTab() {
      int index = 0;

      return constants.TAB_DOOR_TO_DOOR
          .map<TitleTab>((e) => TitleTab(
                title: e,
                index: index++,
                deviceSize: deviceSize,
                currentIndex: _index,
                onChangeTab: onChangeTab,
              ))
          .toList();
    }

    return Stack(
      children: [
        _index == 0 ? DoorToDoorTab() : SelfStorageTab(),
        CartTab(deviceSize: deviceSize, index: _index, tapTab: onChangeTab)
      ],
    );

    // return Center(
    //   child: Text('dasdsadsad'),
    //   // body: Container(
    //   //   width: deviceSize.width,
    //   //   height: deviceSize.height,
    //   //   child: Column(
    //   //     children: [
    // _index == 0 ? DoorToDoorTab() : SelfStorageTab(),
    // CartTab(deviceSize: deviceSize, index: _index, tapTab: onChangeTab)
    //   // ProductWidget(
    //   //   product: listProduct[0],
    //   // )
    //   //     ],
    //   //   ),
    //   // ),
    //   // body: Stack(children: [
    //   //   ProductWidget(
    //   //     product: listProduct[0],
    //   //   ),
    //   // ]),
    // );
  }
}
