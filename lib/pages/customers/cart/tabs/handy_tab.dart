import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/product.dart';
import 'package:rssms/pages/customers/cart/widgets/accessory_widget.dart';
import 'package:rssms/pages/customers/cart/widgets/booking_pop_up_door_to_door.dart';
import 'package:rssms/pages/customers/cart/widgets/booking_pop_up_self_storage.dart';
import 'package:rssms/pages/customers/cart/widgets/door_to_door_product_widget.dart';
import 'package:rssms/pages/customers/cart/widgets/main_product_widget.dart';
import 'package:rssms/pages/customers/cart/widgets/product_widget.dart';
import 'package:rssms/pages/customers/cart/widgets/service_widget.dart';
import '../../../../constants/constants.dart' as constants;

class HandyTab extends StatefulWidget {
  final Map<int, List<Product>>? handyTab;

  const HandyTab({Key? key, required this.handyTab}) : super(key: key);

  @override
  _HandyTabState createState() => _HandyTabState();
}

class _HandyTabState extends State<HandyTab> {
  List<Widget> mapProductWidget(listProduct) => listProduct
      .map<ProductWidget>((e) => ProductWidget(
            product: e,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    final List<Product> listProduct = widget.handyTab![constants.HANDY] == null
        ? []
        : widget.handyTab![constants.HANDY]!
            .map((e) => e.copyWith(quantity: 0))
            .toList();
    final List<Product> listAccessory =
        widget.handyTab![constants.ACCESSORY] == null
            ? []
            : widget.handyTab![constants.ACCESSORY]!
                .map((e) => e.copyWith(quantity: 0))
                .toList();
    final List<Product> listService =
        widget.handyTab![constants.SERVICES] == null
            ? []
            : widget.handyTab![constants.SERVICES]!
                .map((e) => e.copyWith(quantity: 0))
                .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(children: [
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: mapProductWidget(listProduct),
        ),
        CustomSizedBox(
          context: context,
          height: 8,
        ),
        Row(
          children: [
            CustomText(
                text: 'Phụ kiện ',
                color: CustomColor.blue,
                fontWeight: FontWeight.bold,
                context: context,
                fontSize: 24),
            CustomText(
                text: 'đóng gói ',
                color: CustomColor.black[3]!,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 24)
          ],
        ),
        CustomSizedBox(
          context: context,
          height: 8,
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            crossAxisSpacing: 16.0,
          ),
          itemBuilder: (ctx, i) {
            return AccessoryWidget(
              product: listAccessory[i],
            );
          },
          itemCount: listAccessory.length,
        ),
        CustomSizedBox(
          context: context,
          height: 16,
        ),
        CustomButton(
            height: 24,
            text: 'Đặt',
            width: double.infinity,
            onPressFunction: () {
              OrderBooking orderBooking =
                  Provider.of<OrderBooking>(context, listen: false);
              List<dynamic> listBooking = orderBooking.productOrder!['product'];
              if (listBooking.isNotEmpty) {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return const BookingPopUpDoorToDoor();
                    });
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Thông báo"),
                        content:
                            const Text("Vui lòng chọn ít nhất một dịch vụ?"),
                        actions: [
                          TextButton(
                            child: const Text("Đồng ý"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    });
              }
            },
            isLoading: false,
            textColor: CustomColor.white,
            buttonColor: CustomColor.blue,
            borderRadius: 6),
        CustomSizedBox(
          context: context,
          height: 88,
        ),
      ]),
    );
  }
}
