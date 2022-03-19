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
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/invoice_update_model.dart';
import 'package:rssms/pages/customers/cart/cart_screen.dart';
import 'package:rssms/pages/customers/my_account/my_account.dart';
import 'package:rssms/pages/customers/notification/notification_screen.dart';
import 'package:rssms/pages/delivery_staff/delivery/delivery_screen.dart';
import 'package:rssms/pages/delivery_staff/my_account/my_account_delivery.dart';
import 'package:rssms/pages/delivery_staff/notifcation/notification_delivery.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/update_invoice_screen/widget/addition_cost.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/update_invoice_screen/widget/dialog_add_cost.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/update_invoice_screen/widget/dialog_add_service.dart';
import 'package:rssms/pages/delivery_staff/qr/qr_screen.dart';
import 'package:rssms/presenters/invoice_update_presenter.dart';
import 'package:rssms/views/invoice_update_view.dart';
import 'package:rssms/constants/constants.dart' as constant;

class UpdateInvoiceScreen extends StatefulWidget {
  final bool? isView;
  final bool? isScanQR;
  UpdateInvoiceScreen({Key? key, this.isView, this.isScanQR}) : super(key: key);

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
        CustomSnackBar.buildErrorSnackbar(
            context: context,
            message: 'Trả đơn thành công',
            color: CustomColor.green);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const CustomBottomNavigation(
                      listIndexStack: [
                        MyAccountDeliveryScreen(),
                        DeliveryScreen(),
                        QrScreen(),
                        NotificationDeliveryScreen(),
                      ],
                      listNavigator: constant.LIST_DELIVERY_BOTTOM_NAVIGATION,
                    )),
            (Route<dynamic> route) => false);
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
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => const CustomBottomNavigation(
                      listIndexStack: [
                        MyAccountScreen(),
                        CartScreen(),
                        NotificationScreen(),
                      ],
                      listNavigator: constant.LIST_CUSTOMER_BOTTOM_NAVIGATION,
                    )),
            (Route<dynamic> route) => false);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClickUpdateOrder() async {
    if (widget.isView == null) {
      sendNoti();
    } else if (widget.isScanQR == true && widget.isView == true) {
      doneOrder();
    } else if (widget.isScanQR == null && widget.isView == true) {
      updateOrder();
    }
  }

  List<AddtionCost> buildListAdditionCost() {
    return _model.listAdditionCost
        .map((e) => AddtionCost(additionCost: e))
        .toList();
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
                isView: widget.isView ?? false,
              ))
          .toList();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

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
                    CustomButton(
                        height: 16,
                        text: 'Thêm dịch vụ',
                        width: deviceSize.width * 1 / 3.5,
                        onPressFunction: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return DialogAddService();
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
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return DialogAddCost(
                                listAdditionCost: _model.listAdditionCost,
                                addAdditionCost: _presenter.addAdditionCost,
                                updateAdditionCost:
                                    _presenter.updateAdditionCost,
                              );
                            });
                      },
                      child: Row(
                        children: [
                          CustomText(
                            text: "Thêm",
                            color: CustomColor.blue,
                            context: context,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomSizedBox(
                            context: context,
                            width: 8,
                          ),
                          Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                                color: CustomColor.blue,
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: CustomText(
                                  text: '+',
                                  color: CustomColor.white,
                                  context: context,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: buildListAdditionCost(),
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
                        onChanged: widget.isView == null
                            ? (value) {
                                setState(() {
                                  _model.setIsPaid = value;
                                });
                              }
                            : (val) => {})
                  ],
                ),
                Center(
                  child: CustomButton(
                      height: 24,
                      isLoading: _model.isLoadingUpdateInvoice,
                      text: 'Cập nhật đơn',
                      textColor: CustomColor.white,
                      onPressFunction: () {
                        Invoice invoice =
                            Provider.of<Invoice>(context, listen: false);
                        List<OrderDetail>? listImage = invoice.orderDetails;
                        bool emptyImage = false;
                        for (var image in listImage) {
                          if (image.images.isEmpty) {
                            emptyImage = true;
                            break;
                          }
                        }
                        if (_formKey.currentState!.validate() && !emptyImage) {
                          onClickUpdateOrder();
                        }
                        if (emptyImage) {
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
                        }
                      },
                      width: deviceSize.width / 2.5,
                      buttonColor: CustomColor.blue,
                      borderRadius: 6),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
