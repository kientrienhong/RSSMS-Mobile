import 'package:flutter/material.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/helpers/date_format.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/pages/time_line/time_line_screen.dart';
import 'package:rssms/constants/constants.dart';

class InvoiceInfoWidget extends StatelessWidget {
  final Invoice invoice;
  final Size deviceSize;

  const InvoiceInfoWidget(
      {Key? key, required this.invoice, required this.deviceSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
              text: "Trạng thái:",
              color: Colors.black,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 17),
          Row(
            children: [
              CustomText(
                  text: listStatusOrder[invoice.typeOrder]![invoice.status]
                      ['name']! as String,
                  color: listStatusOrder[invoice.typeOrder]![invoice.status]
                      ['color'] as Color,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              Container(
                width: 2,
                height: deviceSize.height / 40,
                color: CustomColor.black,
                margin: const EdgeInsets.symmetric(horizontal: 4),
              ),
              CustomText(
                  text: mapIsPaid[invoice.isPaid]!['name']! as String,
                  color: mapIsPaid[invoice.isPaid]!['color'] as Color,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ],
          ),
        ],
      ),
      CustomSizedBox(
        context: context,
        height: 24,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
              text: "Ngày nhận hàng:",
              color: Colors.black,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 17),
          CustomText(
              text: DateFormatHelper.formatToVNDay(invoice.deliveryDate),
              color: Colors.black,
              context: context,
              fontSize: 16),
        ],
      ),
      CustomSizedBox(
        context: context,
        height: 24,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
              text: "Khung giờ lấy hàng:",
              color: Colors.black,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 17),
          CustomText(
              text: invoice.deliveryTime.isEmpty
                  ? 'Khách tự vận chuyển'
                  : invoice.deliveryTime,
              color: Colors.black,
              context: context,
              fontSize: 16),
        ],
      ),
      CustomSizedBox(
        context: context,
        height: 24,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
              text: "Ngày trả hàng:",
              color: Colors.black,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 17),
          CustomText(
              text: DateFormatHelper.formatToVNDay(invoice.returnDate),
              color: Colors.black,
              context: context,
              fontSize: 16),
        ],
      ),
      CustomSizedBox(
        context: context,
        height: 24,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
              text: "Địa chỉ:",
              color: Colors.black,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 17),
          SizedBox(
            width: deviceSize.width * 1.5 / 3,
            child: CustomText(
              text: invoice.deliveryAddress,
              color: CustomColor.black,
              textAlign: TextAlign.right,
              context: context,
              maxLines: 2,
              fontSize: 16,
              textOverflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      CustomSizedBox(
        context: context,
        height: 24,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
              text: "Thông tin vận chuyển:",
              color: Colors.black,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 17),
          CustomButton(
              height: 24,
              isLoading: false,
              text: 'Xem thêm',
              textColor: CustomColor.white,
              onPressFunction: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TimeLineScreen(
                              invoiceId: invoice.id,
                            )));
              },
              width: deviceSize.width / 3,
              buttonColor: CustomColor.blue,
              borderRadius: 6),
        ],
      ),
    ]);
  }
}
