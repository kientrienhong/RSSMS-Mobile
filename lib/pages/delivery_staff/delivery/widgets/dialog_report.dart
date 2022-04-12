import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/helpers/validator.dart';
import 'package:rssms/models/dialog_confirm_model.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/presenters/dialog_confirm_presenter.dart';
import 'package:rssms/views/dialog_confirm_view.dart';

class DialogReport extends StatefulWidget {
  String idRequest;
  DialogReport({Key? key, required this.idRequest}) : super(key: key);

  @override
  State<DialogReport> createState() => _DialogReportState();
}

class _DialogReportState extends State<DialogReport>
    implements DialogConfirmView {
  late FocusNode _focusNode;
  late DialogConfirmModel _model;
  late DialogConfirmPresenter _presenter;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _presenter = DialogConfirmPresenter();
    _model = _presenter.model;
    _presenter.view = this;
    _focusNode = FocusNode();

    super.initState();
  }

  @override
  void updateLoading() {
    setState(() {
      _model.isLoading = !_model.isLoading;
    });
  }

  @override
  void onClickClose() {
    Navigator.of(context).pop();
  }

  @override
  void onClickSubmit() async {
    if (_formKey.currentState!.validate()) {
      try {
        Users user = Provider.of<Users>(context, listen: false);
        bool result = await _presenter.onClickReport(
            _model.note.text, widget.idRequest, user.idToken!);
        if (result) {
          CustomSnackBar.buildSnackbar(
              context: context,
              message: 'Báo cáo thành công',
              color: CustomColor.green);
        }
        Navigator.pop(context, result);
      } catch (e) {
        log(e.toString());
      }
    }
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
                text: 'Bạn có muốn báo cáo?',
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 20),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                    height: 24,
                    text: 'Đóng',
                    width: deviceSize.width * 1 / 3 - 4,
                    onPressFunction: onClickClose,
                    isLoading: false,
                    textColor: CustomColor.white,
                    buttonColor: CustomColor.red,
                    borderRadius: 6),
                CustomButton(
                    height: 24,
                    text: 'Xác nhận',
                    width: deviceSize.width * 1 / 3 - 4,
                    onPressFunction: onClickSubmit,
                    isLoading: _model.isLoading,
                    textColor: CustomColor.white,
                    buttonColor: const Color.fromRGBO(4, 191, 254, 1),
                    borderRadius: 6),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
