import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/product.dart';
import 'package:rssms/pages/customers/cart/widgets/accessory_widget.dart';
import 'package:rssms/pages/customers/cart/widgets/booking_pop_up_self_storage.dart';
import 'package:rssms/pages/customers/cart/widgets/self_storage_widget.dart';
import '../../../../constants/constants.dart' as constants;

class SelfStorageTab extends StatelessWidget {
  final Map<int, List<Product>>? selfStorageTab;

  const SelfStorageTab({Key? key, required this.selfStorageTab})
      : super(key: key);
  List<Widget> mapProductWidget(listProduct) => listProduct
      .map<SelfStorageWidget>((e) => SelfStorageWidget(
            product: e,
          ))
      .toList();
  @override
  Widget build(BuildContext context) {
    final List<Product> listSelfStorage =
        selfStorageTab![constants.typeProduct.selfStorage.index] == null
            ? []
            : selfStorageTab![constants.typeProduct.selfStorage.index]!
                .map((e) => e.copyWith(quantity: 0))
                .toList();
    final List<Product> listAccessory =
        selfStorageTab![constants.typeProduct.accessory.index] == null
            ? []
            : selfStorageTab![constants.typeProduct.accessory.index]!
                .map((e) => e.copyWith(quantity: 0))
                .toList();

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            Row(
              children: [
                CustomText(
                    text: 'Chọn ',
                    color: CustomColor.blue,
                    fontWeight: FontWeight.bold,
                    context: context,
                    fontSize: 24),
                CustomText(
                    text: 'diện tích ',
                    color: CustomColor.black[3]!,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 24)
              ],
            ),
            ListView(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: mapProductWidget(listSelfStorage),
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
              padding: const EdgeInsets.all(0),
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
                  List<dynamic> listBooking =
                      orderBooking.productOrder['product']!;
                  if (listBooking.isNotEmpty) {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return const BookingPopUpSelfStorage();
                        });
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Thông báo"),
                            content: const Text(
                                "Vui lòng chọn ít nhất một dịch vụ!"),
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
          ],
        ),
      ),
    );
  }
}
