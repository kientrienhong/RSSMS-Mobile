import 'package:flutter/material.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/helpers/validator.dart';
import 'package:rssms/models/dialog_add_cost_model.dart';
import 'package:rssms/presenters/dialog_add_cost_presenter.dart';
import 'package:rssms/views/dialog%20_add_cost_view.dart';

class DialogAddCost extends StatefulWidget {
  final Map<String, dynamic>? additionCost;
  final Function? addAdditionCost;
  final Function? updateAdditionCost;
  final List<Map<String, dynamic>> listAdditionCost;
  const DialogAddCost(
      {Key? key,
      this.additionCost,
      this.addAdditionCost,
      required this.listAdditionCost,
      this.updateAdditionCost})
      : super(key: key);

  @override
  State<DialogAddCost> createState() => _DialogAddCostState();
}

class _DialogAddCostState extends State<DialogAddCost>
    implements DialogAddCostView {
  final _formKey = GlobalKey<FormState>();
  late DialogAddCostModel _model;
  late DialogAddCostPresenter _presenter;
  late FocusNode _nameFocusNode;
  late FocusNode _priceFocusNode;
  @override
  void initState() {
    _presenter = DialogAddCostPresenter(widget.additionCost);
    _model = _presenter.model;
    _nameFocusNode = FocusNode();
    _priceFocusNode = FocusNode();
    super.initState();
  }

  @override
  void onSubmit() {
    if (widget.additionCost == null) {
      widget.addAdditionCost!(<String, dynamic>{
        "id": widget.listAdditionCost.length,
        "name": _model.nameController.text,
        "price": double.parse(_model.priceController.text)
      });
    } else {
      widget.updateAdditionCost!(<String, dynamic>{
        "id": widget.additionCost!['id'],
        "name": _model.nameController.text,
        "price": double.parse(_model.priceController.text)
      });
    }
    Navigator.of(context).pop();
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
                text: 'Nhập chi phí',
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 24),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            CustomOutLineInput(
                controller: _model.nameController,
                isDisable: false,
                focusNode: _nameFocusNode,
                nextNode: _priceFocusNode,
                deviceSize: deviceSize,
                validator: Validator.notEmpty,
                maxLine: 4,
                labelText: 'Tên chi phí'),
            CustomOutLineInput(
                controller: _model.priceController,
                isDisable: false,
                focusNode: _priceFocusNode,
                deviceSize: deviceSize,
                textInputType: TextInputType.number,
                validator: Validator.notEmpty,
                maxLine: 1,
                labelText: 'Chi phí'),
            CustomSizedBox(
              context: context,
              height: 8,
            ),
            CustomButton(
                height: 24,
                text: 'Xác nhận',
                width: double.infinity,
                onPressFunction: onSubmit,
                isLoading: false,
                textColor: CustomColor.white,
                buttonColor: CustomColor.blue,
                borderRadius: 6)
          ],
        ),
      ),
    );
  }
}
