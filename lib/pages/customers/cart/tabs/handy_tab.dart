import 'package:flutter/material.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/pages/customers/cart/widgets/accessory_widget.dart';
import 'package:rssms/pages/customers/cart/widgets/booking_pop_up_door_to_door.dart';
import 'package:rssms/pages/customers/cart/widgets/product_widget.dart';
import '../../../../constants/constants.dart' as constants;

class HandyTab extends StatefulWidget {
  const HandyTab({Key? key}) : super(key: key);

  @override
  _HandyTabState createState() => _HandyTabState();
}

class _HandyTabState extends State<HandyTab> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> mapProductWidget(listProduct) => listProduct
      .map<ProductWidget>((e) => ProductWidget(
            product: e,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final List<Map<String, dynamic?>> listProduct = constants.LIST_PRODUCT
        .map<Map<String, dynamic>>((e) => {...e, 'quantity': 0})
        .toList();
    final List<Map<String, dynamic?>> listAccessory = constants.LIST_ACCESSORY
        .map<Map<String, dynamic>>((e) => {...e, 'quantity': 0})
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
            height: 18,
            text: 'Đặt',
            width: double.infinity,
            onPressFunction: () {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return BookingPopUpDoorToDoor();
                  });
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
