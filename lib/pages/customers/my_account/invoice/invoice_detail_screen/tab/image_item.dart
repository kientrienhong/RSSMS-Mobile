import 'package:flutter/material.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';

class ImageItem extends StatefulWidget {
  Map<String, dynamic> image;
  Function()? onPressDelete;
  Function()? onPressDetails;
  int? index;
  bool? isView;
  ImageItem(
      {Key? key,
      required this.image,
      required this.onPressDelete,
      required this.onPressDetails,
      required this.isView,
      required this.index})
      : super(key: key);

  @override
  _ImageItemState createState() => _ImageItemState();
}

class _ImageItemState extends State<ImageItem> {
  @override
  Widget build(BuildContext context) {
    Widget _buildImage(Size deviceSize) {
      if (widget.image['file'] != null) {
        return Image.file(
          widget.image['file']!,
          width: (deviceSize.width - 32) / 3,
        );
        // } else if (widget.image['url'] != null) {
        //   return Image.network(
        //     widget.image['url']!,
        //     width: (deviceSize.width - 32) / 3,
        //   );
      } else {
        return Image.asset(
          widget.image['url']!,
          width: (deviceSize.width - 32) / 3,
        );
      }
    }

    var deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 18),
      child: Column(
        children: [
          Row(
            children: [
              _buildImage(deviceSize),
              CustomSizedBox(
                context: context,
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: widget.image['name']!,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      context: context,
                      fontSize: 14),
                  CustomSizedBox(
                    context: context,
                    height: 12,
                  ),
                  Row(
                    children: [
                      CustomButton(
                          height: 20,
                          isLoading: false,
                          text: 'Xem thêm',
                          textColor: CustomColor.white,
                          onPressFunction: widget.onPressDetails,
                          width: deviceSize.width / 3.5,
                          buttonColor: CustomColor.blue,
                          borderRadius: 6),
                      CustomSizedBox(
                        context: context,
                        width: 8,
                      ),
                      widget.isView == false
                          ? CustomButton(
                              height: 20,
                              isLoading: false,
                              text: 'Xóa',
                              textColor: CustomColor.white,
                              onPressFunction: widget.onPressDelete,
                              width: deviceSize.width / 8,
                              buttonColor: CustomColor.red,
                              borderRadius: 6)
                          : Container(),
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
