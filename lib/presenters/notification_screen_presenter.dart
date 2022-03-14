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
      await model.loadListNotification(user);
      if (model.list.isNotEmpty) {
        view.updateView();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
