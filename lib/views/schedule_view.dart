import 'package:rssms/models/schedule_model.dart';

abstract class ScheduleView {
  void onPressReport();
  void onPressDelivery();
  void onPressViewDetail();
  void updateView(ScheduleModel model);
}
