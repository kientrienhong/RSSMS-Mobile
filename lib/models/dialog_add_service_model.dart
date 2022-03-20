import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/product.dart';

class DialogAddServiceModel {
  late List<Product> listProductHandy;
  late List<Product> listProductBulky;
  late List<Product> listProductAccessory;
  late List<Product> listProductServices;
  late bool isSeperate;
  String? idOrderDetail;
  late bool isLoading;
  DialogAddServiceModel(String? id, bool isSeperateAgru) {
    listProductBulky = [];
    listProductHandy = [];
    listProductAccessory = [];
    listProductServices = [];
    isLoading = true;
    idOrderDetail = id;
    isSeperate = isSeperateAgru;
  }

  Future<dynamic> getListProduct(String idToken) async {
    return await ApiServices.getService(idToken);
  }
}
