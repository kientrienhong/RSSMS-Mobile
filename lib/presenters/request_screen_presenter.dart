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

  void loadCusRequest({idToken = "", clearCachedDate = false}) async {
    try {
      if (clearCachedDate) {
        model!.listRequest = List<Request>.empty(growable: true);
        model!.hasMore = true;
        model!.listRequestFull = List<Request>.empty(growable: true);
        model!.page = 1;
        model!.data = List<Request>.empty(growable: true);
      }
      if (model!.isLoadingRequest! || !model!.hasMore!) {
        return Future.value();
      }
      view!.updateLoadingRequest();
      final response = await ApiServices.getRequest(idToken);
      if (response.statusCode == 200) {
        final decodedReponse = jsonDecode(response.body);
        model!.metadata = decodedReponse["metadata"];
        if (!decodedReponse['data'].isEmpty) {
          List<Request>? listTemp = decodedReponse['data']!
              .map<Request>((e) => Request.fromMap(e))
              .toList();
          model!.listRequestFull!.addAll(listTemp!);
          model!.listRequest = model!.listRequestFull;
        }
        model!.data!.addAll(model!.listRequestFull!);
        model!.hasMore = !(model!.page == model!.metadata!["totalPage"]);
        model!.controller.add(model!.data);
        print(model!.listRequestFull!.length);
      }
    } catch (e) {
      print(e);
    } finally {
      view!.updateLoadingRequest();
      view!.setChangeList();
    }
  }

  Future<void> loadStaffRequest({idToken = "", clearCachedDate = false}) async {
    try {
      if (clearCachedDate) {
        model!.listRequest = List<Request>.empty(growable: true);
        model!.hasMore = true;
        model!.listRequestFull = List<Request>.empty(growable: true);
        model!.page = 1;
        model!.data = List<Request>.empty(growable: true);
      }
      if (model!.isLoadingRequest! || !model!.hasMore!) {
        return Future.value();
      }
      view!.updateLoadingRequest();
      final response = await ApiServices.getRequest(idToken);
      if (response.statusCode == 200) {
        final decodedReponse = jsonDecode(response.body);
        model!.metadata = decodedReponse["metadata"];
        if (!decodedReponse['data'].isEmpty) {
          List<Request>? listTemp = decodedReponse['data']!
              .map<Request>((e) => Request.fromMap(e))
              .toList();
          model!.listRequestFull!.addAll(listTemp!);
          model!.listRequest = model!.listRequestFull;
        }
        model!.data!.addAll(model!.listRequestFull!);
        model!.hasMore = !(model!.page == model!.metadata!["totalPage"]);
        model!.controller.add(model!.data);
        print(model!.listRequestFull!.length);
      }
    } catch (e) {
      print(e);
    } finally {
      view!.updateLoadingRequest();
      view!.setChangeList();
    }
  }
}
