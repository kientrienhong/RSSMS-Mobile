import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:rssms/common/custom_app_bar.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/account.dart';
import 'package:rssms/models/entity/export.dart';
import 'package:rssms/models/entity/import.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/placing_items_screen_model.dart';
import 'package:rssms/presenters/placing_items_screen_presenter.dart';

class ImportExportInfo extends StatefulWidget {
  final bool backButton;
  final Import? import;
  final Export? export;
  final bool isExport;
  final bool isView;
  final Function(Account user)? updateStaff;
  const ImportExportInfo(
      {Key? key,
      this.import,
      this.updateStaff,
      required this.backButton,
      required this.isExport,
      required this.isView,
      this.export})
      : super(key: key);

  @override
  State<ImportExportInfo> createState() => _ImportExportInfoState();
}

class _ImportExportInfoState extends State<ImportExportInfo> {
  late PlacingItemsScreenPresenter _presenter;
  late PlacingItemsScreenModel _model;
  String qrCode = "";
  @override
  void initState() {
    _presenter = PlacingItemsScreenPresenter();
    _model = _presenter.model;
    super.initState();
  }

  Future<void> scanQR(Size deviceSize) async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    if (barcodeScanRes == '-1') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Không tìm thấy nhân viên"),
      ));
      return;
    }
    setState(() {
      qrCode = barcodeScanRes;
    });
    try {
      String prefixQrcode = qrCode.split("_")[1];
      if (prefixQrcode == "user") {
        Users user = Provider.of<Users>(context, listen: false);
        bool result = await _presenter.getStaffDetail(
            user.idToken!, qrCode.split("_")[0]);
        if (!result) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Không tìm thấy nhân viên"),
          ));
          return;
        } else {
          widget.updateStaff!(_model.deliveryStaff);
          setState(() {});
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: CustomColor.red,
          content: Text("Vui lòng quét mã trên nhân viên vận chuyển!"),
        ));
      }
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.grey,
        content: Text("Vui lòng quét mã trên nhân viên vận chuyển!"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppBar(
          isHome: widget.backButton,
          name: widget.isExport ? "Phiếu xuất kho" : "Phiếu nhập kho",
        ),
        CustomSizedBox(
          context: context,
          height: 18,
        ),
        CustomText(
          text: "Thông tin kho",
          color: CustomColor.black,
          context: context,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        CustomSizedBox(
          context: context,
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
                text: "Tên kho",
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            CustomText(
              text: widget.isExport
                  ? widget.export!.storageName
                  : widget.import!.storageName,
              color: CustomColor.black,
              context: context,
              fontSize: 16,
            ),
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
                text: "Địa chỉ",
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            Flexible(
              child: CustomText(
                textAlign: TextAlign.right,
                text: widget.isExport
                    ? widget.export!.storageAddress
                    : widget.import!.storageAddress,
                color: CustomColor.black,
                context: context,
                fontSize: 16,
                maxLines: 2,
                textOverflow: TextOverflow.fade,
              ),
            ),
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
                text: "Nhân viên thực hiện",
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            CustomText(
              text: widget.isExport
                  ? widget.export!.exportStaff
                  : widget.import!.importStaff,
              color: CustomColor.black,
              context: context,
              fontSize: 16,
            ),
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
                text: widget.isExport ? "Ngày xuất kho" : "Ngày nhập kho",
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            CustomText(
              text: widget.isExport
                  ? widget.export!.exportDate.split('T')[0]
                  : widget.import!.deliveryDate.split('T')[0],
              color: CustomColor.black,
              context: context,
              fontSize: 16,
            ),
          ],
        ),
        CustomSizedBox(
          context: context,
          height: 18,
        ),
        CustomText(
          text: "Thông tin vận chuyển",
          color: CustomColor.black,
          context: context,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        CustomSizedBox(
          context: context,
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
                text: "Mã đơn hàng",
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            CustomText(
              text: widget.isExport
                  ? '#' + widget.export!.id
                  : '#' + widget.import!.id,
              color: CustomColor.black,
              context: context,
              fontSize: 16,
            ),
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
                text: "Tên khách hàng",
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            CustomText(
              text: widget.isExport
                  ? widget.export!.customerName
                  : widget.import!.customerName,
              color: CustomColor.black,
              context: context,
              fontSize: 16,
            ),
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
                text: "Số điện thoại",
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            CustomText(
              text: widget.isExport
                  ? widget.export!.customerPhone
                  : widget.import!.customerPhone,
              color: CustomColor.black,
              context: context,
              fontSize: 16,
            ),
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
                text:
                    widget.isExport ? "Địa chỉ giao hàng" : "Địa chỉ nhận hàng",
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            Flexible(
              child: CustomText(
                textAlign: TextAlign.right,
                text: widget.isExport
                    ? widget.export!.returnAddress == ''
                        ? "Về kho trung chuyển"
                        : widget.export!.returnAddress
                    : widget.import!.deliveryAddress,
                color: CustomColor.black,
                context: context,
                fontSize: 16,
                maxLines: 3,
                textOverflow: TextOverflow.fade,
              ),
            ),
          
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
                text: "Nhân viên vân chuyển",
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            if (widget.isExport && !widget.isView)
              if (widget.export!.exportDeliveryBy == '')
                CustomButton(
                    height: 20,
                    text: 'Quét QR',
                    width: deviceSize.width / 3 - 50,
                    onPressFunction: () {
                      scanQR(deviceSize);
                    },
                    isLoading: _model.isLoading,
                    textColor: CustomColor.white,
                    buttonColor: CustomColor.blue,
                    textSize: 12,
                    borderRadius: 4),
            if (widget.isExport &&
                widget.export!.exportDeliveryBy != '' &&
                !widget.isView)
              CustomText(
                text: _model.deliveryStaff.name,
                color: CustomColor.black,
                context: context,
                fontSize: 16,
              ),
            if (widget.isExport && widget.isView)
              CustomText(
                text: widget.export!.exportDeliveryBy!,
                color: CustomColor.black,
                context: context,
                fontSize: 16,
              ),
            if (!widget.isExport)
              CustomText(
                text: widget.import!.importDeliveryBy,
                color: CustomColor.black,
                context: context,
                fontSize: 16,
              ),
          ],
        ),
      ],
    );
  }
}
