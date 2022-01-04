import 'package:flutter/material.dart';
import 'package:rssms/common/custom_button.dart';
import 'package:rssms/common/custom_color.dart';
import 'package:rssms/common/custom_sizebox.dart';
import 'package:rssms/common/custom_text.dart';

class NoPermissionScreen extends StatelessWidget {
  const NoPermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColor.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(
              height: deviceSize.width,
              width: deviceSize.width,
              child: Image.asset(
                'assets/images/noPermission.png',
                fit: BoxFit.cover,
              ),
            ),
            CustomSizedBox(
              context: context,
              height: 8,
            ),
            CustomText(
                text: 'Quyền của bạn không thể xác thực\nVui lòng thử lại!',
                color: CustomColor.black,
                textAlign: TextAlign.center,
                context: context,
                maxLines: 3,
                fontWeight: FontWeight.bold,
                fontSize: 24),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            CustomButton(
                height: 24,
                text: 'Thử lại',
                width: deviceSize.width * 1.2 / 3,
                onPressFunction: () {
                  Navigator.of(context).pop();
                },
                isLoading: false,
                textColor: CustomColor.white,
                buttonColor: CustomColor.blue,
                borderRadius: 6),
          ],
        ),
      ),
    );
  }
}
