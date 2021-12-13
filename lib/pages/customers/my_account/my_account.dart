import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_tabbutton.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_screen.dart';
import 'package:rssms/pages/customers/my_account/profile/profile_screen.dart';
import 'package:rssms/pages/customers/my_account/request/request_screen.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<MyAccountScreen>
    with SingleTickerProviderStateMixin {
  var _scrollController, _tabController;
  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: const Text("My Account"),
                titleTextStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                centerTitle: true,
                pinned: false,
                floating: true,
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
                      text: "Đơn Hàng",
                      pageNumber: 1,
                      onPressed: () {},
                    ),
                    TabButton(
                      text: "Yêu Cầu",
                      pageNumber: 2,
                      onPressed: () {},
                    )
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: const [ProfileScreen(), InvoiceScreen(), RequestScreen()],
          )),
    );
  }
}
