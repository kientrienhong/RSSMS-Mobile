import 'dart:convert';

import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/request.dart';
import 'package:rssms/models/request_screen_model.dart';
import 'package:rssms/views/request_screen_view.dart';

class RequestScreenPresenter {
  RequestScreenModel? model;
  RequestScreenView? view;

  RequestScreenPresenter() {
    model = RequestScreenModel();
  }

  void loadRequest(String idToken) async {
    view!.updateLoadingRequest();
    try {
      final response = await ApiServices.getRequest(idToken);
      final decodedReponse = jsonDecode(response.body);

      if (!decodedReponse['data'].isEmpty) {
        List<Request>? listTemp = decodedReponse['data']!
            .map<Request>((e) => Request.fromMap(e))
            .toList();
        model!.listRequest = listTemp!.reversed.toList();
      } else {
        model!.listRequest = [];
      }
    } catch (e) {
      print(e);
    } finally {
      view!.updateLoadingRequest();
      view!.setChangeList();
    }
  }
}
