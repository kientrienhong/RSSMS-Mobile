import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_input_date.dart';
import 'package:rssms/common/custom_radio_button.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/helpers/validator.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/signup_model.dart';
import 'package:rssms/pages/log_in/log_in_screen.dart';
import 'package:rssms/presenters/signup_presenters.dart';
import 'package:rssms/views/signup_view.dart';
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
                      child: SizedBox(
                          height: 24,
                          width: 24,
                          child: Image.asset(
                            'assets/images/arrowLeft.png',
                            fit: BoxFit.contain,
                          )),
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
  late FirebaseMessaging _firebaseMessaging;
  late SignUpModel _model;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging = FirebaseMessaging.instance;
    firebaseCloudMessagingListeners();
    signupPresenter = SignUpPresenter();
    signupPresenter.setView(this);
    _model = signupPresenter.model;
  }

  void firebaseCloudMessagingListeners() {
    _firebaseMessaging.getToken().then((token) {
      _model.token = token!;
    });
  }

  @override
  void onChangeInput() {
    signupPresenter.handleOnChangeInput();
  }

  @override
  void onClickSignUp() async {
    try {
      Users? result = await signupPresenter.handleSignUp();

      if (result != null) {
        CustomSnackBar.buildSnackbar(
            context: context,
            message: 'Đăng ký thành công',
            color: CustomColor.green);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LogInScreen()));
      }
    } catch (e) {
      log(e.toString());
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
    signupPresenter.dispose();
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
              focusNode: _model.focusNodeName,
              nextNode: _model.focusNodeEmail,
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
                  setState(() => _model.gender = 0);
                },
                text: "Nam",
                color:
                    _model.gender == 0 ? CustomColor.blue : CustomColor.white,
                state: _model.gender,
                value: 0),
            CustomRadioButton(
                function: () {
                  setState(() => _model.gender = 1);
                },
                text: "Nữ",
                color:
                    _model.gender == 1 ? CustomColor.blue : CustomColor.white,
                state: _model.gender,
                value: 1),
            CustomRadioButton(
                function: () {
                  setState(() => _model.gender = 2);
                },
                text: "Khác",
                color:
                    _model.gender == 2 ? CustomColor.blue : CustomColor.white,
                state: _model.gender,
                value: 2),
            SizedBox(
              width: widget.deviceSize.width / 2.5,
              child: CustomOutLineInputDateTime(
                deviceSize: widget.deviceSize,
                labelText: 'Năm sinh',
                isDisable: false,
                focusNode: _model.focusNodeBirthDate,
                nextNode: _model.focusNodeEmail,
                controller: _model.controllerBirthDate,
                icon: "assets/images/calendar.png",
              ),
            ),
            CustomOutLineInput(
              deviceSize: widget.deviceSize,
              labelText: 'Email',
              isDisable: false,
              focusNode: _model.focusNodeEmail,
              validator: Validator.checkEmail,
              controller: _model.controllerEmail,
              nextNode: _model.focusNodePhone,
            ),
            CustomOutLineInput(
              deviceSize: widget.deviceSize,
              labelText: 'Số điện thoại',
              isDisable: false,
              textInputType: TextInputType.number,
              focusNode: _model.focusNodePhone,
              controller: _model.controllerPhone,
              validator: (value) {},
              nextNode: _model.focusNodeAddress,
            ),
            CustomOutLineInput(
                deviceSize: widget.deviceSize,
                labelText: 'Địa chỉ',
                isDisable: false,
                focusNode: _model.focusNodeAddress,
                controller: _model.controllerAddress,
                nextNode: _model.focusNodePassword,
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
              focusNode: _model.focusNodePassword,
              controller: _model.controllerPassword,
              nextNode: _model.focusNodeConfirmPassword,
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
              focusNode: _model.focusNodeConfirmPassword,
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
                          onClickSignUp();
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
