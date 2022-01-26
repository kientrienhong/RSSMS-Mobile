import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input_with_hint.dart';
import 'package:rssms/common/custom_radio_button.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/constants/constants.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/invoice_update_model.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/update_invoice_screen/image_widget.dart';
import 'package:rssms/presenters/invoice_update_presenter.dart';
import 'package:rssms/views/invoice_update_view.dart';

class UpdateInvoiceScreen extends StatefulWidget {
  final bool? isView;
  UpdateInvoiceScreen({Key? key, this.isView}) : super(key: key);

  @override
  _UpdateInvoiceScreenState createState() => _UpdateInvoiceScreenState();
}

class _UpdateInvoiceScreenState extends State<UpdateInvoiceScreen>
    implements UpdateInvoiceView {
  late InvoiceUpdatePresenter _presenter;
  late InvoiceUpdateModel _model;

  final _focusNodeFullname = FocusNode();
  final _focusNodePhone = FocusNode();

  File? image;
  List<bool>? _isOpen;

  @override
  void initState() {
    Invoice invoice = Provider.of<Invoice>(context, listen: false);

    Users users = Provider.of<Users>(context, listen: false);
    _presenter = InvoiceUpdatePresenter(users, invoice);
    _isOpen =
        List<bool>.generate(invoice.orderDetails.length, (index) => false);
    _presenter.setView(this);
    _model = _presenter.model;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNodeFullname.dispose();
    _focusNodePhone.dispose();
  }

  @override
  void updateLoadingUpdate() {
    setState(() {
      _presenter.model.isLoadingUpdateInvoice =
          !_presenter.model.isLoadingUpdateInvoice;
    });
  }

  void sendNoti() async {
    try {
      Invoice invoice = Provider.of<Invoice>(context, listen: false);

      Users user = Provider.of<Users>(context, listen: false);
      var response = await _presenter.sendNoti(user, invoice);
      if (response == true) {
        CustomSnackBar.buildErrorSnackbar(
            context: context,
            message: 'Gửi thông báo thành công',
            color: CustomColor.green);
      }
    } catch (e) {
      print(e);
    }
  }

  void updateOrder() async {
    try {
      Invoice invoice = Provider.of<Invoice>(context, listen: false);

      Users user = Provider.of<Users>(context, listen: false);
      var response = await _presenter.updateOrder(user, invoice);
      if (response == true) {
        CustomSnackBar.buildErrorSnackbar(
            context: context,
            message: 'Cập nhật đơn thành công',
            color: CustomColor.green);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClickUpdateOrder() async {
    if (widget.isView == null) {
      sendNoti();
    } else {
      updateOrder();
    }
  }

  List<Widget> mapInvoiceWidget(List<OrderDetail> listOrderDetail) =>
      listOrderDetail
          .map<ImageWidget>((e) => ImageWidget(
                orderDetail: e,
                isView: widget.isView ?? false,
              ))
          .toList();

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    Invoice invoice = Provider.of<Invoice>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: CustomColor.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSizedBox(
                context: context,
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: GestureDetector(
                      onTap: () => {Navigator.of(context).pop()},
                      child: Image.asset('assets/images/arrowLeft.png'),
                    ),
                  ),
                  CustomText(
                      text: "Cập nhật đơn hàng",
                      color: Colors.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                  CustomSizedBox(
                    context: context,
                    height: 0,
                  ),
                ],
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              CustomText(
                text: "Thông tin khách hàng",
                color: CustomColor.black,
                context: context,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              CustomOutLineInputWithHint(
                  controller: _model.controllerFullname,
                  isDisable: false,
                  hintText: "Họ và Tên",
                  focusNode: _focusNodeFullname,
                  deviceSize: deviceSize),
              CustomOutLineInputWithHint(
                  controller: _model.controllerPhone,
                  isDisable: false,
                  hintText: "Phone",
                  focusNode: _focusNodePhone,
                  deviceSize: deviceSize),
              CustomText(
                text: "Hình ảnh",
                color: CustomColor.black,
                context: context,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              Consumer<Invoice>(
                builder: (context, invoiceLocal, child) {
                  return Column(
                    children: mapInvoiceWidget(invoiceLocal.orderDetails
                        .where((element) =>
                            element.productType != SERVICES &&
                            element.productType != ACCESSORY)
                        .toList()),
                  );
                },
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              CustomText(
                text: "Tình trạng đơn hàng",
                color: CustomColor.black,
                context: context,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              CustomRadioButton(
                  function: () {
                    setState(() {
                      _model.txtStatus = "Đã đặt";
                    });
                  },
                  text: "Đã đặt",
                  color: Colors.black,
                  state: _model.txtStatus,
                  value: "Đã đặt"),
              CustomRadioButton(
                  function: () {
                    setState(() {
                      _model.txtStatus = "Đang lưu kho";
                    });
                  },
                  text: "Đang lưu kho",
                  color: CustomColor.black,
                  state: _model.txtStatus,
                  value: "Đang lưu kho"),
              CustomRadioButton(
                  function: () {
                    setState(() {
                      _model.txtStatus = "Yêu cầu trả";
                    });
                  },
                  text: "Yêu cầu trả",
                  color: CustomColor.black,
                  state: _model.txtStatus,
                  value: "Yêu cầu trả"),
              CustomRadioButton(
                  function: () {
                    setState(() {
                      _model.txtStatus = "Đã trả";
                    });
                  },
                  text: "Đã trả",
                  color: CustomColor.black,
                  state: _model.txtStatus,
                  value: "Đã trả"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Đã thanh toán",
                    color: CustomColor.black,
                    context: context,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  Checkbox(
                      fillColor: MaterialStateProperty.all(CustomColor.blue),
                      value: _model.getIsPaid,
                      onChanged: (value) {
                        setState(() {
                          _model.setIsPaid = value;
                        });
                      })
                ],
              ),
              Center(
                child: CustomButton(
                    height: 24,
                    isLoading: _model.isLoadingUpdateInvoice,
                    text: 'Cập nhật đơn',
                    textColor: CustomColor.white,
                    onPressFunction: onClickUpdateOrder,
                    width: deviceSize.width / 2.5,
                    buttonColor: CustomColor.blue,
                    borderRadius: 6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
