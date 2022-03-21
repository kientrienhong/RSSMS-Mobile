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

      double price = 0;

      invoice.orderDetails.forEach((element) {
        price += element.price;

        element.listAdditionService!.forEach((ele1) {
          price += ele1.price * ele1.quantity!;
        });
      });

      final orderDetails = [];

      List<OrderDetail> newListOrderDetails =
          await Future.wait(invoice.orderDetails.map((element) async {
        List<ImageEntity> listImageEntity =
            await FirebaseStorageHelper.convertImageToBase64(element);
        return element.copyWith(images: listImageEntity);
      }).toList());
      newListOrderDetails.forEach((element) {
        final orderDetailImages = element.images.map((e) {
          return {"file": e.base64};
        }).toList();

        final orderDetailServices = [
          {
            "serviceId": element.productId,
            "amount": element.amount,
            "totalPrice": element.price
          }
        ];

        element.listAdditionService!.forEach((element) {
          orderDetailServices.add({
            "serviceId": element.id,
            "amount": element.quantity!,
            "totalPrice": element.price
          });
        });

        orderDetails.add({
          "height": element.height,
          "width": element.width,
          "length": element.length,
          "orderDetailImages": orderDetailImages,
          "orderDetailServices": orderDetailServices
        });
      });

      final dataRequest = {
        "customerId": "c3bb1c0f-0021-4624-ac51-bef0da994eaf",
        "deliveryAddress": invoice.deliveryAddress,
        "returnAddress": invoice.addressReturn,
        "totalPrice": price,
        "rejectedReason": "",
        "duration": 0,
        "type": invoice.typeOrder,
        "isPaid": invoice.isPaid,
        "paymentMethod": invoice.paymentMethod,
        "isUserDelivery": false,
        "deliveryDate": invoice.deliveryDate,
        "deliveryTime": invoice.deliveryTime,
        "returnDate": invoice.returnDate,
        "returnTime": invoice.returnTime,
        "status": invoice.status,
        "orderDetails": orderDetails
      };

      var response = await model.createOrder(dataRequest, user.idToken!);
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
        var response = await model.sendNotification(invoice, user.idToken!);
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

      var response = await model.doneOrder(invoice, user.idToken!);
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
