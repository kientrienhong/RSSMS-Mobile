import 'package:rssms/models/entity/invoice.dart';

class DeliveryScreenModel {
  late Map<DateTime, List<Invoice>> listInvoice;
  late int currentIndex;
  late List<DateTime> listDateTime;
  DeliveryScreenModel() {
    listInvoice = {};
    currentIndex = -1;
    listDateTime = [];
  }
}
