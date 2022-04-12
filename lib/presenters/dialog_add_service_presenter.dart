import 'dart:convert';
import 'dart:developer';

import 'package:rssms/models/dialog_add_service_model.dart';
import 'package:rssms/models/entity/product.dart';
import 'package:rssms/views/dialog_add_service_view.dart';

class DialogAddServicePresenter {
  late DialogAddServiceModel model;
  late DialogAddServiceView view;

  DialogAddServicePresenter(String? id, bool isSeperate) {
    model = DialogAddServiceModel(id, isSeperate);
  }

  void getListProduct(String idToken) async {
    try {
      final response = await model.getListProduct(idToken);
      if (response.statusCode == 200) {
        final decodedReponse = jsonDecode(response.body);
        if (model.idOrderDetail != null) {
          List<Product> listAccessory = decodedReponse['1']!
              .map<Product>((e) => Product.fromMap(e))
              .toList();
          view.updateListAddition(listAccessory);
        } else {
          if (model.isSeperate) {
            List<Product> listAccessory = decodedReponse['1']!
                .map<Product>((e) => Product.fromMap(e))
                .toList();
            view.updateListAddition(listAccessory);
          } else {
            List<Product> listHandy = decodedReponse['2']!
                .map<Product>((e) => Product.fromMap(e))
                .toList();

            List<Product> listArea = decodedReponse['3']!
                .map<Product>((e) => Product.fromMap(e))
                .toList();

            List<Product> listStorages = decodedReponse['0']!
                .map<Product>((e) => Product.fromMap(e))
                .toList();
            view.updateListService(listArea, listHandy, listStorages);
          }
        }
      }
      view.updateLoading();
    } catch (e) {
      log(e.toString());
      view.updateLoading();
    }
  }
}
