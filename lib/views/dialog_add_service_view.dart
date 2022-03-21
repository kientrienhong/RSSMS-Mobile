import 'package:rssms/models/entity/product.dart';

abstract class DialogAddServiceView {
  void updateLoading();

  void updateListService(List<Product> listBucky, List<Product> listHandy);

  void updateListAddition(List<Product> listAccessory);
}
