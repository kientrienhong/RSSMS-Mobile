import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/export.dart';
import 'package:rssms/models/entity/import.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/request.dart';

class InvoiceDetailScreenModel {
  late Invoice invoice;
  late Invoice orginalInvoice;
  late Invoice showUIInvoice;
  late bool isLoading;
  late Import import;
  late Export export;
  late bool isRequestReturn;
  late Request request;
  InvoiceDetailScreenModel() {
    invoice = Invoice.empty();
    showUIInvoice = Invoice.empty();
    orginalInvoice = Invoice.empty();
    isLoading = true;
    import = Import.empty();
    export = Export.empty();
    isRequestReturn = false;
    request = Request.empty();
  }

  Future<dynamic> loadingDetailInvoice(String id, String idToken) async {
    return await ApiServices.getInvoicebyId(idToken, id);
  }
}
