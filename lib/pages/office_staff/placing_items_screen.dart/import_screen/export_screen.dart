import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_snack_bar.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/import_export_details.dart';
import 'package:rssms/common/import_export_info.dart';
import 'package:rssms/common/import_export_license.dart';
import 'package:rssms/models/entity/account.dart';
import 'package:rssms/models/entity/export.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/export_model.dart';
import 'package:rssms/presenters/export_presenter.dart';
import 'package:rssms/views/export_view.dart';

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
              message: 'Xuất kho thành công',
              color: CustomColor.green);

          Navigator.of(context)
            ..pop()
            ..pop();
        }
      } else {
        CustomSnackBar.buildSnackbar(
            context: context,
            message: 'Bạn không có đủ quyền',
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
                      text: "Vui lòng chọn nhân viên vận chuyển",
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
                      text: 'Chấp nhận',
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
