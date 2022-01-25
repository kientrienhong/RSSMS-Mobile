import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_radio_button.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/pages/customers/cart/widgets/quantity_widget_custom.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/product_in_invoice/product_widget.dart';
import 'package:rssms/views/extend_invoice_view.dart';
import 'package:rssms/constants/constants.dart' as constants;

class InvoiveExtendWidget extends StatefulWidget {
  Invoice? invoice;

  InvoiveExtendWidget({Key? key, required this.invoice}) : super(key: key);

  @override
  State<InvoiveExtendWidget> createState() => _InvoiveExtendWidgetState();
}

enum PaymentMethod { tienmat, mbanking, theatm, quocte, vidientu }

class _InvoiveExtendWidgetState extends State<InvoiveExtendWidget>
    implements ExtendInvoiceView {
  final oCcy = NumberFormat("#,##0", "en_US");
  int? durationMonth;
  int totalProduct = 0;
  PaymentMethod? _state;
  List<OrderDetail>? listProduct;
  DateTime? returnDateNew;
  List<Widget> mapProductWidget(listProduct) => listProduct
      .map<ProductInvoiceWidget>((p) => ProductInvoiceWidget(
            product: p,
          ))
      .toList();

  @override
  void onAddQuantity() {
    setState(() {
      durationMonth = durationMonth! + 1;
      returnDateNew = DateTime(
          returnDateNew!.year, returnDateNew!.month + 1, returnDateNew!.day);
    });
  }

  @override
  void onMinusQuantity() {
    if (durationMonth! > 1) {
      setState(() {
        durationMonth = durationMonth! - 1;
        returnDateNew = DateTime(
            returnDateNew!.year, returnDateNew!.month - 1, returnDateNew!.day);
      });
    }
  }

  @override
  void initState() {
    List<OrderDetail> listTemp = widget.invoice!.orderDetails;
    listProduct = listTemp
        .where((element) =>
            element.productType == constants.HANDY ||
            element.productType == constants.UNWEILDY)
        .toList();
    listProduct!.forEach((element) {
      totalProduct += (element.price * element.amount);
    });
    durationMonth = 1;
    returnDateNew = DateTime.parse(widget.invoice!.returnDate
        .substring(0, widget.invoice!.returnDate.indexOf("T")));
    returnDateNew = DateTime(
        returnDateNew!.year, returnDateNew!.month + 1, returnDateNew!.day);
    super.initState();
  }

  @override
  void onClickPayment() {
    try {
      // OrderBooking orderBooking =
      //     Provider.of<OrderBooking>(context, listen: false);

      // Users users = Provider.of<Users>(context, listen: false);
      // if (_model.currentIndexPaymentMethod == PAYMENT_METHOD.cash) {
      //   orderBooking.setOrderBooking(
      //       orderBooking: orderBooking.copyWith(isPaid: false));
      //   bool isSuccess = await _presenter.createOrder(orderBooking, users);

      //   if (isSuccess) {
      //     orderBooking.setOrderBooking(
      //         orderBooking: OrderBooking.empty(TypeOrder.doorToDoor));
      //     CustomSnackBar.buildErrorSnackbar(
      //         context: context,
      //         message: 'Create order success',
      //         color: CustomColor.green);
      //     Navigator.of(context).pushAndRemoveUntil(
      //         MaterialPageRoute(
      //             builder: (context) => const CustomBottomNavigation(
      //                   listIndexStack: [
      //                     MyAccountScreen(),
      //                     CartScreen(),
      //                     NotificationDeliveryScreen(),
      //                   ],
      //                   listNavigator:
      //                       constants.LIST_CUSTOMER_BOTTOM_NAVIGATION,
      //                 )),
      //         (Route<dynamic> route) => false);
      //   }
      // } else {
      //   orderBooking.setOrderBooking(
      //       orderBooking: orderBooking.copyWith(isPaid: true));
      //   var request = BraintreeDropInRequest(
      //       tokenizationKey: 'sandbox_x62jjpjk_n5rdrcwx7kv3ppb7',
      //       collectDeviceData: true,
      //       paypalRequest: BraintreePayPalRequest(
      //           currencyCode: 'VND',
      //           amount: orderBooking.totalPrice.toString(),
      //           displayName: users.name));
      //   BraintreeDropInResult? result = await BraintreeDropIn.start(request);
      //   if (result != null) {
      //     bool isSuccess = await _presenter.createOrder(orderBooking, users);

      //     if (isSuccess) {
      //       orderBooking.setOrderBooking(
      //           orderBooking: OrderBooking.empty(TypeOrder.doorToDoor));
      //       CustomSnackBar.buildErrorSnackbar(
      //           context: context,
      //           message: 'Create order success',
      //           color: CustomColor.green);
      //       Navigator.of(context).pushAndRemoveUntil(
      //           MaterialPageRoute(
      //               builder: (context) => const CustomBottomNavigation(
      //                     listIndexStack: [
      //                       MyAccountScreen(),
      //                       CartScreen(),
      //                       NotificationDeliveryScreen(),
      //                     ],
      //                     listNavigator:
      //                         constants.LIST_CUSTOMER_BOTTOM_NAVIGATION,
      //                   )),
      //           (Route<dynamic> route) => false);
      //     }
      //   }
      // }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
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
                              textAlign: TextAlign.right,
                              fontWeight: FontWeight.bold,
                              context: context,
                              fontSize: 14),
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
                            text: oCcy.format(totalProduct).toString() + " đ",
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
                        QuantityWidgetCustom(
                          quantity: durationMonth,
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
                            text: oCcy
                                    .format((totalProduct * durationMonth!))
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
                      text: widget.invoice!.returnDate.substring(
                          0, widget.invoice!.returnDate.indexOf("T")),
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
                  SizedBox(
                    width: deviceSize.width * 1.3 / 3,
                    child: CustomText(
                      text: "Ngày trả kho sau khi gia hạn",
                      color: CustomColor.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      maxLines: 2,
                      fontSize: 18,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  CustomText(
                      text: returnDateNew
                          .toString()
                          .substring(0, returnDateNew.toString().indexOf(" ")),
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
          child: Column(
            children: [
              CustomRadioButton(
                  function: () {
                    setState(() {
                      _state = PaymentMethod.tienmat;
                    });
                  },
                  text: "Thanh toán tiền mặt",
                  color: _state == PaymentMethod.tienmat
                      ? CustomColor.blue
                      : CustomColor.white,
                  state: PaymentMethod.tienmat,
                  value: _state),
              CustomRadioButton(
                  function: () {
                    setState(() {
                      _state = PaymentMethod.mbanking;
                    });
                  },
                  text: "Ứng dụng Mobile Banking",
                  color: _state == PaymentMethod.mbanking
                      ? CustomColor.blue
                      : CustomColor.white,
                  state: PaymentMethod.mbanking,
                  value: _state),
              CustomRadioButton(
                  function: () {
                    setState(() {
                      _state = PaymentMethod.theatm;
                    });
                  },
                  text: "Thẻ ATM và tài khoản ngân hàng",
                  color: _state == PaymentMethod.theatm
                      ? CustomColor.blue
                      : CustomColor.white,
                  state: PaymentMethod.theatm,
                  value: _state),
              CustomRadioButton(
                function: () {
                  setState(() {
                    _state = PaymentMethod.quocte;
                  });
                },
                text: "Thẻ thanh toán quốc tế",
                color: _state == PaymentMethod.quocte
                    ? CustomColor.blue
                    : CustomColor.white,
                state: PaymentMethod.quocte,
                value: _state,
              ),
              CustomRadioButton(
                function: () {
                  setState(() {
                    _state = PaymentMethod.vidientu;
                  });
                },
                text: "Ví điện tử",
                color: _state == PaymentMethod.vidientu
                    ? CustomColor.blue
                    : CustomColor.white,
                state: PaymentMethod.vidientu,
                value: _state,
              ),
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
              height: 24,
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
