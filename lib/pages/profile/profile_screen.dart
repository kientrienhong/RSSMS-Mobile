import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/background.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input_date.dart';
import 'package:rssms/common/custom_input_with_hint.dart';
import 'package:rssms/common/custom_radio_button.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/helpers/validator.dart';
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
      body: SizedBox(
        width: deviceSize.width,
        height: deviceSize.height * 1.2,
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
    setState(() {
      _model.errorMsgChangePassword = error;
    });
  }

  @override
  void onClickChangePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    try {
      Users user = Provider.of<Users>(context, listen: false);
      _model.errorMsgChangePassword = "";

      bool response = await profilePresenter.changePassword(newPassword,
          oldPassword, confirmPassword, user.idToken!, user.userId!);
      if (response) {
        CustomSnackBar.buildErrorSnackbar(
            context: context,
            message: 'Đổi mật khẩu thành công',
            color: CustomColor.green);
        _model.controllerConfirmPassword.text = "";
        _model.controllerPassword.text = "";
        _model.controllerOldPassword.text = "";
      }
    } catch (e) {
      print(e.toString());
      profilePresenter.view
          .updateViewPasswordErrorMsg(e.toString().split(': ')[2]);
    }
  }

  void onChangeGender(String value) {
    print(value);
    setState(() {
      _model.txtGender = value;
    });
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

  ScrollController? scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    Users users = Provider.of<Users>(context, listen: false);
    profilePresenter = ProfilePresenter(users);
    profilePresenter.setView(this);
    _model = profilePresenter.model;
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

  final _formKey = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
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
              Form(
                  key: _formKey,
                  onChanged: () {
                    _formKey.currentState!.validate();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomOutLineInputWithHint(
                        deviceSize: widget.deviceSize,
                        hintText: "Họ Và Tên",
                        isDisable: false,
                        focusNode: _focusNodeFullname,
                        nextNode: _focusNodePhone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Vui lòng nhập đầy đủ họ và tên.";
                          } else if (value.length < 5) {
                            return "Vui lòng nhập đầy đủ họ và tên.";
                          } else {
                            return null;
                          }
                        },
                        controller: _model.controllerFullname,
                      ),
                      CustomOutLineInputWithHint(
                        deviceSize: widget.deviceSize,
                        hintText: 'Số Điện Thoại',
                        isDisable: false,
                        focusNode: _focusNodePhone,
                        validator: (value) {
                          if (value!.length < 10) {
                            return "Sai định dạng";
                          } else if (value.contains(RegExp(
                              r'/^(0|\+84)(\s|\.)?((3[2-9])|(5[689])|(7[06-9])|(8[1-689])|(9[0-46-9]))(\d)(\s|\.)?(\d{3})(\s|\.)?(\d{3})$/;{10,10}'))) {
                            return "Sai định dạng.";
                          } else {
                            return null;
                          }
                        },
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
                          isDisable: true,
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
                              Expanded(
                                child: CustomRadioButton(
                                    function: () {
                                      onChangeGender("Nam");
                                    },
                                    text: "Nam",
                                    color: _model.txtGender == "Nam"
                                        ? CustomColor.blue
                                        : CustomColor.white,
                                    state: _model.txtGender,
                                    value: "Nam"),
                              ),
                              Expanded(
                                child: CustomRadioButton(
                                    function: () {
                                      onChangeGender("Nữ");
                                    },
                                    text: "Nữ",
                                    color: _model.txtGender == "Nữ"
                                        ? CustomColor.blue
                                        : CustomColor.white,
                                    state: _model.txtGender,
                                    value: "Nữ"),
                              ),
                              Expanded(
                                child: CustomRadioButton(
                                    function: () {
                                      onChangeGender("Khác");
                                    },
                                    text: "Khác",
                                    color: _model.txtGender == "Khác"
                                        ? CustomColor.blue
                                        : CustomColor.white,
                                    state: _model.txtGender,
                                    value: "Khác"),
                              ),
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Vui lòng nhập địa chỉ.";
                          }
                        },
                      ),
                      Center(
                        child: CustomButton(
                            height: 24,
                            isLoading: _model.isLoadingUpdateProfile,
                            text: 'Cập Nhật',
                            width: widget.deviceSize.width / 3,
                            textColor: CustomColor.white,
                            onPressFunction: () {
                              if (_formKey.currentState!.validate()) {
                                onClickUpdateProfile(
                                    _model.controllerFullname.text,
                                    _model.controllerPhone.text,
                                    _model.controllerBirthDate.text,
                                    _model.txtGender,
                                    _model.controllerStreet.text);
                              }
                            },
                            buttonColor: CustomColor.blue,
                            borderRadius: 6),
                      ),
                    ],
                  )),
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
              Form(
                key: _formKeyPassword,
                child: Column(
                  children: [
                    CustomSizedBox(
                      context: context,
                      height: 16,
                    ),
                    CustomOutLineInputWithHint(
                      deviceSize: widget.deviceSize,
                      validator: Validator.notEmpty,
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
                      validator: (value) {
                        if (value!.length < 6) {
                          return "Mật khẩu quá ngắn (ít nhất 6 kí tự)";
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomOutLineInputWithHint(
                      deviceSize: widget.deviceSize,
                      hintText: 'Xác nhận mật khẩu mới',
                      isDisable: false,
                      isSecure: true,
                      focusNode: _focusNodeConfirmPassword,
                      validator: (value) {
                        if (_model.controllerPassword.text ==
                            _model.controllerConfirmPassword.text) {
                          return "Xác nhận mật khẩu không trùng.";
                        } else {
                          return null;
                        }
                      },
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
                          onPressFunction: () {
                            if (_formKeyPassword.currentState!.validate()) {
                              onClickChangePassword(
                                  _model.controllerOldPassword.text,
                                  _model.controllerPassword.text,
                                  _model.controllerConfirmPassword.text);
                            }
                          },
                          buttonColor: CustomColor.blue,
                          borderRadius: 6),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
