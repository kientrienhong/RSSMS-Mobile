import 'dart:developer';

import 'package:rssms/helpers/response_handle.dart';
import 'package:rssms/models/detail_area_screen_model.dart';
import 'package:rssms/models/entity/space.dart';
import 'package:rssms/views/detail_area_screen_view.dart';

class DetailAreaScreenPresenter {
  late DetailAreaScreenModel model;
  late DetailAreaScreenView view;

  DetailAreaScreenPresenter() {
    model = DetailAreaScreenModel.constructor();
  }

  void getListSpace(String idToken, String idArea) async {
    try {
      view.updateLoading();
      final response = await model.getListSpace(idToken, idArea);
      final result = ResponseHandle.handle(response);
      if (result['status'] == 'success') {
        model.listSpace =
            result['data']['data'].map<Space>((e) => Space.fromMap(e)).toList();
      } else {
        view.updateErrorMsg(result['data']);
      }
    } catch (e) {
      log(e.toString());
      view.updateErrorMsg('Xảy ra lỗi hệ thống. Vui lòng thử lại sau!');
    } finally {
      view.updateLoading();
    }
  }
}
