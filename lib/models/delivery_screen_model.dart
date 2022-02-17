import 'package:rssms/models/entity/invoice.dart';

class DeliveryScreenModel {
  late bool isLoadingStartDelivery;
  late Map<String, List<Invoice>> listInvoice;
  late int currentIndex;
  late List<DateTime> listDateTime;
  late DateTime firstDayOfWeek;
  late DateTime endDayOfWeek;
  DeliveryScreenModel() {
    listInvoice = {};
    currentIndex = -1;
    isLoadingStartDelivery = false;
    listDateTime = [];
  }
}
