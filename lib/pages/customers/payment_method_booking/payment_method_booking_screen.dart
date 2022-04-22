import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_bottom_navigation.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_radio_button.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/payment_method_booking_screen_model.dart';
import 'package:rssms/pages/customers/cart/cart_screen.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_product_widget.dart';
import 'package:rssms/pages/customers/my_account/my_account.dart';
import 'package:rssms/pages/delivery_staff/notifcation/notification_delivery.dart';
import 'package:rssms/presenters/payment_method_booking_screen_presenter.dart';
import 'package:rssms/utils/ui_utils.dart';
import 'package:rssms/views/payment_method_booking_screen_view.dart';
import '../../../constants/constants.dart' as constants;
import 'package:flutter_braintree/flutter_braintree.dart';

enum PAYMENT_METHOD { cash, paypal }

class PaymentMethodBookingScreen extends StatefulWidget {
  const PaymentMethodBookingScreen({Key? key}) : super(key: key);

  @override
  _PaymentMethodBookingScreenState createState() =>
      _PaymentMethodBookingScreenState();
}

class _PaymentMethodBookingScreenState extends State<PaymentMethodBookingScreen>
    implements PaymentMethodBookingScreenView {
  late PaymentMethodBookingScreenPresenter _presenter;
  late PaymentMethodBookingScreenModel _model;

  @override
  void initState() {
    super.initState();
    _presenter = PaymentMethodBookingScreenPresenter();
    _model = _presenter.model;
    _presenter.view = this;
    _presenter.view.formatDataDisplayInvoice();
  }

  @override
  void updateLoading() {
    setState(() {
      _model.isLoading = !_model.isLoading;
    });
  }

  @override
  void updateError(String error) {
    setState(() {
      _model.error = error;
    });
  }

  @override
  void onClickPayment() async {
    try {
      OrderBooking orderBooking =
          Provider.of<OrderBooking>(context, listen: false);

      Users users = Provider.of<Users>(context, listen: false);
      if (_model.currentIndexPaymentMethod == PAYMENT_METHOD.cash) {
        orderBooking.setOrderBooking(
            orderBooking: orderBooking.copyWith(isPaid: false));
        bool isSuccess = await _presenter.createOrder(orderBooking, users);

        if (isSuccess) {
          orderBooking.setOrderBooking(
              orderBooking: OrderBooking.empty(TypeOrder.doorToDoor));
          CustomSnackBar.buildSnackbar(
              context: context,
              message: 'Tạo yêu cầu đặt đơn hàng thành công',
              color: CustomColor.green);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const CustomBottomNavigation(
                        listIndexStack: [
                          MyAccountScreen(initIndex: 2),
                          CartScreen(),
                          NotificationDeliveryScreen(),
                        ],
                        listNavigator: constants.listCustomerBottomNavigation,
                      )),
              (Route<dynamic> route) => false);
        }
      } else {
        orderBooking.setOrderBooking(
            orderBooking: orderBooking.copyWith(isPaid: true));
        bool isSuccess = await _presenter.createOrder(orderBooking, users);
        if (isSuccess) {
          var request = BraintreeDropInRequest(
            tokenizationKey: 'sandbox_x62jjpjk_n5rdrcwx7kv3ppb7',
            collectDeviceData: true,
            paypalRequest: BraintreePayPalRequest(
              currencyCode: 'VND',
              amount: (orderBooking.totalPrice / 2).toString(),
              displayName: users.name,
            ),
          );
          BraintreeDropInResult? result = await BraintreeDropIn.start(request);
          if (result != null) {
            orderBooking.setOrderBooking(
                orderBooking: OrderBooking.empty(TypeOrder.doorToDoor));
            CustomSnackBar.buildSnackbar(
                context: context,
                message: 'Tạo yêu cầu đặt đơn hàng thành công',
                color: CustomColor.green);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => const CustomBottomNavigation(
                          listIndexStack: [
                            MyAccountScreen(initIndex: 2),
                            CartScreen(),
                            NotificationDeliveryScreen(),
                          ],
                          listNavigator: constants.listCustomerBottomNavigation,
                        )),
                (Route<dynamic> route) => false);
          } else {
            bool isSuccess = await _presenter.cancelRequest(_model.request,
                users, constants.createRequestCreatingError['paymentfail']!);
            if (isSuccess) {
              CustomSnackBar.buildSnackbar(
                  context: context,
                  message: 'Tạo yêu cầu đặt đơn hàng không thành công',
                  color: CustomColor.red);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const CustomBottomNavigation(
                            listIndexStack: [
                              MyAccountScreen(initIndex: 2),
                              CartScreen(),
                              NotificationDeliveryScreen(),
                            ],
                            listNavigator:
                                constants.listCustomerBottomNavigation,
                          )),
                  (Route<dynamic> route) => false);
            }
          }
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void formatDataDisplayInvoice() {
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);

    _presenter.formatDisplayInvoice(orderBooking);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(
                isHome: false,
                name: '',
              ),
              CustomText(
                  text: 'Phương thức thanh toán',
                  color: CustomColor.blue,
                  fontWeight: FontWeight.bold,
                  context: context,
                  fontSize: 24),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              CustomRadioButton(
                  function: () {
                    setState(() {
                      _model.currentIndexPaymentMethod =
                          constants.listPaymentMethodChoices[0]['value'];
                    });
                  },
                  text: constants.listPaymentMethodChoices[0]['name'],
                  color: _model.currentIndexPaymentMethod ==
                          constants.listPaymentMethodChoices[0]['value']
                      ? CustomColor.blue
                      : CustomColor.white,
                  state: _model.currentIndexPaymentMethod,
                  value: constants.listPaymentMethodChoices[0]['value']),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              CustomText(
                  text: 'Thông tin chi tiết đơn hàng',
                  color: CustomColor.blue,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              CustomSizedBox(
                context: context,
                height: 24,
              ),
              InvoiceProductWidget(
                  deviceSize: deviceSize, invoice: _model.invoiceDisplay),
              CustomSizedBox(
                context: context,
                height: 24,
              ),
              UIUtils.buildErrorUI(error: _model.error, context: context),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: CustomButton(
                      height: 24,
                      text: 'Tạo yêu cầu đặt đơn',
                      width: deviceSize.width * 2 / 3,
                      onPressFunction: () {
                        onClickPayment();
                      },
                      isLoading: _model.isLoading,
                      textColor: CustomColor.white,
                      buttonColor: CustomColor.blue,
                      borderRadius: 6),
                ),
              ),
              CustomSizedBox(
                context: context,
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
