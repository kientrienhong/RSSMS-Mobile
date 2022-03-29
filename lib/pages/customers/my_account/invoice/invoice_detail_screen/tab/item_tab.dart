import 'package:flutter/material.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/image_widget.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/constants/constants.dart' as constants;
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/update_invoice_screen/widget/addition_service_widget.dart';

class ItemTab extends StatefulWidget {
  Invoice? invoice;

  ItemTab({Key? key, required this.invoice}) : super(key: key);

  @override
  _ItemTabState createState() => _ItemTabState();
}

class _ItemTabState extends State<ItemTab> {
  List<Widget> mapInvoiceWidget(List<OrderDetail> listOrderDetail) =>
      listOrderDetail
          .where((element) => element.productType == constants.HANDY)
          .map((e) => ImageWidget(
                orderDetail: e,
                isView: true,
              ))
          .toList();

  List<Widget> mapSeperateAdditionWidget(List<OrderDetail> listOrderDetail) =>
      listOrderDetail
          .where((element) => element.productType == constants.ACCESSORY)
          .map((e) => AdditionServiceWidget(
                isView: true,
                onAddAddition: () {},
                onMinusAddition: () {},
                orderDetail: e,
              ))
          .toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // CustomText(
        //     text: "Hình ảnh:",
        //     color: Colors.black,
        //     context: context,
        //     fontWeight: FontWeight.bold,
        //     fontSize: 17),
        CustomSizedBox(
          context: context,
          height: 8,
        ),
        Column(
          children: mapInvoiceWidget(widget.invoice!.orderDetails),
        )
      ],
    );
  }
}
