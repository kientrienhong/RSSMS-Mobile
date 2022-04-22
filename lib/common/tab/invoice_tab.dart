import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/export.dart';
import 'package:rssms/models/entity/import.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/placing_items.dart';
import 'package:rssms/models/entity/request.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_cancelled_screen/invoice_cancelled_screen.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_info_widget.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoice_detail_screen/invoice_product_widget.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoive_update/send_request_screen.dart';
import 'package:rssms/pages/office_staff/placing_items_screen.dart/import_screen/export_screen.dart';
import 'package:rssms/presenters/invoice_update_presenter.dart';
import 'package:rssms/views/invoice_update_view.dart';

class InvoiceTab extends StatefulWidget {
  final Invoice invoice;
  final Invoice orginalInvoice;
  final Size deviceSize;
  final bool isOrderReturn;
  final Request? request;

  const InvoiceTab(
      {Key? key,
      this.request,
      required this.isOrderReturn,
      required this.orginalInvoice,
      required this.deviceSize,
      required this.invoice})
      : super(key: key);

  @override
  State<InvoiceTab> createState() => _InvoiceTabState();
}

class _InvoiceTabState extends State<InvoiceTab> implements UpdateInvoiceView {
  late InvoiceUpdatePresenter _presenter;

  @override
  void initState() {
    Invoice invoice = Provider.of<Invoice>(context, listen: false);

    Users users = Provider.of<Users>(context, listen: false);
    _presenter = InvoiceUpdatePresenter(users, invoice);
    _presenter.setView(this);
    super.initState();
  }

  @override
  void onClickUpdateOrder() async {}

  @override
  void updateError(String error) {}

  @override
  void updateLoadingUpdate() {}

  @override
  void updateView() {}

  @override
  Widget build(BuildContext context) {
    Users user = Provider.of<Users>(context, listen: false);

    return Column(
      children: [
        CustomSizedBox(
          context: context,
          height: 24,
        ),
        CustomText(
            text: "Chi tiết đơn hàng",
            color: Colors.black,
            context: context,
            fontWeight: FontWeight.bold,
            fontSize: 25),
        CustomSizedBox(
          context: context,
          height: 48,
        ),
        InvoiceInfoWidget(
            deviceSize: widget.deviceSize, invoice: widget.invoice),
        SizedBox(
          width: widget.deviceSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              InvoiceProductWidget(
                  deviceSize: widget.deviceSize, invoice: widget.invoice),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              CustomText(
                  text: "Mã QR",
                  color: CustomColor.blue,
                  context: context,
                  textAlign: TextAlign.right,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: QrImage(
                    data: widget.invoice.requestId!,
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
              if (widget.invoice.status != 0 &&
                  user.roleName == 'Customer' &&
                  widget.invoice.status != 8 &&
                  widget.invoice.status != 7)
                Center(
                  child: CustomButton(
                      height: 24,
                      isLoading: false,
                      text: 'Gửi yêu cầu',
                      textColor: CustomColor.white,
                      onPressFunction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SendRequestScreen(
                                    invoice: widget.invoice,
                                  )),
                        );
                      },
                      width: widget.deviceSize.width / 2.5,
                      buttonColor: CustomColor.blue,
                      borderRadius: 6),
                ),
              if (widget.invoice.status == 0)
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
                      width: widget.deviceSize.width / 2.5,
                      buttonColor: CustomColor.blue,
                      borderRadius: 6),
                ),
              if (widget.invoice.status == 1 && user.roleName == 'Office Staff')
                Center(
                  child: CustomButton(
                      height: 24,
                      isLoading: false,
                      text: 'Lưu trữ kho',
                      textColor: CustomColor.white,
                      onPressFunction: () {
                        final placingItems =
                            Provider.of<PlacingItems>(context, listen: false);
                        placingItems.setUpStoredOrder(widget.orginalInvoice);
                        placingItems.import = Import(
                            storageName: widget.orginalInvoice.storageName,
                            customerName: widget.orginalInvoice.customerName,
                            deliveryDate: widget.orginalInvoice.deliveryDate,
                            id: widget.orginalInvoice.name,
                            customerPhone: widget.orginalInvoice.customerPhone,
                            deliveryAddress:
                                widget.orginalInvoice.deliveryAddress,
                            storageAddress:
                                widget.orginalInvoice.storageAddress,
                            importDeliveryBy: '',
                            importStaff: '');
                        Navigator.pop(context);
                        CustomSnackBar.buildSnackbar(
                            context: context,
                            message: 'Thao tác thành công',
                            color: CustomColor.green);
                      },
                      width: widget.deviceSize.width / 2.5,
                      buttonColor: CustomColor.blue,
                      borderRadius: 6),
                ),
              if ((user.roleName == 'Office Staff' &&
                      widget.invoice.typeOrder == 1 &&
                      widget.isOrderReturn) ||
                  widget.invoice.status == 4)
                Center(
                  child: CustomButton(
                      height: 24,
                      isLoading: false,
                      text: 'Xuất kho',
                      textColor: CustomColor.white,
                      onPressFunction: () {
                        Users user = Provider.of<Users>(context, listen: false);
                        String formattedDate = DateFormat('yyyy-MM-dd kk:mm')
                            .format(DateTime.now());
                        Export export = Export(
                            storageName: widget.orginalInvoice.storageName,
                            storageAddress:
                                widget.orginalInvoice.storageAddress,
                            exportStaff: user.name!,
                            exportDate: formattedDate,
                            id: widget.orginalInvoice.name,
                            customerName: widget.orginalInvoice.customerName,
                            customerPhone: widget.orginalInvoice.customerPhone,
                            returnAddress: widget.request!.deliveryAddress,
                            exportDeliveryBy: '');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExportScreen(
                                      isOrderReturn: widget.isOrderReturn,
                                      invoice: widget.orginalInvoice,
                                      onClickAcceptImport: () {},
                                      export: export,
                                      orderDetail: widget.invoice.orderDetails,
                                    )));
                      },
                      width: widget.deviceSize.width / 2.5,
                      buttonColor: CustomColor.blue,
                      borderRadius: 6),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
