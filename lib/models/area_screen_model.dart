import 'package:rssms/models/entity/area.dart';

class AreaScreenModel {
  late List<Area> listArea;
  late bool isLoading;
  AreaScreenModel() {
    listArea = [];
    isLoading = false;
  }
}
