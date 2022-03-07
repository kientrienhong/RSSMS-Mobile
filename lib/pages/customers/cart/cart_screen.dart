import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/cart_screen_model.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/pages/customers/cart/tabs/cart_tab.dart';
import 'package:rssms/pages/customers/cart/tabs/door_to_door_tab.dart';
import 'package:rssms/pages/customers/cart/tabs/self_storage_tab.dart';
import 'package:rssms/presenters/cart_screen_presenter.dart';
import 'package:rssms/views/cart_screen_view.dart';
import '../../../constants/constants.dart' as constants;

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> implements CartScreenView {
  late CartScreenPresenter _presenter;
  late CartScreenModel _model;

  @override
  void initState() {
    super.initState();
    Users user = Provider.of<Users>(context, listen: false);
    _presenter = CartScreenPresenter();
    _presenter.view = this;
    _model = _presenter.model!;
    _presenter.loadProduct(user.idToken!);
  }

  @override
  void setChangeList() {
    setState(() {});
  }

  @override
  void onChangeTab(int index) {
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);
    setState(() {
      orderBooking.setOrderBooking(
          orderBooking: OrderBooking.empty(
              index == 0 ? TypeOrder.doorToDoor : TypeOrder.selfStorage));
      _model.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        _model.index == constants.DOOR_TO_DOOR_TAB
            ? DoorToDoorTab(
                handyTab: _model.handyTab,
                unweildyTab: _model.unweildyTab,
              )
            : SelfStorageTab(
                selfStorageTab: _model.selfStorageTab,
              ),
        CartTab(
            deviceSize: deviceSize, index: _model.index!, tapTab: onChangeTab),
      ],
    );
  }
}
