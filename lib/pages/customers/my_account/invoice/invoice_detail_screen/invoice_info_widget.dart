import 'package:flutter/material.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';

class InvoiceInfoWidget extends StatelessWidget {
  Map<String, dynamic>? invoice;
  final Size deviceSize;

  InvoiceInfoWidget({Key? key, required this.invoice, required this.deviceSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
              text: "Mã đơn hàng:",
              color: Colors.black,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 17),
          CustomText(
              text: "#" + invoice!["id"],
              color: Colors.black,
              context: context,
              fontWeight: FontWeight.bold,
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
              text: "Trạng thái:",
              color: Colors.black,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 17),
          CustomText(
              text: invoice!["status"],
              color: invoice!['statusCode']! == 1
                  ? CustomColor.blue
                  : invoice!['statusCode']! == 2
                      ? const Color.fromRGBO(249, 168, 37, 1)
                      : CustomColor.red,
              context: context,
              fontWeight: FontWeight.bold,
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
              text: "Ngày nhận hàng:",
              color: Colors.black,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 17),
          CustomText(
              text: invoice!["getDate"],
              color: Colors.black,
              context: context,
              fontWeight: FontWeight.bold,
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
              text: invoice!["returnnDate"],
              color: Colors.black,
              context: context,
              fontWeight: FontWeight.bold,
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
              text: invoice!["address"],
              color: CustomColor.black,
              textAlign: TextAlign.right,
              context: context,
              fontWeight: FontWeight.bold,
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
              text: "Mã giảm giá:",
              color: Colors.black,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 17),
          CustomText(
              text: invoice!["discount"],
              color: Colors.black38,
              context: context,
              fontSize: 16)
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
              onPressFunction: null,
              width: deviceSize.width / 3,
              buttonColor: CustomColor.blue,
              borderRadius: 6),
        ],
      ),
    ]);
  }
}
