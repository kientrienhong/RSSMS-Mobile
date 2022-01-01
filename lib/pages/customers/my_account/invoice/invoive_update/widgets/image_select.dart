import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/invoice_image_detail.dart';

class ImageSelectWidget extends StatelessWidget {
  Map<String, dynamic> image;
  List<Map<String, dynamic>> listCurrent;
  int index;
  final Function onTapChoice;

  ImageSelectWidget(
      {Key? key,
      required this.image,
      required this.listCurrent,
      required this.onTapChoice,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    int indexFound = listCurrent.indexWhere((e) => e['index'] == index);

    return GestureDetector(
      onTap: () {
        onTapChoice(image, indexFound, index);
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
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color:
                        indexFound != -1 ? CustomColor.blue : CustomColor.white,
                    border: Border.all(width: 1.5, color: CustomColor.blue)),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    size: 12,
                    color: CustomColor.white,
                  ),
                ),
              ),
            ]),
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: CustomColor.white,
            border: indexFound == -1
                ? Border.all(width: 0, color: CustomColor.white)
                : Border.all(width: 3, color: CustomColor.blue),
            boxShadow: [
              indexFound != -1
                  ? const BoxShadow()
                  : BoxShadow(
                      blurRadius: 14,
                      color: Color(0x000000).withOpacity(0.06),
                      offset: const Offset(0, 6)),
            ]),
      ),
    );
  }
}
