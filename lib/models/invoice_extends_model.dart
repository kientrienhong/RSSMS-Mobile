import 'package:rssms/pages/customers/my_account/invoice/invoive_update/invoive_extend_widget.dart';

class InvoiceExtendsModel {
  late PaymentMethod currentIndexPaymentMethod;
  late bool isLoading;

  InvoiceExtendsModel() {
    currentIndexPaymentMethod = PaymentMethod.trong;
    isLoading = false;
  }
}
