import 'dart:convert';
import 'dart:developer';

import 'package:rssms/models/entity/floor.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/floor_detail_model.dart';
import 'package:rssms/views/floor_detail_view.dart';

class FloorDetailPresenter {
  late FloorDetailModel model;
  late FloorDetailView view;
  FloorDetailPresenter() {
    model = FloorDetailModel();
  }

  Future<void> getFloorDetails(String idToken, String floorId) async {
    view.changeLoadingStatus();
    try {
      final responseFloor = await model.getFloorById(idToken, floorId);
      if (responseFloor.statusCode == 200) {
        final decodedReponse = jsonDecode(responseFloor.body);
        Floor? floor = Floor.fromMap(decodedReponse);
        model.floor = floor;
        model.listOrderDetails = decodedReponse["orderDetails"]
            .map<OrderDetail>((e) => OrderDetail.fromMap(e))
            .toList();
        log(model.listOrderDetails.length.toString());
      } else if (responseFloor.statusCode >= 500) {
        throw Exception("Máy chủ bị lỗi vui lòng thử lại sau");
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    } finally {
      view.changeLoadingStatus();
    }
  }
}
