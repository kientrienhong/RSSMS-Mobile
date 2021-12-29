import 'package:flutter/material.dart';
import 'package:rssms/common/custom_input.dart';
import 'package:rssms/common/custom_sizebox.dart';

class InvoiceImageDetail extends StatefulWidget {
  Map<String, dynamic> image;
  final bool isDisable;
  InvoiceImageDetail({Key? key, required this.image, required this.isDisable})
      : super(key: key);

  @override
  _InvoiceImageDetailState createState() => _InvoiceImageDetailState();
}

class _InvoiceImageDetailState extends State<InvoiceImageDetail> {
  late final _nameController;
  late final _noteController;
  late final _nameFocusNode;
  late final _noteFocusNode;

  @override
  void initState() {
    _nameController = TextEditingController(text: 'Box 1');
    _noteController = TextEditingController(
        text: '- 1 picture of idols/n- 2 clothes of zara');
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
                        labelText: 'Note')
                    // TextFormField(
                    //   controller: _noteController,
                    //   readOnly: widget.isDisable,
                    //   maxLines: 4,

                    // )
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
