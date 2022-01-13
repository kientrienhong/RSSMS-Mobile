import 'package:flutter/cupertino.dart';

abstract class QRInvoiceView {
  Future<void> scanQR(Size deviceSize);
}
