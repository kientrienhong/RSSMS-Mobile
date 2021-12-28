import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/pages/delivery_staff/delivery/delivery_screen.dart';

class ScheduleWidget extends StatelessWidget {
  final Map<String, dynamic> schedule;
  final int listLength;
  final int currentIndex;
  const ScheduleWidget(
      {Key? key,
      required this.schedule,
      required this.currentIndex,
      required this.listLength})
      : super(key: key);

  Widget buildInfo(String title, String content, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          color: CustomColor.black,
          context: context,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        CustomSizedBox(
          context: context,
          height: 8,
        ),
        Flexible(
          child: CustomText(
              maxLines: 4,
              text: content,
              color: CustomColor.black,
              context: context,
              fontSize: 16),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    Color status = CustomColor.black[3]!;
    String statusString = '';
    switch (schedule['order']['status']) {
      case ORDER_STATUS.notYet:
        {
          status = CustomColor.black[3]!;
          statusString = 'Not yet';
          break;
        }
      case ORDER_STATUS.completed:
        {
          status = CustomColor.blue;
          statusString = 'Completed';
          break;
        }
    }

    return Container(
      width: deviceSize.width,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Stack(clipBehavior: Clip.none, children: [
              currentIndex == listLength - 1
                  ? Container()
                  : Positioned(
                      left: 8,
                      child: Container(
                        width: 1,
                        color: CustomColor.black[3],
                        height: deviceSize.height / 2.8,
                      ),
                    ),
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: CustomColor.blue),
              ),
            ]),
          ),
          CustomSizedBox(
            context: context,
            width: 8,
          ),
          SizedBox(
            height: deviceSize.height / 3,
            width: deviceSize.width * 3 / 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: schedule['time'],
                    color: CustomColor.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
                CustomSizedBox(
                  context: context,
                  height: 24,
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: CustomColor.white,
                      boxShadow: [
                        BoxShadow(
                          color: CustomColor.black[3]!,
                          spreadRadius: 3,
                          blurRadius: 16,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CustomText(
                                  text: 'Order Id: #${schedule['id']}',
                                  color: CustomColor.black,
                                  fontWeight: FontWeight.bold,
                                  context: context,
                                  fontSize: 18),
                            ],
                          ),
                          CustomText(
                              text: statusString,
                              color: status,
                              fontWeight: FontWeight.bold,
                              context: context,
                              textAlign: TextAlign.right,
                              fontSize: 20)
                        ],
                      ),
                      CustomSizedBox(
                        context: context,
                        height: 8,
                      ),
                      buildInfo(
                          'Address: ', schedule['order']['address'], context),
                      CustomSizedBox(
                        context: context,
                        height: 8,
                      ),
                      buildInfo('Customer Name: ',
                          schedule['order']['customerName'], context),
                      CustomSizedBox(
                        context: context,
                        height: 8,
                      ),
                      buildInfo('Customer Phone: ',
                          schedule['order']['customerPhone'], context),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
