import 'package:flutter/cupertino.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/import_export_item.dart';
import 'package:rssms/models/entity/order_detail.dart';

class ImportExportDetails extends StatelessWidget {
  final List<OrderDetail>? orderDetail;
  const ImportExportDetails({Key? key, required this.orderDetail})
      : super(key: key);

  List<Widget> mapProductWidget(List<OrderDetail> listItem) => listItem
      .map<ImportExportItem>((i) => ImportExportItem(
            orderDetail: i,
          ))
      .where((element) => element.orderDetail.productType != 1)
      .toList();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Table(
          children: [
            TableRow(
              children: [
                CustomText(
                    text: "Sản phẩm",
                    color: CustomColor.black,
                    fontWeight: FontWeight.bold,
                    context: context,
                    fontSize: 16),
                CustomText(
                    text: "Số lượng",
                    color: CustomColor.black,
                    textAlign: TextAlign.right,
                    fontWeight: FontWeight.bold,
                    context: context,
                    fontSize: 16)
              ],
            ),
          ],
        ),
        CustomSizedBox(
          context: context,
          height: 12,
        ),
        Column(children: mapProductWidget(orderDetail!))
      ],
    );
  }
}
