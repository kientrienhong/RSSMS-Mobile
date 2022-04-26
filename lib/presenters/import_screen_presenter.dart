import 'dart:developer';

import 'package:rssms/helpers/response_handle.dart';
import 'package:rssms/models/entity/placing_items.dart';
import 'package:rssms/models/import_screen_model.dart';
import 'package:rssms/views/import_screen_view.dart';

class ImportScreenPresenter {
  late ImportScreenView view;
  late ImportScreenModel model;

  ImportScreenPresenter() {
    model = ImportScreenModel();
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
          "note": e['note']
        };
      }).toList();
      Map<String, dynamic> dataRequest = {
        "deliveryId": deliveryId,
        "orderDetailAssignFloor": listAssigned
      };
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
