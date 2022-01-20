import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/background.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input_date.dart';
import 'package:rssms/common/custom_input_with_hint.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
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

  @override
  void onChangeInput() {
    profilePresenter.handleOnChangeInputChangePassword(
        _model.controllerOldPassword.text,
        _model.controllerPassword.text,
        _model.controllerConfirmPassword.text);
  }

  @override
  void onChangeInputProfile() {
    profilePresenter.handleOnChangeInputProfile(_model.controllerFullname.text,
        _model.controllerPhone.text, _model.controllerStreet.text);
  }

  @override
  void updateStatusOfButtonChangePassword(
      String oldPassword, String newPassword, String confirmPassword) {
    if (oldPassword.isNotEmpty &&
        newPassword.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      setState(() {
        _model.isDisableUpdatePass = false;
      });
    } else {
      setState(() {
        _model.isDisableUpdatePass = true;
      });
    }
  }

  @override
  void updateStatusOfButtonUpdateProfile(
      String fullname, String phone, String address) {
    if (fullname.isNotEmpty && phone.isNotEmpty && address.isNotEmpty) {
      setState(() {
        _model.isDisableUpdateProfile = false;
      });
    } else {
      setState(() {
        _model.isDisableUpdateProfile = true;
      });
    }
  }

  @override
  void updateLoadingPassword() {
    setState(() {
      profilePresenter.model.isLoadingChangePassword =
          !profilePresenter.model.isLoadingChangePassword;
    });
  }

  @override
  void updateLoadingProfile() {
    setState(() {
      profilePresenter.model.isLoadingUpdateProfile =
          !profilePresenter.model.isLoadingUpdateProfile;
    });
  }

  @override
  void updateViewPasswordErrorMsg(String error) {
    // TODO: implement updateViewErrorMsg
    setState(() {
      _model.errorMsgChangePassword = error;
    });
  }

  @override
  void onClickChangePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    try {
      Users user = Provider.of<Users>(context, listen: false);

      bool response = await profilePresenter.changePassword(newPassword,
          oldPassword, confirmPassword, user.idToken!, user.userId!);
      if (response) {
        CustomSnackBar.buildErrorSnackbar(
            context: context,
            message: 'Đổi mật khẩu thành công',
            color: CustomColor.green);
      }
    } catch (e) {
      print(e.toString());
      profilePresenter.view
          .updateViewPasswordErrorMsg(e.toString().split(': ')[2]);
    }
  }

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
              _model.txtGender = gender;
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
            color:
                (_model.txtGender == gender) ? CustomColor.blue : Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  void onClickUpdateProfile(String fullname, String phone, String birthdate,
      String gender, String address) async {
    _focusNodeStreet.unfocus();
    _focusNodePhone.unfocus();
    _focusNodeFullname.unfocus();
    int genderCode;
    switch (gender) {
      case "Nam":
        genderCode = 0;
        break;
      case "Nữ":
        genderCode = 1;
        break;
      default:
        genderCode = 2;
        break;
    }
    DateTime tempDate = DateFormat("dd/MM/yyyy").parse(birthdate);
    try {
      Users user = Provider.of<Users>(context, listen: false);
      bool response = await profilePresenter.updateProfile(fullname, genderCode,
          tempDate, address, phone, user.idToken!, user.userId!);
      if (response) {
        CustomSnackBar.buildErrorSnackbar(
            context: context,
            message: 'Cập nhật thông tin thành công',
            color: CustomColor.green);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    Users users = Provider.of<Users>(context, listen: false);
    profilePresenter = ProfilePresenter(users);
    profilePresenter.setView(this);
    _model = profilePresenter.model;
    _model.controllerFullname.addListener(onChangeInputProfile);
    _model.controllerOldPassword.addListener(onChangeInput);
    _model.controllerPassword.addListener(onChangeInput);
    _model.controllerConfirmPassword.addListener(onChangeInput);
    _model.controllerPhone.addListener(onChangeInputProfile);
    _model.controllerStreet.addListener(onChangeInputProfile);
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
            CustomText(
              text: 'Ngày sinh',
              color: CustomColor.black,
              context: context,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            CustomSizedBox(
              context: context,
              height: 16,
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
                        _model.txtGender == "Nam"
                            ? CustomColor.blue
                            : CustomColor.white),
                    customRadioButton(
                        "Nữ",
                        "Nữ",
                        _model.txtGender == "Nữ"
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
              hintText: "Địa chỉ",
              isDisable: false,
              focusNode: _focusNodeStreet,
              controller: _model.controllerStreet,
            ),
            Center(
              child: CustomButton(
                  height: 24,
                  isLoading: _model.isLoadingUpdateProfile,
                  text: 'Cập Nhật',
                  width: widget.deviceSize.width / 3,
                  textColor: CustomColor.white,
                  onPressFunction: _model.isDisableUpdateProfile == true
                      ? null
                      : () {
                          onClickUpdateProfile(
                              _model.controllerFullname.text,
                              _model.controllerPhone.text,
                              _model.controllerBirthDate.text,
                              _model.txtGender,
                              _model.controllerStreet.text);
                        },
                  buttonColor: _model.isDisableUpdateProfile == false
                      ? CustomColor.blue
                      : CustomColor.black[3],
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
              nextNode: _focusNodePassword,
              controller: _model.controllerOldPassword,
            ),
            CustomOutLineInputWithHint(
              deviceSize: widget.deviceSize,
              hintText: 'Mật khẩu mới',
              isDisable: false,
              nextNode: _focusNodeConfirmPassword,
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
            if (_model.errorMsgChangePassword.isNotEmpty)
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: CustomText(
                      text: _model.errorMsgChangePassword,
                      maxLines: 2,
                      color: CustomColor.red,
                      context: context,
                      textAlign: TextAlign.center,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomSizedBox(
                    context: context,
                    height: 16,
                  )
                ],
              ),
            Center(
              child: CustomButton(
                  height: 24,
                  isLoading: _model.isLoadingChangePassword,
                  text: 'Cập Nhật',
                  width: widget.deviceSize.width / 3,
                  textColor: CustomColor.white,
                  onPressFunction: _model.isDisableUpdatePass == true
                      ? null
                      : () {
                          onClickChangePassword(
                              _model.controllerOldPassword.text,
                              _model.controllerPassword.text,
                              _model.controllerConfirmPassword.text);
                        },
                  buttonColor: _model.isDisableUpdatePass == false
                      ? CustomColor.blue
                      : CustomColor.black[3],
                  borderRadius: 6),
            )
          ],
        ),
      ),
    );
  }
}
