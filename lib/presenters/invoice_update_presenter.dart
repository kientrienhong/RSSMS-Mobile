import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:rssms/helpers/image_handle.dart';
import 'package:rssms/models/entity/imageEntity.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_additional_fee.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/models/invoice_update_model.dart';
import 'package:rssms/views/invoice_update_view.dart';
import 'package:rssms/constants/constants.dart';
import '/models/entity/user.dart';
import 'dart:developer';
import 'package:rssms/constants/constants.dart' as constants;

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
            await ImageHandle.convertImageToBase64(element);
        return element.copyWith(images: listImageEntity);
      }).toList());
    } catch (e) {
      throw Exception(e);
    }

    return listOrderDetailNew;
  }

  Future<Map<String, dynamic>> formatDataCreateOrder(Invoice invoice) async {
    invoice = invoice.copyWith();

    double price = 0;
    for (var element in invoice.orderDetails) {
      if (element.productType == typeProduct.handy.index ||
          element.productType == typeProduct.unweildy.index) {
        price += element.price * (invoice.durationDays / 30).ceil();
      } else if (element.productType == typeProduct.accessory.index) {
        price += element.price;
      } else if (element.productType == typeProduct.selfStorage.index) {
        price += element.price * invoice.durationMonths;
      }
      for (var ele1 in element.listAdditionService!) {
        if (ele1.type == typeProduct.accessory.index ||
            ele1.type == typeProduct.services.index) {
          price += ele1.price * ele1.quantity!;
        }
      }
    }
    String additionalFee = _model.controllerAdditionFeePrice.text == ""
        ? "0"
        : _model.controllerAdditionFeePrice.text;

    final totalPrice =
        price + invoice.deliveryFee + double.parse(additionalFee);
    final orderDetails = [];

    List<OrderDetail> newListOrderDetails =
        await Future.wait(invoice.orderDetails.map((element) async {
      List<ImageEntity> listImageEntity =
          await ImageHandle.convertImageToBase64(element);
      return element.copyWith(images: listImageEntity);
    }).toList());
    for (var element in newListOrderDetails) {
      final orderDetailImages = element.images.map((e) {
        return {"file": e.base64, "note": e.note};
      }).toList();

      final orderDetailServices = [
        {
          "serviceId": element.productId,
          "amount": element.amount,
          "totalPrice": element.price
        }
      ];
      for (var element in element.listAdditionService!) {
        orderDetailServices.add({
          "serviceId": element.id,
          "amount": element.quantity!,
          "totalPrice": element.price
        });
      }

      orderDetails.add({
        "height": element.height,
        "width": element.width,
        "length": element.length,
        "orderDetailImages": orderDetailImages,
        "orderDetailServices": orderDetailServices
      });
    }

    return {
      "customerId": invoice.customerId,
      "requestId": invoice.id,
      "deliveryAddress": invoice.deliveryAddress,
      "returnAddress": invoice.addressReturn,
      "totalPrice": totalPrice,
      "rejectedReason": "",
      "orderAdditionalFees": [
        {
          "type": constants.ADDITION_FEE_TYPE.takingAdditionFee.index,
          "description": _model.isAdditionFee
              ? _model.controllerAdditionFeeDescription.text
              : '',
          "price": _model.isAdditionFee
              ? double.parse(_model.controllerAdditionFeePrice.text)
              : 0
        },
        {
          "type": constants.ADDITION_FEE_TYPE.deliveryFee.index,
          "description": "Ph?? v???n chuy???n",
          "price": invoice.deliveryFee
        }
      ],
      "type": invoice.typeOrder,
      "isPaid": _model.isPaid,
      "paymentMethod": invoice.paymentMethod,
      "isUserDelivery": false,
      "deliveryDate": invoice.deliveryDate,
      "deliveryTime": invoice.deliveryTime,
      "returnDate": DateFormat('dd/MM/yyyy')
          .parse(_model.returnDateController.text)
          .toIso8601String(),
      "returnTime": invoice.returnTime,
      "status": invoice.status,
      "orderDetails": orderDetails
    };
  }

  Map<String, dynamic> dateFormatHelperDoneOrder(Invoice invoice) {
    List<OrderAdditionalFee>? listOrderAdditionFee;

    if (model.isAdditionFee || model.isCompensation) {
      listOrderAdditionFee = [];
    }

    if (model.isAdditionFee) {
      listOrderAdditionFee!.add(OrderAdditionalFee(
          type: constants.ADDITION_FEE_TYPE.returningAdditionFee.index,
          description: model.controllerAdditionFeeDescription.text,
          price: double.parse(model.controllerAdditionFeePrice.text)));
    }

    if (model.isCompensation) {
      listOrderAdditionFee!.add(OrderAdditionalFee(
          type: constants.ADDITION_FEE_TYPE.compensationFee.index,
          description: model.controllerCompensationFeeDescription.text,
          price: double.parse(model.controllerCompensationFeePrice.text)));
    }

    Map<String, dynamic> result = {
      "orderId": invoice.id,
      "requestId": invoice.requestId,
      'status': 6,
      "orderAdditionalFees":
          listOrderAdditionFee?.map((e) => e.toMap()).toList()
    };

    return result;
  }

  Map<String, dynamic> dateFormatHelperDoneOrderOfficeStaff(Invoice invoice) {
    Map<String, dynamic> result = {
      "orderId": invoice.id,
      "requestId": invoice.requestId,
      'status': 6,
    };

    return result;
  }

  Future<bool> updateOrder(Users user, Invoice invoice) async {
    try {
      view.updateLoadingUpdate();
      final dataRequest = await formatDataCreateOrder(invoice);
      var response = await model.createOrder(dataRequest, user.idToken!);
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        view.updateError(jsonDecode(response.body)['error']['message']);
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
      var dataRequest = {};
      if (user.roleName == "Delivery Staff") {
        dataRequest = dateFormatHelperDoneOrder(invoice);
      } else if (user.roleName == "Office Staff") {
        dataRequest = dateFormatHelperDoneOrder(invoice);
      } else {
        return false;
      }
      log(jsonEncode(dataRequest));
      var response = await model.doneOrder(dataRequest, user.idToken!);
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
