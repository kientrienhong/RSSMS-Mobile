import 'package:flutter/cupertino.dart';

class CustomText extends Text {
  static const heightMockUp = 896;
  static const widthMockUp = 414;
  CustomText(
      {Key? key,
      required String text,
      required Color color,
      required BuildContext context,
      required int fontSize,
      int maxLines = 1,
      TextOverflow textOverflow = TextOverflow.ellipsis,
      TextAlign textAlign = TextAlign.start,
      FontWeight fontWeight = FontWeight.normal})
      : super(text,
            key: key,
            overflow: textOverflow,
            maxLines: maxLines,
            textAlign: textAlign,
            style: TextStyle(
                fontWeight: fontWeight,
                color: color,
                fontFamily: 'Helvetica',
                fontSize: MediaQuery.of(context).size.width /
                    (widthMockUp / fontSize)));
}
