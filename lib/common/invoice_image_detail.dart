import 'package:flutter/material.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input.dart';
import 'package:rssms/common/custom_sizebox.dart';

class InvoiceImageDetail extends StatefulWidget {
  final Map<String, dynamic> image;
  final bool isDisable;
  const InvoiceImageDetail(
      {Key? key, required this.image, required this.isDisable})
      : super(key: key);

  @override
  _InvoiceImageDetailState createState() => _InvoiceImageDetailState();
}

class _InvoiceImageDetailState extends State<InvoiceImageDetail> {
  late TextEditingController _nameController;
  late TextEditingController _noteController;
  late FocusNode _nameFocusNode;
  late FocusNode _noteFocusNode;

  @override
  void initState() {
    _nameController = TextEditingController(text: 'Box 1');

    _noteController = TextEditingController(
        text: '1 picture of idol'
            ' + 2 clothes of zara');
    _nameFocusNode = FocusNode();
    _noteFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return AlertDialog(
      insetPadding: const EdgeInsets.all(16),
      content: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                SizedBox(
                    height: deviceSize.width * 1 / 3,
                    child: Image.asset(widget.image['url'])),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                Column(
                  children: [
                    CustomOutLineInput(
                        controller: _nameController,
                        isDisable: widget.isDisable,
                        focusNode: _nameFocusNode,
                        deviceSize: deviceSize,
                        nextNode: _noteFocusNode,
                        labelText: 'Name'),
                    CustomOutLineInput(
                        controller: _noteController,
                        isDisable: widget.isDisable,
                        focusNode: _noteFocusNode,
                        deviceSize: deviceSize,
                        maxLine: 3,
                        labelText: 'Note'),
                    CustomButton(
                        height: 24,
                        text: 'Đóng',
                        width: deviceSize.width * 1.2 / 3,
                        onPressFunction: () {
                          Navigator.of(context).pop();
                        },
                        isLoading: false,
                        textColor: CustomColor.white,
                        buttonColor: CustomColor.red,
                        borderRadius: 6),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
