import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/timeline.dart';

class TimelineModel {
  late bool isLoading;
  late List<Timeline> listTimeline;
  TimelineModel({required this.isLoading, required this.listTimeline});

  TimelineModel.constructor() {
    isLoading = true;
    listTimeline = [];
  }

  TimelineModel copyWith({bool? isLoading, List<Timeline>? listTimeline}) {
    return TimelineModel(
        isLoading: isLoading ?? this.isLoading,
        listTimeline: listTimeline ?? this.listTimeline);
  }

  void setModel(TimelineModel model) {
    isLoading = model.isLoading;
    listTimeline = model.listTimeline;
  }

  Future<dynamic> getListTimeline(String invoiceId, String idToken) async {
    return await ApiServices.getTimeline(idToken, invoiceId);
  }
}
