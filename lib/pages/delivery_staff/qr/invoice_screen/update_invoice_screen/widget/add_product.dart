import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/product.dart';
import 'package:rssms/constants/constants.dart' as constants;

class AddProduct extends StatelessWidget {
  final String? orderDetail;
  final Product product;
  final bool isSeperate;
  const AddProduct(
      {Key? key,
      required this.product,
      this.orderDetail,
      required this.isSeperate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final oCcy = NumberFormat("#,##0", "en_US");

    void addMainProduct() {
      Invoice invoice = Provider.of<Invoice>(context, listen: false);
      Invoice invoiceTemp = invoice.copyWith();
      if (product.type == constants.typeProduct.handy.index ||
          product.type == constants.typeProduct.unweildy.index) {
        final anotherType = product.type == constants.typeProduct.handy.index
            ? constants.typeProduct.unweildy.index
            : constants.typeProduct.handy.index;

        final anotherTypeFoundIndex = invoiceTemp.orderDetails
            .indexWhere((element) => element.productType == anotherType);

        if (anotherTypeFoundIndex == -1) {
          invoiceTemp.orderDetails.add(OrderDetail(
              id: invoiceTemp.orderDetails.length.toString(),
              productId: product.id,
              productName: product.name,
              status: -1,
              price: product.price,
              height: product.height,
              width: product.width,
              length: product.length,
              amount: 1,
              serviceImageUrl: product.imageUrl,
              productType: product.type,
              note: '',
              images: []));
        } else {
          CustomSnackBar.buildSnackbar(
              context: context,
              message: "????n h??ng kh??ng th??? g???m 2 lo???i d???ch v??? ch??nh",
              color: CustomColor.red);
              return;
        }
      } else {
        invoiceTemp.orderDetails.add(OrderDetail(
            id: invoiceTemp.orderDetails.length.toString(),
            productId: product.id,
            productName: product.name,
            status: -1,
            price: product.price,
            width: product.width,
            length: product.length,
            height: product.height,
            amount: 1,
            serviceImageUrl: product.imageUrl,
            productType: product.type,
            note: '',
            images: []));
      }

      invoice.setInvoice(invoice: invoiceTemp);
      CustomSnackBar.buildSnackbar(
          context: context,
          message: 'Th??m d???ch v??? th??nh c??ng!',
          color: CustomColor.green);
    }

    void addAddtion() {
      Invoice invoice = Provider.of<Invoice>(context, listen: false);
      Invoice invoiceTemp = invoice.copyWith();

      if (!isSeperate) {
        int index = invoice.orderDetails
            .indexWhere((element) => element.id == orderDetail);
        if (invoice.orderDetails[index].listAdditionService!.isEmpty) {
          invoiceTemp.orderDetails[index].listAdditionService = [];
        }

        int indexFound = invoiceTemp.orderDetails[index].listAdditionService!
            .indexWhere((element) => element.id == product.id);
        if (indexFound == -1) {
          invoiceTemp.orderDetails[index].listAdditionService!
              .add(product.copyWith(quantity: 1));
        } else {
          int quantity = invoiceTemp
              .orderDetails[index].listAdditionService![indexFound].quantity!;
          invoiceTemp.orderDetails[index].listAdditionService![indexFound] =
              invoiceTemp.orderDetails[index].listAdditionService![indexFound]
                  .copyWith(quantity: ++quantity);
        }
      } else {
        int index = invoice.orderDetails
            .indexWhere((element) => element.id == orderDetail);
        if (index == -1) {
          invoiceTemp.orderDetails.add(OrderDetail(
              id: '${invoiceTemp.orderDetails.length.toString()} + ${product.name}',
              productId: product.id,
              status: -1,
              productName: product.name,
              price: product.price,
              amount: 1,
              serviceImageUrl: product.imageUrl,
              productType: product.type,
              note: '',
              images: []));
        } else {
          int quantity = invoiceTemp.orderDetails[index].amount;
          invoiceTemp.orderDetails[index].amount = ++quantity;
        }
      }

      invoice.setInvoice(invoice: invoiceTemp);
      CustomSnackBar.buildSnackbar(
          context: context,
          message: 'Th??m d???ch v??? th??nh c??ng!',
          color: CustomColor.green);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
                    product.imageUrl,
                    fit: BoxFit.contain,
                  )),
              CustomSizedBox(
                context: context,
                width: 4,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: product.name,
                    color: CustomColor.black,
                    context: context,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomSizedBox(
                    context: context,
                    height: 4,
                  ),
                  CustomText(
                      text: '${oCcy.format(product.price)} ?? / ${product.unit}',
                      color: CustomColor.blue,
                      context: context,
                      fontSize: 16)
                ],
              ),
            ],
          ),
          CustomButton(
              height: 20,
              text: "Th??m",
              width: 50,
              textSize: 12,
              onPressFunction: () {
                if (orderDetail == null) {
                  addMainProduct();
                } else {
                  addAddtion();
                }
              },
              isLoading: false,
              textColor: CustomColor.white,
              buttonColor: CustomColor.blue,
              borderRadius: 4)
        ],
      ),
    );
  }
}
