import 'package:flutter/material.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input.dart';
import 'package:rssms/common/custom_sizebox.dart';

class ImageDetailsInvoice extends StatefulWidget {
  final Map<String, dynamic> image;

  final bool isDisable;
  const ImageDetailsInvoice({
    Key? key,
    required this.isDisable,
    required this.image,
  }) : super(key: key);

  @override
  _InvoiceImageDetailState createState() => _InvoiceImageDetailState();
}

class _InvoiceImageDetailState extends State<ImageDetailsInvoice> {
  late final _nameController;
  late final _noteController;
  late final _nameFocusNode;
  late final _noteFocusNode;

  var imageAdd;
  @override
  void initState() {
    _nameController = TextEditingController(text: widget.image["name"]);
    _noteController = TextEditingController(text: widget.image["description"]);
    imageAdd = widget.image["url"];
    _nameFocusNode = FocusNode();
    _noteFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return AlertDialog(
      insetPadding: const EdgeInsets.all(16),
      content: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  SizedBox(
                      height: deviceSize.height / 3,
                      width: deviceSize.width / 1.3,
                      child: Image.asset(
                        imageAdd,
                        fit: BoxFit.fitWidth,
                      )),
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
                          labelText: 'Tên'),
                      CustomOutLineInput(
                          controller: _noteController,
                          isDisable: widget.isDisable,
                          focusNode: _noteFocusNode,
                          deviceSize: deviceSize,
                          maxLine: 7,
                          labelText: 'Ghi chú'),
                      CustomButton(
                          height: 24,
                          text: 'Xác nhận',
                          width: deviceSize.width * 1.2 / 3,
                          onPressFunction: () {
                            Navigator.of(context).pop();
                          },
                          isLoading: false,
                          textColor: CustomColor.white,
                          buttonColor: CustomColor.blue,
                          borderRadius: 6),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
