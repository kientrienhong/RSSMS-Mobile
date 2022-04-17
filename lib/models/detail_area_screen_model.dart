import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/space.dart';

class DetailAreaScreenModel {
  late bool isLoading;
  late List<Space> listSpace;
  late String error;
  DetailAreaScreenModel(
      {required this.isLoading, required this.listSpace, required this.error});

  DetailAreaScreenModel.constructor() {
    isLoading = false;
    listSpace = [];
    error = '';
  }

  DetailAreaScreenModel copyWith(
      {List<Space>? listSpace, bool? isLoading, String? error}) {
    return DetailAreaScreenModel(
      isLoading: isLoading ?? this.isLoading,
      listSpace: listSpace ?? this.listSpace,
      error: error ?? this.error,
    );
  }

  Future<dynamic> getListSpace(String idToken, String idArea) async {
    try {
      return ApiServices.getListSpaces(idToken, idArea, '');
    } catch (e) {
      throw Exception(e);
    }
  }
}
