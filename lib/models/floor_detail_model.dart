import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/floor.dart';
import 'package:rssms/models/entity/order_detail.dart';

class FloorDetailModel {
  late Floor floor;
  late List<OrderDetail> listOrderDetails;
  late bool isLoading;
  FloorDetailModel() {
    isLoading = false;
    listOrderDetails = [];
  }

  Future<dynamic> getFloorById(String idToken, String floorId) async {
    try {
      return await ApiServices.getFloorbyId(idToken, floorId);
    } catch (e) {
      throw Exception(e);
    }
  }
}
