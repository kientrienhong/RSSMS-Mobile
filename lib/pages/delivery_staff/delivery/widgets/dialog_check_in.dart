import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/dialog_check_in_model.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/presenters/dialog_check_in_presenter.dart';
import 'package:rssms/views/dialog_confirm_view.dart';

class DialogCheckIn extends StatefulWidget {
  final String idRequest;
  const DialogCheckIn({Key? key, required this.idRequest}) : super(key: key);

  @override
  State<DialogCheckIn> createState() => _DialogCheckInState();
}

class _DialogCheckInState extends State<DialogCheckIn>
    implements DialogConfirmView {
  late DialogCheckInModel _model;
  late DialogCheckInPresenter _presenter;

  @override
  void initState() {
    _presenter = DialogCheckInPresenter();
    _model = _presenter.model;
    _presenter.view = this;

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
    try {
      Users user = Provider.of<Users>(context, listen: false);
      bool result = await _presenter.checkInDelivery(
        user.idToken!,
        widget.idRequest,
      );
      if (result) {
        CustomSnackBar.buildSnackbar(
            context: context,
            message: 'Thao tác thành công',
            color: CustomColor.green);
        Navigator.pop(context, result);
      } else {
        CustomSnackBar.buildSnackbar(
            context: context,
            message: 'Thao tác thất bại',
            color: CustomColor.red);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
              text: 'Bạn đang chuẩn bị cho đơn này?',
              color: CustomColor.black,
              context: context,
              fontWeight: FontWeight.bold,
              maxLines: 2,
              fontSize: 16),
          CustomSizedBox(
            context: context,
            height: 16,
          ),
          CustomSizedBox(
            context: context,
            height: 8,
          ),
          Row(
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
              CustomSizedBox(
                context: context,
                width: 8,
              ),
              CustomButton(
                  height: 24,
                  text: 'Xác nhận',
                  width: deviceSize.width * 1 / 3 - 4,
                  onPressFunction: onClickSubmit,
                  isLoading: _model.isLoading,
                  textColor: CustomColor.white,
                  buttonColor: CustomColor.blue,
                  borderRadius: 6),
            ],
          ),
        ],
      ),
    );
  }
}
