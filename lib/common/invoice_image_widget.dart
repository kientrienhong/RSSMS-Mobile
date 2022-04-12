import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/invoice_image_detail.dart';

class InvoiceImageWidget extends StatelessWidget {
  Map<String, dynamic> image;

  InvoiceImageWidget({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (ctx) {
              return InvoiceImageDetail(
                image: image,
                isDisable: true,
              );
            });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16.0),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: deviceSize.width / 2,
              child: Image.asset(
                image["url"],
                fit: BoxFit.cover,
              ),
            ),
            CustomSizedBox(
              context: context,
              height: 8,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              SizedBox(
                width: deviceSize.width / 2 - 16 - 24,
                child: Center(
                  child: CustomText(
                    text: image['name'],
                    color: CustomColor.black,
                    context: context,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                  height: 24,
                  width: 24,
                  child: Image.asset('assets/images/info.png'))
            ]),
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: CustomColor.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 14,
                  color: const Color(0x00000000).withOpacity(0.06),
                  offset: const Offset(0, 6)),
            ]),
      ),
    );
  }
}
