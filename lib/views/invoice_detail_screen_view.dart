import 'package:rssms/models/entity/invoice.dart';

abstract class InvoiceDetailScreenView {
  void updateLoading();
  void updateView(Invoice invoice, Invoice showUIInvoice);
}
