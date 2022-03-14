import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_tabbutton.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_screen.dart';
import 'package:rssms/pages/customers/my_account/request/request_screen.dart';
import 'package:rssms/pages/log_in/log_in_screen.dart';
import 'package:rssms/pages/profile/profile_screen.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<MyAccountScreen>
    with SingleTickerProviderStateMixin {
  ScrollController? _scrollController;
  TabController? _tabController;
  @override
  void initState() {
    _scrollController = ScrollController();
    _tabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 1,
    );
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
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
              text: "Thông tin tài khoản",
              color: CustomColor.black,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 24),
          actions: [
            GestureDetector(
                onTap: () => {onPressLogout(context)},
                child: Image.asset('assets/images/logout.png'))
          ],
          elevation: 0,
          backgroundColor: CustomColor.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              TabButton(
                text: CustomText(
                  text: "Thông tin",
                  color: CustomColor.black,
                  context: context,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                pageNumber: 0,
                onPressed: () {},
              ),
              TabButton(
                text: CustomText(
                  text: "Đơn hàng",
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
                  text: "Yêu cầu",
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
        body: const TabBarView(
          children: [ProfileScreen(), InvoiceScreen(), RequestScreen()],
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: CustomColor.white,
    //   body: NestedScrollView(
    //     physics: const NeverScrollableScrollPhysics(),
    //     controller: _scrollController,
    //     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
    //       return <Widget>[
    //         SliverAppBar(
    //           title: const Text("Thông tin tài khoản"),
    //           actions: <Widget>[
    //             GestureDetector(
    //                 onTap: () => {onPressLogout(context)},
    //                 child: Image.asset('assets/images/logout.png'))
    //           ],
    //           titleTextStyle: const TextStyle(
    //               color: Colors.black,
    //               fontSize: 25,
    //               fontWeight: FontWeight.bold),
    //           centerTitle: true,
    //           pinned: true,
    //           floating: false,
    //           snap: false,
    //           backgroundColor: CustomColor.white,
    //           bottom: TabBar(

    //             controller: _tabController,
    //             indicatorColor: Colors.white,
    //             labelColor: Colors.blue,
    //             labelStyle: const TextStyle(color: Colors.red, fontSize: 18),
    //             unselectedLabelColor: Colors.black,
    //             unselectedLabelStyle: const TextStyle(
    //                 color: Colors.black,
    //                 fontWeight: FontWeight.normal,
    //                 fontSize: 18),
    //             tabs: <TabButton>[
    //               TabButton(
    //                 text: "Thông Tin",
    //                 pageNumber: 0,
    //                 onPressed: () {},
    //               ),
    //               TabButton(
    //                 text: "Đơn Hàng",
    //                 pageNumber: 1,
    //                 onPressed: () {},
    //               ),
    //               TabButton(
    //                 text: "Yêu Cầu",
    //                 pageNumber: 2,
    //                 onPressed: () {},
    //               )
    //             ],
    //           ),
    //         )
    //       ];
    //     },
    //     body: TabBarView(
    //       controller: _tabController,

    //       children: const [ProfileScreen(), InvoiceScreen(), RequestScreen()],
    //     ),
    //   ),
    // );
  }
}
