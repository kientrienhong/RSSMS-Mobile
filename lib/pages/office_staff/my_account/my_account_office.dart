import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_tabbutton.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_screen.dart';
import 'package:rssms/pages/customers/my_account/request/request_screen.dart';
import 'package:rssms/pages/log_in/log_in_screen.dart';
import 'package:rssms/pages/profile/profile_screen.dart';

class MyAccountOfficeScreen extends StatefulWidget {
  const MyAccountOfficeScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountOfficeScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<MyAccountOfficeScreen>
    with SingleTickerProviderStateMixin {
  var _scrollController, _tabController;
  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(vsync: this, length: 1);
    super.initState();
  }

  onPressLogout(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Đồng ý"),
      onPressed: () {
        setState(() {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LogInScreen()),
              (Route<dynamic> route) => false);
        });
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Không"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Thông báo"),
      content: const Text("Bạn chắc chắn muốn đăng xuất?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: const Text("My Account"),
              actions: <Widget>[
                GestureDetector(
                    onTap: () => {onPressLogout(context)},
                    child: Image.asset('assets/images/logout.png'))
              ],
              titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
              centerTitle: true,
              pinned: false,
              floating: false,
              snap: false,
              backgroundColor: CustomColor.white,
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: const [ProfileScreen()],
        ),
      ),
    );
  }
}
