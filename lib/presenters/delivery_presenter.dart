import 'dart:convert';
import 'dart:developer';

import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/delivery_screen_model.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/views/delivery_screen_view.dart';
import 'package:rssms/constants/constants.dart' as constants;

class DeliveryPresenter {
  late DeliveryScreenModel model;
  late DeliveryScreenView view;

  DeliveryPresenter() {
    model = DeliveryScreenModel();
  }

  void loadNewScheduleWeek({required Users user, required bool isPrevious}) {
    DateTime now = model.listDateTime[model.currentIndex];
    model.listDateTime = [];

    if (isPrevious) {
      now = now.subtract(const Duration(days: 7));
    } else {
      if (model.currentIndex == 0) {
        now = now.add(const Duration(days: 10));
      } else {
        now = now.add(const Duration(days: 7));
      }
    }
    var firstDay = now.subtract(Duration(days: now.weekday));
    var firstDayOfWeek = firstDay;
    var endDayOfWeek = firstDay;
    model.currentIndex = 0;
    for (int i = 0; i < 7; i++) {
      endDayOfWeek = firstDay;
      model.listDateTime.add(firstDay);
      if (firstDay.isAtSameMomentAs(now)) {
        model.currentIndex = i;
      }
      firstDay = firstDay.add(const Duration(days: 1));
    }
    model.firstDayOfWeek = firstDayOfWeek;
    model.endDayOfWeek = endDayOfWeek;
    model.listInvoice = <String, List<Invoice>>{};
    loadListShedule(user.idToken!, firstDayOfWeek, endDayOfWeek);
  }

  void init({required Users user, DateTime? currentDate}) {
    model.listDateTime = [];
    DateTime now = DateTime.now();
    if (currentDate != null) now = currentDate;

    if (model.currentIndex == 0) {
      now = now.add(const Duration(days: 1));
    }
    var firstDay = now.subtract(Duration(days: now.weekday));
    var firstDayOfWeek = firstDay;
    var endDayOfWeek = firstDay;
    for (int i = 0; i < 7; i++) {
      endDayOfWeek = firstDay;
      model.listDateTime.add(firstDay);

      if (firstDay.isAtSameMomentAs(now)) {
        if (!(model.currentIndex == 0)) {
          model.currentIndex = i;
        }
      }
      firstDay = firstDay.add(const Duration(days: 1));
    }
    model.firstDayOfWeek = firstDayOfWeek;
    model.endDayOfWeek = endDayOfWeek;
    model.listInvoice = <String, List<Invoice>>{};
  }

  Future<bool?> startDelivery(String idToken) async {
    try {
      view.updateLoadingStartDelivery();
      final currentListInvoice = model.listInvoice[model
          .listDateTime[model.currentIndex]
          .toIso8601String()
          .split('T')[0]];

      List<Map<dynamic, dynamic>> listOrderStatus =
          currentListInvoice!.map((e) {
        int newStatus = 0;

        if (e.status == constants.STATUS_INVOICE.assigned.index) {
          newStatus = 3;
        } else if (e.status == constants.STATUS_INVOICE.stored.index) {
          newStatus = 7;
        }

        return {"id": e.id, "status": newStatus};
      }).toList();

      final response = await model.updateListOrders(idToken, listOrderStatus);
      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<void> refreshListSchedule({
    required Users user,
  }) async {
    try {
      view.updateRefresLoading();
      init(user: user, currentDate: model.listDateTime[model.currentIndex]);
      await loadListShedule(
          user.idToken!, model.firstDayOfWeek, model.endDayOfWeek);
    } catch (e) {
      log(e.toString());
    } finally {
      view.updateRefresLoading();
    }
  }

  Future<void> loadListShedule(
      String idToken, DateTime firstDayOfWeek, DateTime endDayOfWeek) async {
    try {
      final response = await ApiServices.getScheduleOrder(
          idToken, firstDayOfWeek, endDayOfWeek);

      if (response.statusCode == 200) {
        final decodedReponse = jsonDecode(response.body);
        for (var e in model.listDateTime) {
          String date = e.toIso8601String().split('T')[0];
          model.listInvoice.putIfAbsent(date, () => []);
        }
        decodedReponse['data'].forEach((e) {
          String scheduleDay = e['scheduleDay'].split('T')[0];
          for (int i = 0; i < e['requests'].length; i++) {
            Invoice invoice = Invoice.fromRequest(e['requests'][i]);
            model.listInvoice[scheduleDay]!.add(invoice);
          }
        });
        view.updateView();
      } else if (response.statusCode == 404) {
        for (var e in model.listDateTime) {
          String date = e.toIso8601String().split('T')[0];
          model.listInvoice.putIfAbsent(date, () => []);
        }
        view.updateView();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
