import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/product.dart';

class AdditionServiceWidget extends StatefulWidget {
  final bool isView;
  final Product? product;
  final OrderDetail? orderDetail;
  Function onAddAddition;
  Function onMinusAddition;
  AdditionServiceWidget(
      {Key? key,
      this.product,
      this.orderDetail,
      required this.isView,
      required this.onAddAddition,
      required this.onMinusAddition})
      : super(key: key);

  @override
  State<AdditionServiceWidget> createState() => _AdditionServiceWidgetState();
}

class _AdditionServiceWidgetState extends State<AdditionServiceWidget> {
  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,##0", "en_US");

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.network(
                    widget.product == null
                        ? widget.orderDetail!.serviceImageUrl
                        : widget.product!.imageUrl,
                    fit: BoxFit.contain,
                  )),
              CustomSizedBox(
                context: context,
                width: 4,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: widget.product == null
                        ? widget.orderDetail!.productName
                        : widget.product!.name,
                    color: CustomColor.black,
                    context: context,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomSizedBox(
                    context: context,
                    height: 6,
                  ),
                  CustomText(
                      text: widget.product == null
                          ? '${oCcy.format(widget.orderDetail!.price)} đ / số lượng'
                          : ' ${oCcy.format(widget.product!.price)} đ / số lượng',
                      color: CustomColor.blue,
                      context: context,
                      fontSize: 16)
                ],
              ),
            ],
          ),
          Row(
            children: [
              if (!widget.isView)
                GestureDetector(
                  onTap: () {
                    if (widget.product != null) {
                      widget.onMinusAddition(widget.product);
                    } else {
                      widget.onMinusAddition(widget.orderDetail);
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: CustomColor.black[3]!),
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: CustomText(
                          text: '-',
                          color: CustomColor.black[3]!,
                          context: context,
                          fontSize: 32),
                    ),
                  ),
                ),
              CustomSizedBox(
                context: context,
                width: 8,
              ),
              CustomText(
                text: widget.product == null
                    ? widget.orderDetail!.amount.toString()
                    : widget.product!.quantity.toString(),
                color: CustomColor.blue,
                context: context,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              CustomSizedBox(
                context: context,
                width: 8,
              ),
              if (!widget.isView)
                GestureDetector(
                  onTap: () {
                    if (widget.product != null) {
                      widget.onAddAddition(widget.product);
                    } else {
                      widget.onAddAddition(widget.orderDetail);
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: CustomColor.blue),
                    child: Center(
                      child: CustomText(
                          text: '+',
                          color: CustomColor.white,
                          context: context,
                          fontSize: 32),
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
