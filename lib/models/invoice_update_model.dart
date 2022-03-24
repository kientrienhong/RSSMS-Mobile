import 'package:flutter/cupertino.dart';
import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/invoice.dart';

import '/models/entity/user.dart';

class InvoiceUpdateModel {
  bool? _isDisableUpdateInvoice;
  bool? _isLoadingUpdateInvoice;
  bool? _isAdditionFee;

  get isAdditionFee => _isAdditionFee;

  set isAdditionFee(value) => _isAdditionFee = value;
  TextEditingController? _controllerFullname;
  TextEditingController? _controllerPhone;
  TextEditingController? _controllerAdditionFeeDescription;
  TextEditingController? _controllerAdditionFeePrice;
  get controllerAdditionFeeDescription => _controllerAdditionFeeDescription;

  set controllerAdditionFeeDescription(value) =>
      _controllerAdditionFeeDescription = value;

  get controllerAdditionFeePrice => _controllerAdditionFeePrice;

  set controllerAdditionFeePrice(value) => _controllerAdditionFeePrice = value;
  String? _txtStatus;
  bool? _isPaid;
  late List<Map<String, dynamic>> listAdditionCost;
  InvoiceUpdateModel(Users user, Invoice invoice) {
    listAdditionCost = [];
    _isDisableUpdateInvoice = true;
    _isLoadingUpdateInvoice = false;
    _isPaid = invoice.isPaid;
    _controllerAdditionFeeDescription = TextEditingController();
    _controllerAdditionFeePrice = TextEditingController();
    _isAdditionFee = false;
    _controllerFullname = TextEditingController(text: invoice.customerName);
    _controllerPhone = TextEditingController(text: invoice.customerPhone);
    switch (invoice.status) {
      case 0:
        _txtStatus = "Đã đặt";
        break;
      case 1:
        _txtStatus = "Đang lưu kho";
        break;
      case 2:
        _txtStatus = "Yêu cầu trả";
        break;
      case 3:
        _txtStatus = "Đã trả";
        break;
    }
  }

  get isDisableUpdateInvoice => _isDisableUpdateInvoice;

  set isDisableUpdateInvoice(value) => _isDisableUpdateInvoice = value;

  get isLoadingUpdateInvoice => _isLoadingUpdateInvoice;

  set isLoadingUpdateInvoice(value) => _isLoadingUpdateInvoice = value;

  get controllerFullname => _controllerFullname;

  set controllerFullname(value) => _controllerFullname = value;

  get controllerPhone => _controllerPhone;

  set controllerPhone(value) => _controllerPhone = value;

  get txtStatus => _txtStatus;

  set txtStatus(value) => _txtStatus = value;

  get getIsPaid => _isPaid;

  set setIsPaid(isPaid) => _isPaid = isPaid;

  Future<dynamic> updateOrder(Invoice invoice, String idToken) async {
    return await ApiServices.updateOrder(invoice, idToken);
  }

  Future<dynamic> sendNotification(dataRequest, String idToken) async {
    return await ApiServices.sendNotification(dataRequest, idToken);
  }

  Future<dynamic> doneOrder(Invoice invoice, String idToken) async {
    return await ApiServices.doneOrder(invoice, idToken);
  }

  Future<dynamic> createOrder(dataRequest, String idToken) async {
    return await ApiServices.createOrder(dataRequest, idToken);
  }
}
