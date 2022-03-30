import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/invoice.dart';

class ScheduleModel {
  late bool isLoadingReport;
  late bool isLoadingDelivery;
  Invoice? invoiceDetail;
  ScheduleModel.constructor() {
    isLoadingDelivery = false;
    isLoadingReport = false;
    invoiceDetail = Invoice.empty();
  }

  ScheduleModel(
      {required this.isLoadingDelivery,
      required this.isLoadingReport,
      this.invoiceDetail});

  ScheduleModel copyWith(
      {bool? isLoadingReport,
      bool? isLoadingDelivery,
      Invoice? invoiceDetail}) {
    return ScheduleModel(
        isLoadingDelivery: isLoadingDelivery ?? this.isLoadingDelivery,
        isLoadingReport: isLoadingReport ?? this.isLoadingReport,
        invoiceDetail: invoiceDetail ?? this.invoiceDetail);
  }

  void setModel(ScheduleModel model) {
    isLoadingDelivery = model.isLoadingDelivery;
    isLoadingReport = model.isLoadingReport;
    invoiceDetail = model.invoiceDetail;
  }

  Future<dynamic> getRequestId(String idToken, String idInvoice) async {
    return await ApiServices.getRequestbyId(idToken, idInvoice);
  }
}
