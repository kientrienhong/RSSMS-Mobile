import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_text.dart';
import 'package:rssms/common/image_details.dart';
import 'package:rssms/pages/delivery_staff/qr/invoice_screen/update_invoice_screen/image_item.dart';
import 'package:rssms/pages/log_in/widget/button_icon.dart';

class ImageWidget extends StatefulWidget {
  Map<String, dynamic> image;

  ImageWidget({Key? key, required this.image}) : super(key: key);

  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  List<Map<String, dynamic>>? listImage;

  onPressDeleteImage(BuildContext context, int index) {
    Widget cancelButton = TextButton(
      child: const Text("Có"),
      onPressed: () {
        setState(() {
          listImage!.removeAt(index);
        });
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Không"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Cảnh báo"),
      content: const Text("Bạn muốn xóa hình này chứ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  onPressDetailImage(Map<String, dynamic> image) {
    showDialog(
        context: context,
        builder: (ctx) {
          return ImageDetailsInvoice(
            isDisable: false,
            image: image,
          );
        });
  }

  @override
  void initState() {
    listImage = [...widget.image["image"]];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: CustomColor.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 14,
                color: const Color(0x00000000).withOpacity(0.16),
                offset: const Offset(0, 1)),
          ]),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
                text: widget.image["name"],
                color: Colors.black,
                fontWeight: FontWeight.bold,
                context: context,
                fontSize: 14),
            CustomText(
                text: widget.image["quantityImage"],
                color: Colors.black38,
                context: context,
                fontSize: 14)
          ],
        ),
        children: [
          for (var i = 0; i < listImage!.length; i++)
            if (i != listImage!.length - 1)
              ImageItem(
                onPressDelete: () {
                  onPressDeleteImage(context, i);
                },
                onPressDetails: () {
                  onPressDetailImage(listImage![i]);
                },
                index: i,
                image: listImage![i],
              )
            else
              Container(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8, bottom: 18),
                  height: deviceSize.width * 1 / 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: DottedBorder(
                        color: CustomColor.black,
                        strokeWidth: 1,
                        dashPattern: const [8, 4],
                        child: Center(
                          child: TextButton(
                            onPressed: () {},
                            clipBehavior: Clip.none,
                            autofocus: false,
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(Size(
                                    deviceSize.width,
                                    deviceSize.width * 1 / 3))),
                            child: CustomText(
                              text: "Thêm hình ảnh",
                              color: CustomColor.black,
                              context: context,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  )),
        ],
      ),
    );
  }
}
