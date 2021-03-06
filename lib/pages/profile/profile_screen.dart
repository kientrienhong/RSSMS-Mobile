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
          message: '?????i m???t kh???u th??nh c??ng',
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
          await profilePresenter.updateProfile(user.idToken!, user.userId!, user.roleName!);
      if (response) {
        CustomSnackBar.buildSnackbar(
            context: context,
            message: 'C???p nh???t th??ng tin th??nh c??ng',
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
          AlertDialog(content: const Text("Ch???n ngu???n ???nh"), actions: [
        TextButton(
          child: const Text("Camera"),
          onPressed: () => Navigator.pop(context, ImageSource.camera),
        ),
        TextButton(
          child: const Text("Th?? vi???n ???nh"),
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
                text: "Th??ng tin c?? nh??n",
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
                        hintText: "H??? V?? T??n",
                        isDisable: false,
                        focusNode: _model.focusNodeFullname,
                        nextNode: _model.focusNodePhone,
                        validator: Validator.notEmpty,
                        controller: _model.controllerFullname,
                      ),
                      CustomOutLineInputWithHint(
                        deviceSize: widget.deviceSize,
                        hintText: 'S??? ??i???n Tho???i',
                        isDisable: false,
                        focusNode: _model.focusNodePhone,
                        validator: Validator.checkPhoneNumber,
                        nextNode: _model.focusNodeBirthDate,
                        controller: _model.controllerPhone,
                        textInputType: TextInputType.number,
                      ),
                      CustomText(
                        text: 'Ng??y sinh',
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
                              text: "Gi???i T??nh",
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
                                      onChangeGender("N???");
                                    },
                                    text: "N???",
                                    color: _model.textGender == "N???"
                                        ? CustomColor.blue
                                        : CustomColor.white,
                                    state: _model.textGender,
                                    value: "N???"),
                              ),
                              Expanded(
                                child: CustomRadioButton(
                                    function: () {
                                      onChangeGender("Kh??c");
                                    },
                                    text: "Kh??c",
                                    color: _model.textGender == "Kh??c"
                                        ? CustomColor.blue
                                        : CustomColor.white,
                                    state: _model.textGender,
                                    value: "Kh??c"),
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
                        text: "?????a Ch???",
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
                        hintText: "?????a ch???",
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
                            text: 'C???p nh???t',
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
                text: "?????i m???t kh???u",
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
                      hintText: 'M???t kh???u c??',
                      isDisable: false,
                      isSecure: true,
                      focusNode: _model.focusNodeOldPassword,
                      nextNode: _model.focusNodePassword,
                      controller: _model.controllerOldPassword,
                    ),
                    CustomOutLineInputWithHint(
                      deviceSize: widget.deviceSize,
                      hintText: 'M???t kh???u m???i',
                      isDisable: false,
                      nextNode: _model.focusNodeConfirmPassword,
                      isSecure: true,
                      focusNode: _model.focusNodePassword,
                      controller: _model.controllerPassword,
                      validator: (value) {
                        if (value!.length < 6) {
                          return "M???t kh???u qu?? ng???n (??t nh???t 6 k?? t???)";
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomOutLineInputWithHint(
                      deviceSize: widget.deviceSize,
                      hintText: 'X??c nh???n m???t kh???u m???i',
                      isDisable: false,
                      isSecure: true,
                      focusNode: _model.focusNodeConfirmPassword,
                      validator: (value) {
                        if (_model.controllerPassword.text !=
                            _model.controllerConfirmPassword.text) {
                          return "X??c nh???n m???t kh???u kh??ng tr??ng.";
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
                          text: 'C???p nh???t',
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
              if (user.roleName != "Office Staff")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "M?? QR",
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
