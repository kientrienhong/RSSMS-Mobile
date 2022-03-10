import 'package:rssms/api/api_services.dart';
import 'package:rssms/helpers/firebase_storage_helper.dart';
import 'package:rssms/models/entity/imageEntity.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/invoice_update_model.dart';
import 'package:rssms/views/invoice_update_view.dart';

import '/models/entity/user.dart';

class InvoiceUpdatePresenter {
  late InvoiceUpdateModel _model;
  late UpdateInvoiceView _view;

  UpdateInvoiceView get view => _view;

  setView(UpdateInvoiceView value) {
    _view = value;
  }

  InvoiceUpdateModel get model => _model;

  InvoiceUpdatePresenter(Users user, Invoice invoice) {
    _model = InvoiceUpdateModel(user, invoice);
  }

  void addAdditionCost(Map<String, dynamic> additionCost) {
    _model.listAdditionCost.add(additionCost);
    _view.updateView();
  }

  void deleteAdditionCost(int id) {
    _model.listAdditionCost.removeWhere((element) => element['id'] == id);
    _view.updateView();
  }

  void updateAdditionCost(Map<String, dynamic> additionCost) {
    int indexFound = _model.listAdditionCost
        .indexWhere((element) => element['id'] == additionCost['id']);
    _model.listAdditionCost[indexFound] = additionCost;
    _view.updateView();
  }

  Future<List<OrderDetail>?> formatListImageEntity(
      Invoice invoice, Users user) async {
    List<OrderDetail> listOrderDetailNew = [];
    try {
      listOrderDetailNew =
          await Future.wait(invoice.orderDetails.map((element) async {
        List<ImageEntity> listImageEntity =
            await FirebaseStorageHelper.convertImageToBase64(element);
        return element.copyWith(images: listImageEntity);
      }).toList());
    } catch (e) {
      throw Exception(e);
    }

    return listOrderDetailNew;
  }

  Future<bool> updateOrder(Users user, Invoice invoice) async {
    try {
      view.updateLoadingUpdate();
      invoice = invoice.copyWith(status: 3);
      var response = await ApiServices.updateOrder(invoice, user.idToken!);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      view.updateLoadingUpdate();
    }

    return false;
  }

  Future<bool?> sendNoti(Users user, Invoice invoice) async {
    try {
      view.updateLoadingUpdate();

      List<OrderDetail>? listOrderDetail =
          await formatListImageEntity(invoice, user);

      if (listOrderDetail != null) {
        invoice.setInvoice(
            invoice: invoice.copyWith(
                orderDetails: listOrderDetail, isPaid: model.getIsPaid));
        var response =
            await ApiServices.sendNotification(invoice, user.idToken!);
        if (response.statusCode == 200) {
          return true;
        }
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      view.updateLoadingUpdate();
    }

    return false;
  }

  Future<bool?> doneOrder(Users user, Invoice invoice) async {
    try {
      view.updateLoadingUpdate();

      var response = await ApiServices.doneOrder(invoice, user.idToken!);
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      view.updateLoadingUpdate();
    }

    return false;
  }
}
