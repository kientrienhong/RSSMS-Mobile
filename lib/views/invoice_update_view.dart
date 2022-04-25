import 'package:flutter/cupertino.dart';

abstract class UpdateInvoiceView {
  void updateLoadingUpdate();
  void updateView();
  void onClickUpdateOrder();
  void onChangeDateReturn(BuildContext context);
  void onChangeDurationMonth();
  void updateError(String error);
}
