import 'package:flutter/material.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';

class InvoiceCancelWidget extends StatefulWidget {
  const InvoiceCancelWidget({Key? key}) : super(key: key);

  @override
  _InvoiceCancelWidgetState createState() => _InvoiceCancelWidgetState();
}

class _InvoiceCancelWidgetState extends State<InvoiceCancelWidget> {
  final _focusNodeReason = FocusNode();
  final _controllerReason = TextEditingController();
  String get _email => _controllerReason.text;

  @override
  void dispose() {
    super.dispose();
    _focusNodeReason.dispose();
    _controllerReason.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
              text: "Lý do",
              color: CustomColor.black,
              fontWeight: FontWeight.bold,
              context: context,
              fontSize: 16),
          CustomSizedBox(
            context: context,
            height: 16,
          ),
          TextFormField(
            minLines: 6,
            focusNode: _focusNodeReason,
            controller: _controllerReason,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration.collapsed(
              hintText: "",
              border: OutlineInputBorder(
                borderSide: BorderSide(color: CustomColor.black),
              ),
            ),
          ),
          CustomSizedBox(
            context: context,
            height: 16,
          ),
          CustomButton(
              height: 18,
              isLoading: false,
              text: 'Thanh toán',
              textColor: CustomColor.white,
              onPressFunction: null,
              width: deviceSize.width,
              buttonColor: CustomColor.blue,
              borderRadius: 6),
        ],
      ),
    );
  }
}
