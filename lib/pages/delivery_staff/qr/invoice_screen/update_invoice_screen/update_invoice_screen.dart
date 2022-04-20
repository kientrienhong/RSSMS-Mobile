import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_bottom_navigation.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input_with_hint.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/image_widget.dart';
import 'package:rssms/constants/constants.dart';
import 'package:rssms/helpers/validator.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_additional_fee.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/invoice_update_model.dart';
import 'package:rssms/pages/delivery_staff/delivery/delivery_screen.dart';
import 'package:rssms/pages/delivery_staff/my_account/my_account_delivery.dart';
import 'package:rssms/pages/delivery_staff/notifcation/notification_delivery.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/new_invoice_screen/new_invoice_screen.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/update_invoice_screen/widget/addition_cost.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/update_invoice_screen/widget/addition_service_widget.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/update_invoice_screen/widget/dialog_add_service.dart';
import 'package:rssms/pages/delivery_staff/qr/qr_screen.dart';
import 'package:rssms/pages/office_staff/my_account/my_account_office.dart';
import 'package:rssms/presenters/invoice_update_presenter.dart';
import 'package:rssms/views/invoice_update_view.dart';
import 'package:rssms/constants/constants.dart' as constant;

class UpdateInvoiceScreen extends StatefulWidget {
  final bool? isView;
  final bool? isScanQR;
  final bool isDone;
  const UpdateInvoiceScreen(
      {Key? key, this.isView, this.isScanQR, required this.isDone})
      : super(key: key);

  @override
  _UpdateInvoiceScreenState createState() => _UpdateInvoiceScreenState();
}

class _UpdateInvoiceScreenState extends State<UpdateInvoiceScreen>
    implements UpdateInvoiceView {
  late InvoiceUpdatePresenter _presenter;
  late InvoiceUpdateModel _model;

  final _focusNodeFullname = FocusNode();
  final _focusNodePhone = FocusNode();
  final _focusNodeAdditionFeeDescription = FocusNode();
  final _focusNodeAdditionFeePrice = FocusNode();
  final _focusNodeComposentationDescription = FocusNode();
  final _focusNodeComposentationPrice = FocusNode();
  File? image;

  @override
  void initState() {
    Invoice invoice = Provider.of<Invoice>(context, listen: false);

    Users users = Provider.of<Users>(context, listen: false);
    _presenter = InvoiceUpdatePresenter(users, invoice);
    _presenter.setView(this);
    _model = _presenter.model;
    super.initState();
  }

  @override
  void updateError(String error) {
    setState(() {
      _model.error = error;
    });
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

  void onAddAdditionSeperate(OrderDetail product) {
    Invoice invoice = Provider.of<Invoice>(context, listen: false);
    Invoice invoiceTemp = invoice.copyWith();
    int indexFound = invoiceTemp.orderDetails
        .indexWhere((element) => element.productId == product.productId);

    if (indexFound == -1) {
      invoiceTemp.orderDetails.add(OrderDetail(
          id: '${invoiceTemp.orderDetails.length} - ${product.productName}',
          productId: product.id,
          productName: product.productName,
          price: product.price,
          status: -1,
          amount: 1,
          serviceImageUrl: product.serviceImageUrl,
          productType: product.productType,
          note: '',
          images: []));
    } else {
      int quantity = invoiceTemp.orderDetails[indexFound].amount;
      invoiceTemp.orderDetails[indexFound] =
          invoiceTemp.orderDetails[indexFound].copyWith(amount: ++quantity);
    }
    invoice.setInvoice(invoice: invoiceTemp);
  }

  void onMinusAdditionSeperate(OrderDetail product) {
    Invoice invoice = Provider.of<Invoice>(context, listen: false);
    Invoice invoiceTemp = invoice.copyWith();
    int indexFound = invoiceTemp.orderDetails
        .indexWhere((element) => element.productId == product.productId);
    int quantity = invoiceTemp.orderDetails[indexFound].amount;
    if (quantity == 1) {
      invoiceTemp.orderDetails.removeAt(indexFound);
    } else {
      invoiceTemp.orderDetails[indexFound].amount--;
    }

    invoice.setInvoice(invoice: invoiceTemp);
  }

  @override
  void updateView() {
    setState(() {});
  }

  void doneOrder() async {
    try {
      Invoice invoice = Provider.of<Invoice>(context, listen: false);

      Users user = Provider.of<Users>(context, listen: false);
      var response = await _presenter.doneOrder(user, invoice);
      if (response == true) {
        CustomSnackBar.buildSnackbar(
            context: context,
            message: 'Trả đơn thành công',
            color: CustomColor.green);
        if (user.roleName == 'Delivery Staff') {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const CustomBottomNavigation(
                        listIndexStack: [
                          MyAccountDeliveryScreen(),
                          DeliveryScreen(),
                          QrScreen(),
                          NotificationDeliveryScreen(),
                        ],
                        listNavigator: constant.listDeliveryBottomNavigation,
                      )),
              (Route<dynamic> route) => false);
        } else if (user.roleName == 'Office Staff') {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const CustomBottomNavigation(
                        listIndexStack: [
                          MyAccountOfficeScreen(),
                          QrScreen(),
                        ],
                        listNavigator: constant.listOfficeBottomNavigation,
                      )),
              (Route<dynamic> route) => false);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void updateOrder() async {
    try {
      Invoice invoice = Provider.of<Invoice>(context, listen: false);
      Users user = Provider.of<Users>(context, listen: false);
      var response = await _presenter.updateOrder(user, invoice);
      if (response == true) {
        CustomSnackBar.buildSnackbar(
            context: context,
            message: 'Tạo đơn thành công',
            color: CustomColor.green);
        if (user.roleName == 'Delivery Staff') {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const CustomBottomNavigation(
                        listIndexStack: [
                          MyAccountDeliveryScreen(),
                          DeliveryScreen(),
                          QrScreen(),
                          NotificationDeliveryScreen(),
                        ],
                        listNavigator: constant.listDeliveryBottomNavigation,
                      )),
              (Route<dynamic> route) => false);
        } else if (user.roleName == 'Office Staff') {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const CustomBottomNavigation(
                        listIndexStack: [
                          MyAccountOfficeScreen(),
                          QrScreen(),
                        ],
                        listNavigator: constant.listOfficeBottomNavigation,
                      )),
              (Route<dynamic> route) => false);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void onClickUpdateOrder() async {
    if (widget.isView == false && !widget.isDone) {
      updateOrder();
    } else if (widget.isDone) {
      doneOrder();
    }
  }

  List<AddtionCost> buildListAdditionCost() {
    return _model.listAdditionCost
        .map((e) => AddtionCost(additionCost: e))
        .toList();
  }

  void deleteImageEntity(String id) {
    Invoice invoice = Provider.of<Invoice>(context, listen: false);
    Invoice invoiceTemp = invoice.copyWith();
    int indexFound = invoiceTemp.orderDetails.indexWhere((e) => e.id == id);
    setState(() {
      if (indexFound != -1) {
        invoiceTemp.orderDetails.removeAt(indexFound);
        invoice.setInvoice(invoice: invoiceTemp);
      }
    });
  }

  List<Widget> mapInvoiceWidget(List<OrderDetail> listOrderDetail) =>
      listOrderDetail
          .map<Widget>((e) => ImageWidget(
                orderDetail: e,
                deleteItem: deleteImageEntity,
                isView: widget.isView! || widget.isDone,
              ))
          .toList();

  List<Widget> mapAdditionSeperate(List<OrderDetail> listOrderDetail) {
    return listOrderDetail
        .map((e) => AdditionServiceWidget(
            orderDetail: e,
            onAddAddition: onAddAdditionSeperate,
            isView: widget.isView! || widget.isDone,
            onMinusAddition: onMinusAdditionSeperate))
        .toList();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    Invoice invoice = Provider.of<Invoice>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            color: CustomColor.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
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
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: GestureDetector(
                              onTap: () => {Navigator.of(context).pop()},
                              child: Image.asset(
                                'assets/images/arrowLeft.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          )),
                    ),
                    CustomText(
                        text: widget.isDone ? "Trả đơn hàng" : "Tạo đơn hàng",
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
                    validator: Validator.checkFullname,
                    deviceSize: deviceSize),
                CustomOutLineInputWithHint(
                    controller: _model.controllerPhone,
                    isDisable: false,
                    textInputType: TextInputType.number,
                    hintText: "Số điện thoại",
                    focusNode: _focusNodePhone,
                    validator: Validator.checkPhoneNumber,
                    deviceSize: deviceSize),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Dịch vụ",
                      color: CustomColor.black,
                      context: context,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    if (!widget.isDone)
                      CustomButton(
                          height: 20,
                          text: 'Thêm dịch vụ',
                          textSize: 14,
                          width: deviceSize.width * 1 / 3,
                          onPressFunction: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const DialogAddService(
                                    isSeperate: false,
                                  );
                                });
                          },
                          isLoading: false,
                          textColor: CustomColor.white,
                          buttonColor: CustomColor.blue,
                          borderRadius: 6)
                  ],
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
                              element.productType !=
                                  typeProduct.services.index &&
                              element.productType !=
                                  typeProduct.accessory.index)
                          .toList()),
                    );
                  },
                ),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Phụ kiện riêng",
                      color: CustomColor.black,
                      context: context,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    if (!widget.isDone)
                      CustomButton(
                          height: 20,
                          text: 'Thêm dịch vụ',
                          textSize: 14,
                          width: deviceSize.width * 1 / 3,
                          onPressFunction: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const DialogAddService(
                                    isSeperate: true,
                                  );
                                });
                          },
                          isLoading: false,
                          textColor: CustomColor.white,
                          buttonColor: CustomColor.blue,
                          borderRadius: 6)
                  ],
                ),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                Consumer<Invoice>(
                  builder: (context, invoiceLocal, child) {
                    return Column(
                      children: mapAdditionSeperate(invoiceLocal.orderDetails
                          .where((element) =>
                              element.productType ==
                                  typeProduct.services.index ||
                              element.productType ==
                                  typeProduct.accessory.index)
                          .toList()),
                    );
                  },
                ),
                if (widget.isDone &&
                    invoice.orderDetails
                        .where((element) =>
                            element.productType == typeProduct.services.index ||
                            element.productType == typeProduct.accessory.index)
                        .toList()
                        .isEmpty)
                  Center(
                    child: CustomText(
                        text: '(Trống)',
                        color: CustomColor.black[3]!,
                        context: context,
                        fontSize: 16),
                  ),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Chí phí thêm",
                      color: CustomColor.black,
                      context: context,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    Checkbox(
                        fillColor: MaterialStateProperty.all(CustomColor.blue),
                        value: _model.isAdditionFee,
                        onChanged: widget.isView == false
                            ? (value) {
                                setState(() {
                                  _model.isAdditionFee = value;
                                });
                              }
                            : (val) => {})
                  ],
                ),
                if (_model.isAdditionFee)
                  Column(
                    children: [
                      CustomSizedBox(
                        context: context,
                        height: 8,
                      ),
                      CustomOutLineInputWithHint(
                          controller: _model.controllerAdditionFeeDescription,
                          isDisable: false,
                          hintText: "Mô tả",
                          validator: Validator.notEmpty,
                          textInputType: TextInputType.multiline,
                          maxLine: 3,
                          focusNode: _focusNodeAdditionFeeDescription,
                          deviceSize: deviceSize),
                      CustomOutLineInputWithHint(
                          controller: _model.controllerAdditionFeePrice,
                          isDisable: false,
                          hintText: "Giá tiền",
                          validator: Validator.notEmpty,
                          textInputType: TextInputType.number,
                          focusNode: _focusNodeAdditionFeePrice,
                          deviceSize: deviceSize),
                    ],
                  ),
                Column(
                  children: buildListAdditionCost(),
                ),
                if (widget.isDone)
                  Column(
                    children: [
                      CustomSizedBox(
                        context: context,
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Bồi thường",
                            color: CustomColor.black,
                            context: context,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          Checkbox(
                              fillColor:
                                  MaterialStateProperty.all(CustomColor.blue),
                              value: _model.isCompensation,
                              onChanged: widget.isView == false
                                  ? (value) {
                                      setState(() {
                                        _model.isCompensation = value;
                                      });
                                    }
                                  : (val) => {})
                        ],
                      ),
                    ],
                  ),
                if (_model.isCompensation)
                  Column(
                    children: [
                      CustomSizedBox(
                        context: context,
                        height: 8,
                      ),
                      CustomOutLineInputWithHint(
                          controller:
                              _model.controllerCompensationFeeDescription,
                          isDisable: false,
                          hintText: "Mô tả",
                          validator: Validator.notEmpty,
                          textInputType: TextInputType.multiline,
                          maxLine: 3,
                          focusNode: _focusNodeComposentationDescription,
                          deviceSize: deviceSize),
                      CustomOutLineInputWithHint(
                          controller: _model.controllerCompensationFeePrice,
                          isDisable: false,
                          hintText: "Giá tiền",
                          validator: Validator.notEmpty,
                          textInputType: TextInputType.number,
                          focusNode: _focusNodeComposentationPrice,
                          deviceSize: deviceSize),
                    ],
                  ),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
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
                        onChanged: widget.isView == false
                            ? (value) {
                                setState(() {
                                  _model.setIsPaid = value;
                                });
                              }
                            : (val) => {})
                  ],
                ),
                CustomSizedBox(
                  context: context,
                  height: 8,
                ),
                if (_model.error.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          text: _model.error,
                          textAlign: TextAlign.center,
                          color: CustomColor.red,
                          context: context,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomSizedBox(
                          context: context,
                          height: 16,
                        )
                      ],
                    ),
                  ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                          height: 24,
                          isLoading: _model.isLoadingUpdateInvoice,
                          text: widget.isDone ? "Trả đơn" : 'Tạo đơn',
                          textColor: CustomColor.white,
                          onPressFunction: () {
                            Invoice invoice =
                                Provider.of<Invoice>(context, listen: false);
                            List<OrderDetail>? listImage = invoice.orderDetails;
                            bool emptyImage = false;
                            for (var image in listImage) {
                              if (image.images.isEmpty &&
                                  (image.productType ==
                                          typeProduct.handy.index ||
                                      image.productType ==
                                          typeProduct.unweildy.index)) {
                                emptyImage = true;
                                break;
                              }
                            }
                            if (emptyImage &&
                                invoice.typeOrder ==
                                    constant.doorToDoorTypeOrder) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Thông báo"),
                                      content: const Text(
                                          "Vui lòng cập nhật ít nhất 1 ảnh cho 1 box !"),
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
                            bool isValid = true;
                            for (var element in invoice.orderDetails) {
                              if (element.height == 0 &&
                                  element.width == 0 &&
                                  element.length == 0 &&
                                  element.productType !=
                                      typeProduct.accessory.index) {
                                updateError(
                                    'Vui lòng nhập kích thước của các dịch vụ');
                                isValid = false;
                              }
                            }

                            if (!isValid) {
                              return;
                            }

                            if (!_model.getIsPaid) {
                              updateError('Vui lòng thanh toán hóa đơn');
                              return;
                            }
                            if (_formKey.currentState!.validate()) {
                              onClickUpdateOrder();
                            }
                          },
                          width: deviceSize.width / 2.5,
                          buttonColor: CustomColor.blue,
                          borderRadius: 6),
                      CustomButton(
                          height: 24,
                          isLoading: false,
                          text: 'Xem trước hóa đơn',
                          textColor: CustomColor.white,
                          onPressFunction: () {
                            Invoice invoice =
                                Provider.of<Invoice>(context, listen: false);
                            if (_model.isAdditionFee &&
                                !widget.isDone &&
                                _model.controllerAdditionFeePrice.text
                                    .isNotEmpty) {
                              final listTemp = [...invoice.orderAdditionalFees];
                              listTemp.add(OrderAdditionalFee(
                                  type: constant.ADDITION_FEE_TYPE
                                      .takingAdditionFee.index,
                                  description: _model
                                      .controllerAdditionFeeDescription.text,
                                  price: double.parse(
                                      _model.controllerAdditionFeePrice.text)));
                              invoice.setInvoice(
                                  invoice: invoice.copyWith(
                                      orderAdditionalFees: listTemp));
                            } else if (_model.isAdditionFee && widget.isDone) {
                              final listTemp = [...invoice.orderAdditionalFees];
                              listTemp.add(OrderAdditionalFee(
                                  type: constant.ADDITION_FEE_TYPE
                                      .returningAdditionFee.index,
                                  description: _model
                                      .controllerAdditionFeeDescription.text,
                                  price: double.parse(
                                      _model.controllerAdditionFeePrice.text)));
                              invoice.setInvoice(
                                  invoice: invoice.copyWith(
                                      orderAdditionalFees: listTemp));
                            }

                            if (_model.isCompensation) {
                              final listTemp = [...invoice.orderAdditionalFees];
                              listTemp.add(OrderAdditionalFee(
                                  type: constant
                                      .ADDITION_FEE_TYPE.compensationFee.index,
                                  description: _model
                                      .controllerCompensationFeeDescription
                                      .text,
                                  price: double.parse(_model
                                      .controllerCompensationFeePrice.text)));
                              invoice.setInvoice(
                                  invoice: invoice.copyWith(
                                      orderAdditionalFees: listTemp));
                            }

                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewInvoiceScreen(
                                            invoice: invoice,
                                          )));
                            }
                          },
                          width: deviceSize.width / 2.5,
                          buttonColor: CustomColor.green,
                          borderRadius: 6),
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
