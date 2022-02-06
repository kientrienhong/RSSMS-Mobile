import 'dart:convert';

import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/notification.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/models/notification_screen_model.dart';
import 'package:rssms/views/notification_screen_view.dart';

class NotificationScreenPresenter {
  late NotificationScreenView view;
  late NotificationScreenModel model;

  NotificationScreenPresenter() {
    model = NotificationScreenModel();
  }

  Future<void> loadListNotification(Users user) async {
    try {
      var response =
          await ApiServices.loadListNotification(user.idToken!, user.userId!);
      if (response.statusCode == 200) {
        final decodedReponse = jsonDecode(response.body);
        List<NotificationEntity> listNotification = decodedReponse['data']!
            .map<NotificationEntity>((e) => NotificationEntity.fromMap(e))
            .toList();
        user.setUser(
            user: user.copyWith(
                listUnreadNoti: listNotification
                    .where((element) => element.isRead == false)
                    .toList()));

        model.list = listNotification;
        view.updateView();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
