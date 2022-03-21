import 'package:rssms/models/dialog_update_real_size_model.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/models/entity/order_detail.dart';
import 'package:rssms/views/dialog_update_real_size.dart';

class DialogUpdateRealSizePresenter {
  late DialogUpdateRealSizeModel model;
  late DialogUpdateRealSizeView view;

  DialogUpdateRealSizePresenter(OrderDetail? orderDetail) {
    model = DialogUpdateRealSizeModel(orderDetail);
  }

  void updateRealSize(Invoice invoice, Invoice invoiceTemp) {
    int index = invoice.orderDetails
        .indexWhere((element) => element.id == model.orderDetail!.id);

    invoiceTemp.orderDetails[index] = model.orderDetail!.copyWith(
        length: double.parse(model.controllerLength.text),
        width: double.parse(model.controllerWidth.text),
        height: double.parse(model.controllerHeight.text));
    invoice.setInvoice(invoice: invoiceTemp);
  }
}
