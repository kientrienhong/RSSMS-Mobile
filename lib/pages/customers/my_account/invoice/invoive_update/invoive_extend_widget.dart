import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_bottom_navigation.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/helpers/date_format.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/invoice_extends_model.dart';
import 'package:rssms/pages/customers/cart/cart_screen.dart';
import 'package:rssms/pages/customers/cart/widgets/quantity_widget_custom.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/product_in_invoice/product_widget.dart';
import 'package:rssms/pages/customers/my_account/my_account.dart';
import 'package:rssms/pages/delivery_staff/notifcation/notification_delivery.dart';
import 'package:rssms/presenters/invoice_extend_presenter.dart';
import 'package:rssms/views/extend_invoice_view.dart';
import 'package:rssms/constants/constants.dart' as constants;

class InvoiveExtendWidget extends StatefulWidget {
  final Invoice? invoice;

  const InvoiveExtendWidget({Key? key, required this.invoice})
      : super(key: key);

  @override
  State<InvoiveExtendWidget> createState() => _InvoiveExtendWidgetState();
}

enum PaymentMethod { tienmat, mbanking, trong }

class _InvoiveExtendWidgetState extends State<InvoiveExtendWidget>
    implements ExtendInvoiceView {
  final oCcy = NumberFormat("#,##0", "en_US");
  int? durationMonth;
  int totalProduct = 0;
  late InvoiceExtendPresenter _presenter;
  late InvoiceExtendsModel _model;
  List<OrderDetail>? listProduct;
  DateTime? returnDateNew;
  DateTime? returnDateOld;
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
            element.productType == constants.typeProduct.handy.index ||
            element.productType == constants.typeProduct.unweildy.index ||
            element.productType == constants.typeProduct.selfStorage.index)
        .toList();
    for (var element in listProduct!) {
      totalProduct += (element.price * element.amount);
    }
    durationMonth = 1;
    returnDateOld = DateTime.parse(widget.invoice!.returnDate
        .substring(0, widget.invoice!.returnDate.indexOf("T")));
    returnDateNew = DateTime(
        returnDateOld!.year, returnDateOld!.month + 1, returnDateOld!.day);

    _presenter = InvoiceExtendPresenter();
    _model = _presenter.model!;
    _presenter.view = this;
    super.initState();
  }

  @override
  void onClickPayment() async {
    try {
      if (widget.invoice!.typeOrder == constants.doorToDoorTypeOrder &&
          _model.dateExtensionString.isEmpty) {
        updateError('Vui l??ng ch???n ng??y mu???n gia h???n');
        return;
      }

      Map<String, dynamic> extendInvoice = {
        "oldReturnDate": returnDateOld,
        "newReturnDate":
            widget.invoice!.typeOrder == constants.doorToDoorTypeOrder
                ? _model.dateExtension
                : returnDateNew,
        // "cancelDay": returnDateNew,
        "orderId": widget.invoice!.id,
        "type": 2,
        "status": 1,
        "typeOrder": widget.invoice!.typeOrder,
        "note": "",
        "totalPrice": totalProduct * durationMonth!
      };
      Users users = Provider.of<Users>(context, listen: false);

      var request = BraintreeDropInRequest(
          tokenizationKey: 'sandbox_x62jjpjk_n5rdrcwx7kv3ppb7',
          collectDeviceData: true,
          paypalRequest: BraintreePayPalRequest(
              currencyCode: 'VND',
              amount: (totalProduct * durationMonth!).toString(),
              displayName: users.name));
      BraintreeDropInResult? result = await BraintreeDropIn.start(request);
      if (result != null) {
        bool isSuccess = await _presenter.createRequest(
            {...extendInvoice, "isPaid": true}, users, widget.invoice!);

        if (isSuccess) {
          CustomSnackBar.buildSnackbar(
              context: context,
              message: 'Gia h???n ????n h??ng th??nh c??ng',
              color: CustomColor.green);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const CustomBottomNavigation(
                        listIndexStack: [
                          MyAccountScreen(
                            initIndex: 2,
                          ),
                          CartScreen(),
                          NotificationDeliveryScreen(),
                        ],
                        listNavigator: constants.listCustomerBottomNavigation,
                      )),
              (Route<dynamic> route) => false);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void updateError(String error) {
    setState(() {
      _model.error = error;
    });
  }

  @override
  void onClickChangeDate() async {
    DateTime? date = DateTime(1900);
    // FocusScope.of(context).requestFocus(FocusNode());
    date = await showDatePicker(
      context: context,
      initialDate: DateFormat("yyyy-MM-dd")
          .parse(widget.invoice!.returnDate.split('T')[0]),
      firstDate: DateFormat("yyyy-MM-dd")
          .parse(widget.invoice!.returnDate.split('T')[0]),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      DateTime dateStart = DateFormat("yyyy-MM-dd")
          .parse(widget.invoice!.returnDate.split('T')[0]);

      setState(() {
        _model.dateExtensionString = DateFormat("dd/MM/yyyy").format(date!);
        _model.dateExtension = date;
        durationMonth = (date.difference(dateStart).inDays / 30).ceil();
      });
    }
  }

  @override
  void updateLoading() {
    setState(() {
      _model.isLoading = !_model.isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: "????n h??ng c???a b???n",
                color: CustomColor.blue,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 24),
            CustomSizedBox(
              context: context,
              height: 14,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                            text: "S???n ph???m",
                            color: CustomColor.black,
                            fontWeight: FontWeight.bold,
                            context: context,
                            fontSize: 14),
                        CustomText(
                            text: "S??? l?????ng",
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
                          text: "T???m t??nh",
                          color: Colors.black,
                          context: context,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      CustomText(
                          text: oCcy.format(totalProduct).toString() + " ??",
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
                  widget.invoice!.typeOrder == constants.doorToDoorTypeOrder
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: "S??? ng??y mu???n gia h???n",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            GestureDetector(
                              onTap: () {
                                onClickChangeDate();
                              },
                              child: Row(
                                children: [
                                  CustomText(
                                      text: _model.dateExtension != null
                                          ? _model.dateExtension!
                                                  .difference(
                                                      DateFormat("yyyy-MM-dd")
                                                          .parse(widget.invoice!
                                                              .returnDate
                                                              .split('T')[0]))
                                                  .inDays
                                                  .toString() +
                                              ' ng??y '
                                          : '0 ng??y',
                                      color: CustomColor.blue,
                                      context: context,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  CustomSizedBox(
                                    context: context,
                                    width: 8,
                                  ),
                                  Image.asset('assets/images/calendar.png'),
                                ],
                              ),
                            )
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: "S??? th??ng mu???n gia h???n",
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
                          text: "T???ng ti???n",
                          color: Colors.black,
                          context: context,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      CustomText(
                          text: oCcy
                                  .format((totalProduct * durationMonth!))
                                  .toString() +
                              " ??",
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
                    text: "Ng??y k???t th??c",
                    color: Colors.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                CustomText(
                    text: DateFormat("dd/MM/yyyy").format(
                        DateFormat("yyyy-MM-dd")
                            .parse(widget.invoice!.returnDate)),
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
                    text: "Ng??y k???t th??c sau khi gia h???n",
                    color: CustomColor.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    maxLines: 2,
                    fontSize: 18,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ),
                widget.invoice!.typeOrder == constants.doorToDoorTypeOrder
                    ? CustomText(
                        text: _model.dateExtensionString.isEmpty
                            ? 'Ch??a c??'
                            : _model.dateExtensionString,
                        color: CustomColor.black,
                        context: context,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)
                    : CustomText(
                        text: DateFormatHelper.formatToVNDay(
                            returnDateNew.toString()),
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
                text: "Ph????ng th???c thanh to??n",
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

        CustomSizedBox(
          context: context,
          height: 14,
        ),

        CustomText(
            text:
                'L??u ??: Y??u c???u gia h???n ????n, ch??ng t??i ch??? nh???n thanh to??n chuy???n kho???n',
            color: CustomColor.blue,
            context: context,
            maxLines: 2,
            fontWeight: FontWeight.bold,
            fontSize: 16),

        CustomSizedBox(
          context: context,
          height: 14,
        ),

        if (_model.error.isNotEmpty)
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            CustomText(
                text: _model.error,
                color: CustomColor.red,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            CustomSizedBox(
              context: context,
              height: 8,
            )
          ]),
        GestureDetector(
          onTap: () {
            onClickPayment();
          },
          child: Container(
            width: double.infinity,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: CustomColor.lightBlue,
              borderRadius: BorderRadius.circular(4),
            ),
            child: _model.isLoading
                ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Center(
                    child: SizedBox(
                        height: 40,
                        child: Image.asset('assets/images/paypal.png'))),
          ),
        )
        // Container(
        //   child: CustomButton(
        //       height: 24,
        //       isLoading: _model.isLoading,
        //       text: 'Thanh to??n',
        //       textColor: CustomColor.white,
        //       onPressFunction: () {
        //         onClickPayment();
        //       },
        //       width: deviceSize.width,
        //       buttonColor: CustomColor.blue,
        //       borderRadius: 6),
        // ),
      ],
    );
  }
}
