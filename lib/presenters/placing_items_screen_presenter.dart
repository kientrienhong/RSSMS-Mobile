import 'dart:developer';

import 'package:rssms/helpers/response_handle.dart';
import 'package:rssms/models/entity/area.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/entity/placing_items.dart';
import 'package:rssms/models/entity/account.dart';
import 'package:rssms/models/placing_items_screen_model.dart';
import 'package:rssms/views/placing_items_screen_view.dart';
import 'package:rssms/constants/constants.dart' as constants;

class PlacingItemsScreenPresenter {
  late PlacingItemsScreenModel model;
  late PlacingItemsScreenView view;
  PlacingItemsScreenPresenter() {
    model = PlacingItemsScreenModel();
  }

  Future<bool> getStaffDetail(String idToken, String id) async {
    try {
      final response = await model.getStaffDetail(idToken, id);
      if (response.statusCode == 200) {
        Account staff = Account.fromJson(response.body);
        model.deliveryStaff = staff;
      } else {
        throw Exception();
      }
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> onPressConfirmMove(
      String idToken, PlacingItems placingItems) async {
    try {
      view.updateLoading();
      if (placingItems.storedItems['totalQuantity'] > 0) {
        view.updateError('Vui lòng đặt hết hàng vào không gian');
        return false;
      }
      final listAssigned = placingItems.placingItems['floors'].map((e) {
        return {
          "oldFloorId": e['idFloor'],
          "orderDetailId": e['id'],
          "floorId": e['floorId'],
          "serviceType": e['serviceType']
        };
      }).toList();
      final response = await model.moveOrderToAnotherFloor(
          idToken, {"orderDetailAssignFloor": listAssigned});
      final result = ResponseHandle.handle(response);
      if (result['status'] == 'success') {
        return true;
      } else {
        view.updateError(result['data']);
        return false;
      }
    } catch (e) {
      log(e.toString());
      view.updateError('Xảy ra lỗi hệ thống. Vui lòng thử lại sau');
      return false;
    } finally {
      view.updateLoading();
    }
  }

  bool onPressPlace(PlacingItems placingItems, Map<String, double> sizeOfFloor,
      OrderDetail orderDetail, String floorId, Area area, String floorName) {
    if (orderDetail.length! > sizeOfFloor['length']! ||
        orderDetail.height! > sizeOfFloor['height']! ||
        orderDetail.width! > sizeOfFloor['width']!) {
      return false;
    }

    if ((orderDetail.productType == constants.typeProduct.handy.index ||
            orderDetail.productType == constants.typeProduct.unweildy.index) &&
        area.type == 0) {
      return false;
    }

    if (orderDetail.productType == constants.typeProduct.selfStorage.index &&
        area.type == 1) {
      return false;
    }

    placingItems.placeItems(floorId, orderDetail.id,
        {'areaName': area.name, 'floorName': floorName, 'floorId': floorId});
    return true;
  }

  Future<bool> onPressConfirmStore(
      String idToken, PlacingItems placingItems, String deliveryId) async {
    try {
      view.updateLoading();
      if (placingItems.storedItems['totalQuantity'] > 0) {
        view.updateError('Vui lòng đặt hết hàng vào không gian');
        return false;
      }
      final listAssigned = placingItems.placingItems['floors'].map((e) {
        return {
          "orderDetailId": e['id'],
          "floorId": e['floorId'],
          "serviceType": e['serviceType'],
          "importNote": e['note']
        };
      }).toList();
      Map<String, dynamic> dataRequest;
      if (deliveryId.isEmpty) {
        dataRequest = {"orderDetailAssignFloor": listAssigned};
      } else {
        dataRequest = {
          "deliveryId": deliveryId,
          "orderDetailAssignFloor": listAssigned
        };
      }

      final response = await model.assignOrderToFloor(idToken, dataRequest);
      final result = ResponseHandle.handle(response);
      if (result['status'] == 'success') {
        return true;
      } else {
        view.updateError(result['data']);
        return false;
      }
    } catch (e) {
      log(e.toString());
      view.updateError('Xảy ra lỗi hệ thống. Vui lòng thử lại sau');
      return false;
    } finally {
      view.updateLoading();
    }
  }
}
