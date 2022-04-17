import 'dart:developer';

import 'package:rssms/helpers/response_handle.dart';
import 'package:rssms/models/entity/area.dart';
import 'package:rssms/models/storage_screen_model.dart';
import 'package:rssms/views/storage_screen_view.dart';

class StorageScreenPresenter {
  late StorageScreenModel model;
  late StorageScreenView view;

  StorageScreenPresenter() {
    model = StorageScreenModel.constructor();
  }

  void getListAreas(String idToken, String idStorage) async {
    try {
      final response = await model.getListArea(idToken, idStorage);

      final result = ResponseHandle.handle(response);
      if (result['status'] == 'success') {
        model.listArea =
            result['data']['data'].map<Area>((e) => Area.fromMap(e)).toList();
      } else {
        view.updateErrorMsg(result['data']);
      }
    } catch (e) {
      log(e.toString());
    } finally {
      view.updateLoading();
    }
  }
}
