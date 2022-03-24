import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/request.dart';
import 'package:rssms/pages/customers/my_account/request/request_details_screen/cancel_request_screen.dart';
import 'package:rssms/pages/customers/my_account/request/request_details_screen/create_order_request_screen.dart';
import 'package:rssms/pages/customers/my_account/request/request_details_screen/extends_request_screen.dart';
import 'package:rssms/pages/customers/my_account/request/request_details_screen/get_item_request_screen.dart';
import '../../../../constants/constants.dart' as constants;

class RequestWidget extends StatelessWidget {
  Request? request;
  RequestWidget({Key? key, this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        if (request!.type == constants.REQUEST_TYPE_EXTEND_ORDER) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ExtendRequestScreen(
                        request: request!,
                      )));
        }
        if (request!.type == constants.REQUEST_TYPE_CANCEL_SCHEDULE) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CancelledRequestScreen(
                        request: request!,
                      )));
        }
        if (request!.type == constants.REQUEST_TYPE_RETURN_ORDER) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GetItemRequestScreen(
                        request: request!,
                      )));
        }
        if (request!.type == constants.REQUEST_TYPE_CREATE_ORDER) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CreateOrderRequestScreen(id: request!.id)));
        }
      },
      child: Container(
        padding: EdgeInsets.only(
          top: deviceSize.height / 45,
          bottom: deviceSize.height / 45,
        ),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: CustomColor.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 14,
                  color: Color(0x000000).withOpacity(0.06),
                  offset: const Offset(0, 6)),
            ]),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: (deviceSize.width - 32) / 6,
                      child: Image.asset(constants
                          .LIST_ICON_REQUEST[request!.type]["name"]
                          .toString())),
                  CustomSizedBox(
                    context: context,
                    width: 15,
                  ),
                  SizedBox(
                    width: (deviceSize.width - 50) * 3 / 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                            text: "Mã yêu cầu: #" + request!.id.toString(),
                            color: CustomColor.black,
                            context: context,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        CustomSizedBox(
                          context: context,
                          height: 14,
                        ),
                        CustomText(
                            text: "Loại yêu cầu: " +
                                constants.LIST_TYPE_REQUEST[request!.type]
                                    ['name']!,
                            color: CustomColor.black,
                            context: context,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        CustomSizedBox(
                          context: context,
                          height: 14,
                        ),
                        if (request!.type == 2)
                          Column(
                            children: [
                              Row(
                                children: [
                                  CustomText(
                                      text: 'Ngày lấy đồ: ' +
                                          DateFormat("dd/MM/yyyy")
                                              .format(DateTime.now()),
                                      color: CustomColor.black,
                                      context: context,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ],
                              ),
                              CustomSizedBox(
                                context: context,
                                height: 14,
                              ),
                            ],
                          ),
                        CustomText(
                            text: 'Trạng thái: ' +
                                constants.LIST_STATUS_REQUEST[request!.status]
                                        ['name']
                                    .toString(),
                            color: CustomColor.black,
                            context: context,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ],
                    ),
                  ),
                ]),
          ]),
        ),
      ),
    );
  }
}
