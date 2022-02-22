import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/helpers/validator.dart';
import 'package:rssms/models/dialog_confirm_cancel_model.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/presenters/dialog_confirm_cancel_presenter.dart';
import 'package:rssms/views/dialog_confirm_cancel_view.dart';

class DialogConfirmCancel extends StatefulWidget {
  final DateTime dateTime;
  const DialogConfirmCancel({Key? key, required this.dateTime})
      : super(key: key);

  @override
  _DialogConfirmCancelState createState() => _DialogConfirmCancelState();
}

class _DialogConfirmCancelState extends State<DialogConfirmCancel>
    implements DialogConfirmCancelView {
  late FocusNode _focusNode;
  late DialogConfirmCancelModel _model;
  late DialogConfirmCancelPresenter _presenter;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _presenter = DialogConfirmCancelPresenter();
    _model = _presenter.model;
    _presenter.view = this;
    _focusNode = FocusNode();
  }

  @override
  void onClickSubmit() async {
    if (_formKey.currentState!.validate()) {
      try {
        Users user = Provider.of<Users>(context, listen: false);
        bool result = await _presenter.submit(
            _model.note.text, widget.dateTime.toIso8601String(), user.idToken!);
        if (result) {
          CustomSnackBar.buildErrorSnackbar(
              context: context,
              message: 'Yêu cầu thành công',
              color: CustomColor.green);
        }
        Navigator.pop(context, result);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void updateLoading() {
    setState(() {
      _model.isLoading = !_model.isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
                text: 'Bạn có chắc chắn?',
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 24),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            CustomOutLineInput(
                controller: _model.note,
                isDisable: false,
                focusNode: _focusNode,
                deviceSize: deviceSize,
                validator: Validator.notEmpty,
                maxLine: 4,
                labelText: 'Ghi chú'),
            CustomSizedBox(
              context: context,
              height: 8,
            ),
            CustomButton(
                height: 24,
                text: 'Xác nhận',
                width: double.infinity,
                onPressFunction: onClickSubmit,
                isLoading: _model.isLoading,
                textColor: CustomColor.white,
                buttonColor: CustomColor.blue,
                borderRadius: 6)
          ],
        ),
      ),
    );
  }
}
