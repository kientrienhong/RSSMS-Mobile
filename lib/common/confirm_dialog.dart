import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/confirm_dialog_model.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/presenters/confirm_dialog_presenter.dart';
import 'package:rssms/utils/ui_utils.dart';
import 'package:rssms/views/confirm_dialog_view.dart';

class ConfirmDialog extends StatefulWidget {
  final Function confirmFunction;
  final String id;
  const ConfirmDialog(
      {Key? key, required this.confirmFunction, required this.id})
      : super(key: key);

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog>
    implements ConfirmDialogView {
  late ConfirmDialogModel _model;
  late ConfirmDialogPresenter _presenter;

  @override
  void initState() {
    _presenter = ConfirmDialogPresenter(widget.confirmFunction);
    _model = _presenter.model;
    _presenter.view = this;
    super.initState();
  }

  @override
  void updateErrorMsg(String error) {
    setState(() {
      _model.error = error;
    });
  }

  @override
  void updateLoading() {
    setState(() {
      _model.isLoading = !_model.isLoading;
    });
  }

  @override
  void onPressClose() {
    Navigator.of(context).pop();
  }

  @override
  void onPressConfirm() async {
    Users user = Provider.of<Users>(context, listen: false);
    bool result = await _presenter.onClickConfirm(widget.id, user.idToken!);
    if (result) {
      CustomSnackBar.buildSnackbar(
          context: context,
          message: 'Hủy yêu cầu thành công',
          color: CustomColor.green);
      Navigator.pop(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return AlertDialog(
        title: Center(
          child: CustomText(
              text: 'Bạn đã chắc chắn?',
              color: CustomColor.black,
              fontWeight: FontWeight.bold,
              context: context,
              fontSize: 24),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UIUtils.buildErrorUI(context: context, error: _model.error),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                CustomButton(
                    height: 24,
                    text: 'Xác nhận',
                    width: deviceSize.width / 3 - 40,
                    onPressFunction: onPressConfirm,
                    isLoading: _model.isLoading,
                    textColor: CustomColor.white,
                    buttonColor: CustomColor.green,
                    borderRadius: 4),
                CustomButton(
                    height: 24,
                    text: 'Đóng',
                    width: deviceSize.width / 3 - 40,
                    onPressFunction: onPressClose,
                    isLoading: false,
                    textColor: CustomColor.red,
                    buttonColor: CustomColor.redOpacity,
                    borderRadius: 4),
              ],
            ),
          ],
        ));
  }
}
