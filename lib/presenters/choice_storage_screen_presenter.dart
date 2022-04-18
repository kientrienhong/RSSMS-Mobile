import 'package:rssms/helpers/response_handle.dart';
import 'package:rssms/models/choice_storage_screen_model.dart';
import 'package:rssms/models/entity/order_booking.dart';
import 'package:rssms/models/entity/storage_entity.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/views/choice_storage_screen_view.dart';

class ChoiceStorageScreenPresenter {
  late ChoiceStorageScreenModel model;
  late ChoiceStorageScreenView view;

  ChoiceStorageScreenPresenter() {
    model = ChoiceStorageScreenModel();
  }

  void getListStorage(OrderBooking orderBooking, Users user) async {
    try {
      List<Map<String, dynamic>> listProduct = [];

      List listKeys = orderBooking.productOrder.keys.toList();

      for (var element in listKeys) {
        for (var ele in orderBooking.productOrder[element]!) {
          listProduct.add({
            "serviceId": ele['id'],
            "price": ele['price'],
            "amount": ele['quantity'],
            'note': ele['note']
          });
        }
      }
      final response =
          await model.getListAvailableStorage(listProduct, orderBooking, user);
      final result = ResponseHandle.handle(response);

      if (result['status'] == 'success') {
        model.listStorage = result['data']['data']
            .map<StorageEntity>((e) => StorageEntity.fromMap(e))
            .toList();
      } else {
        view.updateError(result['data']);
      }
    } catch (e) {
      view.updateError('Xảy ra lỗi hệ thống. Vui lòng thử lại sau');
    } finally {
      view.updateLoading();
    }
  }
}
