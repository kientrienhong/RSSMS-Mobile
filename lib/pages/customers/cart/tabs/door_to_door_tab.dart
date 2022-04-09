import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_tabbutton.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/product.dart';
import 'package:rssms/pages/customers/cart/tabs/handy_tab.dart';
import 'package:rssms/pages/customers/cart/tabs/handy_tab_unwidely.dart';
import 'package:rssms/pages/customers/cart/tabs/self_storage_tab.dart';
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

     return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
              text: "Dịch vụ giữ đồ thuê",
              color: Colors.black,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 24),
          elevation: 0,
          backgroundColor: CustomColor.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              TabButton(
                text: CustomText(
                  text: "Gửi theo loại",
                  color: CustomColor.black,
                  context: context,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                pageNumber: 1,
                onPressed: () {},
              ),
              TabButton(
                text: CustomText(
                  text: "Gửi theo diện tích",
                  color: CustomColor.black,
                  context: context,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                pageNumber: 2,
                onPressed: () {},
              )
            ],
          ),
        ),
        body: Container(
          color: CustomColor.white,
          width: deviceSize.width,
          height: deviceSize.height,
          child: TabBarView(
            children: [
              HandyTab(
                handyTab: widget.handyTab,
              ),
              HandyTabUnwidely(handyTab: widget.unweildyTab)
            ],
          ),
        ),
      ),
    );
  }
}
