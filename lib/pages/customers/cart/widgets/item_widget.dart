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
import 'package:rssms/views/item_widget_view.dart';

class ItemWidget extends StatefulWidget {
  Product? product;
  String nameType;
  ItemWidget({Key? key, required this.product, required this.nameType})
      : super(key: key);

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> implements ItemWidgetView {
  final oCcy = NumberFormat("#,##0", "en_US");
  @override
  void onAddQuantity() {
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);
    Product tempProduct = widget.product!.copyWith();

    final foundItem = orderBooking.productOrder![widget.nameType]!.indexWhere(
      (e) => e['idOfList'].toString() == '${widget.product!.id}',
    );

    if (foundItem != -1) {
      orderBooking.productOrder![widget.nameType]![foundItem]['quantity'] += 1;
    } else {
      orderBooking.productOrder![widget.nameType]!.add({
        ...widget.product!.toMap(),
        'quantity': 1,
        'idOfList': '${widget.product!.id}',
      });
    }
    int newQuantity = tempProduct.quantity! + 1;
    tempProduct = tempProduct.copyWith(quantity: newQuantity);
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
    final foundItem = orderBooking.productOrder![widget.nameType]!.indexWhere(
      (e) => e['idOfList'].toString() == '${widget.product!.id}',
    );
    if (foundItem != -1) {
      final quantity =
          orderBooking.productOrder![widget.nameType]![foundItem]['quantity'];
      if (quantity == 1) {
        orderBooking.productOrder![widget.nameType]!.removeAt(foundItem);
      } else {
        orderBooking.productOrder![widget.nameType]![foundItem]['quantity'] -=
            1;
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: CustomColor.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 14,
                color: Color(0x000000).withOpacity(0.06),
                offset: const Offset(0, 6)),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                        margin: const EdgeInsets.only(right: 8, top: 8),
                        child: Image.asset('assets/images/info.png')),
                  ),
                ],
              ),
              SizedBox(
                  height: deviceSize.width / 8,
                  width: deviceSize.width / 8,
                  child: Image.network(widget.product!.imageUrl)),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              CustomText(
                  text: widget.product!.name,
                  color: CustomColor.black,
                  context: context,
                  fontWeight: FontWeight.bold,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  fontSize: 20),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              CustomText(
                  text: widget.product!.description,
                  color: CustomColor.black[3]!,
                  context: context,
                  maxLines: 2,
                  textAlign: TextAlign.center,
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
                height: 16,
              ),
            ],
          ),
          QuantityWidget(
            product: widget.product,
            productType: widget.nameType,
            width: deviceSize.width / 10,
            minusQuantity: onMinusQuantity,
            addQuantity: onAddQuantity,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
