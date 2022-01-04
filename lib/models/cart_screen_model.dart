import 'package:rssms/models/entity/product.dart';

class CartScreenModel {
  Map<int, List<Product>>? handyTab;
  Map<int, List<Product>>? selfStorageTab;
  Map<int, List<Product>>? unweildyTab;
  int? index;
  CartScreenModel() {
    handyTab = {};
    selfStorageTab = {};
    unweildyTab = {};
    index = 0;
  }
}
