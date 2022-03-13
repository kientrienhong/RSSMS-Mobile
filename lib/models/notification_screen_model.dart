import 'dart:convert';

import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/notification.dart';
import 'package:rssms/models/entity/user.dart';

class NotificationScreenModel {
  late List<NotificationEntity> list;

  NotificationScreenModel() {
    list = [];
  }

  Future<void> loadListNotification(Users user) async {
    var response =
        await ApiServices.loadListNotification(user.idToken!, user.userId!);
    if (response.statusCode == 200) {
      final decodedReponse = jsonDecode(response.body);
      List<NotificationEntity> listNotification = decodedReponse['data']!
          .map<NotificationEntity>((e) => NotificationEntity.fromMap(e))
          .toList();
      user.setUser(
          user: user.copyWith(
              listNoti: listNotification,
              listUnreadNoti: listNotification
                  .where((element) => element.isRead == false)
                  .toList()));

      list = listNotification;
    }
  }
}
