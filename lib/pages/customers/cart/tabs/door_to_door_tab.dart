import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/product.dart';
import 'package:rssms/pages/customers/cart/tabs/handy_tab.dart';
import 'package:rssms/pages/customers/cart/tabs/handy_tab_unwidely.dart';
import 'package:rssms/pages/customers/cart/widgets/title_tab.dart';
import 'package:rssms/views/door_to_door_view.dart';
import '../../../../constants/constants.dart' as constants;

class DoorToDoorTab extends StatefulWidget {
  final Map<int, List<Product>>? handyTab;
  final Map<int, List<Product>>? unweildyTab;

  const DoorToDoorTab(
      {Key? key, required this.handyTab, required this.unweildyTab})
      : super(key: key);

  @override
  _DoorToDoorTabState createState() => _DoorToDoorTabState();
}

class _DoorToDoorTabState extends State<DoorToDoorTab>
    implements DoorToDoorView {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  @override
  void onChangeTab(int index) {
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);
    setState(() {
      orderBooking.setOrderBooking(
          orderBooking: OrderBooking.empty(TypeOrder.doorToDoor));
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    List<TitleTab> mapListTab() {
      int index = 0;

      return constants.tabDoorToDoor
          .map<TitleTab>((e) => TitleTab(
                title: e,
                index: index++,
                deviceSize: deviceSize,
                currentIndex: _index,
                onChangeTab: onChangeTab,
              ))
          .toList();
    }

    return SizedBox(
      width: deviceSize.width,
      height: deviceSize.height,
      child: ListView(
        children: [
          CustomSizedBox(
            context: context,
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: mapListTab(),
          ),
          _index == 0
              ? HandyTab(
                  handyTab: widget.handyTab,
                )
              : HandyTabUnwidely(handyTab: widget.unweildyTab)
        ],
      ),
    );
  }
}
