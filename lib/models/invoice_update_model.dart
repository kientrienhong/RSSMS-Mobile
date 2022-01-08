import 'package:flutter/cupertino.dart';
import 'package:rssms/models/entity/invoice.dart';

import '/models/entity/user.dart';

class InvoiceUpdateModel {
  bool? _isDisableUpdateInvoice;
  bool? _isLoadingUpdateInvoice;
  TextEditingController? _controllerFullname;
  TextEditingController? _controllerPhone;
  String? _txtStatus;
  bool? _isPaid;

  InvoiceUpdateModel(Users user, Invoice invoice) {
    _isDisableUpdateInvoice = true;
    _isLoadingUpdateInvoice = false;
    _isPaid = invoice.isPaid;
    _controllerFullname = TextEditingController(text: user.name);
    _controllerPhone = TextEditingController(text: user.phone);
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
}
