import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/product.dart';

class DialogAddServiceModel {
  late List<Product> listProductHandy;
  late List<Product> listProductBulky;
  late List<Product> listProductAccessory;
  late List<Product> listProductServices;
  String? idOrderDetail;
  late bool isLoading;
  DialogAddServiceModel(String? id) {
    listProductBulky = [];
    listProductHandy = [];
    listProductAccessory = [];
    listProductServices = [];
    isLoading = true;
    idOrderDetail = id;
  }

  Future<dynamic> getListProduct(String idToken) async {
    return await ApiServices.getService(idToken);
  }
}
