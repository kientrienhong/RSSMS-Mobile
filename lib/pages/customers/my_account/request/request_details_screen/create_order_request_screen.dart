import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/constants/constants.dart';
import 'package:rssms/models/create_order_request_model.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/pages/customers/cancel_request.dart/cancel_request_screen.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_cancelled_screen/invoice_cancelled_screen.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_info_widget.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_product_widget.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoive_update/send_request_screen.dart';
import 'package:rssms/pages/time_line/time_line_screen.dart';
import 'package:rssms/presenters/create_order_request_presenter.dart';
import 'package:rssms/views/create_order_request_view.dart';

class CreateOrderRequestScreen extends StatefulWidget {
  final String id;
  const CreateOrderRequestScreen({Key? key, required this.id})
      : super(key: key);

  @override
  State<CreateOrderRequestScreen> createState() =>
      _CreateOrderRequestScreenState();
}

class _CreateOrderRequestScreenState extends State<CreateOrderRequestScreen>
    implements CreateOrderRequestView {
  late CreateOrderRequestPresenter _presenter;
  late CreateOrderRequestModel _model;

  @override
  void initState() {
    _presenter = CreateOrderRequestPresenter(widget.id);
    _model = _presenter.model;
    _presenter.view = this;
    Users user = Provider.of<Users>(context, listen: false);
    _presenter.getDetailRequest(user.idToken!);
    super.initState();
  }

  @override
  updateView(Invoice invoice) {
    setState(() {
      _model.invoice = invoice;
    });
  }

  @override
  updateLoading() {
    setState(() {
      _model.isLoading = !_model.isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: _model.isLoading
            ? SizedBox(
                width: deviceSize.width,
                height: deviceSize.height,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SizedBox(
                        height: 48,
                        width: 48,
                        child: CircularProgressIndicator(
                          backgroundColor: CustomColor.blue,
                        ),
                      ),
                    ]),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const CustomAppBar(
                      isHome: false,
                      name: "Chi tiết đơn hàng",
                    ),
                    Column(
                      children: [
                        CustomText(
                            text: _model.invoice.id,
                            color: CustomColor.black,
                            context: context,
                            fontSize: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: "Trạng thái:",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                            CustomText(
                                text: LIST_STATUS_ORDER[_model.invoice.status]
                                    ['name']! as String,
                                color: LIST_STATUS_ORDER[_model.invoice.status]
                                    ['color'] as Color,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ],
                        ),
                        CustomSizedBox(
                          context: context,
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: "Ngày nhận hàng:",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                            CustomText(
                                text: _model.invoice.deliveryDate.substring(0,
                                    _model.invoice.deliveryDate.indexOf("T")),
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ],
                        ),
                        CustomSizedBox(
                          context: context,
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: "Ngày trả hàng:",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                            CustomText(
                                text: _model.invoice.returnDate.substring(
                                    0, _model.invoice.returnDate.indexOf("T")),
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ],
                        ),
                        CustomSizedBox(
                          context: context,
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: "Địa chỉ:",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                            SizedBox(
                              width: deviceSize.width * 1.5 / 3,
                              child: CustomText(
                                text: _model.invoice.deliveryAddress,
                                color: CustomColor.black,
                                textAlign: TextAlign.right,
                                context: context,
                                fontWeight: FontWeight.bold,
                                maxLines: 2,
                                fontSize: 16,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        CustomSizedBox(
                          context: context,
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: "Mã giảm giá:",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                            CustomText(
                                text: "Không có",
                                color: Colors.black38,
                                context: context,
                                fontSize: 16)
                          ],
                        ),
                        CustomSizedBox(
                          context: context,
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: "Thông tin vận chuyển:",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                            CustomButton(
                                height: 24,
                                isLoading: false,
                                text: 'Xem thêm',
                                textColor: CustomColor.white,
                                onPressFunction: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TimeLineScreen()));
                                },
                                width: deviceSize.width / 3,
                                buttonColor: CustomColor.blue,
                                borderRadius: 6),
                          ],
                        ),
                        SizedBox(
                          width: deviceSize.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomSizedBox(
                                context: context,
                                height: 16,
                              ),
                              InvoiceProductWidget(
                                  deviceSize: deviceSize,
                                  invoice: _model.invoice),
                              CustomSizedBox(
                                context: context,
                                height: 16,
                              ),
                              CustomText(
                                  text: "QR code",
                                  color: CustomColor.blue,
                                  context: context,
                                  textAlign: TextAlign.right,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                              SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: QrImage(
                                    data: _model.invoice.id,
                                    size: 88.0,
                                    gapless: true,
                                    version: 4,
                                  ),
                                ),
                              ),
                              CustomSizedBox(
                                context: context,
                                height: 16,
                              ),
                              if (_model.invoice.status != 0)
                                Center(
                                  child: CustomButton(
                                      height: 24,
                                      isLoading: false,
                                      text: 'Hủy yêu cầu',
                                      textColor: CustomColor.white,
                                      onPressFunction: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InvoiceCancelScreen(
                                                    invoice: _model.invoice,
                                                  )),
                                        );
                                      },
                                      width: deviceSize.width / 2.5,
                                      buttonColor: CustomColor.blue,
                                      borderRadius: 6),
                                ),
                              if (_model.invoice.status == 0)
                                Center(
                                  child: CustomButton(
                                      height: 24,
                                      isLoading: false,
                                      text: 'Chi tiết đơn hủy',
                                      textColor: CustomColor.white,
                                      onPressFunction: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const InvoiceCancelledScreen()),
                                        );
                                      },
                                      width: deviceSize.width / 2.5,
                                      buttonColor: CustomColor.blue,
                                      borderRadius: 6),
                                )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
