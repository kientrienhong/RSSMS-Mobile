import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/pages/customers/detail_request/detail_request_screen.dart';

class RequestWidget extends StatefulWidget {
  Map<String, dynamic>? request;
  RequestWidget({Key? key, this.request}) : super(key: key);

  @override
  _RequestWidgetState createState() => _RequestWidgetState();
}

class _RequestWidgetState extends State<RequestWidget> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DetailRequestScreen()));
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
                      width: (deviceSize.width - 32) / 4,
                      child: Image.asset(widget.request!['url']!)),
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
                            text:
                                "Request id: #" + widget.request!["requestId"],
                            color: CustomColor.black,
                            context: context,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        CustomSizedBox(
                          context: context,
                          height: 14,
                        ),
                        CustomText(
                            text: "Order id: #" + widget.request!["orderId"],
                            color: CustomColor.black,
                            context: context,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        CustomSizedBox(
                          context: context,
                          height: 14,
                        ),
                        if (widget.request!["statusCode"] == 1)
                          Column(
                            children: [
                              Row(
                                children: [
                                  CustomText(
                                      text: 'Ngày đổi đồ: ' +
                                          widget.request!["dateChange"],
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
                        Row(
                          children: [
                            CustomText(
                                text:
                                    'Trạng thái: ' + widget.request!["status"],
                                color: CustomColor.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ],
                        ),
                        CustomSizedBox(
                          context: context,
                          height: 8,
                        ),
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
