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
import 'package:rssms/views/product_view.dart';

class ProductWidget extends StatefulWidget {
  Product? product;
  ProductWidget({Key? key, this.product}) : super(key: key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> implements ProductView {
  late double additionHeight;
  final oCcy = NumberFormat("#,##0", "en_US");

  @override
  void initState() {
    super.initState();
    additionHeight = 0;
  }

  @override
  void onAddQuantity(double deviceSizeHeight) {
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);
    Product tempProduct = widget.product!.copyWith();
    tempProduct = tempProduct.copyWith(quantity: tempProduct.quantity! + 1);
    orderBooking.productOrder!['product']!.add({
      ...widget.product!.toMap(),
      'quantity': 1,
      'idOfList': '${widget.product!.id}-${tempProduct.quantity}',
      'note': '',
    });

    setState(() {
      widget.product = tempProduct;
      additionHeight = tempProduct.quantity! * deviceSizeHeight * 7;
    });
  }

  @override
  void onMinusQuantity(double deviceSizeHeight) {
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);
    Product tempProduct = widget.product!.copyWith();
    if (tempProduct.quantity == 0) {
      return;
    }
    final foundItem = orderBooking.productOrder!['product']!.indexWhere(
      (e) =>
          e['idOfList'].toString() ==
          '${widget.product!.id}-${tempProduct.quantity}',
    );

    orderBooking.productOrder!['product']!.removeAt(foundItem);

    tempProduct = tempProduct.copyWith(quantity: tempProduct.quantity! - 1);
    setState(() {
      widget.product = tempProduct;
      additionHeight = tempProduct.quantity! * deviceSizeHeight * 7;
    });
  }

  @override
  Widget build(BuildContext context) {
    String unit = widget.product!.unit == 'quantity' ? 'cái' : 'tháng';

    final deviceSize = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return AnimatedContainer(
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 400),
      height: deviceSize.height > 640
          ? SizeConfig.blockSizeVertical! * 19 + additionHeight
          : SizeConfig.blockSizeVertical! * 24 + additionHeight,
      width: deviceSize.width - 32,
      padding: EdgeInsets.only(top: deviceSize.height / 45, left: 16),
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
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: (deviceSize.width - 64) / 4,
                child: Image.network(widget.product!.imageUrl)),
            SizedBox(
              width: 16,
            ),
            SizedBox(
              width: (deviceSize.width - 64) * 3 / 4,
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
                      text: widget.product!.name,
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
                    padding: const EdgeInsets.only(right: 16),
                    width: (deviceSize.width - 32) / 8,
                    child: QuantityWidget(
                      product: widget.product,
                      width: deviceSize.width / 8,
                      addQuantity: () =>
                          onAddQuantity(SizeConfig.blockSizeVertical!),
                      minusQuantity: () =>
                          onMinusQuantity(SizeConfig.blockSizeVertical!),
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        if (additionHeight > 0)
          CustomSizedBox(
            context: context,
            height: 8,
          ),
        if (additionHeight > 0)
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemBuilder: (ctx, index) => Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    bottom: SizeConfig.blockSizeVertical! * 1),
                height: SizeConfig.blockSizeVertical! * 6,
                child: TextFormField(
                  onChanged: (text) {
                    OrderBooking orderBooking =
                        Provider.of<OrderBooking>(context, listen: false);
                    final foundItem =
                        orderBooking.productOrder!['product']!.indexWhere(
                      (e) =>
                          e['idOfList'].toString() ==
                          '${widget.product!.id}-${index + 1}',
                    );
                    orderBooking.productOrder!['product']![foundItem]['note'] =
                        text;
                  },
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(top: deviceSize.width / 60, left: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(),
                    ),
                    hintText: 'Nhập chú thích cho sản phẩm',
                  ),
                ),
              ),
              itemCount: widget.product!.quantity!,
            ),
          )
      ]),
    );
  }
}
