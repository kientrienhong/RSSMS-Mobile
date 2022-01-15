import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_input_with_hint.dart';
import 'package:rssms/common/custom_radio_button.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/update_image_invoice.dart';
import 'package:rssms/constants/constants.dart';
import 'package:rssms/models/entity/add_image.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/invoice_update_model.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/update_invoice_screen/image_widget.dart';
import 'package:rssms/pages/log_in/widget/button_icon.dart';
import 'package:rssms/presenters/invoice_update_presenter.dart';
import 'package:rssms/views/invoice_update_view.dart';

class UpdateInvoiceScreen extends StatefulWidget {
  UpdateInvoiceScreen({Key? key}) : super(key: key);

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
  updateLoadingProfile() {
    setState(() {
      _presenter.model.isLoadingUpdateInvoice =
          !_presenter.model.isLoadingUpdateInvoice;
    });
  }

  _buildGridView({
    required List<AddedImage> path,
    required Size deviceSize,
  }) {
    return SizedBox(
      height:
          path.length >= 2 ? deviceSize.height / 1.8 : deviceSize.height / 4,
      child: GridView.builder(
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              childAspectRatio: 1,
              mainAxisSpacing: 7),
          itemCount: path.length == 4 ? path.length : path.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == path.length) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: DottedBorder(
                    color: CustomColor.black,
                    strokeWidth: 1,
                    dashPattern: const [8, 4],
                    child: Center(
                      child: ButtonIcon(
                          height: path.length >= 2
                              ? deviceSize.height / 2.6
                              : deviceSize.height / 4,
                          width: 50,
                          url: "assets/images/plus.png",
                          text: "",
                          onPressFunction: () => showDialog(
                              context: context,
                              builder: (ctx) {
                                return UpdateImageInvoice(
                                  isDisable: false,
                                );
                              }),
                          isLoading: false,
                          textColor: Colors.white,
                          buttonColor: Colors.white,
                          borderRadius: 2),
                    )),
              );
            }
            return Stack(children: [
              Container(
                width: deviceSize.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: CustomColor.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 14,
                          color: Color(0x000000).withOpacity(0.06),
                          offset: const Offset(0, 6)),
                    ]),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        path[index].image!,
                        height: deviceSize.height / 6.5,
                        width: deviceSize.width,
                      ),
                    ),
                    CustomText(
                        text: path[index].name.toString(),
                        color: Colors.black,
                        context: context,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(const CircleBorder()),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    overlayColor:
                        MaterialStateProperty.resolveWith<Color?>((states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.red;
                    }),
                  ),
                ),
              )
            ]);
          }),
    );
  }

  List<Widget> mapInvoiceWidget(List<OrderDetail> listOrderDetail) =>
      listOrderDetail
          .map<ImageWidget>((e) => ImageWidget(
                orderDetail: e,
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
                    onPressFunction: null,
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
