import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/imageEntity.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/common/image_pop_up.dart';
import 'package:rssms/models/entity/product.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/update_invoice_screen/widget/addition_service_widget.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/update_invoice_screen/widget/dialog_add_service.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/update_invoice_screen/widget/update_real_size.dart';
import './image_item.dart';
import 'package:rssms/constants/constants.dart' as constants;

class ImageWidget extends StatefulWidget {
  OrderDetail orderDetail;
  Function? deleteItem;
  final bool isView;
  ImageWidget(
      {Key? key,
      required this.orderDetail,
      required this.isView,
      this.deleteItem})
      : super(key: key);

  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  onPressDeleteImage(BuildContext context, int index) {
    Widget cancelButton = TextButton(
      child: const Text("Có"),
      onPressed: () {
        setState(() {
          widget.orderDetail.images.removeAt(index);
          Invoice invoice = Provider.of<Invoice>(context, listen: false);
          invoice.updateOrderDetail(widget.orderDetail);
        });
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Không"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Cảnh báo"),
      content: const Text("Bạn muốn xóa hình này chứ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void onAddAddition(Product product) {
    Invoice invoice = Provider.of<Invoice>(context, listen: false);
    Invoice invoiceTemp = invoice.copyWith();
    int index = invoiceTemp.orderDetails
        .indexWhere((element) => element.id == widget.orderDetail.id);
    int indexFoundAddionProduct = invoiceTemp
        .orderDetails[index].listAdditionService!
        .indexWhere((element) => element.id == product.id);
    if (indexFoundAddionProduct != -1) {
      int quantity = product.quantity!;
      invoiceTemp.orderDetails[index]
          .listAdditionService![indexFoundAddionProduct].quantity = ++quantity;
    }
    invoice.setInvoice(invoice: invoice);
  }

  void onMinusAddition(Product product) {
    Invoice invoice = Provider.of<Invoice>(context, listen: false);
    Invoice invoiceTemp = invoice.copyWith();
    int index = invoiceTemp.orderDetails
        .indexWhere((element) => element.id == widget.orderDetail.id);
    int indexFoundAddionProduct = invoiceTemp
        .orderDetails[index].listAdditionService!
        .indexWhere((element) => element.id == product.id);
    if (indexFoundAddionProduct != -1) {
      int quantity = product.quantity!;
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

  onPressDetailImage(ImageEntity image) {
    showDialog(
        context: context,
        builder: (ctx) {
          return ImageDetailPopUp(
            isView: widget.isView,
            orderDetail: widget.orderDetail,
            imageUpdate: image,
          );
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    Invoice invoice = Provider.of<Invoice>(context, listen: false);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: CustomColor.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 14,
                color: const Color(0x00000000).withOpacity(0.16),
                offset: const Offset(0, 1)),
          ]),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: deviceSize.width * 2 / 5,
              child: CustomText(
                  text:
                      '${widget.orderDetail.productName} (${widget.orderDetail.width ?? 0}m x ${widget.orderDetail.height ?? 0}m x ${widget.orderDetail.length ?? 0}m)',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  context: context,
                  maxLines: 3,
                  fontSize: 14),
            ),
            CustomText(
                text:
                    (widget.orderDetail.images.length).toString() + ' hình ảnh',
                color: Colors.black38,
                context: context,
                fontSize: 14)
          ],
        ),
        children: [
          Column(
            children: [
              for (var i = 0; i < widget.orderDetail.images.length; i++)
                ImageItem(
                  isView: widget.isView,
                  onPressDelete: () {
                    onPressDeleteImage(context, i);
                  },
                  onPressDetails: () {
                    onPressDetailImage(widget.orderDetail.images[i]);
                  },
                  index: i,
                  image: widget.orderDetail.images[i],
                ),
              if (widget.orderDetail.listAdditionService!.isNotEmpty)
                const Divider(),
              for (var i = 0;
                  i < widget.orderDetail.listAdditionService!.length;
                  i++)
                AdditionServiceWidget(
                  product: widget.orderDetail.listAdditionService![i],
                  onAddAddition: onAddAddition,
                  isView: widget.isView,
                  onMinusAddition: onMinusAddition,
                ),
              widget.isView == false
                  ? invoice.typeOrder == constants.SELF_STORAGE_TYPE_ORDER
                      ? Column(
                          children: [
                            const Divider(),
                            CustomSizedBox(
                              context: context,
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomButton(
                                    height: 24,
                                    text: 'Xóa',
                                    width: deviceSize.width / 2 - 40,
                                    onPressFunction: () {
                                      widget.deleteItem!(widget.orderDetail.id);
                                    },
                                    isLoading: false,
                                    textColor: CustomColor.white,
                                    buttonColor: CustomColor.red,
                                    borderRadius: 4),
                                CustomButton(
                                    height: 24,
                                    text: 'Thêm phụ kiện',
                                    width: deviceSize.width / 2 - 40,
                                    onPressFunction: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return DialogAddService(
                                              idOrderDetail:
                                                  widget.orderDetail.id,
                                              isSeperate: false,
                                            );
                                          });
                                    },
                                    isLoading: false,
                                    textColor: CustomColor.white,
                                    buttonColor: CustomColor.green,
                                    borderRadius: 4),
                              ],
                            ),
                            CustomSizedBox(
                              context: context,
                              height: 16,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            const Divider(),
                            CustomSizedBox(
                              context: context,
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomButton(
                                    height: 24,
                                    text: 'Thêm hình ảnh',
                                    width: deviceSize.width / 2 - 40,
                                    onPressFunction: () {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) {
                                            return ImageDetailPopUp(
                                              isView: false,
                                              orderDetail: widget.orderDetail,
                                              imageUpdate: null,
                                            );
                                          });
                                    },
                                    isLoading: false,
                                    textColor: CustomColor.white,
                                    buttonColor: CustomColor.blue,
                                    borderRadius: 4),
                                CustomButton(
                                    height: 24,
                                    text: 'Thêm phụ kiện',
                                    width: deviceSize.width / 2 - 40,
                                    onPressFunction: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return DialogAddService(
                                              idOrderDetail:
                                                  widget.orderDetail.id,
                                              isSeperate: false,
                                            );
                                          });
                                    },
                                    isLoading: false,
                                    textColor: CustomColor.white,
                                    buttonColor: CustomColor.green,
                                    borderRadius: 4),
                              ],
                            ),
                            CustomSizedBox(
                              context: context,
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                if (widget.orderDetail.productType ==
                                    constants.HANDY)
                                  CustomButton(
                                      height: 24,
                                      text: 'Chỉnh sửa kích thước',
                                      width: deviceSize.width / 2 - 40,
                                      onPressFunction: () {
                                        showDialog(
                                            context: context,
                                            builder: (_) =>
                                                DialogUpdateRealSize(
                                                  orderDetail:
                                                      widget.orderDetail,
                                                ));
                                      },
                                      isLoading: false,
                                      textColor: CustomColor.white,
                                      buttonColor: CustomColor.purple,
                                      borderRadius: 4),
                                CustomButton(
                                    height: 24,
                                    text: 'Xóa',
                                    width: widget.orderDetail.productType !=
                                            constants.HANDY
                                        ? deviceSize.width - 72
                                        : deviceSize.width / 2 - 40,
                                    onPressFunction: () {
                                      widget.deleteItem!(widget.orderDetail.id);
                                    },
                                    isLoading: false,
                                    textColor: CustomColor.white,
                                    buttonColor: CustomColor.red,
                                    borderRadius: 4),
                              ],
                            ),
                            CustomSizedBox(
                              context: context,
                              height: 8,
                            ),
                          ],
                        )
                  : Container()
            ],
          )
        ],
      ),
    );
  }
}
