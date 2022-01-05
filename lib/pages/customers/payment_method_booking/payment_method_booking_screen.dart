import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_bottom_navigation.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_radio_button.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/pages/customers/cart/cart_screen.dart';
import 'package:rssms/pages/customers/my_account/my_account.dart';
import 'package:rssms/pages/delivery_staff/notifcation/notification_delivery.dart';
import 'package:rssms/views/payment_method_booking_screen_view.dart';
import '../../../constants/constants.dart' as constants;

enum PAYMENT_METHOD { cash, paypal }

class PaymentMethodBookingScreen extends StatefulWidget {
  const PaymentMethodBookingScreen({Key? key}) : super(key: key);

  @override
  _PaymentMethodBookingScreenState createState() =>
      _PaymentMethodBookingScreenState();
}

class _PaymentMethodBookingScreenState extends State<PaymentMethodBookingScreen>
    implements PaymentMethodBookingScreenView {
  final _controllerNote = TextEditingController();
  PAYMENT_METHOD currentIndexPaymentMethod = PAYMENT_METHOD.cash;

  @override
  void onClickPayment() {
    OrderBooking orderBooking =
        Provider.of<OrderBooking>(context, listen: false);
    Users users = Provider.of<Users>(context, listen: false);
    if (currentIndexPaymentMethod == PAYMENT_METHOD.cash) {
      orderBooking.setOrderBooking(
          orderBooking: orderBooking.copyWith(isPaid: false));
    } else {
      orderBooking.setOrderBooking(
          orderBooking: orderBooking.copyWith(isPaid: true));
    }
    // var request = BraintreeDropInRequest(
    //     tokenizationKey: 'sandbox_x62jjpjk_n5rdrcwx7kv3ppb7',
    //     collectDeviceData: true,
    //     paypalRequest: BraintreePayPalRequest(
    //         currencyCode: 'VND',
    //         // amount: presenter.model.totalPrice.toString(),
    //         displayName: users.name));
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(
    //         builder: (context) => const CustomBottomNavigation(
    //               listIndexStack: [
    //                 MyAccountScreen(),
    //                 CartScreen(),
    //                 NotificationDeliveryScreen(),
    //               ],
    //               listNavigator: constants.LIST_CUSTOMER_BOTTOM_NAVIGATION,
    //             )),
    //     (Route<dynamic> route) => false);
  }

  List<Widget> _buildListDropDownPaymentMethods() {
    return constants.LIST_PAYMENT_METHOD_CHOICES
        .map((e) => CustomRadioButton(
            function: () {
              setState(() {
                currentIndexPaymentMethod = e['value'];
              });
            },
            text: e['name'],
            color: currentIndexPaymentMethod == e['value']
                ? CustomColor.blue
                : CustomColor.white,
            state: currentIndexPaymentMethod,
            value: e['value']))
        .toList();
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
              Column(
                children: _buildListDropDownPaymentMethods(),
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              CustomText(
                  text: 'Ghi chú',
                  color: CustomColor.blue,
                  fontWeight: FontWeight.bold,
                  context: context,
                  fontSize: 24),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: CustomColor.black[3]!, width: 1)),
                child: TextFormField(
                  minLines: 6,
                  controller: _controllerNote,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: CustomButton(
                      height: 24,
                      text: 'Tiếp theo',
                      width: deviceSize.width * 1.2 / 3,
                      onPressFunction: () {
                        onClickPayment();
                      },
                      isLoading: false,
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
