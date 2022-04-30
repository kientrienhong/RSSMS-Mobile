import 'package:flutter/material.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/helpers/validator.dart';
import 'package:rssms/models/custom_confirm_dialog_model.dart';
import 'package:rssms/presenters/custom_confirm_dialog_presenter.dart';
import 'package:rssms/views/custom_confirm_dialog_view.dart';

class CustomConfirmDialog extends StatefulWidget {
  final Function onSubmit;
  final String successMsg;
  final String failMsg;
  const CustomConfirmDialog(
      {Key? key,
      required this.successMsg,
      required this.failMsg,
      required this.onSubmit})
      : super(key: key);

  @override
  State<CustomConfirmDialog> createState() => _CustomConfirmDialogState();
}

class _CustomConfirmDialogState extends State<CustomConfirmDialog>
    implements CustomConfirmDialogView {
  late CustomConfirmDialogModel _model;
  late CustomConfirmDialogPresenter _presenter;
  final _formKey = GlobalKey<FormState>();

  @override
  void onPressCancel() {
    Navigator.pop(context);
  }

  @override
  void onPressSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    bool result = await _presenter.onPressSubmit();

    if (result) {
      Navigator.pop(context);
      CustomSnackBar.buildSnackbar(
          context: context,
          message: widget.successMsg,
          color: CustomColor.green);
    } else {
      CustomSnackBar.buildSnackbar(
          context: context, message: widget.failMsg, color: CustomColor.red);
    }
  }

  @override
  void updateLoading() {
    setState(() {
      _model.isLoading = !_model.isLoading;
    });
  }

  @override
  void updateError(String error) {
    setState(() {
      _model.errorMsg = error;
    });
  }

  @override
  void initState() {
    _presenter = CustomConfirmDialogPresenter(widget.onSubmit);
    _model = _presenter.model;
    _presenter.view = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
                text: 'Bạn đã chắc chắn?',
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            CustomOutLineInput(
                labelText: 'Ghi chú',
                controller: _model.controller,
                isDisable: false,
                maxLine: 3,
                validator: Validator.notEmpty,
                focusNode: _model.focusNode,
                deviceSize: deviceSize),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                    height: 24,
                    isLoading: _model.isLoading,
                    text: 'Xác nhận',
                    textColor: CustomColor.white,
                    onPressFunction: onPressSubmit,
                    width: deviceSize.width / 3.5,
                    buttonColor: CustomColor.blue,
                    borderRadius: 6),
                CustomButton(
                    height: 24,
                    isLoading: false,
                    text: 'Đóng',
                    textColor: CustomColor.white,
                    onPressFunction: onPressCancel,
                    width: deviceSize.width / 3.5,
                    buttonColor: CustomColor.red,
                    borderRadius: 6),
              ],
            )
          ],
        ),
      ),
    );
  }
}
