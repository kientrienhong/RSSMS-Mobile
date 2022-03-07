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
import 'package:rssms/helpers/validator.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  void onClickImage() {
    if (widget.isView == true) return;
    showDialog<ImageSource>(
      context: context,
      builder: (context) =>
          AlertDialog(content: const Text("Chọn nguồn ảnh"), actions: [
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
        if (pickedFile != null) {
          setState(() => _model.file = File(pickedFile.path));
        }
      }
    });
  }

  void addImage() {
    var listImage = [...widget.orderDetail.images];

    listImage.add(ImageEntity(
        file: _model.file, name: _model.name.text, note: _model.note.text));
    OrderDetail orderDetailtemp =
        widget.orderDetail.copyWith(images: listImage);
    Invoice invoice = Provider.of<Invoice>(context, listen: false);
    invoice.updateOrderDetail(orderDetailtemp);
  }

  void editImage() {
    var listImage = [...widget.orderDetail.images];

    int indexFound =
        listImage.indexWhere((element) => element.id == widget.imageUpdate!.id);
    listImage[indexFound] = listImage[indexFound].copyWith(
      file: _model.file,
      name: _model.name.text,
      note: _model.note.text,
    );
    OrderDetail orderDetailtemp =
        widget.orderDetail.copyWith(images: listImage);
    Invoice invoice = Provider.of<Invoice>(context, listen: false);
    invoice.updateOrderDetail(orderDetailtemp);
  }

  @override
  void onClickSubmit() {
    if (widget.isView == true) {
      Navigator.of(context).pop();
      return;
    }

    if (_formKey.currentState!.validate()) {
      if (widget.imageUpdate == null) {
        if (_model.file != null) {
          addImage();
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Thông báo"),
                  content:
                      const Text("Vui lòng cập nhật ảnh"),
                  actions: [
                    TextButton(
                      child: const Text("Đồng ý"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
              return;
        }
      } else {
        editImage();
      }
      Navigator.of(context).pop();
    }
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
      } else if (widget.imageUpdate != null) {
        if (widget.imageUpdate!.url != null) {
          return Image.network(
            widget.imageUpdate!.url!,
          );
        }
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
          child: Form(
            key: _formKey,
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
                    validator: Validator.notEmpty,
                    controller: _model.name,
                    isDisable: widget.isView,
                    focusNode: _nameFocusNode,
                    deviceSize: deviceSize,
                    nextNode: _noteFocusNode,
                    labelText: 'Tên'),
                CustomOutLineInput(
                    validator: Validator.notEmpty,
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
      ),
    );
  }
}
