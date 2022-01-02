import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';

enum StatusRequestDelivery { processing, approved, reject }

class RequestWidget extends StatelessWidget {
  final Map<String, dynamic> request;
  const RequestWidget({Key? key, required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
          color: CustomColor.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                blurRadius: 14,
                color: Color(0x000000).withOpacity(0.06),
                offset: const Offset(0, 6))
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: 80, height: 80, child: Image.asset(request['url'])),
              CustomSizedBox(
                context: context,
                width: 8,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      CustomText(
                        text: 'Date: ',
                        color: CustomColor.black,
                        context: context,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      CustomText(
                          text: request['date'],
                          color: CustomColor.blue,
                          context: context,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ],
                  ),
                  Flexible(
                    child: CustomText(
                        text: request['reason'],
                        color: CustomColor.black[2]!,
                        maxLines: 3,
                        fontWeight: FontWeight.bold,
                        context: context,
                        fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
