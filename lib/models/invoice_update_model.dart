import 'package:flutter/cupertino.dart';
import 'package:rssms/api/api_services.dart';
import 'package:rssms/helpers/date_format.dart';
import 'package:rssms/models/entity/invoice.dart';

import '/models/entity/user.dart';

class InvoiceUpdateModel {
  bool? isDisableUpdateInvoice;
  bool? isLoadingUpdateInvoice;
  late bool isAdditionFee;
  late bool isCompensation;
  late String error;
  late TextEditingController returnDateController;
  late TextEditingController durationMonths;

  late TextEditingController controllerFullname;
  late TextEditingController controllerPhone;
  late TextEditingController controllerAdditionFeeDescription;
  late TextEditingController controllerAdditionFeePrice;
  late TextEditingController controllerCompensationFeeDescription;
  late TextEditingController controllerCompensationFeePrice;
  late String txtStatus;
  late bool isPaid;
  late List<Map<String, dynamic>> listAdditionCost;
  InvoiceUpdateModel(Users user, Invoice invoice) {
    listAdditionCost = [];
    error = '';
    isDisableUpdateInvoice = true;
    isLoadingUpdateInvoice = false;
    isPaid = invoice.isPaid;
    controllerCompensationFeeDescription = TextEditingController(text: '');
    controllerCompensationFeePrice = TextEditingController(text: '');
    isCompensation = false;
    isAdditionFee = false;
    durationMonths =
        TextEditingController(text: invoice.durationMonths.toString());
    returnDateController =
        TextEditingController(text: invoice.returnDate.split("T")[0]);
    controllerAdditionFeeDescription = TextEditingController(text: '');
    controllerAdditionFeePrice = TextEditingController(text: '');
    controllerFullname = TextEditingController(text: invoice.customerName);
    controllerPhone = TextEditingController(text: invoice.customerPhone);
    switch (invoice.status) {
      case 0:
        txtStatus = "Đã đặt";
        break;
      case 1:
        txtStatus = "Đang lưu kho";
        break;
      case 2:
        txtStatus = "Yêu cầu trả";
        break;
      case 3:
        txtStatus = "Đã trả";
        break;
    }
  }

  Future<dynamic> updateOrder(Invoice invoice, String idToken) async {
    return await ApiServices.updateOrder(invoice, idToken);
  }

  Future<dynamic> sendNotification(dataRequest, String idToken) async {
    return await ApiServices.sendNotification(dataRequest, idToken);
  }

  Future<dynamic> doneOrder(dataRequest, String idToken) async {
    return await ApiServices.doneOrder(dataRequest, idToken);
  }

  Future<dynamic> createOrder(dataRequest, String idToken) async {
    return await ApiServices.createOrder(dataRequest, idToken);
  }
}
