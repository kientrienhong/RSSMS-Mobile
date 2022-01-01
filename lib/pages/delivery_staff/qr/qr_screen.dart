import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/invoice_screen.dart';
import '../../../../constants/constants.dart' as constants;

class QrScreen extends StatefulWidget {
  const QrScreen({Key? key}) : super(key: key);

  @override
  _QrScreenState createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    final List<Map<String, dynamic?>> listInvoice =
        constants.LIST_INVOICE.toList();

    return Scaffold(
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
                  text: 'Quet QR',
                  textColor: CustomColor.white,
                  onPressFunction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InvoiceDetailsScreen(
                                invoice: listInvoice[0],
                                deviceSize: deviceSize,
                              )),
                    );
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
