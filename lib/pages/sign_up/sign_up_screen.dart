import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_input_date.dart';
import 'package:rssms/common/custom_radio_button.dart';
import 'package:rssms/helpers/validator.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/role_model.dart';
import 'package:rssms/models/signup_model.dart';
import 'package:rssms/common/custom_bottom_navigation.dart';
import 'package:rssms/pages/customers/cart/cart_screen.dart';
import 'package:rssms/pages/customers/my_account/my_account.dart';
import 'package:rssms/pages/customers/notification/notification_screen.dart';
import 'package:rssms/presenters/role_presenter.dart';
import 'package:rssms/presenters/signup_presenters.dart';
import 'package:rssms/views/signup_view.dart';
import 'package:rssms/constants/constants.dart' as constant;
import '/common/background.dart';
import '/common/custom_color.dart';
import '/common/custom_input.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: CustomColor.white,
        body: SingleChildScrollView(
          child: SizedBox(
            width: deviceSize.width,
            height: deviceSize.height * 1.8,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Background(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: GestureDetector(
                    onTap: () => {Navigator.of(context).pop()},
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Image.asset('assets/images/arrowLeft.png'),
                    ),
                  ),
                ),
                SizedBox(
                  width: deviceSize.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      Expanded(child: FormSignUp(deviceSize)),
                      CustomSizedBox(
                        context: context,
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class FormSignUp extends StatefulWidget {
  final Size deviceSize;
  const FormSignUp(this.deviceSize, {Key? key}) : super(key: key);

  @override
  _FormSignUpState createState() => _FormSignUpState();
}

class _FormSignUpState extends State<FormSignUp> implements SignUpView {
  late SignUpPresenter signupPresenter;
  late RolePresenter rolePresenter;
  late FirebaseMessaging _firebaseMessaging;
  String? _token;
  late SignUpModel _model;
  RoleModel? _roleModel;
  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();
  final _focusNodeConfirmPassword = FocusNode();
  final _focusNodeAddress = FocusNode();
  final _focusNodePhone = FocusNode();
  final _focusNodeName = FocusNode();
  final _focusNodeBirthDate = FocusNode();

  int _gender = 0;

  String get _email => _model.controllerEmail.text;
  String get _password => _model.controllerPassword.text;
  String get _confirmPassword => _model.controllerConfirmPassword.text;
  String get _phone => _model.controllerPhone.text;
  String get _name => _model.controllerName.text;
  String get _address => _model.controllerAddress.text;
  String get _birthdate => _model.controllerBirthDate.text;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging = FirebaseMessaging.instance;
    firebaseCloudMessagingListeners();
    signupPresenter = SignUpPresenter();
    rolePresenter = RolePresenter();
    _roleModel = rolePresenter.model;
    signupPresenter.setView(this);
    rolePresenter.loadListRole();
    _model = signupPresenter.model;
    _model.controllerEmail.addListener(onChangeInput);
    _model.controllerPassword.addListener(onChangeInput);
    _model.controllerConfirmPassword.addListener(onChangeInput);
    _model.controllerPhone.addListener(onChangeInput);
    _model.controllerName.addListener(onChangeInput);
    _model.controllerBirthDate.addListener(onChangeInput);
  }

  void firebaseCloudMessagingListeners() {
    _firebaseMessaging.getToken().then((token) {
      _token = token!;
    });
    print(_token);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android;
    });
  }

  @override
  void onChangeInput() {
    signupPresenter.handleOnChangeInput(_email, _password, _confirmPassword,
        _address, _name, _phone, _birthdate);
  }

  @override
  void onClickSignUp(String email, String password, String confirmPassword,
      String address, String name, String phone, String birthDay) async {
    _model.errorMsg = "";
    try {
      Users user = Users.register(
          address: address,
          birthDate: DateFormat('dd/MM/yyyy').parse(birthDay),
          email: email,
          gender: _gender,
          name: name,
          phone: phone);
      Users result =
          await signupPresenter.handleSignUp(user, password, _token!, _roleModel!.role!.id);

      if (result != null) {
        Users user = Provider.of<Users>(context, listen: false);
        user.setUser(user: user);

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
      }
    } catch (e) {
      print(e.toString());
      signupPresenter.view
          .updateViewErrorMsg("Đã có lỗi xảy ra, vui lòng thử lại sau!");
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
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeConfirmPassword.dispose();
    _focusNodeName.dispose();
    _focusNodeBirthDate.dispose();
    _focusNodePhone.dispose();
  }

  @override
  void updateViewStatusButton(
      String email,
      String password,
      String confirmPassword,
      String address,
      String name,
      String phone,
      String birthDay) {
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        address.isNotEmpty &&
        name.isNotEmpty &&
        phone.isNotEmpty &&
        birthDay.isNotEmpty) {
      setState(() {
        _model.isDisableSignup = false;
      });
    } else {
      setState(() {
        _model.isDisableSignup = true;
      });
    }
  }

  @override
  void updateViewErrorMsg(String error) {
    setState(() {
      _model.errorMsg = error;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomOutLineInput(
              deviceSize: widget.deviceSize,
              labelText: 'Họ và tên',
              isDisable: false,
              focusNode: _focusNodeName,
              nextNode: _focusNodeBirthDate,
              validator: Validator.checkFullname,
              controller: _model.controllerName,
            ),
            CustomText(
                text: "Giới Tính",
                color: CustomColor.black,
                fontWeight: FontWeight.bold,
                context: context,
                fontSize: 16),
            CustomSizedBox(context: context, height: 8),
            CustomRadioButton(
                function: () {
                  setState(() => _gender = 0);
                },
                text: "Nam",
                color: _gender == 0 ? CustomColor.blue : CustomColor.white,
                state: _gender,
                value: 0),
            CustomRadioButton(
                function: () {
                  setState(() => _gender = 1);
                },
                text: "Nữ",
                color: _gender == 1 ? CustomColor.blue : CustomColor.white,
                state: _gender,
                value: 1),
            CustomRadioButton(
                function: () {
                  setState(() => _gender = 2);
                },
                text: "Khác",
                color: _gender == 2 ? CustomColor.blue : CustomColor.white,
                state: _gender,
                value: 2),
            SizedBox(
              width: widget.deviceSize.width / 2.5,
              child: CustomOutLineInputDateTime(
                deviceSize: widget.deviceSize,
                labelText: 'Năm sinh',
                isDisable: false,
                focusNode: _focusNodeBirthDate,
                nextNode: _focusNodeEmail,
                controller: _model.controllerBirthDate,
                icon: "assets/images/calendar.png",
              ),
            ),
            CustomOutLineInput(
              deviceSize: widget.deviceSize,
              labelText: 'Email',
              isDisable: false,
              focusNode: _focusNodeEmail,
              validator: Validator.checkEmail,
              controller: _model.controllerEmail,
              nextNode: _focusNodePhone,
            ),
            CustomOutLineInput(
              deviceSize: widget.deviceSize,
              labelText: 'Số điện thoại',
              isDisable: false,
              textInputType: TextInputType.number,
              focusNode: _focusNodePhone,
              controller: _model.controllerPhone,
              validator: (value) {
              
              },
              nextNode: _focusNodeAddress,
            ),
            CustomOutLineInput(
                deviceSize: widget.deviceSize,
                labelText: 'Địa chỉ',
                isDisable: false,
                focusNode: _focusNodeAddress,
                controller: _model.controllerAddress,
                nextNode: _focusNodePassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Vui lòng nhập địa chỉ.";
                  }
                }),
            CustomOutLineInput(
              deviceSize: widget.deviceSize,
              labelText: 'Mật khẩu',
              isDisable: false,
              isSecure: true,
              focusNode: _focusNodePassword,
              controller: _model.controllerPassword,
              nextNode: _focusNodeConfirmPassword,
              validator: (value) {
                if (value!.length < 6) {
                  return "Mật khẩu quá ngắn (ít nhất 6 kí tự)";
                } else {
                  return null;
                }
              },
            ),
            CustomOutLineInput(
              deviceSize: widget.deviceSize,
              labelText: 'Xác nhận mật khẩu',
              isDisable: false,
              isSecure: true,
              focusNode: _focusNodeConfirmPassword,
              controller: _model.controllerConfirmPassword,
              validator: (value) {
                if (!(_model.controllerPassword.text == value)) {
                  return "Xác nhận mật khẩu không trùng.";
                } else {
                  return null;
                }
              },
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
              height: 8,
            ),
            CustomButton(
                height: 24,
                isLoading: _model.isLoading,
                text: 'Đăng Ký',
                width: double.infinity,
                textColor: CustomColor.white,
                onPressFunction: _model.isDisableSignup == false
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          onClickSignUp(_email, _password, _confirmPassword,
                              _address, _name, _phone, _birthdate);
                          _focusNodePassword.unfocus();
                          _focusNodeAddress.unfocus();
                          _focusNodeBirthDate.unfocus();
                          _focusNodeConfirmPassword.unfocus();
                          _focusNodeEmail.unfocus();
                          _focusNodeName.unfocus();
                          _focusNodePhone.unfocus();
                        }
                      }
                    : null,
                buttonColor: _model.isDisableSignup == false
                    ? CustomColor.purple
                    : CustomColor.black[3],
                borderRadius: 6),
          ],
        ),
      ),
    );
  }
}
