import 'package:flutter/cupertino.dart';
import 'package:rssms/models/entity/order_detail.dart';

class DialogUpdateRealSizeModel {
  late TextEditingController controllerWidth;
  late TextEditingController controllerHeight;
  late TextEditingController controllerLength;
  late OrderDetail? orderDetail;
  DialogUpdateRealSizeModel(OrderDetail? orderDetail) {
    controllerHeight = TextEditingController(
        text: orderDetail == null ? '' : orderDetail.height.toString());
    controllerWidth = TextEditingController(
        text: orderDetail == null ? '' : orderDetail.width.toString());
    controllerLength = TextEditingController(
        text: orderDetail == null ? '' : orderDetail.length.toString());
    this.orderDetail = orderDetail;
  }
}
