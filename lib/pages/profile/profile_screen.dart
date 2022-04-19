import 'dart:io';

import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
import 'package:rssms/utils/ui_utils.dart';
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
  void updateErrorProfile(String error) {
    setState(() {
      _model.errorProfileMsg = error;
    });
  }

  @override
  void onClickChangePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    Users user = Provider.of<Users>(context, listen: false);

    bool response = await profilePresenter.changePassword(
        newPassword, oldPassword, confirmPassword, user.idToken!, user.userId!);
    if (response) {
      CustomSnackBar.buildSnackbar(
          context: context,
          message: 'Đổi mật khẩu thành công',
          color: CustomColor.green);
    }
  }

  void onChangeGender(String value) {
    setState(() {
      _model.textGender = value;
    });
  }

  @override
  void onClickUpdateProfile() async {
    try {
      Users user = Provider.of<Users>(context, listen: false);
      bool response =
          await profilePresenter.updateProfile(user.idToken!, user.userId!);
      if (response) {
        CustomSnackBar.buildSnackbar(
            context: context,
            message: 'Cập nhật thông tin thành công',
            color: CustomColor.green);
      }
    } catch (e) {
      developer.log(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    Users users = Provider.of<Users>(context, listen: false);
    profilePresenter = ProfilePresenter(users);
    profilePresenter.setView(this);
    _model = profilePresenter.model;
  }

  @override
  void dispose() {
    super.dispose();
    profilePresenter.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final _formKeyPassword = GlobalKey<FormState>();

  void onClickImage() {
    showDialog<ImageSource>(
      context: context,
      builder: (context) =>
          AlertDialog(content: const Text("Chọn nguồn ảnh"), actions: [
        TextButton(
          child: const Text("Camera"),
          onPressed: () => Navigator.pop(context, ImageSource.camera),
        ),
        TextButton(
          child: const Text("Thư viện ảnh"),
          onPressed: () => Navigator.pop(context, ImageSource.gallery),
        ),
      ]),
    ).then((source) async {
      if (source != null) {
        final pickedFile = await ImagePicker().pickImage(source: source);
        if (pickedFile != null) {
          setState(() {
            _model.imageUrl = pickedFile.path;
            _model.isEditAvatar = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Users user = Provider.of(context, listen: false);
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: SingleChildScrollView(
        controller: _model.scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (user.roleName == 'Delivery Staff')
                Center(
                  child: GestureDetector(
                    onTap: () {
                      onClickImage();
                    },
                    child: CircleAvatar(
                      backgroundImage: _model.isEditAvatar
                          ? FileImage(File(_model.imageUrl)) as ImageProvider
                          : NetworkImage(_model.imageUrl),
                      radius: 80,
                      child: const Align(
          
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25.0,
                          child: Icon(
                            Icons.camera_alt,
                            size: 25.0,
                            color: Color(0xFF404040),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
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
                        focusNode: _model.focusNodeFullname,
                        nextNode: _model.focusNodePhone,
                        validator: Validator.notEmpty,
                        controller: _model.controllerFullname,
                      ),
                      CustomOutLineInputWithHint(
                        deviceSize: widget.deviceSize,
                        hintText: 'Số Điện Thoại',
                        isDisable: false,
                        focusNode: _model.focusNodePhone,
                        validator: Validator.checkPhoneNumber,
                        nextNode: _model.focusNodeBirthDate,
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
                          focusNode: _model.focusNodeBirthDate,
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
                                    color: _model.textGender == "Nam"
                                        ? CustomColor.blue
                                        : CustomColor.white,
                                    state: _model.textGender,
                                    value: "Nam"),
                              ),
                              Expanded(
                                child: CustomRadioButton(
                                    function: () {
                                      onChangeGender("Nữ");
                                    },
                                    text: "Nữ",
                                    color: _model.textGender == "Nữ"
                                        ? CustomColor.blue
                                        : CustomColor.white,
                                    state: _model.textGender,
                                    value: "Nữ"),
                              ),
                              Expanded(
                                child: CustomRadioButton(
                                    function: () {
                                      onChangeGender("Khác");
                                    },
                                    text: "Khác",
                                    color: _model.textGender == "Khác"
                                        ? CustomColor.blue
                                        : CustomColor.white,
                                    state: _model.textGender,
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
                        focusNode: _model.focusNodeStreet,
                        controller: _model.controllerStreet,
                        validator: Validator.notEmpty,
                      ),
                      UIUtils.buildErrorUI(
                          context: context, error: _model.errorProfileMsg),
                      Center(
                        child: CustomButton(
                            height: 24,
                            isLoading: _model.isLoadingUpdateProfile,
                            text: 'Cập nhật',
                            width: widget.deviceSize.width / 3,
                            textColor: CustomColor.white,
                            onPressFunction: () {
                              if (_formKey.currentState!.validate()) {
                                onClickUpdateProfile();
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
                      focusNode: _model.focusNodeOldPassword,
                      nextNode: _model.focusNodePassword,
                      controller: _model.controllerOldPassword,
                    ),
                    CustomOutLineInputWithHint(
                      deviceSize: widget.deviceSize,
                      hintText: 'Mật khẩu mới',
                      isDisable: false,
                      nextNode: _model.focusNodeConfirmPassword,
                      isSecure: true,
                      focusNode: _model.focusNodePassword,
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
                      focusNode: _model.focusNodeConfirmPassword,
                      validator: (value) {
                        if (_model.controllerPassword.text !=
                            _model.controllerConfirmPassword.text) {
                          return "Xác nhận mật khẩu không trùng.";
                        } else {
                          return null;
                        }
                      },
                      controller: _model.controllerConfirmPassword,
                    ),
                    UIUtils.buildErrorUI(
                        error: _model.errorMsgChangePassword, context: context),
                    Center(
                      child: CustomButton(
                          height: 24,
                          isLoading: _model.isLoadingChangePassword,
                          text: 'Cập nhật',
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
              ),
              if (user.roleName == "Delivery Staff")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "QR Code",
                      color: Colors.black,
                      context: context,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomSizedBox(
                      context: context,
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: QrImage(
                          data: user.userId! + "_user",
                          size: 100.0,
                          gapless: true,
                          version: 4,
                        ),
                      ),
                    ),
                    CustomSizedBox(
                      context: context,
                      height: 48,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
