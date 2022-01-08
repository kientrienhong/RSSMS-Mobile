import 'package:rssms/api/api_services.dart';
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


  Future<bool> updateProfile(String name, int gender, DateTime birthday,
      String address, String phone, String idToken, int userId) async {
    _view!.updateLoadingProfile();

    try {
      final response = await ApiServices.updateProfile(
          name, phone, birthday, gender, address, idToken, userId);
      if (response.statusCode == 200) return true;
      return false;
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    } finally {
      _view!.updateLoadingProfile();
    }
  }

}
