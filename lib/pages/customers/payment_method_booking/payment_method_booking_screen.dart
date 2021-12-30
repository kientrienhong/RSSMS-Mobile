import 'package:flutter/material.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_bottom_navigation.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_radio_button.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/pages/customers/cart/cart_screen.dart';
import 'package:rssms/pages/customers/my_account/my_account.dart';
import 'package:rssms/pages/delivery_staff/notifcation/notification_delivery.dart';
import '../../../constants/constants.dart' as constants;

enum PAYMENT_METHOD { cash, mobileBanking, ATM, visa, eWallet }
enum PAYMENT_EACH_MONTHS_METHODS { YES, NO }

class PaymentMethodBookingScreen extends StatefulWidget {
  const PaymentMethodBookingScreen({Key? key}) : super(key: key);

  @override
  _PaymentMethodBookingScreenState createState() =>
      _PaymentMethodBookingScreenState();
}

class _PaymentMethodBookingScreenState
    extends State<PaymentMethodBookingScreen> {
  final _controllerNote = TextEditingController();

  PAYMENT_METHOD currentIndexPaymentMethod = PAYMENT_METHOD.cash;
  PAYMENT_EACH_MONTHS_METHODS currentIndexPaymentEachMonthsMethods =
      PAYMENT_EACH_MONTHS_METHODS.YES;
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

  List<Widget> _buildListDropDownPaymentMonths() {
    return constants.LIST_PAYMENT_EACH_MONTH_CHOICES
        .map((e) => CustomRadioButton(
            function: () {
              setState(() {
                currentIndexPaymentEachMonthsMethods = e['value'];
              });
            },
            text: e['name'],
            color: currentIndexPaymentEachMonthsMethods == e['value']
                ? CustomColor.blue
                : CustomColor.white,
            state: currentIndexPaymentEachMonthsMethods,
            value: e['value']))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(isHome: false),
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
              CustomText(
                  text: 'Thanh toán theo từng tháng',
                  color: CustomColor.blue,
                  fontWeight: FontWeight.bold,
                  context: context,
                  fontSize: 24),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              Column(
                children: _buildListDropDownPaymentMonths(),
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
              Container(
                width: double.infinity,
                child: Center(
                  child: CustomButton(
                      height: 24,
                      text: 'Tiếp theo',
                      width: deviceSize.width * 1.2 / 3,
                      onPressFunction: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CustomBottomNavigation(
                                      listIndexStack: [
                                        MyAccountScreen(),
                                        CartScreen(),
                                        NotificationDeliveryScreen(),
                                      ],
                                      listNavigator: constants
                                          .LIST_CUSTOMER_BOTTOM_NAVIGATION,
                                    )),
                            (Route<dynamic> route) => false);

                        // Navigator.pushAndRemoveUntil(
                        //     MaterialPageRoute(
                        //         builder: (context) => LoginScreen()),
                        //     (Route<dynamic> route) => false);
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
