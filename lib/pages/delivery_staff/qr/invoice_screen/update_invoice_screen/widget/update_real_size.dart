import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/helpers/validator.dart';
import 'package:rssms/models/dialog_update_real_size_model.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/presenters/dialog_update_real_size_presenter.dart';
import 'package:rssms/views/dialog_update_real_size.dart';

class DialogUpdateRealSize extends StatefulWidget {
  final OrderDetail? orderDetail;
  const DialogUpdateRealSize({Key? key, this.orderDetail}) : super(key: key);

  @override
  State<DialogUpdateRealSize> createState() => _DialogUpdateRealSizeState();
}

class _DialogUpdateRealSizeState extends State<DialogUpdateRealSize>
    implements DialogUpdateRealSizeView {
  final FocusNode _focusNodeWidth = FocusNode();
  final FocusNode _focusNodeHeight = FocusNode();
  final FocusNode _focusNodeLength = FocusNode();
  late DialogUpdateRealSizePresenter _presenter;
  late DialogUpdateRealSizeModel _model;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _presenter = DialogUpdateRealSizePresenter(widget.orderDetail);
    _model = _presenter.model;
    _presenter.view = this;
    super.initState();
  }

  @override
  void onSubmit() {
    Invoice invoice = Provider.of<Invoice>(context, listen: false);
    Invoice invoiceTemp = invoice.copyWith();
    _presenter.updateRealSize(invoice, invoiceTemp);
    Navigator.pop(context);
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
                text: 'Nhập kích thước thật',
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 24),
            CustomSizedBox(
              context: context,
              height: 8,
            ),
            CustomOutLineInput(
              deviceSize: deviceSize,
              labelText: 'Chiều rộng (m)',
              isDisable: false,
              focusNode: _focusNodeWidth,
              textInputType: TextInputType.number,
              nextNode: _focusNodeLength,
              validator: Validator.notEmpty,
              controller: _model.controllerWidth,
            ),
            CustomOutLineInput(
              deviceSize: deviceSize,
              labelText: 'Chiều dài (m)',
              isDisable: false,
              focusNode: _focusNodeLength,
              textInputType: TextInputType.number,
              nextNode: _focusNodeHeight,
              validator: Validator.notEmpty,
              controller: _model.controllerLength,
            ),
            CustomOutLineInput(
              deviceSize: deviceSize,
              labelText: 'Chiều cao (m)',
              isDisable: false,
              focusNode: _focusNodeHeight,
              textInputType: TextInputType.number,
              validator: Validator.notEmpty,
              controller: _model.controllerHeight,
            ),
            CustomButton(
                textSize: 15,
                height: 20,
                isLoading: false,
                text: 'Xác nhận',
                textColor: CustomColor.white,
                onPressFunction: () {
                  onSubmit();
                },
                width: deviceSize.width / 3.5,
                buttonColor: CustomColor.blue,
                borderRadius: 6),
          ],
        ),
      ),
    );
  }
}
