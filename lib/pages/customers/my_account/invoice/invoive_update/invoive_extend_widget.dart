import 'package:flutter/material.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/pages/customers/cart/widgets/quantity_widget.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/product_in_invoice/product_widget.dart';
import 'package:rssms/views/extend_invoice_view.dart';
import 'package:rssms/constants/constants.dart' as constants;

class InvoiveExtendWidget extends StatefulWidget {
  Map<String, dynamic>? invoice;

  InvoiveExtendWidget({Key? key, required this.invoice}) : super(key: key);

  @override
  State<InvoiveExtendWidget> createState() => _InvoiveExtendWidgetState();
}

enum PaymentMethod { tienmat, mbanking, theatm, quocte, vidientu }

class _InvoiveExtendWidgetState extends State<InvoiveExtendWidget>
    implements ExtendInvoiceView {
  PaymentMethod? _state;

  List<Widget> mapProductWidget(listProduct) => listProduct
      .map<ProductInvoiceWidget>((p) => ProductInvoiceWidget(
            product: p,
          ))
      .toList();

  @override
  void onAddQuantity() {
    Map<String, dynamic> tempProduct = {...widget.invoice!};
    tempProduct['quantity'] += 1;
    setState(() {
      widget.invoice = tempProduct;
    });
  }

  @override
  void onMinusQuantity() {
    Map<String, dynamic> tempProduct = {...widget.invoice!};
    if (tempProduct['quantity'] > 0) {
      tempProduct['quantity'] -= 1;
    }
    setState(() {
      widget.invoice = tempProduct;
    });
  }

  Widget customRadioButton(String text, PaymentMethod index, Color color) {
    return Row(
      children: [
        OutlinedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.resolveWith((states) => color),
            shape: MaterialStateProperty.all(const CircleBorder()),
            side: MaterialStateProperty.all(
              const BorderSide(color: CustomColor.blue, width: 1.5),
            ),
            maximumSize: MaterialStateProperty.all(
              const Size(70, 70),
            ),
            minimumSize: MaterialStateProperty.all(
              const Size(25, 25),
            ),
          ),
          onPressed: () {
            setState(() {
              _state = index;
            });
          },
          child: const Icon(
            Icons.check,
            size: 15,
            color: CustomColor.white,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: (_state == index) ? CustomColor.blue : Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    List<Map<String, dynamic>> listProduct = widget.invoice!["item"];
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  text: "Đơn hàng của bạn",
                  color: CustomColor.blue,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
              CustomSizedBox(
                context: context,
                height: 14,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                    border: Border.all(color: CustomColor.blue, width: 1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: "Kho",
                        color: CustomColor.blue,
                        context: context,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    CustomSizedBox(
                      context: context,
                      height: 16,
                    ),
                    Table(
                      columnWidths: {0: FractionColumnWidth(.55)},
                      children: [
                        TableRow(children: [
                          CustomText(
                              text: "Sản phẩm",
                              color: CustomColor.black,
                              fontWeight: FontWeight.bold,
                              context: context,
                              fontSize: 14),
                          CustomText(
                              text: "Số lượng",
                              color: CustomColor.black,
                              fontWeight: FontWeight.bold,
                              context: context,
                              fontSize: 14),
                          CustomText(
                              text: "Tổng tiền",
                              color: CustomColor.black,
                              fontWeight: FontWeight.bold,
                              context: context,
                              fontSize: 14)
                        ])
                      ],
                    ),
                    CustomSizedBox(
                      context: context,
                      height: 16,
                    ),
                    Column(
                      children: mapProductWidget(listProduct),
                    ),
                    Container(
                      color: CustomColor.white,
                      child: const Divider(
                        thickness: 0.6,
                        color: Color(0xFF8D8D8D),
                      ),
                    ),
                    CustomSizedBox(
                      context: context,
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: "Tạm tính",
                            color: Colors.black,
                            context: context,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        CustomText(
                            text:
                                widget.invoice!["totalItem"].toString() + " đ",
                            color: Colors.black,
                            context: context,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ],
                    ),
                    CustomSizedBox(
                      context: context,
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: "Số tháng muốn gia hạn",
                            color: Colors.black,
                            context: context,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        QuantityWidget(
                          product: widget.invoice,
                          width: deviceSize.width / 10,
                          addQuantity: () => onAddQuantity(),
                          minusQuantity: () => onMinusQuantity(),
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ],
                    ),
                    CustomSizedBox(
                      context: context,
                      height: 6,
                    ),
                    Container(
                      color: CustomColor.white,
                      child: const Divider(
                        thickness: 0.6,
                        color: Color(0xFF8D8D8D),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: "Tổng tiền thuê kho",
                            color: Colors.black,
                            context: context,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        CustomText(
                            text: (widget.invoice!["totalItem"] *
                                        widget.invoice!["quantity"])
                                    .toString() +
                                " đ",
                            color: CustomColor.blue,
                            context: context,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ],
                    ),
                  ],
                ),
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: "Ngày trả kho",
                      color: Colors.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  CustomText(
                      text: widget.invoice!["returnnDate"],
                      color: CustomColor.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ],
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Flexible(
                    child: Text(
                      "Ngày trả kho sau khi gia hạn",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  CustomSizedBox(
                    context: context,
                    width: 100,
                  ),
                  CustomText(
                      text: widget.invoice!["returnnDate"],
                      color: CustomColor.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ],
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              CustomText(
                  text: "Phương thức thanh toán",
                  color: CustomColor.blue,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
              CustomSizedBox(
                context: context,
                height: 14,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              customRadioButton(
                  "Thanh toán tiền mặt",
                  PaymentMethod.tienmat,
                  _state == PaymentMethod.tienmat
                      ? CustomColor.blue
                      : CustomColor.white),
              customRadioButton(
                  "Ứng dụng Mobile Banking",
                  PaymentMethod.mbanking,
                  _state == PaymentMethod.mbanking
                      ? CustomColor.blue
                      : CustomColor.white),
              customRadioButton(
                  "Thẻ ATM và tài khoản ngân hàng",
                  PaymentMethod.theatm,
                  _state == PaymentMethod.theatm
                      ? CustomColor.blue
                      : CustomColor.white),
              customRadioButton(
                  "Thẻ thanh toán quốc tế",
                  PaymentMethod.quocte,
                  _state == PaymentMethod.quocte
                      ? CustomColor.blue
                      : CustomColor.white),
              customRadioButton(
                  "Ví điện tử",
                  PaymentMethod.vidientu,
                  _state == PaymentMethod.vidientu
                      ? CustomColor.blue
                      : CustomColor.white),
            ],
          ),
        ),
        CustomSizedBox(
          context: context,
          height: 14,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: CustomButton(
              height: 18,
              isLoading: false,
              text: 'Thanh toán',
              textColor: CustomColor.white,
              onPressFunction: null,
              width: deviceSize.width,
              buttonColor: CustomColor.blue,
              borderRadius: 6),
        ),
      ],
    );
  }
}
