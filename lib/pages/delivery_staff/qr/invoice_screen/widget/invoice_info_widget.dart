import 'package:flutter/material.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/models/entity/invoice.dart';
import 'package:rssms/constants/constants.dart' as constants;

class InvoiceInfoWidget extends StatelessWidget {
  Invoice? invoice;
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
              text: "#" + invoice!.id.toString(),
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
              text: constants.LIST_STATUS_ORDER[invoice!.status]['name']!
                  as String,
              color: constants.LIST_STATUS_ORDER[invoice!.status]['color']
                  as Color,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 17
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
              text: invoice!.deliveryDate
                  .substring(0, invoice!.deliveryDate.indexOf("T")),
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
              text: invoice!.returnDate
                  .substring(0, invoice!.returnDate.indexOf("T")),
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
              text: invoice!.deliveryAddress,
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
              text: "Không có",
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
