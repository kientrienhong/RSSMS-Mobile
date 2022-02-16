import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/constants/constants.dart' as constants;
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/tab/image_widget.dart';

class ItemTab extends StatefulWidget {
  Invoice? invoice;

  ItemTab({Key? key, required this.invoice}) : super(key: key);

  @override
  _ItemTabState createState() => _ItemTabState();
}

class _ItemTabState extends State<ItemTab> {
  Widget mapInvoiceWidget(listOrderDetail) => ImageWidget(
        orderDetail: listOrderDetail,
        isView: false,
      );

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> image = constants.IMAGE_INVOICE;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
                text: "Tình trạng đơn hàng:",
                color: Colors.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 17),
            CustomText(
                text: "widget.invoice![]",
                color: CustomColor.blue,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ],
        ),
        CustomSizedBox(
          context: context,
          height: 16,
        ),
        CustomText(
            text: "Hình ảnh:",
            color: Colors.black,
            context: context,
            fontWeight: FontWeight.bold,
            fontSize: 17),
        CustomSizedBox(
          context: context,
          height: 8,
        ),
        Column(
          children: [mapInvoiceWidget(image)],
        )
      ],
    );
  }
}
