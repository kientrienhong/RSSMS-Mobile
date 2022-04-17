import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/area.dart';

class StorageScreenModel {
  late bool isLoading;
  late List<Area> listArea;
  late String error;
  StorageScreenModel.constructor() {
    isLoading = true;
    listArea = [];
    error = '';
  }

  StorageScreenModel(
      {required this.isLoading, required this.listArea, required this.error});

  StorageScreenModel copyWith(
      {List<Area>? listArea, bool? isLoading, String? error}) {
    return StorageScreenModel(
      isLoading: isLoading ?? this.isLoading,
      listArea: listArea ?? this.listArea,
      error: error ?? this.error,
    );
  }

  Future<dynamic> getListArea(String idToken, String idStorage) async {
    try {
      return ApiServices.getArea(idToken, idStorage);
    } catch (e) {
      throw Exception(e);
    }
  }
}
