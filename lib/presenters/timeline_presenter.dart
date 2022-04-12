import 'dart:convert';

import 'package:rssms/models/entity/timeline.dart';
import 'package:rssms/models/timeline_model.dart';
import 'package:rssms/views/timeline_view.dart';

class TimelinePresenter {
  late TimelineModel model;
  late TimelineView view;
  TimelinePresenter() {
    model = TimelineModel.constructor();
  }

  void getListTimeline(String idToken, String idInvoice) async {
    try {
      final response = await model.getListTimeline(idInvoice, idToken);
      if (response.statusCode == 200) {
        final decodeReponse = json.decode(response.body);
        model.listTimeline = decodeReponse['data']
            .map<Timeline>((e) => Timeline.fromMap(e))
            .toList();
      }
    } finally {
      view.updateView(model.copyWith(isLoading: false));
    }
  }
}
