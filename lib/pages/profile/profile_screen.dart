import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/background.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input_date.dart';
import 'package:rssms/common/custom_input_with_hint.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/profile_model.dart';
import 'package:rssms/presenters/profile_presenter.dart';
import 'package:rssms/views/profile_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: deviceSize.width,
          height: deviceSize.height * 1.5,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Background(),
              SizedBox(
                width: deviceSize.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: FormProfileScreen(deviceSize: deviceSize)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormProfileScreen extends StatefulWidget {
  final Size deviceSize;
  const FormProfileScreen({Key? key, required this.deviceSize})
      : super(key: key);

  @override
  State<FormProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<FormProfileScreen>
    implements ProfileView {
  late ProfilePresenter profilePresenter;
  late ProfileModel _model;

  final _focusNodeFullname = FocusNode();
  final _focusNodeOldPassword = FocusNode();
  final _focusNodePassword = FocusNode();
  final _focusNodeConfirmPassword = FocusNode();
  final _focusNodePhone = FocusNode();
  final _focusNodeStreet = FocusNode();
  final _focusNodeWard = FocusNode();
  final _focusNodeBirthDate = FocusNode();
  final _focusNodeDistrict = FocusNode();
  String _textGender = "";

  Widget customRadioButton(String text, String gender, Color color) {
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
              _textGender = gender;
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
            color: (_textGender == gender) ? CustomColor.blue : Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    Users users = Provider.of<Users>(context, listen: false);
    print(users.phone);
    profilePresenter = ProfilePresenter(users);
    profilePresenter.setView(this);
    _model = profilePresenter.model;
    _model.controllerFullname.addListener(onChangeInput);
    _model.controllerOldPassword.addListener(onChangeInput);
    _model.controllerPassword.addListener(onChangeInput);
    _model.controllerConfirmPassword.addListener(onChangeInput);
    _model.controllerPhone.addListener(onChangeInput);
    _model.controllerStreet.addListener(onChangeInput);
    _model.controllerWard.addListener(onChangeInput);
    _model.controllerBirthDate.addListener(onChangeInput);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNodeFullname.dispose();
    _focusNodeOldPassword.dispose();
    _focusNodePassword.dispose();
    _focusNodeConfirmPassword.dispose();
    _focusNodeStreet.dispose();
    _focusNodeWard.dispose();
    _focusNodeDistrict.dispose();
    _focusNodeBirthDate.dispose();
    _focusNodePhone.dispose();

    _model.controllerFullname.dispose();
    _model.controllerOldPassword.dispose();
    _model.controllerPassword.dispose();
    _model.controllerConfirmPassword.dispose();
    _model.controllerStreet.dispose();
    _model.controllerWard.dispose();
    _model.controllerDistrict.dispose();
    _model.controllerPhone.dispose();
    _model.controllerBirthDate.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            CustomText(
              text: "Thông tin cá nhân",
              color: Colors.black,
              context: context,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            CustomOutLineInputWithHint(
              deviceSize: widget.deviceSize,
              hintText: "Họ Và Tên",
              isDisable: false,
              focusNode: _focusNodeFullname,
              nextNode: _focusNodePhone,
              controller: _model.controllerFullname,
            ),
            CustomOutLineInputWithHint(
              deviceSize: widget.deviceSize,
              hintText: 'Số Điện Thoại',
              isDisable: false,
              focusNode: _focusNodePhone,
              nextNode: _focusNodeBirthDate,
              controller: _model.controllerPhone,
              textInputType: TextInputType.number,
            ),
            SizedBox(
              width: widget.deviceSize.width / 2.5,
              child: CustomOutLineInputDateTime(
                deviceSize: widget.deviceSize,
                labelText: '',
                isDisable: false,
                focusNode: _focusNodeBirthDate,
                controller: _model.controllerBirthDate,
                icon: "assets/images/calendar.png",
              ),
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
                    customRadioButton(
                        "Nam",
                        "Nam",
                        _textGender == "Nam"
                            ? CustomColor.blue
                            : CustomColor.white),
                    customRadioButton(
                        "Nữ",
                        "Nữ",
                        _textGender == "Nữ"
                            ? CustomColor.blue
                            : CustomColor.white),
                  ],
                )
              ],
            ),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            CustomText(
              text: "Địa Chỉ",
              color: Colors.black,
              context: context,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            CustomOutLineInputWithHint(
              deviceSize: widget.deviceSize,
              hintText: "Đường",
              isDisable: false,
              focusNode: _focusNodeStreet,
              controller: _model.controllerStreet,
            ),
            Row(
              children: [
                SizedBox(
                  width: widget.deviceSize.width / 3,
                  child: CustomOutLineInputWithHint(
                    deviceSize: widget.deviceSize,
                    hintText: 'Phường',
                    isDisable: false,
                    textInputType: TextInputType.number,
                    focusNode: _focusNodeWard,
                    controller: _model.controllerWard,
                  ),
                ),
                CustomSizedBox(
                  context: context,
                  width: 16,
                ),
                SizedBox(
                  width: widget.deviceSize.width / 4,
                  child: CustomOutLineInputWithHint(
                    deviceSize: widget.deviceSize,
                    hintText: 'Quận',
                    isDisable: false,
                    isSecure: true,
                    focusNode: _focusNodeDistrict,
                    controller: _model.controllerDistrict,
                  ),
                ),
              ],
            ),
            Center(
              child: CustomButton(
                  height: 24,
                  isLoading: false,
                  text: 'Cập Nhật',
                  width: widget.deviceSize.width / 3,
                  textColor: CustomColor.white,
                  onPressFunction: null,
                  buttonColor: CustomColor.blue,
                  borderRadius: 6),
            ),
            CustomSizedBox(
              context: context,
              height: 24,
            ),
            CustomText(
              text: "Đổi mật khẩu",
              color: Colors.black,
              context: context,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            CustomOutLineInputWithHint(
              deviceSize: widget.deviceSize,
              hintText: 'Mật khẩu cũ',
              isDisable: false,
              isSecure: true,
              focusNode: _focusNodeOldPassword,
              controller: _model.controllerOldPassword,
            ),
            CustomOutLineInputWithHint(
              deviceSize: widget.deviceSize,
              hintText: 'Mật khẩu mới',
              isDisable: false,
              isSecure: true,
              focusNode: _focusNodePassword,
              controller: _model.controllerPassword,
            ),
            CustomOutLineInputWithHint(
              deviceSize: widget.deviceSize,
              hintText: 'Xác nhận mật khẩu mới',
              isDisable: false,
              isSecure: true,
              focusNode: _focusNodeConfirmPassword,
              controller: _model.controllerConfirmPassword,
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
            Center(
              child: CustomButton(
                  height: 24,
                  isLoading: false,
                  text: 'Cập Nhật',
                  width: widget.deviceSize.width / 3,
                  textColor: CustomColor.white,
                  onPressFunction: null,
                  buttonColor: CustomColor.blue,
                  borderRadius: 6),
            )
          ],
        ),
      ),
    );
  }

  @override
  void onChangeInput() {
    // TODO: implement onChangeInput
  }

  @override
  void onClickSignIn(String email, String password, String confirmPassword,
      String firstname, String lastname, String phone) {
    // TODO: implement onClickSignIn
  }

  @override
  void updateLoading() {
    // TODO: implement updateLoading
  }

  @override
  void updateViewErrorMsg(String error) {
    // TODO: implement updateViewErrorMsg
  }
}
