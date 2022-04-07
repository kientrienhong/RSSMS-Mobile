import 'package:flutter/material.dart';
import 'package:rssms/common/custom_color.dart';

class CustomSnackBar {
  CustomSnackBar._();
  static buildErrorSnackbar(
      {required BuildContext context,
      required String message,
      required Color color}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 2500),
      content: Text(
        message,
        style: const TextStyle(color: CustomColor.white),
      ),
      backgroundColor: color,
    ));
  }
}
