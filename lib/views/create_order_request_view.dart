import 'package:rssms/models/entity/invoice.dart';

abstract class CreateOrderRequestView {
  updateLoading();

  updateView(Invoice invoice);
}
