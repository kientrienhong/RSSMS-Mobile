import 'package:rssms/models/entity/order_detail.dart';

abstract class UpdateInvoiceView {
  void updateLoadingUpdate();
  void updateView();
  void onClickUpdateOrder();
  void updateError(String error);
}
