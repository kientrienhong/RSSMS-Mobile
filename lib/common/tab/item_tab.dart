import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/image_widget.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/constants/constants.dart' as constants;
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/update_invoice_screen/widget/addition_service_widget.dart';

class ItemTab extends StatefulWidget {
  final Invoice? invoice;

  const ItemTab({Key? key, required this.invoice}) : super(key: key);

  @override
  _ItemTabState createState() => _ItemTabState();
}

class _ItemTabState extends State<ItemTab> {
  List<Widget> mapSeperateAdditionWidget(List<OrderDetail> listOrderDetail) {
    final list = listOrderDetail.where((element) =>
        element.productType == constants.typeProduct.accessory.index);
    if (list.isNotEmpty) {
      return list
          .where((element) =>
              element.productType == constants.typeProduct.accessory.index)
          .map((e) => AdditionServiceWidget(
                isView: true,
                onAddAddition: () {},
                onMinusAddition: () {},
                orderDetail: e,
              ))
          .toList();
    } else {
      return [
        Center(
            child: CustomText(
                text: '(Trống)',
                color: CustomColor.black[3]!,
                context: context,
                fontSize: 16))
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    List<Widget> mapInvoiceWidget(List<OrderDetail> listOrderDetail) =>
        listOrderDetail
            .where((element) =>
                element.productType == constants.typeProduct.handy.index ||
                element.productType == constants.typeProduct.unweildy.index)
            .map((e) =>
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  e.status == 0
                      ? CustomText(
                          maxLines: 2,
                          text: 'Đồ bị thất lạc',
                          color: CustomColor.black[2]!,
                          context: context,
                          fontSize: 16)
                      : SizedBox(
                          width: deviceSize.width,
                          child: CustomText(
                              maxLines: 2,
                              text:
                                  'Vị trí: ${e.nameStorage} / ${e.nameArea} / ${e.nameSpace} / ${e.nameFloor}',
                              color: CustomColor.black,
                              context: context,
                              fontSize: 16),
                        ),
                  CustomSizedBox(
                    context: context,
                    height: 8,
                  ),
                  ImageWidget(
                    orderDetail: e.status == 0 ? e.copyWith(status: 5) : e,
                    isView: true,
                  ),
                  CustomSizedBox(
                    context: context,
                    height: 8,
                  ),
                ]))
            .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomSizedBox(
          context: context,
          height: 24,
        ),
        CustomText(
            text: "Danh sách phụ kiện riêng: ",
            color: Colors.black,
            context: context,
            fontWeight: FontWeight.bold,
            fontSize: 17),
        CustomSizedBox(
          context: context,
          height: 8,
        ),
        Column(
          children: mapSeperateAdditionWidget(widget.invoice!.orderDetails),
        ),
        CustomSizedBox(
          context: context,
          height: 8,
        ),
        CustomText(
            text: "Hình ảnh đồ đạc được lưu kho: ",
            color: Colors.black,
            context: context,
            fontWeight: FontWeight.bold,
            fontSize: 17),
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
