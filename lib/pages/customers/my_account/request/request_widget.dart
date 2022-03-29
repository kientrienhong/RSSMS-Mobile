import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/helpers/format_date.dart';
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
    Widget _buildInformationRequest(Request request) {
      List<Widget> inforRequest = [
        Row(
          children: [
            CustomText(
                text: 'Ngày yêu cầu: ',
                color: CustomColor.black,
                fontWeight: FontWeight.bold,
                context: context,
                fontSize: 16),
            CustomText(
                text: FormatDate.formatToVNDay(request.createdDate),
                color: CustomColor.black,
                context: context,
                fontSize: 16),
          ],
        ),
        CustomSizedBox(
          context: context,
          height: 8,
        ),
        Row(
          children: [
            CustomText(
                text: "Loại yêu cầu: ",
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            CustomText(
                text: constants.LIST_TYPE_REQUEST[request.type]['name']!,
                color: CustomColor.black,
                context: context,
                fontSize: 16),
          ],
        ),
        CustomSizedBox(
          context: context,
          height: 8,
        ),
        Row(children: [
          CustomText(
              text: 'Trạng thái: ',
              color: CustomColor.black,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 15),
          CustomText(
              text: constants.LIST_STATUS_REQUEST[request.status]['name']
                  .toString(),
              color: constants.LIST_STATUS_REQUEST[request.status]['color']
                  as Color,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ])
      ];

      switch (request.type) {
        case constants.REQUEST_TYPE_CANCEL_ORDER:
          return Column(
            children: inforRequest,
          );

        case constants.REQUEST_TYPE_CREATE_ORDER:
          {
            inforRequest.addAll([
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              Row(
                children: [
                  CustomText(
                      text: 'Ngày lấy hàng: ',
                      color: CustomColor.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  CustomText(
                      text: FormatDate.formatToVNDay(request.deliveryDate),
                      color: CustomColor.black,
                      context: context,
                      fontSize: 16),
                ],
              ),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              Row(
                children: [
                  CustomText(
                      text: 'Khung giờ lấy hàng: ',
                      color: CustomColor.black,
                      fontWeight: FontWeight.bold,
                      context: context,
                      fontSize: 16),
                  CustomText(
                      text: request.deliveryTime,
                      color: CustomColor.black,
                      context: context,
                      fontSize: 16),
                ],
              ),
            ]);
            break;
          }

        case constants.REQUEST_TYPE_EXTEND_ORDER:
          {
            inforRequest.addAll([
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              Row(
                children: [
                  CustomText(
                      text: 'Ngày kết thúc mới: ',
                      color: CustomColor.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  CustomText(
                      text: FormatDate.formatToVNDay(request.returnDate),
                      color: CustomColor.black,
                      context: context,
                      fontSize: 16),
                ],
              ),
            ]);
            break;
          }

        case constants.REQUEST_TYPE_RETURN_ORDER:
          {
            inforRequest.addAll([
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              Row(
                children: [
                  CustomText(
                      text: 'Ngày trả đơn: ',
                      color: CustomColor.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  CustomText(
                      text: FormatDate.formatToVNDay(request.returnDate),
                      color: CustomColor.black,
                      context: context,
                      fontSize: 16),
                ],
              ),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              Row(
                children: [
                  CustomText(
                      text: 'Khung giờ trả đơn: ',
                      color: CustomColor.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  CustomText(
                      text: request.returnTime,
                      color: CustomColor.black,
                      context: context,
                      fontSize: 16),
                ],
              ),
            ]);
            break;
          }
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: inforRequest,
      );
    }

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
        padding: EdgeInsets.symmetric(
            vertical: deviceSize.height / 45, horizontal: 8),
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
        child: Column(children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: (deviceSize.width - 72) / 6,
                    child: Image.asset(constants
                        .LIST_ICON_REQUEST[request!.type]["name"]
                        .toString())),
                CustomSizedBox(
                  context: context,
                  width: 15,
                ),
                SizedBox(
                    width: (deviceSize.width - 72) * 5 / 6,
                    child: _buildInformationRequest(request!)),
              ]),
        ]),
      ),
    );
  }
}
