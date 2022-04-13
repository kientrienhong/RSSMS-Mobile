import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_tabbutton.dart';
import 'package:rssms/models/entity/add_image.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/pages/delivery_staff/request/request_screen.dart';
import 'package:rssms/pages/log_in/log_in_screen.dart';
import 'package:rssms/pages/profile/profile_screen.dart';

class MyAccountDeliveryScreen extends StatefulWidget {
  const MyAccountDeliveryScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountDeliveryScreen> createState() =>
      _MyAccountDeliveryScreenState();
}

class _MyAccountDeliveryScreenState extends State<MyAccountDeliveryScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 2, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: const Text("Thông tin tài khoản"),
                actions: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Invoice invoice =
                            Provider.of<Invoice>(context, listen: false);
                        invoice.setInvoice(invoice: Invoice.empty());
                        Users users =
                            Provider.of<Users>(context, listen: false);
                        users.setUser(user: Users.empty());
                        OrderBooking orderBooking =
                            Provider.of<OrderBooking>(context, listen: false);
                        orderBooking.setOrderBooking(
                            orderBooking:
                                OrderBooking.empty(TypeOrder.doorToDoor));
                        AddedImage addedImage =
                            Provider.of<AddedImage>(context, listen: false);
                        addedImage.setImage(aimage: AddedImage.empty());
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const LogInScreen()),
                            (Route<dynamic> route) => false);
                      },
                      child: Image.asset('assets/images/logout.png'))
                ],
                titleTextStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                centerTitle: true,
                pinned: true,
                floating: false,
                snap: false,
                backgroundColor: CustomColor.white,
                bottom: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.white,
                  labelColor: Colors.blue,
                  labelStyle: const TextStyle(color: Colors.red, fontSize: 18),
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 18),
                  tabs: <TabButton>[
                    TabButton(
                      text: "Thông Tin",
                      pageNumber: 0,
                      onPressed: () {},
                    ),
                    TabButton(
                      text: "Yêu Cầu",
                      pageNumber: 1,
                      onPressed: () {},
                    )
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: const [ProfileScreen(), RequestScreen()],
          )),
    );
  }
}
