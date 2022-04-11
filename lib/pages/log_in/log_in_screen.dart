import 'package:provider/provider.dart';
import 'package:rssms/constants/constants.dart' as constant;
import 'package:rssms/common/custom_bottom_navigation.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/pages/customers/cart/cart_screen.dart';
import 'package:rssms/pages/customers/my_account/my_account.dart';
import 'package:rssms/pages/customers/notification/notification_screen.dart';
import 'package:rssms/pages/delivery_staff/delivery/delivery_screen.dart';
import 'package:rssms/pages/delivery_staff/my_account/my_account_delivery.dart';
import 'package:rssms/pages/delivery_staff/notifcation/notification_delivery.dart';
import 'package:rssms/pages/delivery_staff/qr/qr_screen.dart';
import 'package:rssms/pages/no_permission/no_permission.dart';
import 'package:rssms/pages/office_staff/my_account/my_account_office.dart';
import 'package:rssms/pages/sign_up/sign_up_screen.dart';
import '/common/background.dart';
import '/common/custom_button.dart';
import '/common/custom_color.dart';
import '/common/custom_input.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import '/models/login_model.dart';
import '/presenters/login_presenters.dart';
import '/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: CustomColor.white,
        body: SingleChildScrollView(
          child: SizedBox(
            width: deviceSize.width,
            height: deviceSize.height,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Background(),
                SizedBox(
                  width: deviceSize.width,
                  height: deviceSize.height,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      CustomSizedBox(
                        context: context,
                        height: 120,
                      ),
                      Image.asset('assets/images/logo.png'),
                      CustomSizedBox(
                        context: context,
                        height: 56,
                      ),
                      FormLogIn(deviceSize: deviceSize),
                    ],
                  ),
                ),
                Positioned.fill(
                  bottom: 24,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: deviceSize.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                              text: 'Chưa có tài khoản?',
                              color: CustomColor.black,
                              context: context,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          CustomSizedBox(
                            context: context,
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()),
                              );
                            },
                            child: CustomText(
                                text: 'Đăng ký',
                                color: CustomColor.purple,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class FormLogIn extends StatefulWidget {
  final Size deviceSize;
  const FormLogIn({Key? key, required this.deviceSize}) : super(key: key);

  @override
  _FormLogInState createState() => _FormLogInState();
}

class _FormLogInState extends State<FormLogIn> implements LoginView {
  late LoginPresenter loginPresenter;
  late FirebaseMessaging _firebaseMessaging;
  late LoginModel _model;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging = FirebaseMessaging.instance;
    loginPresenter = LoginPresenter();
    loginPresenter.setView(this);
    _model = loginPresenter.model;
    _model.controllerEmail.addListener(onChangeInput);
    _model.controllerPassword.addListener(onChangeInput);
    firebaseCloudMessagingListeners();
  }

  void firebaseCloudMessagingListeners() {
    _firebaseMessaging.getToken().then((token) {
      _model.deviceToken = token!;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // RemoteNotification notification = message.notification!;
      // AndroidNotification? android = message.notification?.android;
    });
  }

  @override
  void onChangeInput() {
    loginPresenter.handleOnChangeInput(
        _model.controllerEmail.text, _model.controllerPassword.text);
  }

  @override
  void onClickSignIn() async {
    Users user = Provider.of<Users>(context, listen: false);

    final result = await loginPresenter.handleSignIn();
    if (result != null) {
      user.setUser(user: result);
      if (user.roleName == 'Customer') {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const CustomBottomNavigation(
                    listIndexStack: [
                      MyAccountScreen(),
                      CartScreen(),
                      NotificationScreen(),
                    ],
                    listNavigator: constant.LIST_CUSTOMER_BOTTOM_NAVIGATION,
                  )),
        );
      } else if (user.roleName == 'Delivery Staff') {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const CustomBottomNavigation(
                    listIndexStack: [
                      MyAccountDeliveryScreen(),
                      DeliveryScreen(),
                      QrScreen(),
                      NotificationDeliveryScreen(),
                    ],
                    listNavigator: constant.LIST_DELIVERY_BOTTOM_NAVIGATION,
                  )),
        );
      } else if (user.roleName == 'Office Staff') {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const CustomBottomNavigation(
                    listIndexStack: [
                      MyAccountOfficeScreen(),
                      QrScreen(),
                    ],
                    listNavigator: constant.LIST_OFFICE_BOTTOM_NAVIGATION,
                  )),
        );
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const NoPermissionScreen()));
      }
    }
  }

  @override
  updateLoading() {
    if (mounted) {
      setState(() {
        _model.isLoading = !_model.isLoading;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    loginPresenter.dispose();
  }

  @override
  void updateViewStatusButton(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      setState(() {
        _model.isDisableLogin = false;
      });
    } else {
      setState(() {
        _model.isDisableLogin = true;
      });
    }
  }

  @override
  void updateViewErrorMsg(String error) {
    setState(() {
      _model.errorMsg = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomOutLineInput(
            deviceSize: widget.deviceSize,
            labelText: 'Email',
            isDisable: false,
            focusNode: _model.focusNodeEmail,
            nextNode: _model.focusNodePassword,
            controller: _model.controllerEmail,
          ),
          CustomOutLineInput(
            deviceSize: widget.deviceSize,
            labelText: 'Mật khẩu',
            isDisable: false,
            isSecure: true,
            focusNode: _model.focusNodePassword,
            controller: _model.controllerPassword,
          ),
          if (_model.errorMsg.isNotEmpty)
            SizedBox(
              width: double.infinity,
              child: CustomText(
                text: _model.errorMsg,
                color: CustomColor.red,
                context: context,
                textAlign: TextAlign.center,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          CustomSizedBox(
            context: context,
            height: 24,
          ),
          CustomButton(
              height: 24,
              isLoading: _model.isLoading,
              text: 'Đăng nhập',
              width: deviceSize.width,
              textColor: CustomColor.white,
              onPressFunction:
                  _model.isDisableLogin == false ? () => onClickSignIn() : null,
              buttonColor: _model.isDisableLogin == false
                  ? CustomColor.purple
                  : CustomColor.black[3],
              borderRadius: 6),
        ],
      ),
    );
  }
}
