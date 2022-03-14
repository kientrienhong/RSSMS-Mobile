import 'dart:convert';

import 'package:rssms/models/cart_screen_model.dart';
import 'package:rssms/models/entity/product.dart';
import 'package:rssms/views/cart_screen_view.dart';
import 'package:rssms/constants/constants.dart' as constants;

class CartScreenPresenter {
  late CartScreenModel model;
  late CartScreenView view;

  CartScreenPresenter() {
    model = CartScreenModel();
  }

  void loadProduct(String idToken) async {
    final response = await model.loadProduct(idToken);
    final decodedReponse = jsonDecode(response.body);
    List<Product> listSelfStorage =
        decodedReponse['0']!.map<Product>((e) => Product.fromMap(e)).toList();
    List<Product> listAccessory =
        decodedReponse['1']!.map<Product>((e) => Product.fromMap(e)).toList();
    List<Product> listHandy =
        decodedReponse['2']!.map<Product>((e) => Product.fromMap(e)).toList();

    List<Product> listArea =
        decodedReponse['3']!.map<Product>((e) => Product.fromMap(e)).toList();

    model.handyTab!.putIfAbsent(constants.HANDY, () => listHandy);
    model.handyTab!.putIfAbsent(constants.ACCESSORY, () => listAccessory);

    model.selfStorageTab!.putIfAbsent(constants.ACCESSORY, () => listAccessory);
    model.selfStorageTab!
        .putIfAbsent(constants.SELF_STORAGE, () => listSelfStorage);

    model.unweildyTab!.putIfAbsent(constants.ACCESSORY, () => listAccessory);
    model.unweildyTab!.putIfAbsent(constants.UNWEILDY, () => listArea);
    view.setChangeList();
  }
}
