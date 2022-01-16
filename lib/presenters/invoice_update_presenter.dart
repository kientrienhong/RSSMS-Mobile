import 'package:rssms/api/api_services.dart';
import 'package:rssms/helpers/firebase_storage_helper.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/invoice_update_model.dart';
import 'package:rssms/views/invoice_update_view.dart';

import '/models/entity/user.dart';

class InvoiceUpdatePresenter {
  InvoiceUpdateModel? _model;
  UpdateInvoiceView? _view;

  UpdateInvoiceView get view => _view!;

  setView(UpdateInvoiceView value) {
    _view = value;
  }

  InvoiceUpdateModel get model => _model!;

  InvoiceUpdatePresenter(Users user, Invoice invoice) {
    _model = InvoiceUpdateModel(user, invoice);
  }

  Future<bool?> updateOrder(Invoice invoice) async {
    // invoice.orderDetails.forEach((element) async {
    //         await FirebaseStorageHelper.uploadImage(type, image, task, email, orderId);

    // });
    return null;
  }
}
