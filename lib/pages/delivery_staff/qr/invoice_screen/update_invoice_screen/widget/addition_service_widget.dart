import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/product.dart';

class AdditionServiceWidget extends StatefulWidget {
  final OrderDetail currentOrderDetail;
  final Product product;
  const AdditionServiceWidget(
      {Key? key, required this.currentOrderDetail, required this.product})
      : super(key: key);

  @override
  State<AdditionServiceWidget> createState() => _AdditionServiceWidgetState();
}

class _AdditionServiceWidgetState extends State<AdditionServiceWidget> {
  void minusQuantity() {
    Invoice invoice = Provider.of<Invoice>(context, listen: false);
    Invoice invoiceTemp = invoice.copyWith();
    int index = invoiceTemp.orderDetails
        .indexWhere((element) => element.id == widget.currentOrderDetail.id);
    int indexFoundAddionProduct = invoiceTemp
        .orderDetails[index].listAdditionService!
        .indexWhere((element) => element.id == widget.product.id);
    if (indexFoundAddionProduct != -1) {
      int quantity = widget.product.quantity!;
      if (quantity == 1) {
        invoiceTemp.orderDetails[index].listAdditionService!
            .removeAt(indexFoundAddionProduct);
      } else {
        invoiceTemp
            .orderDetails[index]
            .listAdditionService![indexFoundAddionProduct]
            .quantity = --quantity;
      }
    }
    invoice.setInvoice(invoice: invoice);
  }

  void addQuantity() {
    Invoice invoice = Provider.of<Invoice>(context, listen: false);
    Invoice invoiceTemp = invoice.copyWith();
    int index = invoiceTemp.orderDetails
        .indexWhere((element) => element.id == widget.currentOrderDetail.id);
    int indexFoundAddionProduct = invoiceTemp
        .orderDetails[index].listAdditionService!
        .indexWhere((element) => element.id == widget.product.id);
    if (indexFoundAddionProduct != -1) {
      int quantity = widget.product.quantity!;
      invoiceTemp.orderDetails[index]
          .listAdditionService![indexFoundAddionProduct].quantity = ++quantity;
    }
    invoice.setInvoice(invoice: invoice);
  }

  @override
  Widget build(BuildContext context) {
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
                    widget.product.imageUrl,
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
                    text: widget.product.name,
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
                      text:
                          '${widget.product.price.toString()} / ${widget.product.unit}',
                      color: CustomColor.blue,
                      context: context,
                      fontSize: 16)
                ],
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: minusQuantity,
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
                text: widget.product.quantity.toString(),
                color: CustomColor.blue,
                context: context,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              CustomSizedBox(
                context: context,
                width: 8,
              ),
              GestureDetector(
                onTap: addQuantity,
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
