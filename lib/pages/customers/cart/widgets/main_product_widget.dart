import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/product.dart';
import 'package:rssms/pages/customers/cart/widgets/info_pop_up.dart';
import 'package:rssms/pages/customers/cart/widgets/quantity_widget.dart';
import 'package:rssms/utils/size_config.dart';
import 'package:rssms/views/item_widget_view.dart';

class MainProductWidget extends StatefulWidget {
  Product? product;
  String nameType;

  MainProductWidget({Key? key, required this.product, required this.nameType})
      : super(key: key);

  @override
  _MainProductWidgetState createState() => _MainProductWidgetState();
}

class _MainProductWidgetState extends State<MainProductWidget>
    implements ItemWidgetView {
  final oCcy = NumberFormat("#,##0", "en_US");

  @override
  void onAddQuantity() {
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);
    Product tempProduct = widget.product!.copyWith();

    final foundItem = orderBooking.productOrder[widget.nameType]!.indexWhere(
      (e) => e['idOfList'].toString() == widget.product!.id,
    );

    if (foundItem != -1) {
      orderBooking.productOrder[widget.nameType]![foundItem]['quantity'] += 1;
    } else {
      orderBooking.productOrder[widget.nameType]!.add({
        ...widget.product!.toMap(),
        'quantity': 1,
        'idOfList': widget.product!.id,
      });
    }
    tempProduct = tempProduct.copyWith(quantity: tempProduct.quantity! + 1);
    setState(() {
      widget.product = tempProduct;
    });
  }

  @override
  void onMinusQuantity() {
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);
    Product tempProduct = widget.product!.copyWith();
    if (tempProduct.quantity == 0) {
      return;
    }
    final foundItem = orderBooking.productOrder[widget.nameType]!.indexWhere(
      (e) => e['idOfList'].toString() == '${widget.product!.id}',
    );
    if (foundItem != -1) {
      final quantity =
          orderBooking.productOrder[widget.nameType]![foundItem]['quantity'];
      if (quantity == 1) {
        orderBooking.productOrder[widget.nameType]!.removeAt(foundItem);
      } else {
        orderBooking.productOrder[widget.nameType]![foundItem]['quantity'] -= 1;
      }
    }
    tempProduct = tempProduct.copyWith(quantity: tempProduct.quantity! - 1);
    setState(() {
      widget.product = tempProduct;
    });
  }

  @override
  Widget build(BuildContext context) {
    String unit = widget.product!.unit == 'quantity' ? 'cái' : 'tháng';

    final deviceSize = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Container(
        height: deviceSize.height > 640
            ? SizeConfig.blockSizeVertical! * 21
            : SizeConfig.blockSizeVertical! * 25,
        width: deviceSize.width - 32,
        padding: EdgeInsets.only(top: deviceSize.height / 45, left: 16),
        margin: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: CustomColor.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 14,
                  color: const Color(0x00000000).withOpacity(0.06),
                  offset: const Offset(0, 6)),
            ]),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: (deviceSize.width - 48) / 4 - 8,
                  child: Image.network(widget.product!.imageUrl)),
              const SizedBox(
                width: 16,
              ),
              SizedBox(
                width: (deviceSize.width - 48) * 3 / 4 - 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: widget.product!.name,
                            color: CustomColor.black,
                            context: context,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return InfoPopUp(
                                    product: widget.product,
                                  );
                                });
                          },
                          child: Container(
                              margin: const EdgeInsets.only(right: 8),
                              child: Image.asset('assets/images/info.png')),
                        )
                      ],
                    ),
                    CustomSizedBox(
                      context: context,
                      height: 8,
                    ),
                    CustomText(
                        text: 'Trọng lượng cho phép < 25kg',
                        color: CustomColor.black[3]!,
                        context: context,
                        fontSize: 16),
                    CustomSizedBox(
                      context: context,
                      height: 8,
                    ),
                    CustomText(
                        text: '${oCcy.format(widget.product!.price)}đ / $unit',
                        color: CustomColor.blue,
                        context: context,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    CustomSizedBox(
                      context: context,
                      height: 8,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 16),
                      width: (deviceSize.width - 32) / 8,
                      child: QuantityWidget(
                        product: widget.product,
                        width: deviceSize.width / 8,
                        productType: widget.nameType,
                        addQuantity: () => onAddQuantity(),
                        minusQuantity: () => onMinusQuantity(),
                        mainAxisAlignment: MainAxisAlignment.end,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ]));
  }
}
