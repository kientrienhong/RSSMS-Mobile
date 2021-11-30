import 'package:group_radio_button/group_radio_button.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_input_date.dart';
import 'package:rssms/constants/constants.dart' as constant;
import 'package:rssms/models/signup_model.dart';
import 'package:rssms/pages/customers/bottom_navigation/custom_bottom_navigation.dart';
import 'package:rssms/pages/customers/cart/cart_screen.dart';
import 'package:rssms/pages/customers/notification/notification_screen.dart';
import 'package:rssms/pages/customers/profile/profile_screen.dart';
import 'package:rssms/presenters/signup_presenters.dart';
import 'package:rssms/views/signup_view.dart';

import '/common/background.dart';
import '/common/custom_color.dart';
import '/common/custom_input.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: CustomColor.white,
        body: SingleChildScrollView(
          child: Container(
            width: deviceSize.width,
            height: deviceSize.height * 1.4,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Background(),
                Container(
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
  FormSignUp(this.deviceSize);

  @override
  _FormSignUpState createState() => _FormSignUpState();
}

class _FormSignUpState extends State<FormSignUp> implements SignUpView {
  late SignUpPresenter signupPresenter;

  late SignUpModel _model;

  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();
  final _focusNodeConfirmPassword = FocusNode();
  final _focusNodePhone = FocusNode();
  final _focusNodeFristname = FocusNode();
  final _focusNodeLastname = FocusNode();
  final _focusNodeBirthDate = FocusNode();
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerConfirmPassword = TextEditingController();
  final _controllerPhone = TextEditingController();
  final _controllerFirstname = TextEditingController();
  final _controllerLastname = TextEditingController();
  final _controllerBirthDate = TextEditingController();
  String _textGender = "";

  String get _email => _controllerEmail.text;
  String get _password => _controllerPassword.text;
  String get _confirmPassword => _controllerEmail.text;
  String get _phone => _controllerPassword.text;
  String get _firstname => _controllerEmail.text;
  String get _lastname => _controllerPassword.text;
  String get _birthdate => _controllerBirthDate.text;

  _selectDate(
      {required BuildContext context,
      required DateTime initialDate,
      required DateTime startDate}) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: startDate,
        lastDate: DateTime(2022));
  }

  @override
  void initState() {
    super.initState();
    signupPresenter = SignUpPresenter();
    signupPresenter.setView(this);
    _model = signupPresenter.model;
    _controllerEmail.addListener(onChangeInput);
    _controllerPassword.addListener(onChangeInput);
    _controllerConfirmPassword.addListener(onChangeInput);
    _controllerPhone.addListener(onChangeInput);
    _controllerFirstname.addListener(onChangeInput);
    _controllerLastname.addListener(onChangeInput);
    _controllerBirthDate.addListener(onChangeInput);
  }

  @override
  void onChangeInput() {
    signupPresenter.handleOnChangeInput(
        _email, _password, _confirmPassword, _firstname, _lastname, _phone);
  }

  @override
  void onClickSignIn(String email, String password, String confirmPassword,
      String firstname, String lastname, String phone) async {
    try {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const CustomBottomNavigation(
                  listIndexStack: [
                    ProfileScreen(),
                    CartScreen(),
                    NotificationScreen(),
                  ],
                  listNavigator: constant.LIST_CUSTOMER_BOTTOM_NAVIGATION,
                )),
      );
    } catch (e) {
      signupPresenter.view
          .updateViewErrorMsg('Tài khoản / mật khẩu không đúng');
    }
  }

  @override
  updateLoading() {
    if (mounted)
      setState(() {
        _model.isLoading = !_model.isLoading;
      });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeConfirmPassword.dispose();
    _focusNodeFristname.dispose();
    _focusNodeLastname.dispose();
    _focusNodeBirthDate.dispose();
    _focusNodePhone.dispose();

    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConfirmPassword.dispose();
    _controllerFirstname.dispose();
    _controllerLastname.dispose();
    _controllerPhone.dispose();
    _controllerBirthDate.dispose();
  }

  @override
  void updateViewStatusButton(String email, String password,
      String confirmPassword, String firstname, String lastname, String phone) {
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        firstname.isNotEmpty &&
        lastname.isNotEmpty &&
        phone.isNotEmpty) {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: widget.deviceSize.width / 2.5,
                child: CustomOutLineInput(
                  deviceSize: widget.deviceSize,
                  labelText: 'Họ',
                  isDisable: false,
                  focusNode: _focusNodeLastname,
                  nextNode: _focusNodeFristname,
                  controller: _controllerLastname,
                ),
              ),
              Container(
                width: widget.deviceSize.width / 2.5,
                child: CustomOutLineInput(
                  deviceSize: widget.deviceSize,
                  labelText: 'Tên',
                  isDisable: false,
                  focusNode: _focusNodeFristname,
                  nextNode: _focusNodeEmail,
                  controller: _controllerFirstname,
                ),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  text: "Giới Tính",
                  color: CustomColor.black,
                  context: context,
                  fontSize: 16),
              CustomSizedBox(context: context, height: 8),
              Row(
                children: [
                  RadioButton(
                    description: "Nam",
                    value: "Male",
                    groupValue: _textGender,
                    onChanged: (value) => setState(
                      () => _textGender = value.toString(),
                    ),
                    activeColor: Colors.blue,
                  ),
                  RadioButton(
                    description: "Nữ",
                    value: "Female",
                    groupValue: _textGender,
                    onChanged: (value) =>
                        setState(() => _textGender = value.toString()),
                    activeColor: Colors.blue,
                  ),
                ],
              )
            ],
          ),
          Container(
            width: widget.deviceSize.width / 2.5,
            child: CustomOutLineInputDateTime(
              deviceSize: widget.deviceSize,
              labelText: 'Năm sinh',
              isDisable: false,
              focusNode: _focusNodeBirthDate,
              nextNode: _focusNodeEmail,
              controller: _controllerBirthDate,
              icon: "assets/images/calendar.png",
            ),
          ),
          CustomOutLineInput(
            deviceSize: widget.deviceSize,
            labelText: 'Email',
            isDisable: false,
            focusNode: _focusNodeEmail,
            controller: _controllerEmail,
          ),
          CustomOutLineInput(
            deviceSize: widget.deviceSize,
            labelText: 'Số điện thoại',
            isDisable: false,
            textInputType: TextInputType.number,
            focusNode: _focusNodePhone,
            controller: _controllerPhone,
          ),
          CustomOutLineInput(
            deviceSize: widget.deviceSize,
            labelText: 'Mật khẩu',
            isDisable: false,
            isSecure: true,
            focusNode: _focusNodePassword,
            controller: _controllerPassword,
          ),
          CustomOutLineInput(
            deviceSize: widget.deviceSize,
            labelText: 'Xác nhận mật khẩu',
            isDisable: false,
            isSecure: true,
            focusNode: _focusNodeConfirmPassword,
            controller: _controllerConfirmPassword,
          ),
          if (_model.errorMsg.isNotEmpty)
            Container(
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
              height: 18,
              isLoading: false,
              text: 'Đăng Ký',
              width: double.infinity,
              textColor: CustomColor.white,
              onPressFunction: null,
              buttonColor: _model.isDisableSignup == false
                  ? CustomColor.purple
                  : CustomColor.black[3],
              borderRadius: 6),
        ],
      ),
    );
  }
}
