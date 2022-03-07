import 'package:rssms/models/area_screen_model.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/views/area_screen_view.dart';

class AreaScreenPresenter {
  late AreaScreenView view;
  late AreaScreenModel model;

  AreaScreenPresenter() {
    model = AreaScreenModel();
  }

  void loadListArea(Users user) {
    try {} catch (e) {
      throw Exception(e);
    }
  }
}
