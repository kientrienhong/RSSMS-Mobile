import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_tabbutton.dart';
import 'package:rssms/pages/delivery_staff/request/request_screen.dart';
import 'package:rssms/pages/profile/profile_screen.dart';

class MyAccountDeliveryScreen extends StatefulWidget {
  const MyAccountDeliveryScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountDeliveryScreen> createState() =>
      _MyAccountDeliveryScreenState();
}

class _MyAccountDeliveryScreenState extends State<MyAccountDeliveryScreen>
    with SingleTickerProviderStateMixin {
  var _scrollController, _tabController;
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
