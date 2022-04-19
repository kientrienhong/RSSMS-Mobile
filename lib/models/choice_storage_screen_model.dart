import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/storage_entity.dart';
import 'package:rssms/models/entity/user.dart';

class ChoiceStorageScreenModel {
  late bool isLoading;
  late String error;
  late List<StorageEntity> listStorage;
  late bool isChoose;
  String? indexIdStorage;
  late int currentIndex;
  ChoiceStorageScreenModel() {
    isLoading = true;
    isChoose = true;
    indexIdStorage = '';
    error = '';
    listStorage = [];
    currentIndex = 0;
  }
  Future<dynamic> getListAvailableStorage(
      List<Map<String, dynamic>> listProduct,
      OrderBooking orderBooking,
      Users user) async {
    return await ApiServices.loadListAvailableStorages(
        listProduct, orderBooking, user);
  }
}
