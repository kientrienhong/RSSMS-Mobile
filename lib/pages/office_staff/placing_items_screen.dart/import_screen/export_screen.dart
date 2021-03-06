import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_bottom_navigation.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/import_export_details.dart';
import 'package:rssms/common/import_export_info.dart';
import 'package:rssms/common/import_export_license.dart';
import 'package:rssms/common/invoice_screen.dart';
import 'package:rssms/models/entity/account.dart';
import 'package:rssms/models/entity/export.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/export_model.dart';
import 'package:rssms/pages/delivery_staff/qr/qr_screen.dart';
import 'package:rssms/pages/office_staff/my_account/my_account_office.dart';
import 'package:rssms/pages/office_staff/storage_screen/storage_screen.dart';
import 'package:rssms/presenters/export_presenter.dart';
import 'package:rssms/views/export_view.dart';
import 'package:rssms/constants/constants.dart' as constant;

class ExportScreen extends StatefulWidget {
  ExportScreen(
      {Key? key,
      required this.onClickAcceptImport,
      required this.export,
      this.invoice,
      required this.isOrderReturn,
      required this.orderDetail})
      : super(key: key);
  late Export export;
  final List<OrderDetail> orderDetail;
  late Invoice? invoice;
  final Function() onClickAcceptImport;
  final bool isOrderReturn;

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> implements ExportView {
  late ExportPresenter _presenter;
  late ExportModel _model;
  late bool isError = false;
  void updateStaff(Account user) {
    widget.export.exportDeliveryBy = user.id;
  }

  @override
  void initState() {
    _presenter = ExportPresenter();
    _model = _presenter.model;
    _presenter.view = this;
    super.initState();
  }

  @override
  void updateIsLoading() {
    setState(() {
      _model.isLoading = !_model.isLoading;
    });
  }

  void onClickUpdateOrder(BuildContext context) async {
    try {
      Users user = Provider.of<Users>(context, listen: false);
      if (widget.export.exportDeliveryBy!.isEmpty) {
        setState(() {
          isError = true;
        });
        return;
      } else {
        setState(() {
          isError = false;
        });
      }

      if (user.roleName == 'Office Staff') {
        var response = await _presenter.updateOrder(
            widget.export, widget.invoice!, user.idToken!);
        if (response == true) {
          CustomSnackBar.buildSnackbar(
              context: context,
              message: 'Xu???t kho th??nh c??ng',
              color: CustomColor.green);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CustomBottomNavigation(
                      listIndexStack: [
                        const MyAccountOfficeScreen(),
                        const QrScreen(),
                        Scaffold(
                            backgroundColor: CustomColor.white,
                            body: Container(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: Column(
                                children: [
                                  CustomSizedBox(
                                    context: context,
                                    height: 8,
                                  ),
                                  CustomText(
                                      text: 'Trang ????n h??ng',
                                      color: CustomColor.black,
                                      context: context,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                  CustomSizedBox(context: context, height: 8),
                                  const Expanded(child: InvoiceScreen()),
                                ],
                              ),
                            )),
                        const StorageScreen(),
                      ],
                      listNavigator: constant.listOfficeBottomNavigation,
                    )),
          );
        }
      } else {
        CustomSnackBar.buildSnackbar(
            context: context,
            message: 'B???n kh??ng c?? ????? quy???n',
            color: CustomColor.green);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImportExportInfo(
                  isView: false,
                  updateStaff: updateStaff,
                  export: widget.export,
                  backButton: false,
                  isExport: true,
                ),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                const SizedBox(
                  height: 0,
                  child: Divider(
                    color: CustomColor.black,
                    thickness: 1,
                  ),
                ),
                const SizedBox(
                  height: 5,
                  child: Divider(
                    color: CustomColor.black,
                    thickness: 0.5,
                  ),
                ),
                ImportExportDetails(orderDetail: widget.orderDetail),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                const ImportExportLicense(),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                if (isError)
                  CustomText(
                      text: "Vui l??ng ch???n nh??n vi??n v???n chuy???n",
                      color: CustomColor.red,
                      context: context,
                      fontSize: 16),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                Center(
                  child: CustomButton(
                      height: 24,
                      text: 'Ch???p nh???n',
                      width: deviceSize.width / 2 - 40,
                      onPressFunction: () {
                        onClickUpdateOrder(context);
                      },
                      isLoading: _model.isLoading,
                      textColor: CustomColor.white,
                      buttonColor: CustomColor.blue,
                      borderRadius: 4),
                ),
              ],
            )),
      ),
    );
  }
}
