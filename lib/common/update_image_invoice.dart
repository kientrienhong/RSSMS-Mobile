import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/models/entity/add_image.dart';
import 'package:rssms/common/button_icon.dart';

class UpdateImageInvoice extends StatefulWidget {
  final bool isDisable;
  const UpdateImageInvoice({Key? key, required this.isDisable})
      : super(key: key);

  @override
  _InvoiceImageDetailState createState() => _InvoiceImageDetailState();
}

class _InvoiceImageDetailState extends State<UpdateImageInvoice> {
  late TextEditingController _nameController;
  late TextEditingController _noteController;
  late FocusNode _nameFocusNode;
  late FocusNode _noteFocusNode;

  File? imageAdd;
  String get _name => _nameController.text;
  String get _note => _noteController.text;
  @override
  void initState() {
    _nameController = TextEditingController();
    _noteController = TextEditingController();

    _nameFocusNode = FocusNode();
    _noteFocusNode = FocusNode();
    super.initState();
  }

  void _pickedImage() {
    showDialog<ImageSource>(
      context: context,
      builder: (context) =>
          AlertDialog(content: const Text("Chọn phương tiện"), actions: [
        TextButton(
          child: const Text("Camera"),
          onPressed: () => Navigator.pop(context, ImageSource.camera),
        ),
        TextButton(
          child: const Text("Thư viện ảnh"),
          onPressed: () => Navigator.pop(context, ImageSource.gallery),
        ),
      ]),
    ).then((source) async {
      if (source != null) {
        final pickedFile = await ImagePicker().pickImage(source: source);
        setState(() => imageAdd = File(pickedFile!.path));
      }
    });
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
                  if (imageAdd != null)
                    SizedBox(
                        height: deviceSize.width * 1 / 3,
                        child: Image.file(imageAdd!)),
                  CustomSizedBox(
                    context: context,
                    height: 16,
                  ),
                  if (imageAdd == null)
                    SizedBox(
                        height: deviceSize.width * 1 / 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: DottedBorder(
                              color: CustomColor.black,
                              strokeWidth: 1,
                              dashPattern: const [8, 4],
                              child: Center(
                                child: ButtonIcon(
                                    height: deviceSize.height / 2.6,
                                    width: 50,
                                    url: "assets/images/plus.png",
                                    text: "",
                                    onPressFunction: () => _pickedImage(),
                                    isLoading: false,
                                    textColor: Colors.white,
                                    buttonColor: Colors.white,
                                    borderRadius: 2),
                              )),
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
                            AddedImage image = AddedImage(
                                description: _note,
                                name: _name,
                                image: imageAdd);
                            if (imageAdd != null) {
                              context
                                  .read<AddedImage>()
                                  .setImage(aimage: image);
                            }
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
      ),
    );
  }
}
