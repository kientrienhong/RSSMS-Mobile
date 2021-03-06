import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/constants/constants.dart';
import 'package:rssms/helpers/date_format.dart';
import 'package:rssms/models/create_order_request_model.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/pages/customers/cancel_request.dart/cancel_request_screen.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_product_widget.dart';
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
    Widget statusText = CustomText(
        text: listStatusOrder[_model.invoice.typeOrder]![_model.invoice.status]
            ['name']! as String,
        color: listStatusOrder[_model.invoice.typeOrder]![_model.invoice.status]
            ['color'] as Color,
        context: context,
        fontWeight: FontWeight.bold,
        fontSize: 16);
    if (!_model.invoice.isOrder!) {
      statusText = CustomText(
          text: listRequestStatus[_model.invoice.status]['name']! as String,
          color: listRequestStatus[_model.invoice.status]['color'] as Color,
          context: context,
          fontWeight: FontWeight.bold,
          fontSize: 16);
    }
    return Scaffold(
      backgroundColor: CustomColor.white,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomAppBar(
                      isHome: false,
                      name: "Chi ti???t y??u c???u",
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: "Tr???ng th??i:",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                statusText,
                                Container(
                                  width: 2,
                                  height: deviceSize.height / 40,
                                  color: CustomColor.black,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                ),
                                CustomText(
                                    text: mapIsPaid[_model.invoice.isPaid]![
                                        'name']! as String,
                                    color: mapIsPaid[_model.invoice.isPaid]![
                                        'color'] as Color,
                                    context: context,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ],
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
                                text: "Ng??y l???y h??ng:",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                            CustomText(
                                text: DateFormatHelper.formatToVNDay(
                                    _model.invoice.deliveryDate),
                                color: Colors.black,
                                context: context,
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
                                text: "Khung gi??? l???y h??ng:",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                            CustomText(
                                text: _model.invoice.deliveryTime.isEmpty
                                    ? 'Kh??ch t??? v???n chuy???n'
                                    : _model.invoice.deliveryTime,
                                color: Colors.black,
                                context: context,
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
                                text: "Ng??y tr??? h??ng:",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                            CustomText(
                                text: DateFormatHelper.formatToVNDay(
                                    _model.invoice.returnDate),
                                color: Colors.black,
                                context: context,
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
                                text: "?????a ch??? c???a kh??ch:",
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
                                maxLines: 3,
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
                                text: "T??n kho:",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                            SizedBox(
                              width: deviceSize.width * 1.5 / 3,
                              child: CustomText(
                                text: _model.invoice.storageName,
                                color: CustomColor.black,
                                textAlign: TextAlign.right,
                                context: context,
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
                                text: "?????a ch??? kho:",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                            SizedBox(
                              width: deviceSize.width * 1.5 / 3,
                              child: CustomText(
                                text: _model.invoice.storageAddress,
                                color: CustomColor.black,
                                textAlign: TextAlign.right,
                                context: context,
                                maxLines: 3,
                                fontSize: 16,
                                textOverflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                        if (_model.invoice.status == 0)
                          CustomSizedBox(
                            context: context,
                            height: 24,
                          ),
                        if (_model.invoice.status == 0)
                          Align(
                            alignment: Alignment.topLeft,
                            child: CustomText(
                                text: "L?? do h???y:",
                                color: Colors.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        if (_model.invoice.status == 0)
                          CustomSizedBox(
                            context: context,
                            height: 10,
                          ),
                        if (_model.invoice.status == 0)
                          Align(
                            alignment: Alignment.topLeft,
                            child: CustomText(
                                text: _model.request.cancelReason,
                                color: CustomColor.black,
                                maxLines: 20,
                                context: context,
                                fontSize: 15),
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
                                  isInvoice: false,
                                  deviceSize: deviceSize,
                                  invoice: _model.invoice),
                              CustomSizedBox(
                                context: context,
                                height: 16,
                              ),
                              CustomText(
                                  text: "M?? QR",
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
                              if (_model.invoice.status != 0 &&
                                  _model.isValidToCancel)
                                Center(
                                  child: CustomButton(
                                      height: 24,
                                      isLoading: false,
                                      text: 'H???y y??u c???u',
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
