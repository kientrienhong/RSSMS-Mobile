import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_tabbutton.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/add_image.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/common/invoice_screen.dart';
import 'package:rssms/pages/customers/my_account/request/request_screen.dart';
import 'package:rssms/pages/log_in/log_in_screen.dart';
import 'package:rssms/pages/profile/profile_screen.dart';

class MyAccountScreen extends StatefulWidget {
  final int? initIndex;
  const MyAccountScreen({Key? key, this.initIndex}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<MyAccountScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  onPressLogout(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Đồng ý"),
      onPressed: () {
        setState(() {
          Invoice invoice = Provider.of<Invoice>(context, listen: false);
          invoice.setInvoice(invoice: Invoice.empty());
          Users users = Provider.of<Users>(context, listen: false);
          users.setUser(user: Users.empty());
          OrderBooking orderBooking =
              Provider.of<OrderBooking>(context, listen: false);
          orderBooking.setOrderBooking(
              orderBooking: OrderBooking.empty(TypeOrder.doorToDoor));
          AddedImage addedImage =
              Provider.of<AddedImage>(context, listen: false);
          addedImage.setImage(aimage: AddedImage.empty());
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LogInScreen()),
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
      initialIndex: widget.initIndex ?? 1,
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
        ),
        body: const TabBarView(
          children: [ProfileScreen(), InvoiceScreen(), RequestScreen()],
        ),
      ),
    );
  }
}
