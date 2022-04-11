import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';

class UIUtils {
  static Widget buildErrorUI(
      {required String error, required BuildContext context}) {
    if (error.isNotEmpty) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              text: error,
              textAlign: TextAlign.center,
              color: CustomColor.red,
              context: context,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            CustomSizedBox(
              context: context,
              height: 8,
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
