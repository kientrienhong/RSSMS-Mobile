import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/invoice_screen.dart';
import 'package:rssms/presenters/qr_scan_presenter.dart';
import 'package:rssms/views/qr_invoice_view.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  _QrScreenState createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> implements QRInvoiceView {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;

  String qrCode = "";
  QRScanPresenter? _presenter;
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _presenter = QRScanPresenter();
  }

  @override
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
    setState(() {
      qrCode = barcodeScanRes;
    });
    Users user = Provider.of<Users>(context, listen: false);
    bool result = await _presenter?.loadInvoice(user.idToken!, qrCode) as bool;
    Invoice invoice = Provider.of<Invoice>(context, listen: false);
    if (result) {
      invoice.setInvoice(invoice: _presenter!.model!.invoice!);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InvoiceDetailsScreen(
            deviceSize: deviceSize,
            isScanQR: true,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Cannot find invoice"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    // return Scaffold(body: _buildQrView(context));
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomSizedBox(
              context: context,
              height: deviceSize.height / 4,
            ),
            Center(
              child: QrImage(
                data: "1234567890",
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
            // _buildQrView(context),

            CustomSizedBox(
              context: context,
              height: deviceSize.height / 5,
            ),
            Center(
              child: CustomButton(
                  height: 24,
                  isLoading: false,
                  text: 'Quet QR',
                  textColor: CustomColor.white,
                  onPressFunction: () {
                    scanQR(deviceSize);
                  },
                  width: deviceSize.width,
                  buttonColor: CustomColor.blue,
                  borderRadius: 6),
            )
          ],
        ),
      ),
    );
  }
}
