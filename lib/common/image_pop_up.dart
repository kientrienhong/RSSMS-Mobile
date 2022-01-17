import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/add_image_pop_up_model.dart';
import 'package:rssms/models/entity/imageEntity.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/presenters/add_image_pop_up_presenter.dart';
import 'package:rssms/views/add_image_pop_up_view.dart';

class ImageDetailPopUp extends StatefulWidget {
  final bool isView;
  OrderDetail orderDetail;
  ImageEntity? imageUpdate;
  ImageDetailPopUp(
      {Key? key,
      required this.isView,
      required this.orderDetail,
      this.imageUpdate})
      : super(key: key);

  @override
  _ImageDetailPopUpState createState() => _ImageDetailPopUpState();
}

class _ImageDetailPopUpState extends State<ImageDetailPopUp>
    implements AddImagePopUpView {
  late AddImagePopUpPresenter _presenter;
  late AddImagePopUpModel _model;
  late FocusNode _nameFocusNode;
  late FocusNode _noteFocusNode;

  @override
  void onClickImage() {
    showDialog<ImageSource>(
      context: context,
      builder: (context) =>
          AlertDialog(content: const Text("Choose image source"), actions: [
        TextButton(
          child: const Text("Camera"),
          onPressed: () => Navigator.pop(context, ImageSource.camera),
        ),
        TextButton(
          child: const Text("Gallery"),
          onPressed: () => Navigator.pop(context, ImageSource.gallery),
        ),
      ]),
    ).then((source) async {
      if (source != null) {
        final pickedFile = await ImagePicker().pickImage(source: source);
        setState(() => _model.file = File(pickedFile!.path));
      }
    });
  }

  @override
  void onClickSubmit() {
    var listImage = [...widget.orderDetail.images];

    listImage.add(ImageEntity(
        file: _model.file, name: _model.name.text, note: _model.note.text));
    OrderDetail orderDetailtemp =
        widget.orderDetail.copyWith(images: listImage);
    Invoice invoice = Provider.of<Invoice>(context, listen: false);
    invoice.updateOrderDetail(orderDetailtemp);
    // var listImageUpdateTemp = [...widget.orderDetail.listImageUpdate!];

    // listImageUpdateTemp.add({
    //   'name': _model.name.text,
    //   'note': _model.note.text,
    //   'file': _model.file
    // });
    // OrderDetail orderDetailtemp =
    //     widget.orderDetail.copyWith(listImageUpdate: listImageUpdateTemp);

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _presenter = AddImagePopUpPresenter(widget.imageUpdate);
    _model = _presenter.model;
    _presenter.view = this;
    _nameFocusNode = FocusNode();
    _noteFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildImageWidget(Size deviceSize) {
      if (_model.file != null) {
        return GestureDetector(
          onTap: () {
            onClickImage();
          },
          child: Image.file(
            _model.file!,
          ),
        );
      } else {
        return DottedBorder(
            color: CustomColor.black,
            strokeWidth: 1,
            dashPattern: const [8, 4],
            child: Center(
              child: TextButton(
                  onPressed: () {
                    onClickImage();
                  },
                  clipBehavior: Clip.none,
                  autofocus: false,
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(deviceSize.width, deviceSize.width * 1 / 3))),
                  child: Image.asset('assets/images/plus.png')),
            ));
      }
    }

    final deviceSize = MediaQuery.of(context).size;
    return Dialog(
      elevation: 16,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: deviceSize.width * 2 / 3,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: _buildImageWidget(deviceSize))),
              CustomSizedBox(
                context: context,
                height: 24,
              ),
              CustomOutLineInput(
                  controller: _model.name,
                  isDisable: widget.isView,
                  focusNode: _nameFocusNode,
                  deviceSize: deviceSize,
                  nextNode: _noteFocusNode,
                  labelText: 'Tên'),
              CustomOutLineInput(
                  controller: _model.note,
                  isDisable: widget.isView,
                  focusNode: _noteFocusNode,
                  maxLine: 8,
                  deviceSize: deviceSize,
                  labelText: 'Ghi chú'),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              CustomButton(
                  height: 24,
                  text: 'Xác nhận',
                  width: deviceSize.width * 1.2 / 3,
                  onPressFunction: () {
                    onClickSubmit();
                  },
                  isLoading: false,
                  textColor: CustomColor.white,
                  buttonColor: CustomColor.blue,
                  borderRadius: 6),
            ],
          ),
        ),
      ),
    );
  }
}
