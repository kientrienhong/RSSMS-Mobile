import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/qr_invoice_model.dart';
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

  String qrCode = "";
  late QRScanPresenter _presenter;
  late QRInvoiceModel _model;
  @override
  void initState() {
    super.initState();
    _presenter = QRScanPresenter();
    _model = _presenter.model;
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

    if (barcodeScanRes == '-1') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Không tìm thấy đơn"),
      ));
      return;
    }
    setState(() {
      qrCode = barcodeScanRes;
    });
    Users user = Provider.of<Users>(context, listen: false);
    bool result = await _presenter.loadRequest(user.idToken!, qrCode);
    if (!result) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Không tìm thấy đơn"),
      ));
      return;
    }

    bool isDone = false;
    Invoice invoice = Provider.of<Invoice>(context, listen: false);
    if (_presenter.model.invoice.orderId!.isNotEmpty &&
        _presenter.model.invoice.status != 0) {
      result =
          await _presenter.loadInvoice(user.idToken!, _model.invoice.orderId!);
      isDone = true;
    }
    if (result) {
      invoice.setInvoice(invoice: _presenter.model.invoice);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QRInvoiceDetailsScreen(
            isScanQR: true,
            isDone: isDone,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Không tìm thấy đơn"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
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
            CustomSizedBox(
              context: context,
              height: deviceSize.height / 5,
            ),
            Center(
              child: CustomButton(
                  height: 24,
                  isLoading: false,
                  text: 'Quét QR',
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
