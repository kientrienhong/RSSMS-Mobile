import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/constants/constants.dart';
import 'package:rssms/models/entity/request.dart';

class InvoiceCancelledScreen extends StatelessWidget {
  final Request request;
  const InvoiceCancelledScreen({Key? key, required this.request})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        width: deviceSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: GestureDetector(
                onTap: () => {Navigator.of(context).pop()},
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: GestureDetector(
                    onTap: () => {Navigator.of(context).pop()},
                    child: Image.asset(
                      'assets/images/arrowLeft.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            CustomText(
                text: "Chi tiết đơn hủy",
                color: Colors.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 25),
            CustomSizedBox(
              context: context,
              height: 32,
            ),
            Row(
              children: [
                CustomText(
                  text: "Trạng thái",
                  color: CustomColor.black,
                  context: context,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  text: listRequestStatus[request.status]['name'].toString(),
                  color: listRequestStatus[request.status]['color'] as Color,
                  context: context,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
