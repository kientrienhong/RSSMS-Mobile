import 'package:flutter/cupertino.dart';
import 'package:rssms/api/api_services.dart';
import 'package:rssms/models/entity/user.dart';
import 'package:rssms/pages/customers/my_account/invoice/invoive_update/invoive_extend_widget.dart';

class InvoiceExtendsModel {
  late PaymentMethod currentIndexPaymentMethod;
  late bool isLoading;
  late FocusNode focusNode;
  late String dateExtensionString;
  late String error;
  DateTime? dateExtension;
  InvoiceExtendsModel() {
    currentIndexPaymentMethod = PaymentMethod.trong;
    isLoading = false;
    focusNode = FocusNode();
    dateExtensionString = '';
    error = '';
  }

  Future<dynamic> createExtendRequest(
      Map<String, dynamic> extendInvoice, Users user) async {
    return await ApiServices.createExtendRequest(extendInvoice, user);
  }
}
